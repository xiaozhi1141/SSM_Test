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
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>id</th>
                    <th>empName</th>
                    <th>email</th>
                    <th>gender</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <%--    分页信息和分页信息--%>
    <div class="row">
        <%--        分页信息--%>
        <div class="col-md-6" id="page_info_area">

        </div>
        <%--        分页条--%>
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>
<script type="text/javascript">
<%--    页面加载完成以后发送ajax请求获取数据--%>
$(function () {
   // 去首页
   to_page(1);
});

function to_page(pn){
    $.ajax({
        url:"${APP_PATH}/emps",
        data:"pn="+pn,
        type:"GET",
        success:function (result) {
            console.log(result)
            //1.在页面解析显示员工数据
            build_emps_table(result)
            //2.在页面解析显示分页信息
            build_page_info(result)
            //    3.解析显示分页条信息
            build_page_nav(result)
        }
    });
}

function  build_emps_table(result){
        //清空table表格
       $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps,function (index,item) {
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var empGenderTd = $("<td></td>").append(item.gender);
            var emailTd = $("<td></td>").append(item.email);
            var empDeptNameTd = $("<td></td>").append(item.department.deptName);

            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm").
            append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑")
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm").
            append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除")
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn)
            //append执行完了之后还会返回原来的元素
            $("<tr></tr>").append(empIdTd).
            append(empNameTd).
            append(emailTd).
            append(empGenderTd).
            append(empDeptNameTd).
            append(btnTd).
            appendTo("#emps_table tbody")
        })
}
//解析显示分页信息
function build_page_info(result){
    $("#page_info_area").empty();
    $("#page_info_area").append("当前第"+result.extend.pageInfo.pageNum +"页，总共"+result.extend.pageInfo.pages+"页，总共"+result.extend.pageInfo.total+"条记录")
}
//解析显示分页条信息点击能够去下一页
function build_page_nav(result){
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination")
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var perPageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if(!result.extend.pageInfo.hasPreviousPage){
            firstPageLi.addClass("disabled")
            perPageLi.addClass("disabled")
        } else {
        firstPageLi.click(function () {
            to_page(1);
        });
        perPageLi.click(function () {
            to_page(result.extend.pageInfo.prePage);
        });
        }
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末尾").attr("href","#"));
        if(!result.extend.pageInfo.hasNextPage){
            lastPageLi.addClass("disabled")
            nextPageLi.addClass("disabled")
        } else{
        nextPageLi.click(function () {
            to_page(result.extend.pageInfo.nextPage);
        });
        lastPageLi.click(function () {
            to_page(result.extend.pageInfo.pages);
        });
        }
        //添加首页和前一页
        ul.append(firstPageLi).append(perPageLi);
    //    遍历给ul中加页码
        $.each(result.extend.pageInfo.navigatepageNums,
          function (index,item) {
            var num = $("<li></li>").append($("<a></a>").append(item));
            if(result.extend.pageInfo.pageNum == item){
                num.addClass("active");
            } else {
                num.click(function () {
                    to_page(item);
                });
            }

            ul.append(num)
        })
        ul.append(nextPageLi).append(lastPageLi);
        var navEle = $("<nav></nav>").append(ul)
        navEle.appendTo("#page_nav_area")
}
</script>
</body>
</html>
