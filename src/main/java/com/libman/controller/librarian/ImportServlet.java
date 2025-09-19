package com.libman.controller.librarian;

import com.libman.dao.SupplierDAO;
import com.libman.dao.BookDAO;
import com.libman.dao.ImportOrderDAO;
import com.libman.model.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.*;

@WebServlet("/import")
public class ImportServlet extends HttpServlet {
    private SupplierDAO supplierDAO = new SupplierDAO();
    private BookDAO bookDAO = new BookDAO();
    private ImportOrderDAO importOrderDAO = new ImportOrderDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/librarian/import.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String action = req.getParameter("action");
            HttpSession session = req.getSession();

            if ("searchSupplier".equals(action)) {
                String name = req.getParameter("supplierName");
                List<Supplier> found = supplierDAO.searchByName(name == null ? "" : name);
                req.setAttribute("suppliers", found);
                req.getRequestDispatcher("/WEB-INF/views/librarian/import.jsp").forward(req, resp);
                return;
            }

            if ("addSupplier".equals(action)) {
                String name = req.getParameter("name");
                String phone = req.getParameter("phone");
                String contact_name = req.getParameter("contact_name");
                String email = req.getParameter("email");
                String address = req.getParameter("address");
                Supplier s = new Supplier();
                s.setName(name);
                s.setContactName(contact_name);
                s.setPhone(phone);
                s.setEmail(email);
                s.setAddress(address);
                supplierDAO.create(s);
                req.setAttribute("message", "Đã thêm nhà cung cấp: " + s.getName());
                session.setAttribute("selected_supplier", s);
                session.setAttribute("selected_supplier_id", String.valueOf(s.getId()));
                req.getRequestDispatcher("/WEB-INF/views/librarian/import.jsp").forward(req, resp);
                return;
            }

            @SuppressWarnings("unchecked")
            List<ImportOrderItem> cart = (List<ImportOrderItem>) session.getAttribute("import_cart");
            if (cart == null) {
                cart = new ArrayList<>();
            }

            if ("selectSupplier".equals(action)) {
                String supplierIdStr = req.getParameter("supplier_id");
                if (supplierIdStr != null && !supplierIdStr.trim().isEmpty()) {
                    try {
                        int supplierId = Integer.parseInt(supplierIdStr);
                        session.setAttribute("selected_supplier_id", supplierIdStr);

                        Supplier selectedSupplier = supplierDAO.findById(supplierId);
                        if (selectedSupplier != null) {
                            session.setAttribute("selected_supplier", selectedSupplier);
                            req.setAttribute("message", "Đã chọn nhà cung cấp: " + selectedSupplier.getName());
                        }
                    } catch (NumberFormatException e) {
                        req.setAttribute("error", "ID nhà cung cấp không hợp lệ");
                    } catch (Exception e) {
                        req.setAttribute("error", "Lỗi khi chọn nhà cung cấp: " + e.getMessage());
                    }
                }
                req.getRequestDispatcher("/WEB-INF/views/librarian/import.jsp").forward(req, resp);
                return;
            }

            if ("searchDocument".equals(action)) {
                String name = req.getParameter("documentName");
                List<Book> found = bookDAO.searchByName(name == null ? "" : name);
                req.setAttribute("documents", found);
                req.getRequestDispatcher("/WEB-INF/views/librarian/import.jsp").forward(req, resp);
                return;
            }

            if ("selectDocument".equals(action)) {
                String documentIdStr = req.getParameter("document_id");
                if (documentIdStr != null && !documentIdStr.trim().isEmpty()) {
                    try {
                        int documentId = Integer.parseInt(documentIdStr);
                        session.setAttribute("selected_document_id", documentIdStr);

                        Book selectedDocument = bookDAO.findById(documentId);
                        if (selectedDocument != null) {
                            session.setAttribute("selected_document", selectedDocument);
                            req.setAttribute("message", "Đã chọn tài liệu " + selectedDocument.getTitle());
                        }
                    } catch (NumberFormatException e) {
                        req.setAttribute("error", "ID tài liệu không hợp lệ");
                    } catch (Exception e) {
                        req.setAttribute("error", "Lỗi khi chọn tài liệu: " + e.getMessage());
                    }
                }
                req.getRequestDispatcher("/WEB-INF/views/librarian/import.jsp").forward(req, resp);
                return;
            }

            if ("addItem".equals(action)) {
                // Get all book attributes
                String isbn = req.getParameter("isbn");
                String title = req.getParameter("title");
                String author = req.getParameter("author");
                String publisher = req.getParameter("publisher");
                String publishYearStr = req.getParameter("publishYear");
                String category = req.getParameter("category");
                String description = req.getParameter("description");
                String content = req.getParameter("content");
                String priceStr = req.getParameter("price");
                String qtyStr = req.getParameter("quantity");

                // Validate required fields
                if (isbn == null || isbn.trim().isEmpty()) {
                    req.setAttribute("error", "ISBN không được để trống");
                    req.getRequestDispatcher("/WEB-INF/views/librarian/import.jsp").forward(req, resp);
                    return;
                }

                if (title == null || title.trim().isEmpty()) {
                    req.setAttribute("error", "Tiêu đề không được để trống");
                    req.getRequestDispatcher("/WEB-INF/views/librarian/import.jsp").forward(req, resp);
                    return;
                }

                if (qtyStr == null || qtyStr.trim().isEmpty()) {
                    req.setAttribute("error", "Số lượng nhập không được để trống");
                    req.getRequestDispatcher("/WEB-INF/views/librarian/import.jsp").forward(req, resp);
                    return;
                }

                try {
                    int qty = Integer.parseInt(qtyStr);
                    int publishYear = 0;
                    long bookPrice = 0;

                    if (publishYearStr != null && !publishYearStr.trim().isEmpty()) {
                        publishYear = Integer.parseInt(publishYearStr);
                    }

                    if (priceStr != null && !priceStr.trim().isEmpty()) {
                        bookPrice = Long.parseLong(priceStr);
                    }

                    // Validate positive values
                    if (qty <= 0) {
                        req.setAttribute("error", "Số lượng phải lớn hơn 0");
                        req.getRequestDispatcher("/WEB-INF/views/librarian/import.jsp").forward(req, resp);
                        return;
                    }

                    Book book = bookDAO.findByIsbn(isbn);
                    if (book == null) {
                        Book b = new Book();
                        b.setIsbn(isbn);
                        b.setTitle(title.trim());
                        b.setAuthor(author != null ? author.trim() : "");
                        b.setPublisher(publisher != null ? publisher.trim() : "");
                        b.setPublishYear(publishYear);
                        b.setCategory(category != null ? category.trim() : "");
                        b.setDescription(description != null ? description.trim() : "");
                        b.setContent(content != null ? content.trim() : "");
                        b.setPrice(bookPrice);
                        b.setQuantity(0);
                        b.setAvailableQuantity(0);

                        bookDAO.create(b);
                        book = bookDAO.findByIsbn(isbn);
                        req.setAttribute("message", "Đã tạo sách mới: " + book.getTitle());
                    } else {
                        // Update existing book with new information if provided
                        boolean updated = false;
                        if (!title.trim().equals(book.getTitle())) {
                            book.setTitle(title.trim());
                            updated = true;
                        }
                        if (author != null && !author.trim().equals(book.getAuthor())) {
                            book.setAuthor(author.trim());
                            updated = true;
                        }
                        if (publisher != null && !publisher.trim().equals(book.getPublisher())) {
                            book.setPublisher(publisher.trim());
                            updated = true;
                        }
                        if (publishYear > 0 && publishYear != book.getPublishYear()) {
                            book.setPublishYear(publishYear);
                            updated = true;
                        }
                        if (category != null && !category.trim().equals(book.getCategory())) {
                            book.setCategory(category.trim());
                            updated = true;
                        }
                        if (description != null && !description.trim().equals(book.getDescription())) {
                            book.setDescription(description.trim());
                            updated = true;
                        }
                        if (content != null && !content.trim().equals(book.getContent())) {
                            book.setContent(content.trim());
                            updated = true;
                        }
                        if (bookPrice > 0 && bookPrice != book.getPrice()) {
                            book.setPrice(bookPrice);
                            updated = true;
                        }

                        if (updated) {
                            bookDAO.update(book);
                            req.setAttribute("message", "Đã cập nhật thông tin sách: " + book.getTitle());
                        }
                    }

                    // Check if item with same ISBN already exists in cart
                    boolean itemExists = false;
                    for (ImportOrderItem existingItem : cart) {
                        if (existingItem.getBook().getIsbn().equals(isbn)) {
                            // Update existing item
                            existingItem.setQuantity(existingItem.getQuantity() + qty);
                            itemExists = true;
                            req.setAttribute("message", "Đã cập nhật số lượng cho: " + book.getTitle());
                            break;
                        }
                    }

                    if (!itemExists) {
                        ImportOrderItem item = new ImportOrderItem();
                        item.setBook(book);
                        item.setQuantity(qty);
                        item.setLineTotal(book.getPrice() * book.getQuantity());
                        cart.add(item);

                        if (!req.getAttribute("message").toString().contains("cập nhật")) {
                            req.setAttribute("message", "Đã thêm vào danh sách nhập: " + book.getTitle());
                        }
                    }

                    session.setAttribute("import_cart", cart);

                } catch (NumberFormatException e) {
                    req.setAttribute("error", "Số lượng, năm xuất bản, hoặc giá không hợp lệ");
                }

                req.getRequestDispatcher("/WEB-INF/views/librarian/import.jsp").forward(req, resp);
                session.removeAttribute("selected_document");
                return;
            }

            if ("updateItemPrice".equals(action)) {
                String indexStr = req.getParameter("index");
                String newPriceStr = req.getParameter("newPrice");

                try {
                    int index = Integer.parseInt(indexStr);
                    double newPrice = Double.parseDouble(newPriceStr);

                    if (index >= 0 && index < cart.size() && newPrice > 0) {
                        ImportOrderItem item = cart.get(index);
                        item.setUnitPrice(newPrice);
                        item.setLineTotal(item.getQuantity() * newPrice);
                        session.setAttribute("import_cart", cart);
                        req.setAttribute("message", "Đã cập nhật giá cho: " + item.getBook().getTitle());
                    } else {
                        req.setAttribute("error", "Thông tin cập nhật giá không hợp lệ");
                    }
                } catch (NumberFormatException e) {
                    req.setAttribute("error", "Giá mới không hợp lệ");
                }

                req.getRequestDispatcher("/WEB-INF/views/librarian/import.jsp").forward(req, resp);
                return;
            }

            if ("submitOrder".equals(action)) {
                String supplierIdStr = req.getParameter("supplier_id");
                String createdBy = req.getParameter("createdBy");

                if (supplierIdStr == null || supplierIdStr.trim().isEmpty()) {
                    req.setAttribute("error", "Chưa chọn nhà cung cấp");
                    req.getRequestDispatcher("/WEB-INF/views/librarian/import.jsp").forward(req, resp);
                    return;
                }

                int supplierId = Integer.parseInt(supplierIdStr);
                Supplier s = supplierDAO.findById(supplierId);
                if (s == null) {
                    req.setAttribute("error", "Nhà cung cấp không tồn tại");
                    req.getRequestDispatcher("/WEB-INF/views/librarian/import.jsp").forward(req, resp);
                    return;
                }

                @SuppressWarnings("unchecked")
                List<ImportOrderItem> items = (List<ImportOrderItem>) session.getAttribute("import_cart");
                if (items == null || items.isEmpty()) {
                    req.setAttribute("error", "Danh sách nhập trống");
                    req.getRequestDispatcher("/WEB-INF/views/librarian/import.jsp").forward(req, resp);
                    return;
                }

                // Validate all items have valid prices
                for (ImportOrderItem item : items) {
                    if (item.book.getPrice() <= 0) {
                        req.setAttribute("error", "Tất cả sản phẩm phải có giá hợp lệ");
                        req.getRequestDispatcher("/WEB-INF/views/librarian/import.jsp").forward(req, resp);
                        return;
                    }
                }

                ImportOrder order = new ImportOrder();
                order.setSupplier(s);
                order.setCreatedBy(createdBy == null ? "unknown" : createdBy);
                order.setItems(items);
                double total = items.stream().mapToDouble(i -> i.getLineTotal()).sum();
                order.setTotalAmount(total);

                int orderId = importOrderDAO.create(order);

                // Clear cart after successful order creation
                session.removeAttribute("import_cart");
                session.removeAttribute("selected_supplier");
                session.removeAttribute("selected_supplier_id");

                resp.sendRedirect(req.getContextPath() + "/invoice?id=" + orderId);
                return;
            }

            if ("removeItem".equals(action)) {
                String idxStr = req.getParameter("index");
                try {
                    int idx = Integer.parseInt(idxStr);
                    if (idx >= 0 && idx < cart.size()) {
                        ImportOrderItem removedItem = cart.remove(idx);
                        session.setAttribute("import_cart", cart);
                        req.setAttribute("message", "Đã xóa: " + removedItem.getBook().getTitle());
                    } else {
                        req.setAttribute("error", "Chỉ số không hợp lệ");
                    }
                } catch (NumberFormatException e) {
                    req.setAttribute("error", "Chỉ số không hợp lệ");
                }
                req.getRequestDispatcher("/WEB-INF/views/librarian/import.jsp").forward(req, resp);
                return;
            }

            if ("clearCart".equals(action)) {
                session.removeAttribute("import_cart");
                req.setAttribute("message", "Đã xóa tất cả sản phẩm khỏi danh sách nhập");
                req.getRequestDispatcher("/WEB-INF/views/librarian/import.jsp").forward(req, resp);
                return;
            }

            // Calculate cart total for display
            if (!cart.isEmpty()) {
                double cartTotal = cart.stream().mapToDouble(item -> item.getLineTotal()).sum();
                req.setAttribute("cartTotal", cartTotal);
            }

            req.getRequestDispatcher("/WEB-INF/views/librarian/import.jsp").forward(req, resp);
        } catch (Exception ex) {
            ex.printStackTrace();
            req.setAttribute("error", "Có lỗi xảy ra: " + ex.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/librarian/import.jsp").forward(req, resp);
        }
    }
}