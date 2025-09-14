<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Library Management System</title>
    <link
      href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css"
      rel="stylesheet"
    />
  </head>
  <% if (session.getAttribute("user") == null) {
  response.sendRedirect(request.getContextPath() + "/login"); return; } %>
  <body class="bg-gray-100">
    <jsp:include page="/WEB-INF/views/_layouts/header.jsp" />

    <div class="container mx-auto mt-10">
      <h1 class="text-3xl font-bold text-center text-blue-600">
        Welcome to Libman
      </h1>
      <div class="flex justify-center space-x-4 mt-8">
        <a
          href="document-list.jsp"
          class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600"
        >
          Manage System
        </a>
        <a
          href="${pageContext.request.contextPath}/search?action=search"
          class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600"
        >
          Find Book
        </a>
        <a
          href="${pageContext.request.contextPath}/import"
          class="bg-yellow-500 text-white px-4 py-2 rounded hover:bg-yellow-600"
        >
          Import Books
        </a>
        <a
          href="reports.jsp"
          class="bg-purple-500 text-white px-4 py-2 rounded hover:bg-purple-600"
        >
          View Statistic
        </a>
      </div>
    </div>ư

    <jsp:include page="/WEB-INF/views/_layouts/footer.jsp" />
  </body>
</html>
