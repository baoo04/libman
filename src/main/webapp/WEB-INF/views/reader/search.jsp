<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<html>
  <head>
    <title>Search Books</title>
    <script src="https://cdn.tailwindcss.com"></script>
  </head>
  <body class="bg-gray-100 min-h-screen flex items-center justify-center p-6">
    <div class="w-full max-w-2xl bg-white shadow-lg rounded-xl p-8">
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
          class="flex-1 px-4 py-2 rounded-lg border border-gray-300 focus:ring-2 focus:ring-green-500 focus:outline-none"
        />
        <button
          type="submit"
          class="px-6 py-2 bg-green-500 text-white font-medium rounded-lg hover:bg-green-600 transition"
        >
          Search
        </button>
      </form>

      <!-- Results -->
      <c:if test="${not empty documents}">
        <h3 class="text-xl font-semibold mb-4 text-gray-800">Results:</h3>
        <ul class="space-y-3">
          <c:forEach var="d" items="${documents}">
            <li
              class="bg-gray-50 hover:bg-green-50 transition p-4 rounded-lg shadow-sm border border-gray-200"
            >
              <a
                href="${pageContext.request.contextPath}/search?action=detail&id=${d.id}"
                class="text-lg font-medium text-green-600 hover:underline"
              >
                ${d.title}
              </a>
              <p class="text-sm text-gray-500">Quantity: ${d.quantity}</p>
              <p>
                <span class="font-medium text-gray-900">Author:</span>
                ${d.author}
              </p>
              <p>
                <span class="font-medium text-gray-900">Publisher:</span>
                ${d.publisher}
              </p>
              <p>
                <span class="font-medium text-gray-900">Publish Year:</span>
                ${d.publishYear}
              </p>
            </li>
          </c:forEach>
        </ul>
      </c:if>

      <!-- Not found -->
      <c:if test="${empty documents and not empty keyword}">
        <p class="text-red-500 font-medium">
          No results found for "<span class="italic">${keyword}</span>"
        </p>
      </c:if>
    </div>
  </body>
</html>
