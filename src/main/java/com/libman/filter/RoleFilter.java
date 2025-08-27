package com.libman.filter;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Set;

public class RoleFilter implements Filter {
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest r = (HttpServletRequest) req;
        HttpServletResponse s = (HttpServletResponse) res;
        HttpSession session = r.getSession(false);
        @SuppressWarnings("unchecked")
        Set<String> roles = (Set<String>) session.getAttribute("roles");
        String uri = r.getRequestURI();

        if (uri.contains("/app/manager/") && (roles == null || !roles.contains("MANAGER"))) {
            s.sendError(403);
            return;
        }
        if (uri.contains("/app/librarian/") && (roles == null || !roles.contains("LIBRARIAN"))) {
            s.sendError(403);
            return;
        }
        chain.doFilter(req, res);
    }
}
