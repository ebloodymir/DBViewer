package com.konstantinkiselev.entities;

import java.util.ArrayList;

/**
 * Created by Kostya on 20.09.2017.
 */
public class DBTable {

    private String name;
    private ArrayList<DBField> fields;

    public DBTable() {
        this.fields = new ArrayList<>();
    }

    public DBTable(String name) {
        this();
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public ArrayList<DBField> getFields() {
        return fields;
    }

    public void setFields(ArrayList<DBField> field) {
        this.fields = field;
    }

    public void putField(String name, String type, String length) {
        this.fields.add(new DBField(name, type, length));
    }
}
