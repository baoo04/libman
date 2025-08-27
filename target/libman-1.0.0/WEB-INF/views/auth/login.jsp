<%@ taglib uri="https://jakarta.ee/jstl/core" prefix="c" %>
<html>
  <head>
    <title>Đăng nhập LibMan</title>
  </head>
  <body>
    <h2>Đăng nhập</h2>
    <c:if test="${not empty error}"
      ><div style="color: red">${error}</div></c:if
    >
    <form method="post" action="${pageContext.request.contextPath}/login">
      <input name="username" placeholder="Username" />
      <input name="password" type="password" placeholder="Password" />
      <button>Đăng nhập</button>
    </form>
  </body>
</html>
