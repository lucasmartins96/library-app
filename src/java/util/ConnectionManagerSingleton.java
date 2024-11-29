/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author Lucas Martins da Silva
 */
public class ConnectionManagerSingleton {

    private static ConnectionManagerSingleton instance;
    private static final String URL = "jdbc:mysql://localhost:3306/library_app";
    private static final String USER = "root";
    private static final String PASS = "";

    private ConnectionManagerSingleton() {
    }

    public static ConnectionManagerSingleton getInstance() {
        if (instance == null) {
            instance = new ConnectionManagerSingleton();
        }

        return instance;
    }

    public Connection getConnection() throws ClassNotFoundException {
        Connection sqlConnection = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            sqlConnection = DriverManager.getConnection(URL, USER, PASS);
        } catch (SQLException ex) {
            System.out.println("Error: " + ex);
        }

        return sqlConnection;
    }
}
