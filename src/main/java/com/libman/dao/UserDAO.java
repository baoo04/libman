package com.libman.dao;

import com.libman.model.User;

import java.sql.*;
import java.util.HashSet;
import java.util.Set;

public class UserDAO extends DAO {
    public UserDAO() throws SQLException {
        super();
    }

    public User findByUsername(String username) throws SQLException {
        String sql = "SELECT id,username,password,full_name,email,phone,status FROM tblUser WHERE username=?";

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, username);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                User u = new User();
                u.setId((long) rs.getInt(1));
                u.setUsername(rs.getString(2));
                u.setPassword(rs.getString(3));
                u.setFullName(rs.getString(4));
                u.setEmail(rs.getString(5));
                u.setPhone(rs.getString(6));
                u.setStatus(rs.getString(7));
                return u;
            }
        }
        return null;
    }

    public Set<String> findRoles(Long userId) throws SQLException {
        Set<String> rslt = new HashSet<>();
        String sql = "SELECT r.code FROM tblUserRole ur JOIN tblRole r ON ur.role_id=r.id WHERE ur.user_id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setLong(1, userId);
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next())
                rslt.add(rs.getString(1));
        }
        return rslt;
    }

}
