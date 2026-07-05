package com.jobportal.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/online_jobportal";
    private static final String USER = "root";
    private static final String PASS = "root"; // apna MySQL password daal do (agar hai toh)

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(URL, USER, PASS);
            System.out.println("DB Connected Successfully!");
            return con;
        } catch (Exception e) {
            System.out.println("DB CONNECTION FAILED!");
            e.printStackTrace();
            return null;
        }
    }
}