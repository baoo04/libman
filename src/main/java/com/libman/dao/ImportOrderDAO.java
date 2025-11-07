package com.libman.dao;

import com.libman.model.ImportOrder;
import com.libman.model.ImportOrderItem;
import com.libman.model.Book;
import com.libman.model.Supplier;

import java.sql.*;
import java.util.*;

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
            ps = conn.prepareStatement("INSERT INTO tblImportOrder(supplier_id, created_by, total_amount, created_at) VALUES(?,?,?,?)", Statement.RETURN_GENERATED_KEYS);
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
            psItem = conn.prepareStatement("INSERT INTO tblImportOrderItem(import_order_id, book_id, quantity, unit_price, line_total) VALUES(?,?,?,?,?)");
            psUpdate = conn.prepareStatement("UPDATE tblBook SET quantity = quantity + ?, availableQuantity = availableQuantity + ? WHERE id = ?");

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
                if (psUpdate != null) psUpdate.close();
                if (psItem != null) psItem.close();
                if (ps != null) ps.close();
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
            ps = conn.prepareStatement("SELECT io.*, s.name as supplier_name FROM tblImportOrder io " + "JOIN tblSupplier s ON io.supplier_id = s.id WHERE io.id = ?");
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
            if (rs != null) rs.close();
            if (ps != null) ps.close();
        }
    }

    public List<ImportOrderItem> getOrderItems(int importOrderId) throws SQLException {
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<ImportOrderItem> items = new ArrayList<>();

        try {
            ps = conn.prepareStatement("SELECT i.*, b.title, b.isbn FROM tblImportOrderItem i " + "JOIN tblBook b ON i.book_id = b.id WHERE i.import_order_id = ?");
            ps.setInt(1, importOrderId);
            rs = ps.executeQuery();

            while (rs.next()) {
                ImportOrderItem item = new ImportOrderItem();
                item.setQuantity(rs.getInt("quantity"));
                item.setUnitPrice(rs.getDouble("unit_price"));
                item.setLineTotal(rs.getDouble("line_total"));

                Book book = new Book();
                book.setId(rs.getInt("book_id"));
                book.setTitle(rs.getString("title"));
                book.setIsbn(rs.getString("isbn"));
                item.setBook(book);

                items.add(item);
            }

            return items;

        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
        }
    }

    public Map<String, Object> getInvoiceData(int id) throws SQLException {
        ImportOrder order = getById(id);
        if (order == null) {
            return null;
        }

        List<ImportOrderItem> items = getOrderItems(id);

        Map<String, Object> invoiceData = new HashMap<>();
        invoiceData.put("orderId", order.getId());
        invoiceData.put("supplierName", order.getSupplier().getName());
        invoiceData.put("createdAt", order.getCreatedAt());
        invoiceData.put("createdBy", order.getCreatedBy());
        invoiceData.put("totalAmount", order.getTotalAmount());

        List<Map<String, Object>> itemMaps = new ArrayList<>();
        for (ImportOrderItem item : items) {
            Map<String, Object> m = new HashMap<>();
            m.put("title", item.getBook().getTitle());
            m.put("isbn", item.getBook().getIsbn());
            m.put("quantity", item.getQuantity());
            m.put("unitPrice", item.getUnitPrice());
            m.put("lineTotal", item.getLineTotal());
            itemMaps.add(m);
        }
        invoiceData.put("items", itemMaps);

        return invoiceData;
    }
}