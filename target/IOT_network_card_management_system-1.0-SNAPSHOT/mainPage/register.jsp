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
            width :700px;
            height:700px;
            position: absolute;
            top:100px;
            left:700px;
            line-height: 2;
            -moz-border-radius: 10px;
            -webkit-border-radius: 10px;
            border-radius: 10px;
        }
        span{
            color: red;
            font-size: 12px;
            position: absolute;
            left:120px;
        }
        #submitBtn{
            position: absolute;
            left:120px;
        }
        a{
            text-decoration:underline;
            color: #1E9FFF;
        }
    </style>

</head>
<body background="picture/2.jpg">
<script type = "text/javascript">
    window.onload = function() {
        var newUserIDElt = document.getElementById("newUserID");
        var newUserIDErrorSpan = document.getElementById("newUserIDError");
        var newPwdElt = document.getElementById("newPwd");
        var newPwdErrorSpan = document.getElementById("newPwdError");
        var newPwd2Elt = document.getElementById("newPwd2");
        var newPwd2ErrorSpan = document.getElementById("newPwdError2");
        var newNameElt = document.getElementById("newName");
        var newNameErrorSpan = document.getElementById("newNameError");
        var newIDCardElt = document.getElementById("newIDCard");
        var newIDCardErrorSpan = document.getElementById("newIDCardError");
        var newQQElt = document.getElementById("newQQ");
        var newQQErrorSpan = document.getElementById("newQQError");
        var newPhoneElt = document.getElementById("newPhone");
        var newPhoneErrorSpan = document.getElementById("newPhoneError");
        var newStoreNameElt = document.getElementById("newStoreName");
        var newStoreNameErrorSpan = document.getElementById("newStoreNameError");
        newUserIDElt.onblur = function () {
            var newUserID = newUserIDElt.value;
            newUserID = newUserID.trim();
            if (newUserID === "") {
                newUserIDErrorSpan.innerText = "用户名不能为空";
            } else {
                if (newUserID.length < 4 || newUserID.length > 14) {
                    newUserIDErrorSpan.innerText = "用户名长度需在【4-14】位之间，且只能由数字和字母组成";
                } else {
                    var regExp = /^[A-Za-z0-9]+$/;
                    var ok1 = regExp.test(newUserID);
                    if (!ok1) {
                        newUserIDErrorSpan.innerText = "用户名长度需在【4-14】位之间，且只能由数字和字母组成";
                    }
                }
            }
        }
        newUserIDElt.onfocus = function () {
            if (newUserIDErrorSpan.innerText != "") {
                newUserIDErrorSpan.innerText = " ";
            }
        }
        newPwdElt.onblur = function () {
            var newPwd = newPwdElt.value;
            newPwd = newPwd.trim();
            if (newPwd === "") {
                newPwdErrorSpan.innerText = "密码不能为空";
            } else {
                if (newPwd.length < 8 || newPwd.length > 16) {
                    newPwdErrorSpan.innerText = "密码长度需在【8-16】位之间，且只能由数字和字母组成";
                } else {
                    var regExp = /^[A-Za-z0-9]+$/;
                    var ok2 = regExp.test(newPwd);
                    if (!ok2) {
                        newPwdErrorSpan.innerText = "密码长度需在【8-16】位之间，且只能由数字和字母组成";
                    }
                }
            }
        }
        newPwdElt.onfocus = function () {
            if (newPwdErrorSpan.innerText != "") {
                newPwdErrorSpan.innerText = " ";
            }
        }
        newPwd2Elt.onblur = function () {
            var newPwd = newPwdElt.value;
            var newPwd2 = newPwd2Elt.value;
            if (newPwd2 == "") {
                newPwd2ErrorSpan.innerText = "确认密码不能为空";
            } else {
                if (newPwd2 != newPwd) {
                    newPwd2ErrorSpan.innerText = "两次密码输入不一致！";
                }
            }
        }
        newPwd2Elt.onfocus = function () {
            if (newPwd2ErrorSpan.innerText != "") {
                newPwd2ErrorSpan.innerText = " ";
            }
        }

        newNameElt.onblur = function () {
            var newName = newNameElt.value;
            if (newName == "") {
                newNameErrorSpan.innerText = "真实姓名不能为空！";
            }
        }
        newNameElt.onfocus = function () {
            if (newNameErrorSpan.innerText != "") {
                newNameErrorSpan.innerText = "";
            }
        }
        newIDCardElt.onblur = function () {
            var newIDCard = newIDCardElt.value;
            if (newIDCard == "") {
                newIDCardErrorSpan.innerText = "身份证号码不能为空！";
            } else {
                if (newIDCard.length != 18) {
                    newIDCardErrorSpan.innerText = "请输入18位的身份证号码！";
                }
            }

        }
        newIDCardElt.onfocus = function () {
            if (newIDCardErrorSpan.innerText != "") {
                newIDCardErrorSpan.innerText = " ";
            }
        }
        newQQElt.onblur = function () {
            var newQQ = newQQElt.value;
            if (newQQ == "") {
                newQQErrorSpan.innerText = "QQ不能为空！";
            }
        }
        newQQElt.onfocus = function () {
            if (newQQErrorSpan.innerText != "") {
                newQQErrorSpan.innerText = "";

            }
        }
        newPhoneElt.onblur = function () {
            var newPhone = newPhoneElt.value;
            if (newPhone == "") {
                newPhoneErrorSpan.innerText = "电话号码不能为空！"
            } else {
                if (newPhone.length != 11) {
                    newPhoneErrorSpan.innerText = "请输入11位的电话号码！";
                }
            }

        }
        newPhoneElt.onfocus = function () {
            if (newPhoneErrorSpan.innerText != "") {
                newPhoneErrorSpan.innerText = "";
            }
        }
        newStoreNameElt.onblur = function () {
            var newStoreName = newStoreNameElt.value;
            if (newStoreName == "") {
                newStoreNameErrorSpan.innerText = "商店名称不能为空！";
            }
        }
        newStoreNameElt.onfocus = function () {
            if (newStoreNameErrorSpan.innerText != "") {
                newStoreNameErrorSpan.innerText = "";
            }
        }
    }
    function Register() {
        var newUserIDElt = document.getElementById("newUserID");
        var newUserIDErrorSpan = document.getElementById("newUserIDError");
        var newPwdElt = document.getElementById("newPwd");
        var newPwdErrorSpan = document.getElementById("newPwdError");
        var newPwd2Elt = document.getElementById("newPwd2");
        var newPwd2ErrorSpan = document.getElementById("newPwdError2");
        var newNameElt = document.getElementById("newName");
        var newNameErrorSpan = document.getElementById("newNameError");
        var newIDCardElt = document.getElementById("newIDCard");
        var newIDCardErrorSpan = document.getElementById("newIDCardError");
        var newQQElt = document.getElementById("newQQ");
        var newQQErrorSpan = document.getElementById("newQQError");
        var newPhoneElt = document.getElementById("newPhone");
        var newPhoneErrorSpan = document.getElementById("newPhoneError");
        var newStoreNameElt = document.getElementById("newStoreName");
        var newStoreNameErrorSpan = document.getElementById("newStoreNameError");
        newUserIDElt.focus();
        newUserIDElt.blur();
        newPwdElt.focus();
        newPwdElt.blur();
        newPwd2Elt.focus();
        newPwd2Elt.blur();
        newNameElt.focus();
        newNameElt.blur();
        newIDCardElt.focus();
        newIDCardElt.blur();
        newQQElt.focus();
        newQQElt.blur();
        newPhoneElt.focus();
        newPhoneElt.blur();
        newStoreNameElt.focus();
        newStoreNameElt.blur();
        var newUserID = newUserIDElt.value;
        var newPwd = newPwdElt.value;
        var newName = newNameElt.value;
        var newIDCard = newIDCardElt.value;
        var newQQ = newQQElt.value;
        var newPhone = newPhoneElt.value;
        var newStoreName = newStoreNameElt.value;
        if(newUserIDErrorSpan.innerText == "" && newPwdErrorSpan.innerText =="" && newPwd2ErrorSpan.innerText == "" && newNameErrorSpan.innerText =="" &&
            newIDCardErrorSpan.innerText == "" && newQQErrorSpan.innerText =="" && newPhoneErrorSpan.innerText =="" && newStoreNameErrorSpan.innerText ==""){
            $.ajax({
                    url:"user/account/registerUser.do",
                    type:"post",
                    data:{'name':newUserID,
                        'password':newPwd,
                        'realName':newName,
                        'IDnumber':newIDCard,
                        'QQ':newQQ,
                        'Phone':newPhone,
                        'storeName':newStoreName},
                    success: function (resp) {
                        alert(resp.msg);
                        if (resp.tag == 1){
                            window.open('mainPage/login.jsp','_self');
                        }
                    }
                }
            )}
        else{
            alert(newUserIDErrorSpan.innerText);
            alert(newPwdErrorSpan.innerText);
            alert(newPwd2ErrorSpan.innerText);
            alert(newNameErrorSpan.innerText);
            alert(newIDCardErrorSpan.innerText);
            alert(newQQErrorSpan.innerText);
            alert(newPhoneErrorSpan.innerText);
            alert(newStoreNameErrorSpan.innerText);
        }
    }

</script>
<form id = "userForm" method = "get">
    <div class="div1">
        <h1>欢迎注册</h1>
        &nbsp;&nbsp;已有帐号？<a href = "mainPage/login.jsp">登录</a>
        <br>
        <label class="layui-form-label">用户名</label>
        <input type = "text" placeholder="请输入注册的用户名"  style = "width: 500px;" id = "newUserID" class="layui-input"/>
        <span id = "newUserIDError"></span>
        <br>
        <label class="layui-form-label">密码</label>
        <input type = "password" placeholder="请输入注册的密码"  style = "width: 500px;" id = "newPwd" class="layui-input"/>
        <span id = "newPwdError"></span>
        <br>
        <label class="layui-form-label">确认密码</label>
        <input type = "password" placeholder="请再次输入注册的密码" style = "width: 500px;" id = "newPwd2" class="layui-input"/>
        <span id = "newPwdError2"></span>
        <br>
        <label class="layui-form-label">真实姓名</label>
        <input type = "text" placeholder="请输入真实姓名" style = "width: 500px;" id = "newName" class="layui-input"/>
        <span id = "newNameError"></span>
        <br>
        <label class="layui-form-label">身份证号</label>
        <input type = "text" placeholder="请输入注册的身份证号" style = "width: 500px;" id = "newIDCard"  class="layui-input" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
        <span id = "newIDCardError"></span>
        <br>
        <label class="layui-form-label">QQ</label>
        <input type = "text" placeholder="请输入注册的QQ" style = "width: 500px;" id = "newQQ"  class="layui-input" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
        <span id = "newQQError"></span>
        <br>
        <label class="layui-form-label">电话</label>
        <input type = "text" placeholder="请输入注册的电话" style = "width: 500px;" id = "newPhone" class="layui-input" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
        <span id = "newPhoneError"></span>
        <br>
        <label class="layui-form-label">商店名称</label>
        <input type = "text" placeholder="请输入注册的商店名称" style = "width: 500px;" id = "newStoreName" class="layui-input"/>
        <span id = "newStoreNameError"></span>
        <br>
        <input type = "button" class="layui-btn layui-btn-radius layui-btn-primary layui-btn-lg " value = "注册" id = "submitBtn" onclick="Register()">
    </div>
</form>

</body>
</html>
