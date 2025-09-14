package com.libman.dao;

import com.libman.config.DataSourceProvider;
import com.libman.model.Book;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookDAO {
    public Book findByIsbn(String isbn) throws Exception {
        try (Connection c = DataSourceProvider.get().getConnection();
                PreparedStatement ps = c.prepareStatement("SELECT * FROM tblBook WHERE isbn = ?")) {
            ps.setString(1, isbn);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Book b = new Book();
                    b.setId(rs.getInt("id"));
                    b.setIsbn(rs.getString("isbn"));
                    b.setTitle(rs.getString("title"));
                    b.setAuthor(rs.getString("author"));
                    b.setPublisher(rs.getString("publisher"));
                    b.setPrice(rs.getLong("price"));
                    b.setPublishYear(rs.getInt("publishYear"));
                    b.setQuantity(rs.getInt("quantity"));
                    b.setAvailableQuantity(rs.getInt("availableQuantity"));
                    b.setDescription(rs.getString("description"));
                    return b;
                }
            }
        }
        return null;
    }

    public Book findById(int id) throws Exception {
        try (Connection c = DataSourceProvider.get().getConnection();
                PreparedStatement ps = c.prepareStatement("SELECT * FROM tblBook WHERE id=?")) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Book b = new Book();
                    b.setId(rs.getInt("id"));
                    b.setIsbn(rs.getString("isbn"));
                    b.setTitle(rs.getString("title"));
                    b.setAuthor(rs.getString("author"));
                    b.setPublisher(rs.getString("publisher"));
                    b.setPrice(rs.getLong("price"));
                    b.setCategory(rs.getString("category"));
                    b.setContent(rs.getString("content"));
                    b.setPublishYear(rs.getInt("publishYear"));
                    b.setQuantity(rs.getInt("quantity"));
                    b.setAvailableQuantity(rs.getInt("availableQuantity"));
                    b.setDescription(rs.getString("description"));
                    return b;
                }
            }
        }
        return null;
    }

    public Book create(Book b) throws Exception {
        try (Connection c = DataSourceProvider.get().getConnection();
                PreparedStatement ps = c.prepareStatement(
                        "INSERT INTO tblBook(isbn,title,author,publisher,price,publishYear,category,quantity,availableQuantity,description,content) "
                                +
                                "VALUES(?,?,?,?,?,?,?,?,?,?,?)",
                        Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, b.getIsbn());
            ps.setString(2, b.getTitle());
            ps.setString(3, b.getAuthor());
            ps.setString(4, b.getPublisher());
            ps.setLong(5, b.getPrice());
            ps.setInt(6, b.getPublishYear());
            ps.setString(7, b.getCategory());
            ps.setInt(8, b.getQuantity());
            ps.setInt(9, b.getAvailableQuantity());
            ps.setString(10, b.getDescription());
            ps.setString(11, b.getContent());
            ps.executeUpdate();
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) {
                    b.setId(keys.getInt(1));
                    return b;
                }
            }
        }
        return null;
    }

    public void increaseStock(int bookId, int qty) throws Exception {
        try (Connection c = DataSourceProvider.get().getConnection();
                PreparedStatement ps = c.prepareStatement(
                        "UPDATE tblBook SET quantity = quantity + ?, availableQuantity = availableQuantity + ? WHERE id = ?")) {
            ps.setInt(1, qty);
            ps.setInt(2, qty);
            ps.setInt(3, bookId);
            ps.executeUpdate();
        }
    }

    public List<Book> searchByName(String name) throws Exception {
        List<Book> res = new ArrayList<>();
        try (Connection c = DataSourceProvider.get().getConnection();
                PreparedStatement ps = c.prepareStatement("SELECT * FROM tblBook WHERE title LIKE ?")) {
            ps.setString(1, "%" + name + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Book b = new Book();
                    b.setId(rs.getInt("id"));
                    b.setIsbn(rs.getString("isbn"));
                    b.setTitle(rs.getString("title"));
                    b.setAuthor(rs.getString("author"));
                    b.setPrice(rs.getLong("price"));
                    b.setPublisher(rs.getString("publisher"));
                    b.setPublishYear(rs.getInt("publishYear"));
                    b.setQuantity(rs.getInt("quantity"));
                    b.setAvailableQuantity(rs.getInt("availableQuantity"));
                    b.setDescription(rs.getString("description"));
                    b.setContent(rs.getString("content"));
                    res.add(b);
                }
            }
        }
        return res;
    }

    public void update(Book b) throws Exception {
        try (Connection c = DataSourceProvider.get().getConnection();
                PreparedStatement ps = c.prepareStatement(
                        "UPDATE tblBook SET isbn=?, title=?, author=?, publisher=?, price=?, publishYear=?, category=?, quantity=?, availableQuantity=?, description=?, content=? WHERE id=?")) {

            ps.setString(1, b.getIsbn());
            ps.setString(2, b.getTitle());
            ps.setString(3, b.getAuthor());
            ps.setString(4, b.getPublisher());
            ps.setLong(5, b.getPrice());
            ps.setInt(6, b.getPublishYear());
            ps.setString(7, b.getCategory());
            ps.setInt(8, b.getQuantity());
            ps.setInt(9, b.getAvailableQuantity());
            ps.setString(10, b.getDescription());
            ps.setString(11, b.getContent());
            ps.setInt(12, b.getId());

            ps.executeUpdate();
        }
    }

}
