<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ page
import="com.libman.model.Book" %>
<html>
  <head>
    <title>Book Details</title>
    <script src="https://cdn.tailwindcss.com"></script>
  </head>
  <body class="bg-gray-100 min-h-screen flex items-center justify-center p-6">
    <div class="w-full max-w-2xl bg-white shadow-lg rounded-xl p-8">
      <% Book book = (Book) request.getAttribute("book"); if (book != null) { %>
      <h2 class="text-2xl font-bold text-green-600 mb-4">
        <%= book.getTitle() %>
      </h2>

      <div class="space-y-3 text-gray-700">
        <p>
          <span class="font-medium text-gray-900">Author:</span> <%=
          book.getAuthor() %>
        </p>
        <p>
          <span class="font-medium text-gray-900">Publisher:</span> <%=
          book.getPublisher() %>
        </p>
        <p>
          <span class="font-medium text-gray-900">Publish Year: </span> <%=
          book.getPublishYear() %>
        </p>
        <p>
          <span class="font-medium text-gray-900">Category: </span> <%=
          book.getCategory() %>
        </p>
        <p>
          <span class="font-medium text-gray-900">Quantity: </span> <%=
          book.getQuantity() %>
        </p>
        <p>
          <span class="font-medium text-gray-900">Available Quantity: </span>
          <%= book.getAvailableQuantity() %>
        </p>
        <p>
          <span class="font-medium text-gray-900">Description: </span> <%=
          book.getDescription() %>
        </p>

        <p>
          <span class="font-medium text-gray-900">Content: </span> <%=
          book.getContent() %>
        </p>
      </div>

      <div class="mt-6">
        <a
          href="${pageContext.request.contextPath}/search"
          class="inline-block px-6 py-2 bg-green-500 text-white rounded-lg hover:bg-green-600 transition"
        >
          Back to search
        </a>
      </div>
      <% } else { %>
      <p class="text-red-500 font-medium">Không tìm thấy tài liệu.</p>
      <div class="mt-6">
        <a
          href="${pageContext.request.contextPath}/search"
          class="inline-block px-6 py-2 bg-green-500 text-white rounded-lg hover:bg-green-600 transition"
        >
          Back to search
        </a>
      </div>
      <% } %>
    </div>
  </body>
</html>
