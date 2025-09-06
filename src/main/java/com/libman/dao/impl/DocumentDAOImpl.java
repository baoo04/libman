package com.libman.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.libman.config.DataSourceProvider;
import com.libman.dao.interfaces.DocumentDAO;
import com.libman.model.Book;

public class DocumentDAOImpl implements DocumentDAO {
    private static final String SEARCH_BOOKS = "SELECT * FROM tblBook WHERE title LIKE ?";

    private static final String FIND_BY_ID = "SELECT * FROM tblBook WHERE id = ?";

    public DocumentDAOImpl() {
    }

    @Override
    public List<Book> searchBooksByTitle(String keyword) {
        List<Book> books = new ArrayList<>();
        try (Connection c = DataSourceProvider.get().getConnection();
                PreparedStatement ps = c.prepareStatement(SEARCH_BOOKS)) {
            ps.setString(1, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Book book = new Book();
                    book.setId(rs.getInt("id"));
                    book.setIsbn(rs.getString("isbn"));
                    book.setTitle(rs.getString("title"));
                    book.setAuthor(rs.getString("author"));
                    book.setPublisher(rs.getString("publisher"));
                    book.setPublishYear(rs.getInt("publishYear"));
                    book.setCategory(rs.getString("category"));
                    book.setQuantity(rs.getInt("quantity"));
                    book.setAvailableQuantity(rs.getInt("availableQuantity"));
                    book.setDescription(rs.getString("description"));
                    books.add(book);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return books;
    }

    public Book getBookById(int id) {
        try (Connection c = DataSourceProvider.get().getConnection();
                PreparedStatement ps = c.prepareStatement(FIND_BY_ID)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Book book = new Book();
                    book.setId(rs.getInt("id"));
                    book.setIsbn(rs.getString("isbn"));
                    book.setTitle(rs.getString("title"));
                    book.setAuthor(rs.getString("author"));
                    book.setPublisher(rs.getString("publisher"));
                    book.setPublishYear(rs.getInt("publishYear"));
                    book.setCategory(rs.getString("category"));
                    book.setQuantity(rs.getInt("quantity"));
                    book.setAvailableQuantity(rs.getInt("availableQuantity"));
                    book.setDescription(rs.getString("description"));
                    return book;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}