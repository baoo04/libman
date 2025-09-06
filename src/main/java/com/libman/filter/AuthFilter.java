package com.libman.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {
  @Override
  public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
      throws IOException, ServletException {
    HttpServletRequest request = (HttpServletRequest) req;
    HttpServletResponse response = (HttpServletResponse) res;
    HttpSession session = request.getSession(false);

    String loginURI = request.getContextPath() + "/login";

    boolean loggedIn = (session != null && session.getAttribute("user") != null);
    boolean loginRequest = request.getRequestURI().equals(loginURI) || request.getRequestURI().endsWith("login.jsp")
        || request.getRequestURI().contains("/css/") || request.getRequestURI().contains("/js/")
        || request.getRequestURI().contains("/images/");

    if (loggedIn || loginRequest) {
      chain.doFilter(req, res);
    } else {
      response.sendRedirect(loginURI);
    }
  }
}
