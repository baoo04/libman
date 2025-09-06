<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, com.libman.model.Book" %>
<html>
<head>
    <title>Kết quả tìm kiếm tài liệu</title>
</head>
<body>
    <h2>Tìm kiếm tài liệu</h2>
    <form action="search" method="get">
        <input type="text" name="keyword" placeholder="Nhập tên tài liệu..." />
        <button type="submit">Tìm</button>
    </form>
    <hr/>
    <h3>Kết quả:</h3>
    <%
        List<Book> books = (List<Book>) request.getAttribute("books");
        if (books != null && !books.isEmpty()) {
    %>
        <ul>
            <% for (Book b : books) { %>
                <li>
                    <a href="detail?id=<%= b.getId() %>">
                        <%= b.getTitle() %> - <%= b.getAuthor() %>
                    </a>
                </li>
            <% } %>
        </ul>
    <% } else { %>
        <p>Không tìm thấy tài liệu nào.</p>
    <% } %>
</body>
</html>
