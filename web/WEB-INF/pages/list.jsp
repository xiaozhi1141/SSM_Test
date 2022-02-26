<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 23108
  Date: 2022/2/24
  Time: 13:10
  To change this template use File | Settings | File Templates.
--%>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
    <link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css"
          integrity="sha384-HSMxcRTRxnN+Bdg0JdbxYKrThecOKuH5zCYotlSAcp1+c8xmyTe9GYg1l9a69psu" crossorigin="anonymous">
    <script src="${APP_PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js"
            integrity="sha384-aJ21OjlMXNL5UyIl/XNwTMqvzeRMZH2w8c5cRVpzpU8Y5bApTppSuUkhZXN0VxHd" crossorigin="anonymous">
    </script>
</head>
<body>
<div class="container">
<%--    标题--%>
    <div class="row">
        <div class="col-md-12"><h1>
            SSM_CRUD
        </h1></div>
    </div>
<%--    按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button type="button" class="btn btn-primary">新增</button>
            <button type="button" class="btn btn-danger">删除</button>
        </div>
    </div>
<%--    显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <tr>
                    <th>id</th>
                    <th>empName</th>
                    <th>email</th>
                    <th>gender</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                <c:forEach items="${page.list}" var="employee">
                <tr>
                    <td>${employee.empId}</td>
                    <td>${employee.empName}</td>
                    <td>${employee.gender}</td>
                    <td>${employee.email}</td>
                    <td>${employee.department.deptName}</td>
                    <td>
                        <button class="btn btn-primary btn-sm">
                            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
                        </button>
                        <button class="btn btn-danger btn-sm">
                            <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
                        </button>
                    </td>
                </tr>
                </c:forEach>
            </table>
        </div>
    </div>
<%--    分页信息和分页信息--%>
    <div class="row">
<%--        分页信息--%>
        <div class="col-md-6">
            当前第${page.pageNum}页，总${page.pages}共页，总共${page.total}条记录
        </div>
<%--        分页条--%>
    <div class="col-md-6">
        <nav aria-label="Page navigation">
            <ul class="pagination">
                <c:if test="${page.isFirstPage}">
                    <li class="disabled">
                        <a>首页</a>
                    </li>
                </c:if>
                <c:if test="${!page.isFirstPage}">
                    <li>
                        <a href="emps">首页</a>
                    </li>
                </c:if>

                <c:if test="${page.hasPreviousPage}">
                    <li>
                        <a href="${APP_PATH}/emps?pn=${page.prePage}" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                </c:if>


                <c:forEach items="${page.navigatepageNums}" var="num">
                    <c:if test="${num == page.pageNum}">
                        <li class="active"><a>${num}</a></li>
                    </c:if>
                    <c:if test="${num != page.pageNum}">
                        <li><a href="${APP_PATH}/emps?pn=${num}">${num}</a></li>
                    </c:if>
                </c:forEach>
                <c:if test="${page.hasNextPage}">
                    <li>
                        <a href="${APP_PATH}/emps?pn=${page.nextPage}" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </c:if>

                <c:if test="${page.isLastPage}">
                    <li class="disabled">
                        <a>末尾</a>
                    </li>
                </c:if>
                <c:if test="${!page.isLastPage}">
                    <li>
                        <a href="emps?pn=${page.pages}">末尾</a>
                    </li>
                </c:if>


            </ul>
        </nav>
    </div>
    </div>
</div>
</body>
</html>
