<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Đăng nhập - Library Management System</title>
    <link
      href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css"
      rel="stylesheet"
    />
  </head>
  <body class="bg-gray-100">
    <div
      class="min-h-screen flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8"
    >
      <div class="max-w-md w-full space-y-8">
        <div>
          <h2 class="mt-6 text-center text-3xl font-extrabold text-gray-900">
            Đăng nhập vào hệ thống
          </h2>
        </div>

        <% String error = (String) request.getAttribute("error"); %> <% if
        (error != null && !error.isEmpty()) { %>
        <div
          class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded"
        >
          <%= error %>
        </div>
        <% } %>

        <form class="mt-8 space-y-6" method="POST">
          <div class="space-y-4">
            <div>
              <label
                for="username"
                class="block text-sm font-medium text-gray-700"
              >
                Tên đăng nhập
              </label>
              <input id="username" name="username" type="text" required
              value="<%= request.getAttribute("username") != null ?
              request.getAttribute("username") : "" %>" class="mt-1 block w-full
              px-3 py-2 border border-gray-300 rounded-md shadow-sm
              focus:outline-none focus:ring-indigo-500 focus:border-indigo-500">
            </div>

            <div>
              <label
                for="password"
                class="block text-sm font-medium text-gray-700"
              >
                Mật khẩu
              </label>
              <input
                id="password"
                name="password"
                type="password"
                required
                class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
              />
            </div>
          </div>

          <div>
            <button
              type="submit"
              class="group relative w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
            >
              Đăng nhập
            </button>
          </div>
        </form>
      </div>
    </div>
  </body>
</html>
