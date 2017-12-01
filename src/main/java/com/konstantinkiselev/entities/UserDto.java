package com.konstantinkiselev.entities;

/**
 * Created by Kostya on 20.09.2017.
 */
public class UserDto {
    private String DBLink;
    private String username;
    private String password;

    public UserDto() {
    }

    public UserDto(String DBLink, String username, String password) {
        this.DBLink = DBLink;
        this.username = username;
        this.password = password;
    }

    public String getDBLink() {
        return DBLink;
    }

    public void setDBLink(String DBLink) {
        this.DBLink = DBLink;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
