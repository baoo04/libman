package com.libman.config;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import javax.sql.DataSource;
import java.io.InputStream;
import java.util.Properties;

public class DataSourceProvider {
    private static DataSource ds;

    public static DataSource get() {
        if (ds == null) {
            try {
                Properties p = new Properties();
                InputStream in = DataSourceProvider.class.getResourceAsStream("/db.properties");
                p.load(in);
                HikariConfig cfg = new HikariConfig();
                cfg.setJdbcUrl(p.getProperty("jdbc.url"));
                cfg.setUsername(p.getProperty("jdbc.user"));
                cfg.setPassword(p.getProperty("jdbc.password"));
                cfg.setMaximumPoolSize(Integer.parseInt(p.getProperty("jdbc.pool.size", "10")));
                ds = new HikariDataSource(cfg);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }
        return ds;
    }
}
