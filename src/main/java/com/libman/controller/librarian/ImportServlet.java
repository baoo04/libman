package com.libman.controller.librarian;

import com.libman.dao.SupplierDAO;
import com.libman.dao.DocumentDAO;
import com.libman.dao.ImportOrderDAO;
import com.libman.model.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.*;

@WebServlet("/import")
public class ImportServlet extends HttpServlet {
    private SupplierDAO supplierDAO;
    private DocumentDAO documentDAO;
    private ImportOrderDAO importOrderDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            supplierDAO = new SupplierDAO();
            documentDAO = new DocumentDAO();
            importOrderDAO = new ImportOrderDAO();
        } catch (java.sql.SQLException e) {
            throw new ServletException("Failed to initialize DAOs", e);
        }
    }

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

            @SuppressWarnings("unchecked") List<ImportOrderItem> cart = (List<ImportOrderItem>) session.getAttribute("import_cart");
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
                List<Book> found = documentDAO.searchByName(name == null ? "" : name);
                req.setAttribute("documents", found);
                req.getRequestDispatcher("/WEB-INF/views/librarian/import.jsp").forward(req, resp);
                return;
            }

            if ("addItem".equals(action)) {
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

                if (isbn == null || isbn.trim().isEmpty()) {
                    req.setAttribute("error", "ISBN không được để trống");
                    req.getRequestDispatcher("/WEB-INF/views/librarian/import.jsp").forward(req, resp);
                    return;
                }

                // If title is not provided but ISBN exists, try to get from database
                if ((title == null || title.trim().isEmpty())) {
                    Book existingBook = documentDAO.findByIsbn(isbn);
                    if (existingBook != null) {
                        title = existingBook.getTitle();
                        if (author == null || author.trim().isEmpty()) author = existingBook.getAuthor();
                        if (publisher == null || publisher.trim().isEmpty()) publisher = existingBook.getPublisher();
                        if (publishYearStr == null || publishYearStr.trim().isEmpty())
                            publishYearStr = String.valueOf(existingBook.getPublishYear());
                        if (category == null || category.trim().isEmpty()) category = existingBook.getCategory();
                        if (description == null || description.trim().isEmpty())
                            description = existingBook.getDescription();
                        if (content == null || content.trim().isEmpty()) content = existingBook.getContent();
                    } else {
                        req.setAttribute("error", "Tiêu đề không được để trống");
                        req.getRequestDispatcher("/WEB-INF/views/librarian/import.jsp").forward(req, resp);
                        return;
                    }
                }

                if (priceStr == null || priceStr.trim().isEmpty()) {
                    req.setAttribute("error", "Giá nhập không được để trống");
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
                    // Handle both integer and decimal inputs for price
                    double priceDouble = Double.parseDouble(priceStr);
                    long bookPrice = (long) priceDouble;
                    int publishYear = 0;

                    if (publishYearStr != null && !publishYearStr.trim().isEmpty()) {
                        publishYear = Integer.parseInt(publishYearStr);
                    }

                    if (qty <= 0) {
                        req.setAttribute("error", "Số lượng phải lớn hơn 0");
                        req.getRequestDispatcher("/WEB-INF/views/librarian/import.jsp").forward(req, resp);
                        return;
                    }

                    if (bookPrice <= 0) {
                        req.setAttribute("error", "Giá nhập phải lớn hơn 0");
                        req.getRequestDispatcher("/WEB-INF/views/librarian/import.jsp").forward(req, resp);
                        return;
                    }

                    for (ImportOrderItem existingItem : cart) {
                        if (existingItem.getBook().getIsbn().equals(isbn)) {
                            req.setAttribute("error", "ISBN này đã có trong giỏ hàng. Vui lòng chỉnh sửa trực tiếp trong bảng.");
                            req.getRequestDispatcher("/WEB-INF/views/librarian/import.jsp").forward(req, resp);
                            return;
                        }
                    }

                    // Create or update book in database
                    Book book = documentDAO.findByIsbn(isbn);
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

                        documentDAO.create(b);
                        book = documentDAO.findByIsbn(isbn);
                        req.setAttribute("message", "Đã tạo sách mới và thêm vào giỏ: " + book.getTitle());
                    } else {
                        req.setAttribute("message", "Đã thêm sách vào giỏ: " + book.getTitle());
                    }

                    // Add to cart
                    ImportOrderItem item = new ImportOrderItem();
                    item.setBook(book);
                    item.setQuantity(qty);
                    item.setUnitPrice(bookPrice);
                    item.setLineTotal(bookPrice * qty);
                    cart.add(item);

                    session.setAttribute("import_cart", cart);

                } catch (NumberFormatException e) {
                    req.setAttribute("error", "Số lượng, năm xuất bản, hoặc giá không hợp lệ");
                }

                resp.sendRedirect(req.getContextPath() + "/import");
                return;
            }

            if ("updateItem".equals(action)) {
                String idxStr = req.getParameter("index");
                String qtyStr = req.getParameter("quantity");
                String priceStr = req.getParameter("price");
                String author = req.getParameter("author");
                String publisher = req.getParameter("publisher");
                String publishYearStr = req.getParameter("publishYear");
                String category = req.getParameter("category");
                String description = req.getParameter("description");
                String content = req.getParameter("content");

                try {
                    int idx = Integer.parseInt(idxStr);
                    if (idx >= 0 && idx < cart.size()) {
                        ImportOrderItem item = cart.get(idx);
                        Book book = item.getBook();

                        // Parse and validate quantity
                        int qty;
                        try {
                            qty = Integer.parseInt(qtyStr);
                            if (qty <= 0) {
                                req.setAttribute("error", "Số lượng phải lớn hơn 0");
                                req.getRequestDispatcher("/WEB-INF/views/librarian/import.jsp").forward(req, resp);
                                return;
                            }
                        } catch (NumberFormatException e) {
                            req.setAttribute("error", "Số lượng không hợp lệ: " + qtyStr);
                            req.getRequestDispatcher("/WEB-INF/views/librarian/import.jsp").forward(req, resp);
                            return;
                        }

                        // Parse and validate price
                        long price;
                        try {
                            // Handle both integer and decimal inputs
                            double priceDouble = Double.parseDouble(priceStr);
                            price = (long) priceDouble;
                            if (price <= 0) {
                                req.setAttribute("error", "Giá nhập phải lớn hơn 0");
                                req.getRequestDispatcher("/WEB-INF/views/librarian/import.jsp").forward(req, resp);
                                return;
                            }
                        } catch (NumberFormatException e) {
                            req.setAttribute("error", "Giá không hợp lệ: " + priceStr);
                            req.getRequestDispatcher("/WEB-INF/views/librarian/import.jsp").forward(req, resp);
                            return;
                        }

                        // Update cart item
                        item.setQuantity(qty);
                        item.setUnitPrice(price);
                        item.setLineTotal(qty * price);

                        // Update book info
                        boolean bookUpdated = false;
                        if (author != null && !author.trim().equals(book.getAuthor())) {
                            book.setAuthor(author.trim());
                            bookUpdated = true;
                        }
                        if (publisher != null && !publisher.trim().equals(book.getPublisher())) {
                            book.setPublisher(publisher.trim());
                            bookUpdated = true;
                        }
                        if (publishYearStr != null && !publishYearStr.trim().isEmpty()) {
                            try {
                                int publishYear = Integer.parseInt(publishYearStr);
                                if (publishYear != book.getPublishYear()) {
                                    book.setPublishYear(publishYear);
                                    bookUpdated = true;
                                }
                            } catch (NumberFormatException e) {
                                // Ignore invalid year, keep original value
                            }
                        }
                        if (category != null && !category.trim().equals(book.getCategory())) {
                            book.setCategory(category.trim());
                            bookUpdated = true;
                        }
                        if (description != null && !description.trim().equals(book.getDescription())) {
                            book.setDescription(description.trim());
                            bookUpdated = true;
                        }
                        if (content != null && !content.trim().equals(book.getContent())) {
                            book.setContent(content.trim());
                            bookUpdated = true;
                        }
                        if (price != book.getPrice()) {
                            book.setPrice(price);
                            bookUpdated = true;
                        }

                        if (bookUpdated) {
                            documentDAO.update(book);
                        }

                        session.setAttribute("import_cart", cart);
                        req.setAttribute("message", "Đã cập nhật thông tin sách: " + book.getTitle());
                    } else {
                        req.setAttribute("error", "Chỉ số không hợp lệ");
                    }
                } catch (NumberFormatException e) {
                    req.setAttribute("error", "Dữ liệu không hợp lệ: " + e.getMessage());
                    e.printStackTrace();
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

                @SuppressWarnings("unchecked") List<ImportOrderItem> items = (List<ImportOrderItem>) session.getAttribute("import_cart");
                if (items == null || items.isEmpty()) {
                    req.setAttribute("error", "Danh sách nhập trống");
                    req.getRequestDispatcher("/WEB-INF/views/librarian/import.jsp").forward(req, resp);
                    return;
                }

                for (ImportOrderItem item : items) {
                    if (item.getUnitPrice() <= 0) {
                        req.setAttribute("error", "Tất cả sản phẩm phải có giá hợp lệ");
                        req.getRequestDispatcher("/WEB-INF/views/librarian/import.jsp").forward(req, resp);
                        return;
                    }
                }

                ImportOrder order = new ImportOrder();
                order.setSupplier(s);
                order.setCreatedBy(createdBy == null ? "unknown" : createdBy);
                order.setItems(items);
                double total = items.stream().mapToDouble(ImportOrderItem::getLineTotal).sum();
                order.setTotalAmount(total);

                int orderId = importOrderDAO.create(order);

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