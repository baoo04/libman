package com.libman.dao;

import com.libman.model.ImportOrder;
import com.libman.model.ImportOrderItem;
import com.libman.model.Supplier;

import java.sql.*;

public class ImportOrderDAO extends DAO {
    public ImportOrderDAO() throws SQLException {
        super();
    }

    public int create(ImportOrder order) throws Exception {
        PreparedStatement ps = null;
        PreparedStatement psItem = null;
        PreparedStatement psUpdate = null;

        try {
            conn.setAutoCommit(false);
            ps = conn.prepareStatement(
                    "INSERT INTO tblImportOrder(supplier_id, created_by, total_amount, created_at) VALUES(?,?,?,?)",
                    Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, order.getSupplier().getId());
            ps.setString(2, order.getCreatedBy());
            ps.setDouble(3, order.getTotalAmount());
            ps.setTimestamp(4, new java.sql.Timestamp(System.currentTimeMillis())); // add timestamp
            ps.executeUpdate();

            ResultSet keys = ps.getGeneratedKeys();
            int orderId = -1;
            if (keys.next()) {
                orderId = keys.getInt(1);
            }
            keys.close();

            if (orderId == -1) {
                throw new SQLException("Failed to create import order, no ID obtained.");
            }
            psItem = conn.prepareStatement(
                    "INSERT INTO tblImportOrderItem(import_order_id, book_id, quantity, unit_price, line_total) VALUES(?,?,?,?,?)");
            psUpdate = conn.prepareStatement(
                    "UPDATE tblDocument SET quantity = quantity + ?, availableQuantity = availableQuantity + ? WHERE id = ?");

            for (ImportOrderItem item : order.getItems()) {
                psItem.setInt(1, orderId);
                psItem.setInt(2, item.getBook().getId());
                psItem.setInt(3, item.getQuantity());
                psItem.setDouble(4, item.getUnitPrice());
                psItem.setDouble(5, item.getLineTotal());
                psItem.executeUpdate();

                psUpdate.setInt(1, item.getQuantity());
                psUpdate.setInt(2, item.getQuantity());
                psUpdate.setInt(3, item.getBook().getId());
                psUpdate.executeUpdate();
            }

            conn.commit();
            return orderId;

        } catch (Exception e) {
            if (conn != null) {
                try {
                    conn.rollback();
                    System.err.println("Transaction rolled back due to error: " + e.getMessage());
                } catch (SQLException ex) {
                    System.err.println("Error during rollback: " + ex.getMessage());
                }
            }
            throw e;

        } finally {
            try {
                if (psUpdate != null)
                    psUpdate.close();
                if (psItem != null)
                    psItem.close();
                if (ps != null)
                    ps.close();
                if (conn != null) {
                    conn.setAutoCommit(true);
                }
            } catch (SQLException e) {
                System.err.println("Error closing resources: " + e.getMessage());
            }
        }
    }

    public ImportOrder getById(int id) throws SQLException {
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement("SELECT io.*, s.name as supplier_name FROM tblImportOrder io "
                    + "JOIN tblSupplier s ON io.supplier_id = s.id WHERE io.id = ?");
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (!rs.next()) {
                return null;
            }

            ImportOrder order = new ImportOrder();
            order.setId(rs.getInt("id"));
            order.setCreatedBy(rs.getString("created_by"));
            order.setCreatedAt(rs.getTimestamp("created_at"));
            order.setTotalAmount(rs.getDouble("total_amount"));

            Supplier supplier = new Supplier();
            supplier.setId(rs.getInt("supplier_id"));
            supplier.setName(rs.getString("supplier_name"));
            order.setSupplier(supplier);

            return order;

        } finally {
            if (rs != null)
                rs.close();
            if (ps != null)
                ps.close();
        }
    }
}