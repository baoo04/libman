package com.libman.dao;

import com.libman.model.ImportOrderItem;
import com.libman.model.Book;

import java.sql.*;
import java.util.*;

public class ImportOrderItemDAO extends DAO {
    public ImportOrderItemDAO() throws SQLException {
        super();
    }

    public List<ImportOrderItem> getOrderItems(int importOrderId) throws SQLException {
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<ImportOrderItem> items = new ArrayList<>();

        try {
            ps = conn.prepareStatement("SELECT i.*, b.title, b.isbn FROM tblImportOrderItem i "
                    + "JOIN tblDocument b ON i.book_id = b.id WHERE i.import_order_id = ?");
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
            if (rs != null)
                rs.close();
            if (ps != null)
                ps.close();
        }
    }
}