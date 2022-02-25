<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 23108
  Date: 2022/2/24
  Time: 13:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<table cellspacing="0" border="1" cellpadding="5">
    <tr>
    <th>书名</th>
    <th>作者</th>
    <th>价格</th>
    <th>销量</th>
    <th>库存</th>
    <th>类别</th>
    </tr>
    <f:forEach items="${books.list}" var="book">
    <tr>
        <td>${book.name}</td>
        <td>${book.author}</td>
        <td>${book.price}</td>
        <td>${book.sales}</td>
        <td>${book.stock}</td>
            <%--        <td><img src="${requestScope.book.imgPath}"/></td>--%>
        <td>${book.category}</td>
    </tr>
    </f:forEach>
    <tr>
        <td colspan="6">
            <a href="hello2?page=${books.firstPage}">首页</a>
            <a href="hello2?page=${books.prePage}">上一页</a>
            <f:forEach items="${books.navigatepageNums}" var="num">
                <f:if test="${num != books.pageNum}">
                    <a href="hello2?page=${num}">${num}</a>
                </f:if>
                <f:if test="${num == books.pageNum}">
                    [${books.pageNum}]
                </f:if>
            </f:forEach>

            <a href="hello2?page=${books.nextPage}">下一页</a>
            <a href="hello2?page=${books.lastPage}">末尾</a>
        </td>
    </tr>
</table>
</body>
</html>
