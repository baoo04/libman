package com.libman.controller.librarian;

import java.io.IOException;
import java.util.Map;
import com.libman.dao.InvoiceDAO;
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

        try {
            int id = Integer.parseInt(idStr);

            InvoiceDAO dao = new InvoiceDAO();
            Map<String, Object> invoiceData = dao.getInvoiceData(id);

            if (invoiceData == null) {
                resp.sendRedirect(req.getContextPath() + "/import");
                return;
            }

            req.setAttribute("orderId", invoiceData.get("orderId"));
            req.setAttribute("supplierName", invoiceData.get("supplierName"));
            req.setAttribute("createdBy", invoiceData.get("createdBy"));
            req.setAttribute("createdAt", invoiceData.get("createdAt"));
            req.setAttribute("totalAmount", invoiceData.get("totalAmount"));
            req.setAttribute("items", invoiceData.get("items"));

            req.getRequestDispatcher("/WEB-INF/views/librarian/invoice.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/import");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}