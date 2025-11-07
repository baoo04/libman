<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>Invoice</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
      body {
        background: linear-gradient(135deg, #f0f4f8 0%, #d9e8f5 100%);
        min-height: 100vh;
      }
    </style>
  </head>
  <body class="p-6">
    <div class="max-w-5xl mx-auto">
      <div
        class="bg-gradient-to-r from-blue-600 to-blue-700 px-8 py-8 text-white shadow-lg"
      >
        <div class="flex justify-between items-start">
          <div>
            <h1 class="text-4xl font-bold mb-2">INVOICE</h1>
            <p class="text-blue-100">Import Document Receipt</p>
          </div>
          <div class="text-right">
            <p class="text-blue-100 text-sm">Date</p>
            <p class="text-xl font-semibold">${createdAt}</p>
          </div>
        </div>
      </div>

      <!-- Improved info section with better layout -->
      <div class="bg-white px-8 py-6 border-b border-gray-200">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
          <div class="border-l-4 border-blue-600 pl-4">
            <p
              class="text-gray-500 text-sm font-medium uppercase tracking-wide"
            >
              Invoice Code
            </p>
            <p class="text-xl font-bold text-gray-900 mt-1">${orderId}</p>
          </div>
          <div class="border-l-4 border-indigo-600 pl-4">
            <p
              class="text-gray-500 text-sm font-medium uppercase tracking-wide"
            >
              Supplier
            </p>
            <p class="text-xl font-bold text-gray-900 mt-1">${supplierName}</p>
          </div>
          <div class="border-l-4 border-cyan-600 pl-4">
            <p
              class="text-gray-500 text-sm font-medium uppercase tracking-wide"
            >
              Imported By
            </p>
            <p class="text-xl font-bold text-gray-900 mt-1">${createdBy}</p>
          </div>
        </div>
      </div>

      <!-- Enhanced table with modern styling -->
      <div class="bg-white px-8 py-6">
        <div class="overflow-x-auto">
          <table class="w-full">
            <thead>
              <tr
                class="bg-gradient-to-r from-gray-50 to-gray-100 border-b-2 border-gray-200"
              >
                <th
                  class="px-4 py-4 text-left text-sm font-semibold text-gray-700"
                >
                  #
                </th>
                <th
                  class="px-4 py-4 text-left text-sm font-semibold text-gray-700"
                >
                  ISBN
                </th>
                <th
                  class="px-4 py-4 text-left text-sm font-semibold text-gray-700"
                >
                  Book Name
                </th>
                <th
                  class="px-4 py-4 text-center text-sm font-semibold text-gray-700"
                >
                  Quantity
                </th>
                <th
                  class="px-4 py-4 text-right text-sm font-semibold text-gray-700"
                >
                  Unit Price
                </th>
                <th
                  class="px-4 py-4 text-right text-sm font-semibold text-gray-700"
                >
                  Total
                </th>
              </tr>
            </thead>
            <tbody class="divide-y divide-gray-200">
              <c:forEach var="it" items="${items}" varStatus="st">
                <tr class="hover:bg-blue-50 transition-colors">
                  <td class="px-4 py-4 text-gray-600">${st.index + 1}</td>
                  <td class="px-4 py-4 text-gray-800 font-medium">
                    ${it.isbn}
                  </td>
                  <td class="px-4 py-4 text-gray-800">${it.title}</td>
                  <td class="px-4 py-4 text-center text-gray-800">
                    ${it.quantity}
                  </td>
                  <td class="px-4 py-4 text-right text-gray-800">
                    ${it.unitPrice}
                  </td>
                  <td class="px-4 py-4 text-right font-semibold text-blue-600">
                    ${it.lineTotal}
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </div>

      <div class="bg-white rounded-t-2xl px-8 py-6 shadow-lg">
        <div
          class="flex flex-col md:flex-row md:items-center md:justify-between gap-6"
        >
          <div class="w-full md:w-auto">
            <div
              class="bg-gradient-to-r from-blue-50 to-indigo-50 rounded-lg p-6 border border-blue-200"
            >
              <p class="text-gray-600 text-sm font-medium mb-2">Total Amount</p>
              <p class="text-3xl font-bold text-blue-700">${totalAmount}</p>
            </div>
          </div>

          <div class="flex gap-3 w-full md:w-auto">
            <a
              href="${pageContext.request.contextPath}/import"
              class="flex-1 md:flex-none px-6 py-2.5 bg-gray-200 text-gray-700 rounded-lg font-medium hover:bg-gray-300 transition-colors text-center"
            >
              Back to Home
            </a>
            <button
              onclick="window.print()"
              class="flex-1 md:flex-none px-6 py-2.5 bg-gradient-to-r from-blue-600 to-blue-700 text-white rounded-lg font-medium hover:shadow-lg transition-all"
            >
              Print
            </button>
          </div>
        </div>
      </div>

      <div
        class="bg-white rounded-b-2xl px-8 py-6 shadow-lg border-t border-gray-200"
      ></div>
    </div>
  </body>
</html>
