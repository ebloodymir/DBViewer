package com.konstantinkiselev.dataBase;

import com.konstantinkiselev.entities.DBTable;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Kostya on 20.09.2017.
 */

public class DBHelper {

    // Get all Table names and their field names
    public static ArrayList<DBTable> getTables() throws SQLException {

        ArrayList<DBTable> tables = new ArrayList<>(); // git test
        Connection connection = DBConnection.getInstance().getConnection();

        Statement tablesStatement = connection.createStatement();
        tablesStatement.execute("select table_name from user_tables");
        ResultSet tablesResultSet = tablesStatement.getResultSet();
        while (tablesResultSet.next()) {
            DBTable table = new DBTable(tablesResultSet.getString("table_name"));
            System.out.println(table.getName());

            String sqlQuery = "select column_name, data_type, data_length from USER_TAB_COLUMNS where table_name = \'" + table.getName() + "\'";
            Statement fieldsStatement = connection.createStatement();
            fieldsStatement.execute(sqlQuery);
            ResultSet fieldsSResultSet = fieldsStatement.getResultSet();
            while (fieldsSResultSet.next()) {
                table.putField(fieldsSResultSet.getString(1), fieldsSResultSet.getString(2),
                        fieldsSResultSet.getString(3));
            }
            tables.add(table);
        }
        return tables;
    }

    public static List getTableData(String tableName) throws SQLException {

        Connection connection = DBConnection.getInstance().getConnection();
        Statement tablesStatement = connection.createStatement();
        tablesStatement.execute("select * from " + tableName);
        ResultSet tablesResultSet = tablesStatement.getResultSet();
        return resultSetToArrayList(tablesResultSet);
    }

    private static List resultSetToArrayList(ResultSet rs) throws SQLException {
        ResultSetMetaData md = rs.getMetaData();
        Object data;
        int columns = md.getColumnCount();
        ArrayList list = new ArrayList();
        while (rs.next()) {
            ArrayList row = new ArrayList(columns);
            for (int i = 1; i <= columns; ++i) {
                data = rs.getObject(i);
                if (data instanceof Timestamp)//Timestamp
                    data = new SimpleDateFormat("dd.MM.YYYY HH:mm").format(data);
                row.add(data);
            }
            list.add(row);
        }
        return list;
    }

    public static void addRecord(String tableName, ArrayList<String> parameters, ArrayList<String> fields) throws SQLException, ParseException {
        //insert into students values (2, 'Linda', 'Ruiz', 'Phillip', 15, to_date('2015-11-22' , 'YYYY-MM-DD'));
        Connection connection = DBConnection.getInstance().getConnection();
        Statement insertStatement = connection.createStatement();
        String sql = "insert into " + tableName + "(";
        for (String field : fields) {
            sql += field + ", ";
        }
        sql = sql.substring(0, sql.length() - 2);
        sql += ") values(";
        for (String param : parameters) {
            if (param.matches("\\d{2}.\\d{2}.\\d{4} \\d{2}:\\d{2}")) { // if DATE type
                SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy HH:mm");
                java.util.Date date = dateFormat.parse(param);
                Timestamp tstamp = new Timestamp(date.getTime());
                sql += "TIMESTAMP\'" + tstamp + "'',";
            } else
                sql += "'" + param + "', ";
        }
        sql = sql.substring(0, sql.length() - 2);
        sql += ")";
        System.out.print("Add query: " + sql);
        insertStatement.execute(sql, Statement.RETURN_GENERATED_KEYS);
        /*
        ResultSet rs = insertStatement.getGeneratedKeys();
        if (rs.next()) {
            int productId = rs.getInt(1);
        }
        */
    }

    public static void deleteRecords(String tableName, ArrayList<String> ids) throws SQLException {
        Connection connection = DBConnection.getInstance().getConnection();
        Statement pkStatement = connection.createStatement();
        String sql = "delete from " + tableName + " where " + getPrimaryKey(tableName) + " in (";
        for (String id : ids)
            sql += id + ", ";
        sql = sql.substring(0, sql.length() - 2);
        sql += ")";
        System.out.print("Delete query: " + sql);
        pkStatement.execute(sql);

    }

    public static void updateRecord(String tableName, ArrayList<String> parameters, ArrayList<String> fields, String pkName) throws SQLException, ParseException {
        Connection connection = DBConnection.getInstance().getConnection();
        Statement insertStatement = connection.createStatement();
        String sql = "update " + tableName + " set ";
        for (int i = 0; i < fields.size(); i++) {
            sql += fields.get(i) + "=";
            if (parameters.get(i).matches("\\d{2}.\\d{2}.\\d{4} \\d{2}:\\d{2}")) { // if DATE type
                SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy HH:mm");
                java.util.Date date = dateFormat.parse(parameters.get(i));
                Timestamp tstamp = new Timestamp(date.getTime());
                sql += "TIMESTAMP\'" + tstamp + "'',";
            } else
                sql += "'" + parameters.get(i) + "', ";
        }
        sql = sql.substring(0, sql.length() - 2);
        sql += " where " + getPrimaryKey(tableName) + " = " + getPKValue(pkName, fields, parameters);
        System.out.println("Update query: " + sql);
        insertStatement.execute(sql);
    }

    private static String getPKValue(String pkName, ArrayList<String> fields, ArrayList<String> parameters) {
        for (int i = 0; i < fields.size(); i++) {
            if (fields.get(i).equals(pkName))
                return parameters.get(i);
        }
        return null;
    }

    public static String getPrimaryKey(String tableName) throws SQLException {
        //SELECT cols.column_name FROM all_constraints cons, all_cons_columns cols WHERE cols.table_name = 'STUDENTS' AND cons.constraint_type = 'P' AND cons.constraint_name = cols.constraint_name AND cons.owner = cols.owner
        Connection connection = DBConnection.getInstance().getConnection();
        Statement pkStatement = connection.createStatement();
        String sql = "SELECT cols.column_name FROM all_constraints cons, all_cons_columns cols WHERE cols.table_name = \'" + tableName + "\' AND cons.constraint_type = 'P' AND cons.constraint_name = cols.constraint_name AND cons.owner = cols.owner";
        pkStatement.execute(sql);
        ResultSet tablesResultSet = pkStatement.getResultSet();
        tablesResultSet.next();
        try {
            return tablesResultSet.getString(1);
        } catch (Exception e) {
            return null;
        }
    }

    /*
    public static void main(String [] args) throws SQLException {
        String url = "jdbc:oracle:thin:@localhost:1521:XE";
        String username = "kiselev";
        String password = "kiselev";
        Connection con = DBConnection.getInstance().setConnection(url, username, password);
        //addRecord("Students", "400", "Vasilii", "stepanov", "ivanovi4", "15", "01.09.2010");
        String s = getPrimaryKey("STUDENTS");
        s += "a";
    }
    */
}
