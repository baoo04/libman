package com.libman.controller.reader;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

import com.libman.dao.impl.DocumentDAOImpl;
import com.libman.dao.interfaces.DocumentDAO;
import com.libman.model.Book;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {
    public DocumentDAO documentDao;

    @Override
    public void init() throws ServletException {
        documentDao = new DocumentDAOImpl();
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        String kw = req.getParameter("keyword");
        String id = req.getParameter("id");
        if ("search".equals(action) && kw != null && !kw.trim().isEmpty()) {
            List<Book> documents = documentDao.searchBooksByTitle(kw.trim());
            req.setAttribute("documents", documents);
            req.setAttribute("keyword", kw);
            RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/reader/search.jsp");
            dispatcher.forward(req, resp);
        } else if ("detail".equals(action) && id != null) {
            try {
                int _id = Integer.parseInt(id);
                Book book = documentDao.getBookById(_id);
                req.setAttribute("book", book);
                RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/reader/book-detail.jsp");
                dispatcher.forward(req, resp);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        } else {
            req.setAttribute("keyword", kw);
            RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/reader/search.jsp");
            dispatcher.forward(req, resp);
        }
    }

}
