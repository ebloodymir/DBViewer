package com.konstantinkiselev.controller;

import com.google.gson.Gson;
import com.konstantinkiselev.dataBase.DBConnection;
import com.konstantinkiselev.dataBase.DBHelper;
import com.konstantinkiselev.entities.DBField;
import com.konstantinkiselev.entities.DBTable;
import com.konstantinkiselev.entities.UserDto;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;


/**
 * Created by Kostya on 20.09.2017.
 */

@Controller
public class AppController {

    private UserDto userDto;
    private ArrayList tableRecords;
    private ArrayList<DBTable> tables;

    ////////////////////////////////////////////////Login///////////////////////////////////////////////////////////////
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String getLogin() {
        tableRecords = new ArrayList();
        return "login";
    }

    @RequestMapping(value = "/login")
    public String login(@ModelAttribute("userDto") UserDto userDto) throws SQLException {
        DBConnection.getInstance().setConnection(userDto.getDBLink(), userDto.getUsername(), userDto.getPassword());
        this.userDto = userDto;
        this.tables = DBHelper.getTables();
        return "redirect:/table_" + tables.get(0).getName();
    }

    ////////////////////////////////////////////////Table///////////////////////////////////////////////////////////////
    @RequestMapping(value = "/table_{tName}", method = RequestMethod.GET)
    public String getTable(@PathVariable("tName") String tName, ModelMap model) throws SQLException {

        model.addAttribute("tables", tables);
        for (DBTable table : tables)
            if (table.getName().equals(tName)) {
                this.tableRecords = (ArrayList) DBHelper.getTableData(tName);
                model.addAttribute("records", this.tableRecords);
                model.addAttribute("fields", table.getFields());
                model.addAttribute("tName", tName);
                int i = 0;
                for (DBField field : table.getFields()) {
                    if (field.getName().equals(DBHelper.getPrimaryKey(tName)))
                        model.addAttribute("pkFieldIndex", i);
                    i++;
                }
            }
        return "dataTable";
    }

    // Добавление записи
    @RequestMapping(value = "/addRecord{tableName}", method = RequestMethod.POST)
    public @ResponseBody
    String addRecord(@PathVariable("tableName") String tableName,
                     @ModelAttribute("values") String values
    ) throws ParseException {

        HashMap<String, String> selects = new Gson().fromJson(values, HashMap.class);
        ArrayList<String> sqlParams = new ArrayList<>();
        ArrayList<String> sqlFields = new ArrayList<>();
        for (Map.Entry<String, String> entry : selects.entrySet()) {
            sqlParams.add(entry.getValue());
            sqlFields.add(entry.getKey());
        }
        try {
            DBHelper.addRecord(tableName, sqlParams, sqlFields);
            ArrayList records = (ArrayList) DBHelper.getTableData(tableName);
            records.removeAll(this.tableRecords);
            int pkIndex = getPKIndex(tableName);
            ArrayList tempList = (ArrayList<String>) records.get(0);
            return "{\"status\":\"OK\", \"id\": \"" + tempList.get(pkIndex) + "\"}";
        } catch (SQLException e) {
            System.out.println(e.toString());
            return "{\"status\":\"FAILED\"}";
        }
    }

    // Удаление записи
    @RequestMapping(value = "/deleteRecord{tableName}", method = RequestMethod.POST)
    public @ResponseBody
    String deleteRecord(@PathVariable("tableName") String tableName,
                        @ModelAttribute("values") String values
    ) {

        ArrayList<String> ids = new Gson().fromJson(values, ArrayList.class);
        try {
            DBHelper.deleteRecords(tableName, ids);
        } catch (SQLException e) {
            System.out.println("ERROR CODE: " + e.getErrorCode());
            if (e.getErrorCode() == 2292) // Constraint
                return "{\"status\":\"ConstraintError\"}";
        }
        return "{\"status\":\"OK\"}";
    }

    // Изменение записи
    @RequestMapping(value = "/updateRecord{tableName}", method = RequestMethod.POST)
    public @ResponseBody
    String updateRecord(@PathVariable("tableName") String tableName,
                        @ModelAttribute("values") String values
    ) throws ParseException {
        String pkName = "";
        HashMap<String, String> selects = new Gson().fromJson(values, HashMap.class);
        ArrayList<String> sqlParams = new ArrayList<>();
        ArrayList<String> sqlFields = new ArrayList<>();
        for (Map.Entry<String, String> entry : selects.entrySet()) {
            sqlParams.add(entry.getValue());
            sqlFields.add(entry.getKey());
        }
        try {
            for (DBTable table : tables)
                if (table.getName().equals(tableName)) {
                    int i = 0;
                    for (DBField field : table.getFields()) {
                        if (field.getName().equals(DBHelper.getPrimaryKey(tableName)))
                            pkName = field.getName();
                    }
                }
            DBHelper.updateRecord(tableName, sqlParams, sqlFields, pkName);
            ArrayList records = (ArrayList) DBHelper.getTableData(tableName);
            records.removeAll(this.tableRecords);
        } catch (SQLException e) {
            e.printStackTrace();
            return "{\"status\":\"ERROR\"}";
        }
        return "{\"status\":\"OK\"}";
    }

    private int getPKIndex(String tableName) throws SQLException {
        int pkIndex = 0;
        for (DBTable table : tables)
            if (table.getName().equals(tableName)) {
                int i = 0;
                for (DBField field : table.getFields()) {
                    if (field.getName().equals(DBHelper.getPrimaryKey(tableName))) {
                        pkIndex = i;
                        break;
                    }
                    i++;
                }
            }
        return pkIndex;
    }
}
