<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>Invoice</title>
    <script src="https://cdn.tailwindcss.com"></script>
  </head>
  <body class="bg-gray-100 p-6">
    <div class="max-w-4xl mx-auto bg-white p-8 rounded-xl shadow-lg">
      <!-- Header -->
      <div class="flex justify-between items-center border-b pb-4 mb-6">
        <h1 class="text-3xl font-bold text-blue-700">INVOICE</h1>
        <p class="text-gray-500">
          Date: <span class="font-medium">${date}</span>
        </p>
      </div>

      <!-- Info -->
      <div class="grid grid-cols-2 gap-6 mb-6">
        <div>
          <p class="text-gray-600">Invoice Code:</p>
          <p class="font-semibold text-gray-800">${orderId}</p>
        </div>
        <div>
          <p class="text-gray-600">Supplier:</p>
          <p class="font-semibold text-gray-800">${supplierName}</p>
        </div>
        <div>
          <p class="text-gray-600">Imported By:</p>
          <p class="font-semibold text-gray-800">${createdBy}</p>
        </div>
      </div>

      <!-- Table -->
      <div class="overflow-x-auto">
        <table class="w-full border-collapse rounded-lg overflow-hidden shadow">
          <thead>
            <tr class="bg-blue-600 text-white text-left">
              <th class="px-4 py-3">#</th>
              <th class="px-4 py-3">ISBN</th>
              <th class="px-4 py-3">Name</th>
              <th class="px-4 py-3">Quantity</th>
              <th class="px-4 py-3">Price</th>
              <th class="px-4 py-3">Total</th>
            </tr>
          </thead>
          <tbody class="divide-y divide-gray-200">
            <c:forEach var="it" items="${items}" varStatus="st">
              <tr class="hover:bg-gray-50">
                <td class="px-4 py-3">${st.index + 1}</td>
                <td class="px-4 py-3">${it.isbn}</td>
                <td class="px-4 py-3">${it.title}</td>
                <td class="px-4 py-3">${it.quantity}</td>
                <td class="px-4 py-3">${it.unitPrice}</td>
                <td class="px-4 py-3 font-medium text-gray-800">
                  ${it.lineTotal}
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>

      <!-- Total -->
      <div class="text-right mt-6">
        <p class="text-xl font-bold text-blue-700">
          Total Amount: ${totalAmount}
        </p>
      </div>

      <!-- Actions -->
      <div class="mt-6 flex justify-end gap-3">
        <button
          onclick="window.print()"
          class="px-5 py-2 bg-blue-600 text-white rounded-lg shadow hover:bg-blue-700 transition"
        >
          Print Invoice
        </button>
        <a
          href="${pageContext.request.contextPath}/import"
          class="px-5 py-2 bg-gray-200 text-gray-700 rounded-lg shadow hover:bg-gray-300 transition"
        >
          Back
        </a>
      </div>
    </div>
  </body>
</html>
