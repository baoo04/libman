package com.libman.dao;

import com.libman.config.DataSourceProvider;
import com.libman.model.ImportOrder;
import com.libman.model.ImportOrderItem;
import java.sql.*;

public class ImportOrderDAO {
    public int create(ImportOrder order) throws Exception {
        Connection c = null;
        try {
            c = DataSourceProvider.get().getConnection();
            c.setAutoCommit(false);

            PreparedStatement ps = c.prepareStatement(
                    "INSERT INTO import_order(supplier_id, created_by, total_amount) VALUES(?,?,?)",
                    Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, order.getSupplier().getId());
            ps.setString(2, order.getCreatedBy());
            ps.setDouble(3, order.getTotalAmount());
            ps.executeUpdate();
            ResultSet keys = ps.getGeneratedKeys();
            int orderId = -1;
            if (keys.next())
                orderId = keys.getInt(1);

            PreparedStatement psItem = c.prepareStatement(
                    "INSERT INTO import_order_item(import_order_id, book_id, quantity, unit_price, line_total) VALUES(?,?,?,?,?)");
            BookDAO bookDAO = new BookDAO();
            for (ImportOrderItem item : order.getItems()) {
                psItem.setInt(1, orderId);
                psItem.setInt(2, item.getBook().getId());
                psItem.setInt(3, item.getQuantity());
                psItem.setDouble(4, item.getUnitPrice());
                psItem.setDouble(5, item.getLineTotal());
                psItem.executeUpdate();

                // update book stock
                PreparedStatement psUpdate = c.prepareStatement(
                        "UPDATE tblBook SET quantity = quantity + ?, availableQuantity = availableQuantity + ? WHERE id = ?");
                psUpdate.setInt(1, item.getQuantity());
                psUpdate.setInt(2, item.getQuantity());
                psUpdate.setInt(3, item.getBook().getId());
                psUpdate.executeUpdate();
                psUpdate.close();
            }

            c.commit();
            return orderId;
        } catch (Exception ex) {
            if (c != null)
                c.rollback();
            throw ex;
        } finally {
            if (c != null)
                c.setAutoCommit(true);
            if (c != null)
                c.close();
        }
    }
}
