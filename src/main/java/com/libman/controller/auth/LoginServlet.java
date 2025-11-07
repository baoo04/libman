package com.libman.controller.auth;

import com.libman.dao.UserDAO;
import com.libman.model.User;
import com.libman.util.PasswordUtil;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Set;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private final UserDAO userDAO;

    public LoginServlet() {
        try {
            this.userDAO = new UserDAO();
        } catch (java.sql.SQLException e) {
            throw new RuntimeException("Failed to initialize UserDAO", e);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String u = req.getParameter("username");
        String p = req.getParameter("password");
        User user;
        try {
            user = userDAO.findByUsername(u);
            if (user != null && PasswordUtil.matches(p, user.getPassword())) {
                // Set<String> roles = userDAO.findRoles(user.getId());
                HttpSession s = req.getSession(true);
                s.setAttribute("user", user);
                // s.setAttribute("roles", roles);
                resp.sendRedirect(req.getContextPath() + "/index.jsp");
            } else {
                req.setAttribute("error", "Sai thông tin đăng nhập");
                doGet(req, resp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }
}
