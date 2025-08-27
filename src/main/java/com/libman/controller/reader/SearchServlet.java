package com.libman.controller.reader;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class SearchServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.getWriter().println("Search Servlet is working!");
    }
}
