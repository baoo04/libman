<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<html>
  <head>
    <title>Search Books</title>
    <script src="https://cdn.tailwindcss.com"></script>
  </head>
  <body class="bg-gray-100 min-h-screen flex items-center justify-center p-6">
    <div class="w-full max-w-5xl bg-white shadow-xl rounded-xl p-8">
      <!-- Form tìm kiếm -->
      <form
        method="get"
        action="${pageContext.request.contextPath}/search"
        class="flex gap-2 mb-6"
      >
        <input type="hidden" name="action" value="search" />
        <input
          name="keyword"
          value="${keyword}"
          placeholder="Enter book name..."
          class="flex-1 px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-green-500 focus:outline-none shadow-sm"
        />
        <button
          type="submit"
          class="px-6 py-3 bg-green-600 text-white font-semibold rounded-lg hover:bg-green-700 transition shadow"
        >
          Search
        </button>
      </form>

      <!-- Results -->
      <c:if test="${not empty documents}">
        <h3 class="text-2xl font-bold mb-4 text-gray-800 border-b pb-2">
          Search Results
        </h3>
        <div class="overflow-x-auto">
          <table
            class="w-full border-collapse rounded-lg overflow-hidden shadow-sm"
          >
            <thead>
              <tr class="bg-green-600 text-white text-left">
                <th class="px-4 py-3">#</th>
                <th class="px-4 py-3">Title</th>
                <th class="px-4 py-3">Author</th>
                <th class="px-4 py-3">Publisher</th>
                <th class="px-4 py-3">Year</th>
                <th class="px-4 py-3">Quantity</th>
                <th class="px-4 py-3">Action</th>
              </tr>
            </thead>
            <tbody class="divide-y divide-gray-200">
              <c:forEach var="d" items="${documents}" varStatus="i">
                <tr class="hover:bg-green-50 transition">
                  <td class="px-4 py-3 font-medium text-gray-700">
                    ${i.index + 1}
                  </td>
                  <td class="px-4 py-3">
                    <a
                      href="${pageContext.request.contextPath}/search?action=detail&id=${d.id}"
                      class="text-green-700 font-semibold hover:underline"
                    >
                      ${d.title}
                    </a>
                  </td>
                  <td class="px-4 py-3 text-gray-600">${d.author}</td>
                  <td class="px-4 py-3 text-gray-600">${d.publisher}</td>
                  <td class="px-4 py-3 text-gray-600">${d.publishYear}</td>
                  <td class="px-4 py-3 text-gray-600">${d.quantity}</td>
                  <td class="px-4 py-3">
                    <a
                      href="${pageContext.request.contextPath}/search?action=detail&id=${d.id}"
                      class="px-4 py-2 bg-green-500 text-white text-sm rounded-lg shadow hover:bg-green-600 transition whitespace-nowrap inline-flex items-center justify-center"
                    >
                      Detail
                    </a>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </c:if>

      <!-- Not found -->
      <c:if test="${empty documents and not empty keyword}">
        <div
          class="mt-6 p-4 border border-red-300 bg-red-50 rounded-lg text-red-600"
        >
          No results found for "<span class="italic">${keyword}</span>"
        </div>
      </c:if>

      <div class="mt-6">
        <a
          href="${pageContext.request.contextPath}/"
          class="inline-block px-6 py-3 bg-gray-600 text-white font-semibold rounded-lg shadow hover:bg-gray-700 transition"
        >
          Back to Home
        </a>
      </div>
    </div>
  </body>
</html>
