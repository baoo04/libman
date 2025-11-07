<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<html>
  <head>
    <title>Search Books</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
    />
    <style>
      body {
        background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)),
          url("${pageContext.request.contextPath}/images/bg_search.jpg")
            center/cover no-repeat fixed;
        min-height: 100vh;
        font-family: "Inter", sans-serif;
      }

      /* Hover effect without layout shift */
      tr.table-row {
        transition: background-color 0.25s ease, box-shadow 0.25s ease;
      }
      tr.table-row:hover {
        background-color: #fdf7f2; /* light brown background */
        box-shadow: 0 0 6px rgba(181, 136, 99, 0.3);
      }

      /* Common brown theme */
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

      .btn-gray {
        background-color: #5a4634;
        color: white;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.25);
        transition: all 0.25s ease;
      }
      .btn-gray:hover {
        background-color: #473322;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.35);
        transform: translateY(-1px);
      }

      /* Table header gradient in brown tone */
      thead {
        background: linear-gradient(to right, #b58863, #a1744f);
        color: white;
      }
    </style>
  </head>

  <body class="min-h-screen flex items-center justify-center p-6 text-gray-900">
    <div
      class="w-full max-w-6xl bg-white/95 backdrop-blur-md shadow-2xl rounded-2xl p-10"
    >
      <!-- 🔍 Search bar -->
      <form
        method="get"
        action="${pageContext.request.contextPath}/search"
        class="flex gap-3 mb-8"
      >
        <input type="hidden" name="action" value="search" />
        <input
          name="keyword"
          value="${keyword}"
          placeholder="Enter book title..."
          class="flex-1 px-5 py-3 text-lg rounded-xl border border-gray-300 focus:ring-4 focus:ring-amber-200 focus:outline-none shadow-sm"
        />
        <button
          type="submit"
          class="btn-brown px-8 py-3 font-semibold rounded-xl flex items-center gap-2"
        >
          <i class="fa-solid fa-magnifying-glass"></i> Search
        </button>
      </form>

      <!-- 📚 Results -->
      <c:if test="${not empty documents}">
        <h3
          class="text-3xl font-bold mb-6 text-gray-800 flex items-center gap-2 border-b pb-3"
        >
          <i class="fa-solid fa-book-open text-[#b58863]"></i>
          Search Results
        </h3>

        <div class="overflow-x-auto rounded-2xl shadow-md">
          <table class="min-w-full text-left text-gray-800">
            <thead>
              <tr>
                <th class="px-5 py-4 text-sm uppercase tracking-wider">#</th>
                <th class="px-5 py-4 text-sm uppercase tracking-wider">
                  Title
                </th>
                <th class="px-5 py-4 text-sm uppercase tracking-wider">
                  Author
                </th>
                <th class="px-5 py-4 text-sm uppercase tracking-wider">
                  Publisher
                </th>
                <th class="px-5 py-4 text-sm uppercase tracking-wider">Year</th>
                <th class="px-5 py-4 text-sm uppercase tracking-wider">
                  Quantity
                </th>
                <th
                  class="px-5 py-4 text-sm uppercase tracking-wider text-center"
                >
                  Action
                </th>
              </tr>
            </thead>

            <tbody class="divide-y divide-gray-200 bg-white">
              <c:forEach var="d" items="${documents}" varStatus="i">
                <tr class="table-row">
                  <td class="px-5 py-4 font-semibold text-gray-700">
                    ${i.index + 1}
                  </td>
                  <td class="px-5 py-4 font-medium">
                    <a
                      href="${pageContext.request.contextPath}/search?action=detail&id=${d.id}"
                      class="text-[#a1744f] hover:text-[#8c5e3c] hover:underline"
                    >
                      ${d.title}
                    </a>
                  </td>
                  <td class="px-5 py-4">${d.author}</td>
                  <td class="px-5 py-4">${d.publisher}</td>
                  <td class="px-5 py-4">${d.publishYear}</td>
                  <td class="px-5 py-4">${d.quantity}</td>
                  <td class="px-5 py-4 text-center">
                    <a
                      href="${pageContext.request.contextPath}/search?action=detail&id=${d.id}"
                      class="btn-brown inline-flex items-center gap-2 px-4 py-2 text-sm font-semibold rounded-lg"
                    >
                      <i class="fa-solid fa-circle-info"></i> Detail
                    </a>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </c:if>

      <!-- ❌ No result -->
      <c:if test="${empty documents and not empty keyword}">
        <div
          class="mt-8 p-5 border border-[#d9b99b] bg-[#fcf8f5] rounded-xl text-[#7a5236] text-center shadow-sm"
        >
          <i class="fa-solid fa-triangle-exclamation mr-2"></i>
          No results found for
          <span class="italic text-[#8c5e3c]">"${keyword}"</span>.
        </div>
      </c:if>

      <!-- 🔙 Back -->
      <div class="mt-8 text-center">
        <a
          href="${pageContext.request.contextPath}/"
          class="btn-gray inline-flex items-center gap-2 px-6 py-3 font-semibold rounded-lg"
        >
          <i class="fa-solid fa-house"></i> Back to Home
        </a>
      </div>
    </div>
  </body>
</html>
