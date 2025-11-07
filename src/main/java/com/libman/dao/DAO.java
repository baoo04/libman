package com.libman.dao;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DAO {

    private static final String PROPERTIES_FILE = "/db.properties";
    private static String DB_URL;
    private static String DB_USER;
    private static String DB_PASSWORD;
    protected static Connection conn;

    static {
        try (InputStream input = DAO.class.getResourceAsStream(PROPERTIES_FILE)) {
            if (input == null) {
                throw new RuntimeException("Không tìm thấy file cấu hình: " + PROPERTIES_FILE);
            }

            Properties prop = new Properties();
            prop.load(input);

            DB_URL = prop.getProperty("jdbc.url");
            DB_USER = prop.getProperty("jdbc.user");
            DB_PASSWORD = prop.getProperty("jdbc.password");

            Class.forName("com.mysql.cj.jdbc.Driver");

        } catch (IOException | ClassNotFoundException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi tải cấu hình DB", e);
        }
    }

    public DAO() throws SQLException {
        if (conn == null || conn.isClosed()) {
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        }
    }

    public static Connection getConnection() throws SQLException {
        if (conn == null || conn.isClosed()) {
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        }
        return conn;
    }
}
