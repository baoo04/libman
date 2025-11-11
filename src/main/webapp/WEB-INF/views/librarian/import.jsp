<%@ page contentType="text/html;charset=UTF-8" language="java" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Import Document</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
      function toggleEdit(index) {
        const viewRow = document.getElementById('view-' + index);
        const editRow = document.getElementById('edit-' + index);
        
        if (viewRow.style.display === 'none') {
          viewRow.style.display = 'table-row';
          editRow.style.display = 'none';
        } else {
          viewRow.style.display = 'none';
          editRow.style.display = 'table-row';
        }
      }

      function showQuickAddModal(isbn, title, author, price) {
        document.getElementById('quickAddModal').style.display = 'flex';
        document.getElementById('quickIsbn').value = isbn;
        document.getElementById('quickTitle').innerText = title;
        document.getElementById('quickAuthor').innerText = author || 'N/A';
        document.getElementById('quickPrice').value = price;
      }

      function closeQuickAddModal() {
        document.getElementById('quickAddModal').style.display = 'none';
      }
    </script>
    <style>
      .edit-input {
        width: 100%;
        padding: 0.5rem;
        border: 1px solid #e5e7eb;
        border-radius: 0.375rem;
        font-size: 0.875rem;
        transition: all 0.2s;
      }
      .edit-input:focus {
        outline: none;
        border-color: #3b82f6;
        box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
      }
      .modal {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0,0,0,0.5);
        align-items: center;
        justify-content: center;
        z-index: 1000;
      }
      body {
        background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
        min-height: 100vh;
      }
    </style>
  </head>
  <body class="text-gray-900">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
      <!-- Header -->
      <div class="mb-8">
        <h1 class="text-4xl font-bold text-gray-900 mb-2">Import Document</h1>
        <p class="text-gray-600">Manage supplier imports and build your inventory</p>
      </div>

      <!-- Messages -->
      <c:if test="${not empty message}">
        <div class="mb-6 p-4 rounded-lg bg-green-50 border border-green-200 text-green-800 shadow-sm">
          <div class="flex items-center gap-2">
            <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/></svg>
            <span>${message}</span>
          </div>
        </div>
      </c:if>
      <c:if test="${not empty error}">
        <div class="mb-6 p-4 rounded-lg bg-red-50 border border-red-200 text-red-800 shadow-sm">
          <div class="flex items-center gap-2">
            <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"/></svg>
            <span>${error}</span>
          </div>
        </div>
      </c:if>

      <!-- Main Grid -->
      <div class="space-y-6">
        <!-- Supplier Section -->
        <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
          <div class="bg-gradient-to-r from-blue-600 to-blue-700 px-6 py-4">
            <h2 class="text-xl font-semibold text-white">Search Supplier</h2>
          </div>
          <div class="p-6 space-y-4">
            <form method="post" class="flex gap-3">
              <input type="hidden" name="action" value="searchSupplier" />
              <div class="flex-1">
                <label class="block text-sm font-medium text-gray-700 mb-2">Supplier Name</label>
                <input
                  name="supplierName"
                  placeholder="Enter supplier name..."
                  class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition"
                />
              </div>
              <div class="flex items-end">
                <button
                  type="submit"
                  class="px-6 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition font-medium"
                >
                  Search
                </button>
              </div>
            </form>

            <c:if test="${not empty suppliers}">
              <div class="pt-4 border-t border-gray-200">
                <h3 class="font-semibold text-gray-900 mb-3">Select Supplier</h3>
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-3">
                  <c:forEach var="s" items="${suppliers}">
                    <form method="post" class="inline">
                      <input type="hidden" name="action" value="selectSupplier" />
                      <input type="hidden" name="supplier_id" value="${s.id}" />
                      <button
                        type="submit"
                        class="w-full px-4 py-3 rounded-lg border-2 transition font-medium ${sessionScope.selected_supplier_id == s.id ? 'bg-blue-50 border-blue-500 text-blue-700' : 'border-gray-300 text-gray-700 hover:border-blue-400'}"
                      >
                        <div class="font-semibold">${s.name}</div>
                        <div class="text-sm opacity-75">${s.phone}</div>
                      </button>
                    </form>
                  </c:forEach>
                </div>
              </div>
            </c:if>
          </div>
        </div>

        <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
          <div class="bg-gradient-to-r from-indigo-600 to-indigo-700 px-6 py-4">
            <h2 class="text-xl font-semibold text-white">Add New Supplier</h2>
          </div>
          <div class="p-6">
            <form method="post" class="grid grid-cols-1 md:grid-cols-2 gap-4">
              <input type="hidden" name="action" value="addSupplier" />

              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Name <span class="text-red-500">*</span></label>
                <input
                  name="name"
                  placeholder="Supplier name"
                  required
                  class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent transition"
                />
              </div>

              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Phone</label>
                <input
                  name="phone"
                  placeholder="Phone number"
                  class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent transition"
                />
              </div>

              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Email</label>
                <input
                  name="email"
                  placeholder="Email address"
                  class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent transition"
                />
              </div>

              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Contact Name</label>
                <input
                  name="contact_name"
                  placeholder="Contact person"
                  class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent transition"
                />
              </div>

              <div class="md:col-span-2">
                <label class="block text-sm font-medium text-gray-700 mb-2">Address</label>
                <input
                  name="address"
                  placeholder="Full address"
                  class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent transition"
                />
              </div>

              <div class="md:col-span-2 text-right">
                <button
                  type="submit"
                  class="px-6 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 transition font-medium"
                >
                  Add Supplier
                </button>
              </div>
            </form>
          </div>
        </div>

        <!-- Search Existing Book -->
        <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
          <div class="bg-gradient-to-r from-emerald-600 to-emerald-700 px-6 py-4">
            <h2 class="text-xl font-semibold text-white">Search Existing Book</h2>
          </div>
          <div class="p-6 space-y-4">
            <form method="post" class="flex gap-3">
              <input type="hidden" name="action" value="searchDocument" />
              <div class="flex-1">
                <label class="block text-sm font-medium text-gray-700 mb-2">Book Title or ISBN</label>
                <input
                  name="documentName"
                  placeholder="Search by title or ISBN..."
                  class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-emerald-500 focus:border-transparent transition"
                />
              </div>
              <div class="flex items-end">
                <button
                  type="submit"
                  class="px-6 py-2 bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 transition font-medium"
                >
                  Search
                </button>
              </div>
            </form>

            <c:if test="${not empty documents}">
              <div class="pt-4 border-t border-gray-200">
                <h3 class="font-semibold text-gray-900 mb-3">Available Books</h3>
                <div class="space-y-2">
                  <c:forEach var="d" items="${documents}">
                    <div class="border border-gray-200 rounded-lg p-4 hover:bg-gray-50 transition flex justify-between items-start gap-4">
                      <div class="flex-1">
                        <p class="font-semibold text-gray-900">${d.title}</p>
                        <p class="text-sm text-gray-600 mt-1">ISBN: <span class="font-mono">${d.isbn}</span> | Author: ${d.author} | Price: <span class="font-semibold">${d.price}</span></p>
                      </div>
                      <button
                        type="button"
                        onclick="showQuickAddModal('${d.isbn}', '${d.title}', '${d.author}', '${d.price}')"
                        class="px-4 py-2 bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 transition font-medium whitespace-nowrap"
                      >
                        Add to Cart
                      </button>
                    </div>
                  </c:forEach>
                </div>
              </div>
            </c:if>
          </div>
        </div>

        <!-- Quick Add Modal -->
        <div id="quickAddModal" class="modal">
          <div class="bg-white rounded-xl shadow-2xl max-w-md w-full mx-4">
            <div class="bg-gradient-to-r from-emerald-600 to-emerald-700 px-6 py-4">
              <h3 class="text-lg font-semibold text-white">Add to Cart</h3>
            </div>
            <form method="post" class="p-6 space-y-4">
              <input type="hidden" name="action" value="addItem" />
              <input type="hidden" name="isbn" id="quickIsbn" />
              
              <div>
                <p class="text-sm text-gray-600">Title</p>
                <p class="font-semibold text-gray-900" id="quickTitle"></p>
              </div>
              <div>
                <p class="text-sm text-gray-600">Author</p>
                <p class="font-semibold text-gray-900" id="quickAuthor"></p>
              </div>
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Import Price <span class="text-red-500">*</span></label>
                <input
                  type="number"
                  name="price"
                  id="quickPrice"
                  required
                  class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-emerald-500 focus:border-transparent transition"
                />
              </div>
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Quantity <span class="text-red-500">*</span></label>
                <input
                  type="number"
                  name="quantity"
                  required
                  value="1"
                  class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-emerald-500 focus:border-transparent transition"
                />
              </div>

              <div class="flex gap-3 pt-4">
                <button
                  type="button"
                  onclick="closeQuickAddModal()"
                  class="flex-1 px-4 py-2 bg-gray-200 text-gray-800 rounded-lg hover:bg-gray-300 transition font-medium"
                >
                  Cancel
                </button>
                <button
                  type="submit"
                  class="flex-1 px-4 py-2 bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 transition font-medium"
                >
                  Add to Cart
                </button>
              </div>
            </form>
          </div>
        </div>

        <!-- Add New Book -->
        <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
          <div class="bg-gradient-to-r from-amber-600 to-amber-700 px-6 py-4">
            <h2 class="text-xl font-semibold text-white">Add New Book</h2>
          </div>
          <div class="p-6">
            <form method="post" class="grid grid-cols-1 md:grid-cols-3 gap-4">
              <input type="hidden" name="action" value="addItem" />

              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">ISBN <span class="text-red-500">*</span></label>
                <input
                  name="isbn"
                  placeholder="ISBN"
                  required
                  class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-amber-500 focus:border-transparent transition"
                />
              </div>

              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Title <span class="text-red-500">*</span></label>
                <input
                  name="title"
                  placeholder="Book title"
                  required
                  class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-amber-500 focus:border-transparent transition"
                />
              </div>

              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Author</label>
                <input
                  name="author"
                  placeholder="Author name"
                  class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-amber-500 focus:border-transparent transition"
                />
              </div>

              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Publisher</label>
                <input
                  name="publisher"
                  placeholder="Publisher"
                  class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-amber-500 focus:border-transparent transition"
                />
              </div>

              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Publish Year</label>
                <input
                  name="publishYear"
                  type="number"
                  placeholder="Year"
                  class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-amber-500 focus:border-transparent transition"
                />
              </div>

              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Category</label>
                <input
                  name="category"
                  placeholder="Category"
                  class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-amber-500 focus:border-transparent transition"
                />
              </div>

              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Import Price <span class="text-red-500">*</span></label>
                <input
                  name="price"
                  type="number"
                  step="1"
                  min="1"
                  placeholder="Price"
                  required
                  class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-amber-500 focus:border-transparent transition"
                />
              </div>

              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Quantity <span class="text-red-500">*</span></label>
                <input
                  name="quantity"
                  type="number"
                  placeholder="Quantity"
                  required
                  class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-amber-500 focus:border-transparent transition"
                />
              </div>

              <div class="md:col-span-3">
                <label class="block text-sm font-medium text-gray-700 mb-2">Description</label>
                <textarea
                  name="description"
                  placeholder="Book description"
                  rows="2"
                  class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-amber-500 focus:border-transparent transition"
                ></textarea>
              </div>

              <div class="md:col-span-3">
                <label class="block text-sm font-medium text-gray-700 mb-2">Content</label>
                <textarea
                  name="content"
                  placeholder="Book content"
                  rows="2"
                  class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-amber-500 focus:border-transparent transition"
                ></textarea>
              </div>

              <div class="md:col-span-3 text-right">
                <button
                  type="submit"
                  class="px-6 py-2 bg-amber-600 text-white rounded-lg hover:bg-amber-700 transition font-medium"
                >
                  Add to Cart
                </button>
              </div>
            </form>
          </div>
        </div>

        <!-- Cart with Editable Rows -->
        <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
          <div class="bg-gradient-to-r from-purple-600 to-purple-700 px-6 py-4 flex justify-between items-center">
            <h2 class="text-xl font-semibold text-white">Import Cart</h2>
            <c:if test="${not empty sessionScope.import_cart}">
              <form method="post" class="inline">
                <input type="hidden" name="action" value="clearCart" />
                <button
                  type="submit"
                  class="px-4 py-2 text-sm bg-red-500 text-white rounded-lg hover:bg-red-600 transition font-medium"
                  onclick="return confirm('Clear all items from cart?')"
                >
                  Clear Cart
                </button>
              </form>
            </c:if>
          </div>

          <div class="p-6">
            <c:choose>
              <c:when test="${not empty sessionScope.import_cart}">
                <div class="overflow-x-auto">
                  <table class="w-full">
                    <thead>
                      <tr class="border-b-2 border-gray-200">
                        <th class="px-4 py-3 text-left text-sm font-semibold text-gray-700">#</th>
                        <th class="px-4 py-3 text-left text-sm font-semibold text-gray-700">ISBN</th>
                        <th class="px-4 py-3 text-left text-sm font-semibold text-gray-700">Title</th>
                        <th class="px-4 py-3 text-left text-sm font-semibold text-gray-700">Author</th>
                        <th class="px-4 py-3 text-left text-sm font-semibold text-gray-700">Publisher</th>
                        <th class="px-4 py-3 text-left text-sm font-semibold text-gray-700">Year</th>
                        <th class="px-4 py-3 text-center text-sm font-semibold text-gray-700">Qty</th>
                        <th class="px-4 py-3 text-right text-sm font-semibold text-gray-700">Price</th>
                        <th class="px-4 py-3 text-right text-sm font-semibold text-gray-700">Total</th>
                        <th class="px-4 py-3 text-center text-sm font-semibold text-gray-700">Actions</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach var="it" items="${sessionScope.import_cart}" varStatus="st">
                        <!-- View Mode Row -->
                        <tr class="border-b border-gray-200 hover:bg-gray-50 transition" id="view-${st.index}">
                          <td class="px-4 py-3 text-sm text-gray-900">${st.index + 1}</td>
                          <td class="px-4 py-3 text-sm font-mono text-gray-600">${it.book.isbn}</td>
                          <td class="px-4 py-3 text-sm text-gray-900 font-medium">${it.book.title}</td>
                          <td class="px-4 py-3 text-sm text-gray-600">${it.book.author}</td>
                          <td class="px-4 py-3 text-sm text-gray-600">${it.book.publisher}</td>
                          <td class="px-4 py-3 text-sm text-gray-600">${it.book.publishYear > 0 ? it.book.publishYear : '-'}</td>
                          <td class="px-4 py-3 text-sm text-center text-gray-900 font-medium">${it.quantity}</td>
                          <td class="px-4 py-3 text-sm text-right text-gray-900">${it.unitPrice}</td>
                          <td class="px-4 py-3 text-sm text-right text-gray-900 font-semibold">${it.lineTotal}</td>
                          <td class="px-4 py-3 text-center">
                            <div class="flex gap-2 justify-center">
                              <button
                                onclick="toggleEdit('${st.index}')"
                                class="px-3 py-1 text-xs bg-blue-500 text-white rounded hover:bg-blue-600 transition font-medium"
                              >
                                Edit
                              </button>
                              <form method="post" class="inline">
                                <input type="hidden" name="action" value="removeItem" />
                                <input type="hidden" name="index" value="${st.index}" />
                                <button
                                  type="submit"
                                  class="px-3 py-1 text-xs bg-red-500 text-white rounded hover:bg-red-600 transition font-medium"
                                  onclick="return confirm('Remove this item?')"
                                >
                                  Remove
                                </button>
                              </form>
                            </div>
                          </td>
                        </tr>

                        <!-- Edit Mode Row -->
                        <tr class="bg-blue-50 border-b border-gray-200" id="edit-${st.index}" style="display: none;">
                          <td colspan="10" class="px-4 py-4">
                            <form method="post" class="space-y-4">
                              <input type="hidden" name="action" value="updateItem" />
                              <input type="hidden" name="index" value="${st.index}" />
                              
                              <div class="grid grid-cols-2 md:grid-cols-4 gap-3">
                                <div>
                                  <label class="block text-xs font-medium text-gray-700 mb-1">ISBN</label>
                                  <input
                                    type="text"
                                    value="${it.book.isbn}"
                                    disabled
                                    class="edit-input bg-gray-100 cursor-not-allowed"
                                  />
                                </div>
                                
                                <div>
                                  <label class="block text-xs font-medium text-gray-700 mb-1">Author</label>
                                  <input
                                    type="text"
                                    name="author"
                                    value="${it.book.author}"
                                    class="edit-input"
                                  />
                                </div>
                                
                                <div>
                                  <label class="block text-xs font-medium text-gray-700 mb-1">Publisher</label>
                                  <input
                                    type="text"
                                    name="publisher"
                                    value="${it.book.publisher}"
                                    class="edit-input"
                                  />
                                </div>
                                
                                <div>
                                  <label class="block text-xs font-medium text-gray-700 mb-1">Year</label>
                                  <input
                                    type="text"
                                    name="publishYear"
                                    value="${it.book.publishYear > 0 ? it.book.publishYear : ''}"
                                    class="edit-input"
                                  />
                                </div>
                                
                                <div>
                                  <label class="block text-xs font-medium text-gray-700 mb-1">Category</label>
                                  <input
                                    type="text"
                                    name="category"
                                    value="${it.book.category}"
                                    class="edit-input"
                                  />
                                </div>
                                
                                <div>
                                  <label class="block text-xs font-medium text-gray-700 mb-1">Quantity <span class="text-red-500">*</span></label>
                                  <input
                                    type="number"
                                    name="quantity"
                                    value="${it.quantity}"
                                    required
                                    class="edit-input"
                                  />
                                </div>
                                
                                <div>
                                  <label class="block text-xs font-medium text-gray-700 mb-1">Price <span class="text-red-500">*</span></label>
                                  <input
                                    type="number"
                                    name="price"
                                    value="${it.unitPrice}"
                                    required
                                    class="edit-input"
                                  />
                                </div>
                              </div>
                              
                              <div class="grid grid-cols-1 md:grid-cols-2 gap-3">
                                <div>
                                  <label class="block text-xs font-medium text-gray-700 mb-1">Description</label>
                                  <textarea
                                    name="description"
                                    rows="2"
                                    class="edit-input"
                                  >${it.book.description}</textarea>
                                </div>
                                
                                <div>
                                  <label class="block text-xs font-medium text-gray-700 mb-1">Content</label>
                                  <textarea
                                    name="content"
                                    rows="2"
                                    class="edit-input"
                                  >${it.book.content}</textarea>
                                </div>
                              </div>
                              
                              <div class="flex justify-end gap-2 pt-2">
                                <button
                                  type="button"
                                  onclick="toggleEdit('${st.index}')"
                                  class="px-4 py-2 text-sm bg-gray-400 text-white rounded-lg hover:bg-gray-500 transition font-medium"
                                >
                                  Cancel
                                </button>
                                <button
                                  type="submit"
                                  class="px-4 py-2 text-sm bg-green-600 text-white rounded-lg hover:bg-green-700 transition font-medium"
                                >
                                  Save Changes
                                </button>
                              </div>
                            </form>
                          </td>
                        </tr>
                      </c:forEach>
                      
                      <!-- Total Row -->
                      <tr class="bg-gray-100 border-t-2 border-gray-300">
                        <td colspan="8" class="px-4 py-3 text-right font-semibold text-gray-900">Total:</td>
                        <td class="px-4 py-3 text-right font-bold text-lg text-gray-900">
                          <c:set var="total" value="0" />
                          <c:forEach var="it" items="${sessionScope.import_cart}">
                            <c:set var="total" value="${total + it.lineTotal}" />
                          </c:forEach>
                          ${total}
                        </td>
                        <td></td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </c:when>
              <c:otherwise>
                <div class="py-12 text-center">
                  <svg class="w-16 h-16 mx-auto text-gray-300 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z"/></svg>
                  <p class="text-gray-500 text-lg">Your cart is empty</p>
                  <p class="text-gray-400 text-sm mt-1">Search existing books or add new books to get started</p>
                </div>
              </c:otherwise>
            </c:choose>
          </div>
        </div>

        <!-- Submit Order -->
        <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
          <div class="bg-gradient-to-r from-rose-600 to-rose-700 px-6 py-4">
            <h2 class="text-xl font-semibold text-white">Submit Import Order</h2>
          </div>
          <div class="p-6">
            <form method="post" class="grid grid-cols-1 md:grid-cols-3 gap-6">
              <input type="hidden" name="action" value="submitOrder" />
              <input
                type="hidden"
                name="supplier_id"
                value="${sessionScope.selected_supplier_id}"
              />

              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Supplier <span class="text-red-500">*</span></label>
                <input
                  type="text"
                  readonly
                  class="w-full px-4 py-2 rounded-lg border-2 font-medium ${not empty sessionScope.selected_supplier ? 'bg-green-50 border-green-500 text-green-700' : 'bg-gray-100 border-gray-300 text-gray-500'}"
                  value="${not empty sessionScope.selected_supplier ? sessionScope.selected_supplier.name.concat(' (ID: ').concat(sessionScope.selected_supplier_id).concat(')') : 'Please select a supplier'}"
                />
              </div>

              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Imported By <span class="text-red-500">*</span></label>
                <input
                  name="createdBy"
                  placeholder="Your name"
                  required
                  class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-rose-500 focus:border-transparent transition"
                  value="admin"
                />
              </div>

              <div class="flex flex-col justify-end">
                <button
                  type="submit"
                  class="w-full py-3 bg-rose-600 text-white font-semibold rounded-lg hover:bg-rose-700 transition shadow-md ${empty sessionScope.selected_supplier_id || empty sessionScope.import_cart ? 'opacity-50 cursor-not-allowed' : ''}"
                  ${empty sessionScope.selected_supplier_id || empty sessionScope.import_cart ? 'disabled' : ''}
                >
                  Submit Import Order
                </button>
              </div>
            </form>
          </div>
        </div>

        <!-- Back Button -->
        <div class="flex justify-center">
          <a
            href="${pageContext.request.contextPath}/"
            class="inline-flex items-center gap-2 px-6 py-3 bg-gray-600 text-white font-semibold rounded-lg hover:bg-gray-700 transition shadow-md"
          >
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"/></svg>
            Back to Home
          </a>
        </div>
      </div>
    </div>
  </body>
</html>
