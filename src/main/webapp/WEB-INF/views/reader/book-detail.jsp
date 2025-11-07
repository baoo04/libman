<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ page
import="com.libman.model.Book" %>
<html>
  <head>
    <title>Book Details</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
    />
    <style>
      body {
        background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
          url("${pageContext.request.contextPath}/images/bg_detail.jpg")
            center/cover no-repeat fixed;
        min-height: 100vh;
        font-family: "Inter", sans-serif;
      }

      /* Brown button theme */
      .btn-brown {
        background-color: #b58863;
        color: white;
        box-shadow: 0 2px 6px rgba(90, 45, 15, 0.25);
        transition: all 0.25s ease;
      }
      .btn-brown:hover {
        background-color: #a1744f;
        box-shadow: 0 4px 10px rgba(90, 45, 15, 0.35);
        transform: translateY(-1px);
      }

      .tag {
        background-color: #fdf7f2;
        color: #7a5236;
        font-weight: 600;
        padding: 0.25rem 0.75rem;
        border-radius: 9999px;
        font-size: 0.85rem;
      }

      .section-box {
        background-color: #fcf8f5;
        border: 1px solid #e8d8ca;
        border-radius: 1rem;
        padding: 1rem 1.25rem;
        color: #5b4633;
        box-shadow: inset 0 1px 2px rgba(181, 136, 99, 0.1);
      }
    </style>
  </head>

  <body class="flex items-center justify-center p-8 text-gray-900">
    <div
      class="w-full max-w-4xl bg-white/95 backdrop-blur-md shadow-2xl rounded-2xl p-10"
    >
      <% Book book = (Book) request.getAttribute("book"); if (book != null) { %>

      <!-- Title -->
      <div class="flex items-center justify-between border-b pb-4 mb-6">
        <h2 class="text-4xl font-bold text-[#a1744f] flex items-center gap-3">
          <i class="fa-solid fa-book-open-reader text-[#b58863]"></i>
          <%= book.getTitle() %>
        </h2>
      </div>

      <!-- Book Info Grid -->
      <div class="grid grid-cols-1 sm:grid-cols-2 gap-4 text-gray-700">
        <p>
          <span class="font-semibold text-gray-900"
            ><i class="fa-solid fa-user-pen mr-1 text-[#b58863]"></i>
            Author:</span
          >
          <span class="ml-1"><%= book.getAuthor() %></span>
        </p>

        <p>
          <span class="font-semibold text-gray-900"
            ><i class="fa-solid fa-building mr-1 text-[#b58863]"></i>
            Publisher:</span
          >
          <span class="ml-1"><%= book.getPublisher() %></span>
        </p>

        <p>
          <span class="font-semibold text-gray-900"
            ><i class="fa-solid fa-calendar mr-1 text-[#b58863]"></i> Publish
            Year:</span
          >
          <span class="ml-1"><%= book.getPublishYear() %></span>
        </p>

        <p>
          <span class="font-semibold text-gray-900"
            ><i class="fa-solid fa-tag mr-1 text-[#b58863]"></i> Category:</span
          >
          <span class="tag"><%= book.getCategory() %></span>
        </p>

        <p>
          <span class="font-semibold text-gray-900"
            ><i class="fa-solid fa-boxes-stacked mr-1 text-[#b58863]"></i>
            Quantity:</span
          >
          <span class="tag"><%= book.getQuantity() %></span>
        </p>

        <p>
          <span class="font-semibold text-gray-900"
            ><i class="fa-solid fa-check-circle mr-1 text-[#b58863]"></i>
            Available:</span
          >
          <span class="tag"><%= book.getAvailableQuantity() %></span>
        </p>
      </div>

      <!-- Description -->
      <div class="mt-8">
        <h3
          class="text-2xl font-semibold text-[#5a4634] mb-3 flex items-center gap-2"
        >
          <i class="fa-solid fa-align-left text-[#b58863]"></i> Description
        </h3>
        <div class="section-box leading-relaxed">
          <%= book.getDescription() %>
        </div>
      </div>

      <!-- Content -->
      <div class="mt-8">
        <h3
          class="text-2xl font-semibold text-[#5a4634] mb-3 flex items-center gap-2"
        >
          <i class="fa-solid fa-file-lines text-[#b58863]"></i> Content
        </h3>
        <div class="section-box leading-relaxed"><%= book.getContent() %></div>
      </div>

      <!-- Back button -->
      <div class="mt-10 flex justify-end">
        <a
          href="${pageContext.request.contextPath}/search"
          class="btn-brown inline-flex items-center gap-2 px-6 py-3 font-semibold rounded-xl"
        >
          <i class="fa-solid fa-arrow-left"></i> Back to Search
        </a>
      </div>

      <% } else { %>
      <p class="text-red-600 font-semibold text-lg">
        <i class="fa-solid fa-triangle-exclamation mr-2"></i> Book not found.
      </p>
      <div class="mt-6 flex justify-end">
        <a
          href="${pageContext.request.contextPath}/search"
          class="btn-brown inline-flex items-center gap-2 px-6 py-3 font-semibold rounded-xl"
        >
          <i class="fa-solid fa-arrow-left"></i> Back to Search
        </a>
      </div>
      <% } %>
    </div>
  </body>
</html>
