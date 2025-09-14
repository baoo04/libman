package com.libman.controller.librarian;

import java.io.IOException;
import java.sql.*;
import java.util.*;

import com.libman.config.DataSourceProvider;
import jakarta.servlet.annotation.WebServlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/invoice")
public class InvoiceServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr == null) {
            resp.sendRedirect(req.getContextPath() + "/import");
            return;
        }
        int id = Integer.parseInt(idStr);
        try (Connection c = DataSourceProvider.get().getConnection()) {
            PreparedStatement ps = c.prepareStatement(
                    "SELECT io.*, s.name as supplier_name FROM import_order io JOIN tblSupplier s ON io.supplier_id = s.id WHERE io.id = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (!rs.next()) {
                resp.sendRedirect(req.getContextPath() + "/import");
                return;
            }
            req.setAttribute("orderId", id);
            req.setAttribute("supplierName", rs.getString("supplier_name"));
            req.setAttribute("createdBy", rs.getString("created_by"));
            req.setAttribute("totalAmount", rs.getDouble("total_amount"));

            PreparedStatement ps2 = c.prepareStatement(
                    "SELECT i.*, b.title, b.isbn FROM import_order_item i JOIN tblBook b ON i.book_id = b.id WHERE i.import_order_id = ?");
            ps2.setInt(1, id);
            ResultSet rs2 = ps2.executeQuery();
            List<Map<String, Object>> items = new ArrayList<>();
            while (rs2.next()) {
                Map<String, Object> m = new HashMap<>();
                m.put("title", rs2.getString("title"));
                m.put("isbn", rs2.getString("isbn"));
                m.put("quantity", rs2.getInt("quantity"));
                m.put("unitPrice", rs2.getDouble("unit_price"));
                m.put("lineTotal", rs2.getDouble("line_total"));
                items.add(m);
            }
            req.setAttribute("items", items);
            req.getRequestDispatcher("/WEB-INF/views/librarian/invoice.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
