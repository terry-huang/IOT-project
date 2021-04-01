<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri ="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    String basePath = request.getScheme() + "://" +
            request.getServerName() + ":" +request.getServerPort() +
            request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>物联网连接服务平台</title>
    <base href=<%=basePath%>/>
    <script src = "${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
    <link href="${pageContext.request.contextPath}/layui/css/layui.css" rel="stylesheet" />
    <script src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <style type= "text/css">
        .div1{
            background:rgba(245,245,245,0.8);
            width :500px;
            height:300px;
            position: absolute;
            top:300px;
            left:700px;
            text-align: center;
            font-size: 20px;
            -moz-border-radius: 10px;
            -webkit-border-radius: 10px;
            border-radius: 10px;
        }
        #usernameError{
            color: red;
            font-size: 15px;
        }
        #passwordError{
            color: red;
            font-size: 15px;
        }


    </style>

</head>
<body background="picture/2.jpg">

<script type = "text/javascript">
    window.onload = function() {
        var usernameElt = document.getElementById("username");
        var usernameErrorSpan = document.getElementById("usernameError");
        var passwordElt = document.getElementById("password");
        var passwordErrorSpan = document.getElementById("passwordError");
        usernameElt.onblur = function () {
            var username = usernameElt.value;
            username = username.trim();
            if (username === "") {
                usernameErrorSpan.innerText = "用户名不能为空";
            }
        }
        usernameElt.onfocus = function () {
            usernameErrorSpan.innerText = "";
        }
        passwordElt.onblur = function () {
            var password = passwordElt.value;
            if (password === "") {
                passwordErrorSpan.innerText = "密码不能为空";
            }
            passwordElt.onfocus = function () {
                if (passwordErrorSpan.innerText != "") {
                    passwordElt.value = "";
                }
                passwordErrorSpan.innerText = "";
            }
        }
        //给提交按钮绑定鼠标单击事件
        var submitBtnElt = document.getElementById("submitBtn");
        submitBtnElt.onclick = function () {
            usernameElt.focus();
            usernameElt.blur();
            passwordElt.focus();
            passwordElt.blur();
            if (passwordErrorSpan.innerText == "" && usernameErrorSpan.innerText == "") {
                /* var userFormElt = document.getElementById("userForm");
                 userFormElt.action = "user/account/loginUser.do";
                 userFormElt.submit();*/
                $.ajax({
                    url: "user/account/loginUser.do",
                    type: "post",
                    data: $("#userForm").serialize(),
                    success: function (resp) {
                        if(resp ==0){
                            window.open('mainPage/mainpage.jsp','_self');
                        }
                        if(resp ==1){
                            alert("用户名与密码不匹配，请重新输入！");
                        }

                    },
                    error : function (XMLHttpRequest, textStatus, errorThrown) {
                        alert(XMLHttpRequest.status);
                        alert(XMLHttpRequest.readyState);
                        alert(textStatus);
                    }
                })
            }
        }

        var registerBtnElt = document.getElementById("registerBtn");
        registerBtnElt.onclick = function () {
            window.open('mainPage/register.jsp','_self');
        }
    }

</script>

<form id = "userForm" method = "post">
    <div class="div1">
        <br><br>
        用户名&nbsp;<input type = "text" name = "name" id = "username" placeholder="请输入账号"/><br>
        <span class = "usernameError" id = "usernameError"></span>
        <br><br>
        密&nbsp;&nbsp;&nbsp;码&nbsp;<input type = "password" name = "password" id = "password" placeholder="请输入密码"/><br>
        <span class = "passwordError" id = "passwordError"></span>
        <br><br>
        <input type = "button" value = "登录" class="layui-btn layui-btn-radius layui-btn-primary layui-btn-lg" id = "submitBtn" />
        <input type = "button" value = "注册" class="layui-btn layui-btn-radius layui-btn-primary layui-btn-lg" id = "registerBtn" />
    </div>
</form>
</body>
</html>
