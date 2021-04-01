<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri ="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
    <link href="${pageContext.request.contextPath}/layui/css/layui.css" rel="stylesheet" />
    <script src = "${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
    <script src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <style type="text/css">
        .hzsjtitle{
            width:1000px;
            height:1000px;
            position:absolute;
            top:18px;
            left: 1%;
        }
        .export{
            position:absolute;
            top:18px;
            left: 95%;
        }
        .userLogChangeTitle{
            position:absolute;
            top:48px;
            left: 1%;
        }
        .userLogChangeBody{
            position:absolute;
            top:78px;
            left: 1%;
        }
    </style>
    <script type = "text/javascript">
        function checkOption(id,value) {
            var select = document.getElementById(id);
            var options = select.options;
            for (var i =0;i<options.length;i++){
                if(options[i].value == value){
                    options[i].selected = true;
                    break;
                }
            }
        }
    </script>
</head>
<body bgcolor="white" >
<script type="text/javascript">
    window.onload = function () {
        layui.use('form', function() {
            var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
            form.render();
        });
        var submitBtnElt = document.getElementById("submitBtn");
        submitBtnElt.onclick = function () {
            var userLogChange = document.getElementById("userLogChangeForm");
            userLogChange.action = "user/account/updateOneUserAllInfo.do";
            userLogChange.submit();
        }
    }
</script>
<form id = "userLogChangeForm" class="layui-form">
    <div class = "hzsjtitle">您现在的位置：修改用户信息</div>
    <div class = "userLogChangeTitle">以下为用户编号为${user.ID}的信息，在文本框内进行修改或改变下拉框进行修改，不能将值修改为空，修改完毕之后，点击提交即可。</div>
    <div class = "userLogChangeBody">
        <table>
            <tr>
                <td>用户编号：</td>
                <td><input type="text" name = "ID" value = ${user.ID} readonly="readonly" class = "layui-input"></td>
            </tr>
            <tr>
                <td>用户账号：</td>
                <td><input type = "text" name = "name" value = "${user.name}" class = "layui-input"></td>
            </tr>
            <tr>
                <td>用户密码：</td>
                <td><input type = "text" name = "password" value = "${user.password}" class = "layui-input"></td>
            </tr>
            <tr>
                <td>用户所属公司：</td>
                <td><input type = "text" name = "company" value = "${user.company}" class = "layui-input"></td>
            </tr>
            <tr>
                <td>用户余额：</td>
                <td><input type = "text" name = "charge" value = "${user.charge}" class = "layui-input"></td>
            </tr>
            <tr>
                <td>用户真实姓名：</td>
                <td><input type = "text" name = "realName" value = "${user.realName}" class = "layui-input"></td>
            </tr>
            <tr>
                <td>用户身份证：</td>
                <td><input type = "text" name = "IDnumber" value = "${user.IDnumber}" class = "layui-input"></td>
            </tr>
            <tr>
                <td>联系QQ：</td>
                <td><input type = "text" name = "QQ" value = "${user.QQ}" class = "layui-input"></td>
            </tr>
            <tr>
                <td>联系电话：</td>
                <td><input type = "text" name = "phone" value = "${user.phone}" class = "layui-input"></td>
            </tr>
            <tr>
                <td>店铺名称：</td>
                <td><input type = "text" name = "storeName" value = "${user.storeName}" class = "layui-input"></td>
            </tr>
            <tr>
                <td>店铺状态</td>
                <td><input type="text" name = "status" value = "${user.status}" class = "layui-input"></td>
            </tr>
            <tr>
                <td>用户权限</td>
                <td>
                    <div class="layui-input-inline ">
                    <select name = "priority" id = "priority">
                        <option value = "0">管理员</option>
                        <option value = "1">普通用户</option>
                    </select>
                    </div>
                </td>
            </tr>
            <tr>
                <td> <input type = "button" value = "提交" id = "submitBtn" class = "layui-btn layui-btn-normal"></td>
            </tr>
        </table>
    </div>
</form>
<script type = "text/javascript">
    checkOption('priority','${user.priority}');
</script>
</body>
</html>
