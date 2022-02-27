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

<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAndModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input"  class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@xx.com">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="男" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="女"> 女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-10">
<%--                            部门提交部门id即可--%>
                            <select class="form-control" name="dId" id="dept_add_select">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-default" data-dismiss="modal">关闭</button>
                <button class="btn btn-primary" id="emp_save_but">保存</button>
            </div>
        </div>
    </div>
</div>

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
            <button type="button" class="btn btn-primary" id="emp_add_model_btn">新增</button>
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
<%--    保存总页码数--%>
    var totalRecord;
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
    totalRecord = result.extend.pageInfo.total
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

//清空表单样式及内容
function reset_form(ele) {
    //重置表单内容
    $(ele)[0].reset();
    // 清空表单样式
    $(ele).find("*").removeClass("has-success has-error");
    $(ele).find(".help-block").text("")
}
//点击新增按钮弹出模态框
$("#emp_add_model_btn").click(function () {
    //清除表单数据以及样式
    reset_form("#empAndModal form");
    // $("#empAndModal form")[0].reset();
    //发送ajax请求得到部门信息显示在下拉列表里
     getDepts();
    //显示部门信息下拉列表
    //$("#dept_add_select").append()
    //弹出模态框
    $("#empAndModal").modal({
        backdrop:true
    });
});

//查出所有部门信息并显示在下拉列表中
function getDepts(){
    $.ajax({
        url:"${APP_PATH}/depts",
        type:"GET",
        success:function (result) {
            //result里面有部门信息
            console.log(result)
            $.each(result.extend.depts,function (index,item) {
                var optionEle = $("<option></option>").append(item.deptName).attr("value",item.deptId);
                optionEle.appendTo("#dept_add_select");
            });
        }
    });
}

//校验表单数据方法
function validate_add_form(){
    //1.使用真正表达式
    var empName = $("#empName_add_input").val();
    var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
    if(!regName.test(empName)){
        //alert("用户名可以使2-5位中文或者6-16位字母和数字的组合！");
        //应该清空这个元素的所有之前样式

        show_validate_msg("#empName_add_input","error","用户名必须是2-5位中文或者6-16位字母和数字的组合！");
        return false;
    } else {
        show_validate_msg("#empName_add_input","success","")
    }
    var email = $("#email_add_input").val()
    var regEmail = 	/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/
    if(!regEmail.test(email)){
        //alert("邮箱格式不合法");
        show_validate_msg("#email_add_input","error","邮箱格式不合法！")
        return false;
    } else {
        show_validate_msg("#email_add_input","success","")
    }
    return true;
}

function  show_validate_msg(ele,status,msg){
    //清除当前元素校验状态
    $(ele).parent().removeClass("has-success has-error");
    $(ele).next("span").text("");
    if("success"  == status){
        $(ele).parent().addClass("has-success");
        $(ele).next("span").text(msg);
    } else if("error" == status){
        $(ele).parent().addClass("has-error");
        $(ele).next("span").text(msg);
    }
}
$("#empName_add_input").change(function () {
    var empName = this.value;
    $.ajax({
        url:"${APP_PATH}/checkuser",
        data:"empName="+empName,
        type:"POST",
        success:function (result) {
            if(result.code == 100){
                show_validate_msg("#empName_add_input","success","用户名可用！");
                $("#emp_save_but").attr("ajax_va","success");
            } else {
                show_validate_msg("#empName_add_input","error",result.extend.va_msg);
                $("#emp_save_but").attr("ajax_va","error");
            }
        }
    })
});
//点击保存员工
$("#emp_save_but").click(function () {
//    将模态框中的数据保存提交给服务器
//对数据进行校验
    if(!validate_add_form()){
        return false;
    }
    //判断之前的用户名校验是否成功
    if($(this).attr("ajax_va") == "error"){
        show_validate_msg("#empName_add_input","error","用户名不可用！");
        return false;
    }
    //发送ajax请求保存员工
    $.ajax({
        url:"${APP_PATH}/emp",
        type:"post",
        data: $("#empAndModal form").serialize(),
        success: function (result) {
            if(result.code == 100){
                //员工保存成功 1.关闭状态框 2.来到最后一页显示添加的数据
                $("#empAndModal").modal('hide');
                //发送ajax请求显示最后一页
                to_page(totalRecord);
                alert(result.msg)
            } else{
                //显示失败信息
                //有那个字段的错误信息就显示那个字段的错误信息
                if(undefined != result.extend.errorFields.email){
                    //显示员工的邮箱错误信息
                    show_validate_msg("#email_add_input","error",result.extend.errorFields.email)
                }

                if(undefined != result.extend.errorFields.empName){
                    //显示员工的名字错误信息
                    show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
                }
                console.log(result);
            }

        }
    })
})


// $("#email_add_input").blur(function () {
//     validate_add_form();
// });

</script>
</body>
</html>
