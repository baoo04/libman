<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>Import Document</title>
    <script src="https://cdn.tailwindcss.com"></script>
  </head>
  <body class="p-6 bg-gray-100">
    <div class="max-w-6xl mx-auto space-y-6">
      <!-- Title -->
      <h2 class="text-3xl font-bold text-green-700 text-center mb-4">
        Import Document from Supplier
      </h2>

      <!-- Messages -->
      <c:if test="${not empty message}">
        <div class="p-3 rounded bg-green-100 text-green-800 shadow">
          ${message}
        </div>
      </c:if>
      <c:if test="${not empty error}">
        <div class="p-3 rounded bg-red-100 text-red-800 shadow">${error}</div>
      </c:if>

      <!-- Supplier Section -->
      <div class="bg-white p-6 rounded-xl shadow space-y-4">
        <h3 class="text-xl font-semibold text-gray-800 border-b pb-2">
          Search Supplier
        </h3>
        <form method="post" class="grid grid-cols-3 gap-2">
          <input type="hidden" name="action" value="searchSupplier" />
          <input
            name="supplierName"
            placeholder="Enter supplier name"
            class="col-span-2 p-2 border rounded focus:ring-2 focus:ring-green-500 focus:outline-none"
          />
          <button
            type="submit"
            class="p-2 bg-green-600 text-white rounded hover:bg-green-700 transition"
          >
            Search
          </button>
        </form>

        <c:if test="${not empty suppliers}">
          <div>
            <h4 class="font-medium mb-2">Choose Supplier</h4>
            <div class="flex flex-wrap gap-2">
              <c:forEach var="s" items="${suppliers}">
                <form method="post">
                  <input type="hidden" name="action" value="selectSupplier" />
                  <input type="hidden" name="supplier_id" value="${s.id}" />
                  <button
                    class="px-4 py-2 rounded-lg border hover:bg-green-50 transition"
                  >
                    ${s.name} - ${s.phone}
                  </button>
                </form>
              </c:forEach>
            </div>
          </div>
        </c:if>
      </div>

      <!-- Add Supplier -->
      <div class="bg-white p-6 rounded-xl shadow space-y-4">
        <h3 class="text-xl font-semibold text-gray-800 border-b pb-2">
          Add New Supplier
        </h3>
        <form method="post" class="grid grid-cols-2 gap-4">
          <input type="hidden" name="action" value="addSupplier" />
          <input
            name="name"
            placeholder="Name"
            required
            class="p-2 border rounded focus:ring-2 focus:ring-green-500 focus:outline-none"
          />
          <input
            name="phone"
            placeholder="Phone"
            class="p-2 border rounded focus:ring-2 focus:ring-green-500 focus:outline-none"
          />
          <input
            name="email"
            placeholder="Email"
            class="p-2 border rounded focus:ring-2 focus:ring-green-500 focus:outline-none"
          />
          <input
            name="contact_name"
            placeholder="Contact name"
            class="p-2 border rounded focus:ring-2 focus:ring-green-500 focus:outline-none"
          />
          <input
            name="address"
            placeholder="Address"
            class="p-2 border rounded focus:ring-2 focus:ring-green-500 focus:outline-none"
          />
          <div class="col-span-2 text-right">
            <button
              type="submit"
              class="px-6 py-2 bg-green-600 text-white rounded-lg hover:bg-green-700 transition"
            >
              Add Supplier
            </button>
          </div>
        </form>
      </div>

      <!-- Document Section -->
      <div class="bg-white p-6 rounded-xl shadow space-y-4">
        <h3 class="text-xl font-semibold text-gray-800 border-b pb-2">
          Search Document
        </h3>
        <form method="post" class="grid grid-cols-3 gap-2">
          <input type="hidden" name="action" value="searchDocument" />
          <input
            name="documentName"
            placeholder="Enter document name"
            class="col-span-2 p-2 border rounded focus:ring-2 focus:ring-blue-500 focus:outline-none"
          />
          <button
            type="submit"
            class="p-2 bg-blue-600 text-white rounded hover:bg-blue-700 transition"
          >
            Search
          </button>
        </form>

        <c:if test="${not empty documents}">
          <div>
            <h4 class="font-medium mb-2">Choose Document</h4>
            <div class="flex flex-wrap gap-2">
              <c:forEach var="d" items="${documents}">
                <form method="post">
                  <input type="hidden" name="action" value="selectDocument" />
                  <input type="hidden" name="document_id" value="${d.id}" />
                  <button
                    class="px-4 py-2 border rounded-lg hover:bg-blue-50 transition"
                  >
                    ${d.title} - ${d.author}
                  </button>
                </form>
              </c:forEach>
            </div>
          </div>
        </c:if>
      </div>

      <!-- Add / Edit Book -->
      <div class="bg-white p-6 rounded-xl shadow space-y-4">
        <h3 class="text-xl font-semibold text-gray-800 border-b pb-2">
          Add / Edit Book
        </h3>
        <form method="post" class="grid grid-cols-2 gap-4">
          <input type="hidden" name="action" value="addItem" />
          <input
            name="isbn"
            placeholder="ISBN"
            required
            value="${sessionScope.selected_document != null ? sessionScope.selected_document.isbn : ''}"
            class="p-2 border rounded focus:ring-2 focus:ring-indigo-500 focus:outline-none"
          />
          <input
            name="title"
            placeholder="Title"
            value="${sessionScope.selected_document != null ? sessionScope.selected_document.title : ''}"
            class="p-2 border rounded"
          />
          <input
            name="author"
            placeholder="Author"
            value="${sessionScope.selected_document != null ? sessionScope.selected_document.author : ''}"
            class="p-2 border rounded"
          />
          <input
            name="publisher"
            placeholder="Publisher"
            value="${sessionScope.selected_document != null ? sessionScope.selected_document.publisher : ''}"
            class="p-2 border rounded"
          />
          <input
            name="publishYear"
            placeholder="Year"
            value="${sessionScope.selected_document != null ? sessionScope.selected_document.publishYear : ''}"
            class="p-2 border rounded"
          />
          <input
            name="category"
            placeholder="Category"
            value="${sessionScope.selected_document != null ? sessionScope.selected_document.category : ''}"
            class="p-2 border rounded"
          />
          <input
            name="price"
            placeholder="Price"
            value="${sessionScope.selected_document != null ? sessionScope.selected_document.price : ''}"
            class="p-2 border rounded"
          />
          <textarea
            name="description"
            placeholder="Description"
            class="col-span-2 p-2 border rounded"
          >
${sessionScope.selected_document != null ? sessionScope.selected_document.description : ''}</textarea
          >
          <textarea
            name="content"
            placeholder="Content"
            class="col-span-2 p-2 border rounded"
          >
${sessionScope.selected_document != null ? sessionScope.selected_document.content : ''}</textarea
          >
          <input
            name="quantity"
            placeholder="Quantity"
            required
            value="${sessionScope.selected_document != null ? sessionScope.selected_document.quantity : ''}"
            class="p-2 border rounded"
          />
          <div class="col-span-2 text-right">
            <button
              type="submit"
              class="px-6 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 transition"
            >
              Add and Save Book
            </button>
          </div>
        </form>
      </div>

      <!-- Cart -->
      <div class="bg-white p-6 rounded-xl shadow space-y-4">
        <h3 class="text-xl font-semibold text-gray-800 border-b pb-2">
          List Imported Documents
        </h3>
        <table class="w-full table-auto border rounded-lg overflow-hidden">
          <thead class="bg-gray-100">
            <tr>
              <th class="p-2 text-left">#</th>
              <th class="p-2 text-left">ISBN</th>
              <th class="p-2 text-left">Name</th>
              <th class="p-2 text-left">Qty</th>
              <th class="p-2 text-left">Price</th>
              <th class="p-2 text-left">Total</th>
              <th class="p-2 text-left">Action</th>
            </tr>
          </thead>
          <tbody>
            <c:choose>
              <c:when test="${not empty sessionScope.import_cart}">
                <c:forEach
                  var="it"
                  items="${sessionScope.import_cart}"
                  varStatus="st"
                >
                  <tr class="border-t hover:bg-gray-50">
                    <td class="p-2">${st.index + 1}</td>
                    <td class="p-2">${it.book.isbn}</td>
                    <td class="p-2">${it.book.title}</td>
                    <td class="p-2">${it.quantity}</td>
                    <td class="p-2">${it.book.price}</td>
                    <td class="p-2">${it.lineTotal}</td>
                    <td class="p-2">
                      <form method="post">
                        <input type="hidden" name="action" value="removeItem" />
                        <input type="hidden" name="index" value="${st.index}" />
                        <button
                          class="px-3 py-1 text-sm bg-red-500 text-white rounded hover:bg-red-600 transition"
                        >
                          Remove
                        </button>
                      </form>
                    </td>
                  </tr>
                </c:forEach>
              </c:when>
              <c:otherwise>
                <tr>
                  <td colspan="7" class="p-3 text-center text-gray-500">
                    No document found
                  </td>
                </tr>
              </c:otherwise>
            </c:choose>
          </tbody>
        </table>
      </div>

      <!-- Submit order -->
      <div class="bg-white p-6 rounded-xl shadow">
        <h3 class="text-xl font-semibold text-gray-800 border-b pb-2 mb-4">
          Submit Import Order
        </h3>
        <form method="post" class="grid grid-cols-3 gap-6">
          <input type="hidden" name="action" value="submitOrder" />
          <input
            type="hidden"
            name="supplier_id"
            value="${sessionScope.selected_supplier_id}"
          />

          <!-- Supplier -->
          <div class="flex flex-col gap-2">
            <label class="text-sm font-medium text-gray-700">Supplier</label>
            <input
              name="supplier_id"
              placeholder="Enter supplier ID"
              class="p-2 border rounded focus:ring-2 focus:ring-green-500 focus:outline-none ${not empty sessionScope.selected_supplier ? 'bg-green-50 border-green-500 text-green-700' : ''}"
              value="${not empty sessionScope.selected_supplier ? 
                        sessionScope.selected_supplier.name.concat(' (ID: ').concat(sessionScope.selected_supplier_id).concat(')') : 
                        (sessionScope.selected_supplier_id != null ? sessionScope.selected_supplier_id : '')}"
              required
            />
          </div>

          <!-- Created By -->
          <div class="flex flex-col gap-2">
            <label class="text-sm font-medium text-gray-700">Imported By</label>
            <input
              name="createdBy"
              placeholder="Imported by"
              class="p-2 border rounded focus:ring-2 focus:ring-blue-500 focus:outline-none"
              value="admin"
            />
          </div>

          <!-- Submit -->
          <div class="flex flex-col justify-end">
            <button
              type="submit"
              class="w-full py-3 bg-yellow-600 text-white font-medium rounded-lg shadow hover:bg-yellow-700 transition"
            >
              Import Order
            </button>
          </div>
        </form>
      </div>
    </div>
  </body>
</html>
