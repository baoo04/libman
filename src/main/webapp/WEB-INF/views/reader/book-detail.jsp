<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ page
import="com.libman.model.Book" %>
<html>
  <head>
    <title>Book Details</title>
    <script src="https://cdn.tailwindcss.com"></script>
  </head>
  <body class="bg-gray-100 min-h-screen flex items-center justify-center p-6">
    <div class="w-full max-w-3xl bg-white shadow-xl rounded-xl p-8">
      <% Book book = (Book) request.getAttribute("book"); if (book != null) { %>
      <!-- Title -->
      <h2 class="text-3xl font-bold text-green-700 mb-6 border-b pb-3">
        <%= book.getTitle() %>
      </h2>

      <!-- Grid info -->
      <div class="grid grid-cols-1 sm:grid-cols-2 gap-4 text-gray-700">
        <p>
          <span class="font-semibold text-gray-900">Author:</span>
          <span class="ml-1"><%= book.getAuthor() %></span>
        </p>
        <p>
          <span class="font-semibold text-gray-900">Publisher:</span>
          <span class="ml-1"><%= book.getPublisher() %></span>
        </p>
        <p>
          <span class="font-semibold text-gray-900">Publish Year:</span>
          <span class="ml-1"><%= book.getPublishYear() %></span>
        </p>
        <p>
          <span class="font-semibold text-gray-900">Category:</span>
          <span
            class="ml-1 inline-block px-3 py-1 bg-green-100 text-green-700 text-sm rounded-full"
          >
            <%= book.getCategory() %>
          </span>
        </p>
        <p>
          <span class="font-semibold text-gray-900">Quantity:</span>
          <span
            class="ml-1 inline-block px-3 py-1 bg-blue-100 text-blue-700 text-sm rounded-full"
          >
            <%= book.getQuantity() %>
          </span>
        </p>
        <p>
          <span class="font-semibold text-gray-900">Available:</span>
          <span
            class="ml-1 inline-block px-3 py-1 bg-yellow-100 text-yellow-700 text-sm rounded-full"
          >
            <%= book.getAvailableQuantity() %>
          </span>
        </p>
      </div>

      <!-- Description -->
      <div class="mt-6">
        <h3 class="text-xl font-semibold text-gray-800 mb-2">Description</h3>
        <div
          class="p-4 bg-gray-50 border rounded-lg text-gray-600 leading-relaxed"
        >
          <%= book.getDescription() %>
        </div>
      </div>

      <!-- Content -->
      <div class="mt-6">
        <h3 class="text-xl font-semibold text-gray-800 mb-2">Content</h3>
        <div
          class="p-4 bg-gray-50 border rounded-lg text-gray-600 leading-relaxed"
        >
          <%= book.getContent() %>
        </div>
      </div>

      <!-- Back button -->
      <div class="mt-8 flex justify-end">
        <a
          href="${pageContext.request.contextPath}/search"
          class="inline-flex items-center gap-2 px-6 py-3 bg-green-600 text-white font-medium rounded-lg shadow hover:bg-green-700 transition"
        >
          Back to Search
        </a>
      </div>
      <% } else { %>
      <p class="text-red-500 font-medium">❌ Không tìm thấy tài liệu.</p>
      <div class="mt-6">
        <a
          href="${pageContext.request.contextPath}/search"
          class="inline-flex items-center gap-2 px-6 py-3 bg-green-600 text-white font-medium rounded-lg shadow hover:bg-green-700 transition"
        >
          Back to Search
        </a>
      </div>
      <% } %>
    </div>
  </body>
</html>
