package com.libman.controller.reader;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import com.libman.dao.DocumentDAO;
import com.libman.model.Book;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {
    private DocumentDAO documentDao;

    @Override
    public void init() throws ServletException {
        try {
            documentDao = new DocumentDAO();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @SuppressWarnings("unchecked")
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        String action = req.getParameter("action");
        String kw = req.getParameter("keyword");
        String id = req.getParameter("id");

        try {
            if ("search".equals(action) && kw != null && !kw.trim().isEmpty()) {
                List<Book> documents = documentDao.searchByName(kw.trim());
                session.setAttribute("lastKeyword", kw);
                session.setAttribute("lastResults", documents);

                req.setAttribute("keyword", kw);
                req.setAttribute("documents", documents);
                req.getRequestDispatcher("/WEB-INF/views/reader/search.jsp").forward(req, resp);

            } else if ("detail".equals(action) && id != null) {
                int _id = Integer.parseInt(id);
                Book book = documentDao.findById(_id);
                req.setAttribute("book", book);
                req.getRequestDispatcher("/WEB-INF/views/reader/book-detail.jsp").forward(req, resp);

            } else {
                List<Book> lastResults = (List<Book>) session.getAttribute("lastResults");
                String lastKeyword = (String) session.getAttribute("lastKeyword");

                req.setAttribute("keyword", lastKeyword);
                req.setAttribute("documents", lastResults);
                req.getRequestDispatcher("/WEB-INF/views/reader/search.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
