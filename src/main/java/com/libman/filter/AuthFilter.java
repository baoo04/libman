package com.libman.filter;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class AuthFilter implements Filter {
  public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
    HttpServletRequest r = (HttpServletRequest) req;
    HttpServletResponse s = (HttpServletResponse) res;
    HttpSession session = r.getSession(false);
    boolean loggedIn = (session != null && session.getAttribute("user") != null);
    if (!loggedIn) { s.sendRedirect(r.getContextPath()+"/login"); return; }
    chain.doFilter(req,res);
  }
}
