<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>Import Document</title>
    <script src="https://cdn.tailwindcss.com"></script>
  </head>
  <body class="p-6 bg-gray-100">
    <div class="max-w-5xl mx-auto bg-white p-6 rounded shadow">
      <h2 class="text-2xl font-semibold mb-4">Import document from supplier</h2>

      <!-- Messages -->
      <c:if test="${not empty message}">
        <div class="p-2 mb-4 bg-green-100 text-green-800">${message}</div>
      </c:if>
      <c:if test="${not empty error}">
        <div class="p-2 mb-4 bg-red-100 text-red-800">${error}</div>
      </c:if>

      <!-- Search Supplier -->
      <form method="post" class="mb-6 grid grid-cols-3 gap-2">
        <input type="hidden" name="action" value="searchSupplier" />
        <input
          name="supplierName"
          placeholder="Tìm nhà cung cấp theo tên"
          class="col-span-2 p-2 border rounded"
        />
        <button type="submit" class="p-2 bg-blue-600 text-white rounded">
          Search
        </button>
      </form>

      <!-- Supplier list -->
      <c:if test="${not empty suppliers}">
        <div class="mb-4">
          <h4>Choose Supplier</h4>
          <ul>
            <c:forEach var="s" items="${suppliers}">
              <li class="py-1">
                <form method="post" style="display: inline">
                  <input type="hidden" name="action" value="selectSupplier" />
                  <input type="hidden" name="supplier_id" value="${s.id}" />
                  <button class="px-3 py-1 border rounded">
                    ${s.name} - ${s.phone}
                  </button>
                </form>
              </li>
            </c:forEach>
          </ul>
        </div>
      </c:if>

      <!-- Add Supplier -->
      <h4 class="font-medium mb-2">Add new supplier</h4>
      <form method="post" class="grid grid-cols-2 gap-2 mb-6">
        <input type="hidden" name="action" value="addSupplier" />
        <input
          name="name"
          placeholder="Tên"
          class="p-2 border rounded"
          required
        />
        <input
          name="phone"
          placeholder="Số điện thoại"
          class="p-2 border rounded"
        />
        <input name="email" placeholder="Email" class="p-2 border rounded" />
        <input
          name="address"
          placeholder="Địa chỉ"
          class="p-2 border rounded"
        />
        <div class="col-span-2">
          <button type="submit" class="p-2 bg-green-600 text-white rounded">
            Add
          </button>
        </div>
      </form>

      <!-- Search Document -->
      <form method="post" class="mb-6 grid grid-cols-3 gap-2">
        <input type="hidden" name="action" value="searchDocument" />
        <input
          name="documentName"
          placeholder="Search document by name"
          class="col-span-2 p-2 border rounded"
        />
        <button type="submit" class="p-2 bg-blue-600 text-white rounded">
          Search
        </button>
      </form>

      <!-- Document list -->
      <c:if test="${not empty documents}">
        <div class="mb-4">
          <h4>Choose Document</h4>
          <ul>
            <c:forEach var="d" items="${documents}">
              <li class="py-1">
                <form method="post" style="display: inline">
                  <input type="hidden" name="action" value="selectDocument" />
                  <input type="hidden" name="document_id" value="${d.id}" />
                  <button class="px-3 py-1 border rounded">
                    ${d.title} - ${d.author}
                  </button>
                </form>
              </li>
            </c:forEach>
          </ul>
        </div>
      </c:if>

      <!-- Add / Edit Book -->
      <h4 class="font-medium mb-2">Add / Edit Book</h4>
      <form method="post" class="grid grid-cols-2 gap-2 mb-6">
        <input type="hidden" name="action" value="addItem" />

        <input
          name="isbn"
          placeholder="ISBN"
          class="p-2 border rounded"
          value="${sessionScope.selected_document != null ? sessionScope.selected_document.isbn : ''}"
          required
        />

        <input
          name="title"
          placeholder="Tên sách"
          class="p-2 border rounded"
          value="${sessionScope.selected_document != null ? sessionScope.selected_document.title : ''}"
        />

        <input
          name="author"
          placeholder="Tác giả"
          class="p-2 border rounded"
          value="${sessionScope.selected_document != null ? sessionScope.selected_document.author : ''}"
        />

        <input
          name="publisher"
          placeholder="Nhà xuất bản"
          class="p-2 border rounded"
          value="${sessionScope.selected_document != null ? sessionScope.selected_document.publisher : ''}"
        />

        <input
          name="publishYear"
          placeholder="Năm XB"
          class="p-2 border rounded"
          value="${sessionScope.selected_document != null ? sessionScope.selected_document.publishYear : ''}"
        />

        <input
          name="category"
          placeholder="Thể loại"
          class="p-2 border rounded"
          value="${sessionScope.selected_document != null ? sessionScope.selected_document.category : ''}"
        />

        <input
          name="price"
          placeholder="Giá"
          class="p-2 border rounded"
          value="${sessionScope.selected_document != null ? sessionScope.selected_document.price : ''}"
        />

        <textarea
          name="description"
          placeholder="Mô tả"
          class="col-span-2 p-2 border rounded"
        >
        ${sessionScope.selected_document != null ? sessionScope.selected_document.description : ''}
      </textarea
        >

        <textarea
          name="content"
          placeholder="Nội dung"
          class="col-span-2 p-2 border rounded"
        >
        ${sessionScope.selected_document != null ? sessionScope.selected_document.content : ''}
      </textarea
        >

        <input
          name="quantity"
          placeholder="Số lượng"
          class="p-2 border rounded"
          required
          value="${sessionScope.selected_document != null ? sessionScope.selected_document.quantity : ''}"
        />

        <div class="col-span-2">
          <button type="submit" class="p-2 bg-indigo-600 text-white rounded">
            Add
          </button>
        </div>
      </form>

      <!-- Cart -->
      <h4 class="font-medium mb-2">List Imported Documents</h4>
      <table class="w-full table-auto mb-4 border">
        <thead class="bg-gray-100">
          <tr>
            <th class="p-2">#</th>
            <th class="p-2">ISBN</th>
            <th class="p-2">Name</th>
            <th class="p-2">Quantity</th>
            <th class="p-2">Price</th>
            <th class="p-2">Total Payment</th>
            <th class="p-2">Action</th>
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
                <tr class="border-t">
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
                      <button class="px-2 py-1 border rounded">Xóa</button>
                    </form>
                  </td>
                </tr>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <tr>
                <td colspan="7" class="p-2 text-center text-gray-500">
                  No document found
                </td>
              </tr>
            </c:otherwise>
          </c:choose>
        </tbody>
      </table>

      <!-- Submit order -->
      <form
        method="post"
        class="grid grid-cols-3 gap-4 items-start bg-white p-4 rounded-lg shadow"
      >
        <input type="hidden" name="action" value="submitOrder" />
        <input
          type="hidden"
          name="supplier_id"
          value="${sessionScope.selected_supplier_id}"
        />

        <!-- Supplier -->
        <div class="flex flex-col gap-2">
          <label class="text-sm font-medium text-gray-700">Supplier ID</label>
          <input
            name="supplier_id"
            placeholder="Enter supplier ID"
            class="p-2 border rounded focus:ring-2 focus:ring-blue-500 focus:outline-none ${not empty sessionScope.selected_supplier ? 'bg-green-50 border-green-500 text-green-700' : ''}"
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
        <div class="flex flex-col gap-2">
          <label class="text-sm font-medium text-gray-700 invisible"
            >Submit</label
          >
          <button
            type="submit"
            class="p-2 bg-yellow-600 text-white rounded hover:bg-yellow-700 transition"
          >
            Import
          </button>
        </div>
      </form>
    </div>
  </body>
</html>
