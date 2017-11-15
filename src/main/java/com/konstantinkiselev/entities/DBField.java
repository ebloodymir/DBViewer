package com.konstantinkiselev.entities;

/**
 * Created by Kostya on 28.09.2017.
 */
public class DBField {

    private String name;
    private String type;
    private String length;

    public DBField() {}

    public DBField(String name, String type, String length) {
        this.name = name;
        this.type = type;
        this.length = length;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getLength() {
        return length;
    }

    public void setLength(String length) {
        this.length = length;
    }
}
