package com.konstantinkiselev.dataBase;

import oracle.jdbc.driver.OracleDriver;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Locale;

/**
 * Created by Kostya on 20.09.2017.
 */
public class DBConnection {

    private static DBConnection instance;
    private Connection connection;
    private String url = "";
    private String username = "";
    private String password = "";

    public static DBConnection getInstance() {
        if (instance == null) {
            instance = new DBConnection();
        }
        return instance;
    }

    public Connection getConnection() {
        return this.connection;
    }

    public Connection setConnection(String url, String username, String password) throws SQLException {
        Locale.setDefault(Locale.ENGLISH);
        try {
            DriverManager.registerDriver(new OracleDriver());
            connection = DriverManager.getConnection(url, username, password);
            this.url = url;
            this.username = username;
            this.password = password;
            return connection;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

    }

    /*
    public static void main(String [] args) throws SQLException {
        String url = "jdbc:oracle:thin:@localhost:1521:XE";
        String username = "kiselev";
        String password = "kiselev";
        Connection con = DBConnection.getInstance().setConnection(url, username, password);
    }
    */

}
