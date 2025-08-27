<%@ page import="com.libman.model.User" %> <% User user = (User)
session.getAttribute("user"); %> <%@ page language="java"
contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<header class="bg-blue-700 text-white p-4 shadow-md">
  <div class="container mx-auto flex justify-between items-center">
    <h2 class="text-xl font-bold">Library System</h2>
    <nav class="flex items-center">
      <a href="index.jsp" class="mr-4 hover:underline">Home</a>
      <a href="document-list.jsp" class="mr-4 hover:underline">Documents</a>
      <a href="borrow.jsp" class="mr-4 hover:underline">Borrow</a>
      <a href="import.jsp" class="mr-4 hover:underline">Import</a>
      <a href="reports.jsp" class="mr-6 hover:underline">Reports</a>

      <% if (user != null) { %>
      <span class="mr-4">Xin chào, <%= user.getUsername() %></span>
      <a href="logout" class="bg-red-500 px-3 py-1 rounded hover:bg-red-600"
        >Đăng xuất</a
      >
      <% } else { %>
      <a href="login" class="bg-green-500 px-3 py-1 rounded hover:bg-green-600"
        >Đăng nhập</a
      >
      <% } %>
    </nav>
  </div>
</header>
