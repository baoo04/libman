<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>Invoice</title>
    <script src="https://cdn.tailwindcss.com"></script>
  </head>
  <body class="p-6">
    <div class="max-w-3xl mx-auto bg-white p-6 rounded shadow">
      <h2 class="text-2xl font-semibold">Invoice Order</h2>
      <p class="mt-2">Code: ${orderId}</p>
      <p>Supplier: ${supplierName}</p>
      <p>Imported By: ${createdBy}</p>
      <hr class="my-4" />
      <table class="w-full table-auto">
        <thead class="bg-gray-100">
          <tr>
            <th class="p-2">#</th>
            <th class="p-2">ISBN</th>
            <th class="p-2">Name</th>
            <th class="p-2">Quantity</th>
            <th class="p-2">Price</th>
            <th class="p-2">Total Payment</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="it" items="${items}" varStatus="st">
            <tr class="border-t">
              <td class="p-2">${st.index + 1}</td>
              <td class="p-2">${it.isbn}</td>
              <td class="p-2">${it.title}</td>
              <td class="p-2">${it.quantity}</td>
              <td class="p-2">${it.unitPrice}</td>
              <td class="p-2">${it.lineTotal}</td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
      <div class="text-right mt-4">
        <p class="text-lg font-semibold">Total: ${totalAmount}</p>
      </div>

      <div class="mt-4">
        <button
          onclick="window.print()"
          class="px-4 py-2 bg-blue-600 text-white rounded"
        >
          Print Invoice
        </button>
        <a
          href="${pageContext.request.contextPath}/import"
          class="px-4 py-2 border rounded ml-2"
          >Back</a
        >
      </div>
    </div>
  </body>
</html>
