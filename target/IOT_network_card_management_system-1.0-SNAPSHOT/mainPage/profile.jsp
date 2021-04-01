<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" +
            request.getServerName() + ":" +request.getServerPort() +
            request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link href="${pageContext.request.contextPath}/layui/css/layui.css" rel="stylesheet" />
    <script src = "${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
    <script src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <base href=<%=basePath%>/>
    <style type = "text/css">
        #table1{
            position: absolute;
            top:30px;
            left: 3%;
        }
        #table2{
            position: absolute;
            top:30px;
            left: 35%;
        }
        #table3{
            position: absolute;
            top:30px;
            left: 67%;
        }
        #table4{
            position: absolute;
            top:200px;
            left: 3%;
        }
    </style>
</head>
<body bgcolor="white">
<script type="text/javascript">
    $(document).ready(function() {
    //window.onload = function(){
       layui.use("layer", function () {
            var layer = layui.layer;
            layer.open({
                type: 1,
                maxmin: true,
                title: '个人资料',
                area: ['700px', '300px'],
                content: $("#test"),
            })
        })

         //  alert(111);


    })



</script>
<form action = "user/account/queryOneUserAllInfo.do">
<div  style = "display: none" id="test">
    <table border="1" class = "layui-table"  lay-size="sm">
        <tr>
            <td bgcolor="skyblue" style="font-weight: bold">登录账号</td>
            <td >${user.name}</td>

            <td  bgcolor="skyblue" style="font-weight: bold">店铺名称</td>
            <td>${user.storeName}</td>
        </tr>
        <tr>
            <td bgcolor="skyblue" style="font-weight: bold">联系人</td>
            <td>${user.realName}</td>
            <td bgcolor="skyblue" style="font-weight: bold">联系电话</td>
            <td>${user.phone}</td>
        </tr>
        <tr>
            <td bgcolor="skyblue" style="font-weight: bold">联系QQ</td>
            <td>${user.QQ}</td>
            <td bgcolor="skyblue" style="font-weight: bold">店铺状态</td>
            <td>正常</td>
        </tr>
    </table>
</div>
</form>
</body>
</html>
