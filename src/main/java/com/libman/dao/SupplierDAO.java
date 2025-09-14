package com.libman.dao;

import com.libman.config.DataSourceProvider;
import com.libman.model.Supplier;
import java.sql.*;
import java.util.*;

public class SupplierDAO {
    // tìm theo tên (like)
    public List<Supplier> searchByName(String name) throws Exception {
        List<Supplier> res = new ArrayList<>();
        try (Connection c = DataSourceProvider.get().getConnection();
                PreparedStatement ps = c.prepareStatement("SELECT * FROM tblSupplier WHERE name LIKE ?")) {
            ps.setString(1, "%" + name + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Supplier s = new Supplier();
                    s.setId(rs.getInt("id"));
                    s.setName(rs.getString("name"));
                    s.setContactName(rs.getString("contact_name"));
                    s.setPhone(rs.getString("phone"));
                    s.setEmail(rs.getString("email"));
                    s.setAddress(rs.getString("address"));
                    res.add(s);
                }
            }
        }
        return res;
    }

    public Supplier findById(int id) throws Exception {
        try (Connection c = DataSourceProvider.get().getConnection();
                PreparedStatement ps = c.prepareStatement("SELECT * FROM tblSupplier WHERE id=?")) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Supplier s = new Supplier();
                    s.setId(rs.getInt("id"));
                    s.setName(rs.getString("name"));
                    s.setContactName(rs.getString("contact_name"));
                    s.setPhone(rs.getString("phone"));
                    s.setEmail(rs.getString("email"));
                    s.setAddress(rs.getString("address"));
                    return s;
                }
            }
        }
        return null;
    }

    public Supplier create(Supplier s) throws Exception {
        try (Connection c = DataSourceProvider.get().getConnection();
                PreparedStatement ps = c.prepareStatement(
                        "INSERT INTO tblSupplier(name,contact_name,phone,email,address) VALUES(?,?,?,?,?)",
                        Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, s.getName());
            ps.setString(2, s.getContactName());
            ps.setString(3, s.getPhone());
            ps.setString(4, s.getEmail());
            ps.setString(5, s.getAddress());
            ps.executeUpdate();
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) {
                    s.setId(keys.getInt(1));
                    return s;
                }
            }
        }
        return null;
    }
}
