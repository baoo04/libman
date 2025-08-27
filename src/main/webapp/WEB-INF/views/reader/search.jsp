<%@ taglib uri="https://jakarta.ee/jstl/core" prefix="c" %>
<html><body>
  <form method="get" action="${pageContext.request.contextPath}/search">
    <input name="q" value="${q}" placeholder="Nhập tên tài liệu"/>
    <button>Tìm</button>
  </form>

  <c:if test="${not empty result.items}">
    <ul>
      <c:forEach var="d" items="${result.items}">
        <li>
          <a href="${pageContext.request.contextPath}/doc?id=${d.id}">
            ${d.title} (${d.availQty} còn)
          </a>
        </li>
      </c:forEach>
    </ul>
    <!-- phân trang -->
  </c:if>
</body></html>
