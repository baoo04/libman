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
    <!-- ✅ Font Awesome 6 (CDN free, icons guaranteed to load) -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
      integrity="sha512-dBwexvSg3aYJ1XkGf4QbSGuCzJH25r3qu7j1p+7mR+xW0tYtCg5Kz5SxS0QyqkY8FZPj5qKwYg0+Y3rFZQG4Jg=="
      crossorigin="anonymous"
      referrerpolicy="no-referrer"
    />

    <style>
      body {
        background: url("${pageContext.request.contextPath}/images/bg_library.jpg")
          center/cover no-repeat fixed;
        min-height: 100vh;
      }
    </style>
  </head>

  <% if (session.getAttribute("user") == null) {
  response.sendRedirect(request.getContextPath() + "/login"); return; } %>

  <body class="bg-gray-900 bg-opacity-60 text-white">
    <jsp:include page="/WEB-INF/views/_layouts/header.jsp" />

    <div class="container mx-auto mt-16 px-6 text-center">
      <h1
        class="text-5xl font-extrabold mb-8 text-transparent bg-clip-text bg-gradient-to-r from-indigo-400 via-purple-400 to-pink-400 drop-shadow-lg"
      >
        Welcome to Libman
      </h1>
      <p class="text-lg text-gray-200 mb-12">
        Manage your library smarter, faster, and beautifully.
      </p>

      <div class="grid grid-cols-1 sm:grid-cols-3 gap-8 max-w-4xl mx-auto">
        <!-- Find Book -->
        <a
          href="${pageContext.request.contextPath}/search?action=search"
          class="group bg-gradient-to-br from-green-400 to-emerald-600 p-8 rounded-2xl shadow-lg transform transition duration-300 hover:scale-105 hover:shadow-2xl"
        >
          <div class="flex flex-col items-center">
            <i
              class="fa-solid fa-magnifying-glass text-5xl mb-4 group-hover:scale-110 transition"
            ></i>
            <h2 class="text-2xl font-semibold mb-2">Find Book</h2>
            <p class="text-sm text-gray-100">
              Search and explore books easily.
            </p>
          </div>
        </a>

        <!-- Import Books -->
        <a
          href="${pageContext.request.contextPath}/import"
          class="group bg-gradient-to-br from-yellow-400 to-orange-500 p-8 rounded-2xl shadow-lg transform transition duration-300 hover:scale-105 hover:shadow-2xl"
        >
          <div class="flex flex-col items-center">
            <i
              class="fa-solid fa-file-import text-5xl mb-4 group-hover:scale-110 transition"
            ></i>
            <h2 class="text-2xl font-semibold mb-2">Import Books</h2>
            <p class="text-sm text-gray-100">
              Add new books to your collection.
            </p>
          </div>
        </a>

        <!-- View Statistics -->
        <a
          href="reports.jsp"
          class="group bg-gradient-to-br from-purple-500 to-indigo-600 p-8 rounded-2xl shadow-lg transform transition duration-300 hover:scale-105 hover:shadow-2xl"
        >
          <div class="flex flex-col items-center">
            <i
              class="fa-solid fa-chart-column text-5xl mb-4 group-hover:scale-110 transition"
            ></i>
            <h2 class="text-2xl font-semibold mb-2">View Statistics</h2>
            <p class="text-sm text-gray-100">Analyze and monitor your data.</p>
          </div>
        </a>
      </div>
    </div>
  </body>
</html>
