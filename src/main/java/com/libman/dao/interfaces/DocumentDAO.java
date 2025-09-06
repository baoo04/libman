package com.libman.dao.interfaces;

import java.util.List;

import com.libman.model.Book;

public interface DocumentDAO {
    List<Book> searchBooksByTitle(String keyword);

    Book getBookById(int id);
}