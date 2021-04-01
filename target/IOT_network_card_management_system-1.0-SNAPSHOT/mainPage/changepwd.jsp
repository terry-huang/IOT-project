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
    <base href=<%=basePath%>/>
    <link href="${pageContext.request.contextPath}/layui/css/layui.css" rel="stylesheet" />
    <script src = "${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
    <script src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <style type = "text/css">
        span{
            color:red;
            font-size:12px;
        }

    </style>
</head>
<body bgcolor="white">
<script type="text/javascript">
    window.onload = function() {
        var OldPwdElt = document.getElementById("OldPwd");
        var OldPwdErrorSpan = document.getElementById("OldPwdError");
        var NewPwdElt = document.getElementById("NewPwd");
        var NewPwdErrorSpan = document.getElementById("NewPwdError");
        var AgainNewPwdElt = document.getElementById("AgainNewPwd");
        var AgainNewPwdErrorSpan = document.getElementById("AgainNewPwdError");
        OldPwdElt.onblur = function () {
            var OldPwd = OldPwdElt.value;
            if (OldPwd === "") {
                OldPwdErrorSpan.innerText = "旧密码不能为空";
                //alert(111);
            }
        };
        OldPwdElt.onfocus = function () {
            OldPwdErrorSpan.innerText = "";
        };
        NewPwdElt.onblur = function () {
            var NewPwd = NewPwdElt.value;
            if (NewPwd === "") {
                NewPwdErrorSpan.innerText = "新密码不能为空";
            } else {
                if (NewPwd.length < 6 || NewPwd.length > 14) {
                    NewPwdErrorSpan.innerText = "新密码长度需在【6-14】位之间";
                } else {
                    var regExp = /^[0-9]+$/;
                    var ok = regExp.test(NewPwd);
                    if (!ok) {
                        NewPwdErrorSpan.innerText = "新密码只能有数字";
                    }
                }
            }
        };
        NewPwdElt.onfocus = function () {
            NewPwdErrorSpan.innerText = "";
        };
        AgainNewPwdElt.onblur = function () {
            var AgainNewPwd = AgainNewPwdElt.value;
            var NewPwd = NewPwdElt.value;
            if (AgainNewPwd === "") {
                AgainNewPwdErrorSpan.innerText = "确认密码不能为空";
            } else {
                if (AgainNewPwd != NewPwd) {
                    AgainNewPwdErrorSpan.innerText = "两次密码不一致！";
                }
            }
        };
        AgainNewPwdElt.onfocus = function () {
            AgainNewPwdErrorSpan.innerText = "";
        };
        var submitBtn1Elt = document.getElementById("submitBtn1");
        submitBtn1Elt.onclick = function () {
            OldPwdElt.focus();
            OldPwdElt.blur();
            NewPwdElt.focus();
            NewPwdElt.blur();
            AgainNewPwdElt.focus();
            AgainNewPwdElt.blur();
            if (OldPwdErrorSpan.innerText == "" && NewPwdErrorSpan.innerText == "" && AgainNewPwdErrorSpan.innerText == "") {
                var OldPwd = OldPwdElt.value;
                var NewPwd = NewPwdElt.value;
                $.ajax({
                    url: "user/account/updateUserPassword.do",
                    type: "post",
                    data: {'oldPassword': OldPwd,
                           'newPassword': NewPwd},
                    dataType: "json",
                    success: function (resp) {
                        alert(resp.msg);
                        window.open('mainPage/queryInfo.do','_self');
                    },
                    error : function (XMLHttpRequest, textStatus, errorThrown) {
                        alert(XMLHttpRequest.status);
                        alert(XMLHttpRequest.readyState);
                        alert(textStatus);
                    }
                })
            }
        }
    };
    layui.use("layer", function () {
        var layer = layui.layer;
        layer.open({
            type: 1,
            maxmin: true,
            title: '修改密码',
            area: ['700px', '300px'],
            content: $("#test"),
        });
    })


</script>
<form id = "changepwdForm" method="post">
    <div style="display: none" id="test">
        <table  class = "layui-table"  lay-size="sm" lay-skin="line">
            <tr>
                <td width="80px" bgcolor="skyblue" style="font-weight: bold">旧密码</td>
                <td width="100px"><input type = "password" id = "OldPwd" placeholder="旧密码"></td>
                <td><span class = "OldPwdError" id = "OldPwdError"></span></td>
            </tr>
            <tr>
                <td width="80px" bgcolor="skyblue" style="font-weight: bold">新密码</td>
                <td width="100px"><input type = "password" id = "NewPwd" placeholder="新密码"></td>
                <td><span class = "NewPwdError" id = "NewPwdError"></span></td>
            </tr>
            <tr>
                <td width="80px" bgcolor="skyblue"style="font-weight: bold">确认密码</td>
                <td width="100px"><input type = "password" id = "AgainNewPwd" placeholder="确认密码"></td>
                <td><span class = "AgainNewPwdError" id = "AgainNewPwdError"></span></td>
            </tr>
        </table>
        <input type = "button" value = "提交" id = "submitBtn1" class = "layui-btn layui-btn-primary layui-btn-sm">
    </div>
</form>

</body>
</html>
