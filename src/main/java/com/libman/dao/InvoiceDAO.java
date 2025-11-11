package com.libman.dao;

import com.libman.model.ImportOrderItem;
import com.libman.model.ImportOrder;

import java.sql.*;
import java.util.*;

public class InvoiceDAO extends DAO {

    private ImportOrderItemDAO importOrderItemDAO = null;
    private ImportOrderDAO importOrderDAO = null;
    public InvoiceDAO() throws SQLException {
        super();
    }

    public void init() throws SQLException {
        this.importOrderItemDAO = new ImportOrderItemDAO();
        this.importOrderDAO = new ImportOrderDAO();
    }

    public Map<String, Object> getInvoiceData(int id) throws SQLException {
        ImportOrder order = importOrderDAO.getById(id);
        if (order == null) {
            return null;
        }

        List<ImportOrderItem> items = importOrderItemDAO.getOrderItems(id);

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