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
        .cardbg{
            position: absolute;
            top:50px;
            left:1%;
        }
        #higherseek1{
            display: none;
        }
        .page1{
            font-size: 15px;
            position: relative;
        }
        .page2{
            font-size: 15px;
            position: relative;
            left: 65%;
        }
        a{
            text-decoration: underline;
            color: #1E9FFF;
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
<%
    String actionx = (String) request.getAttribute("action");
%>
<body bgcolor="white" >
<script type = "text/javascript">
    actionx = "<%=actionx%>";
    $(document).ready(function() {
        layui.use('form', function() {
            var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
            form.render();
        });
        $("#higherseek").click(function () {
            $("#higherseek1").toggle();
        });
    })
    function UserXQ(str) {
        $.ajax({
            url: "user/account/queryOneUserDetailInfo.do",
            type: "get",
            data: {'ID': str},
            //dataType: "json",
            success: function (resp) {
                $("#name").text (resp.user.name);
                $("#password").text (resp.user.password);
                $("#company").text(resp.user.company);
                $("#realName").text(resp.user.realName);
                $("#QQ").text(resp.user.qq);
                $("#Phone").text(resp.user.phone);
                $("#status").text(resp.status);
                $("#IDNumber").text(resp.user.idnumber);
                layui.use('table', function () {
                    var table = layui.table;
                    layer.open({
                        type: 1 //Page层类型
                        , area: ['800px', '500px']
                        , title: '用户详情'
                        , maxmin: true //允许全屏最小化
                        , content:  $("#test")
                    })
                })
            },
            error : function (XMLHttpRequest, textStatus, errorThrown) {
                alert(XMLHttpRequest.status);
                alert(XMLHttpRequest.readyState);
                alert(textStatus);
            }
        })
    }
    function Change(str) {
        var url1 = "user/account/queryOneUserBeforeUpdate.do"+"?ID="+str;
        window.open(url1,'right');

    }
    function DeleteUser(str) {
        if(confirm('确定删除该用户吗？')==true){
            var url2 = "user/account/deleteUser.do"+"?ID="+str;
            window.open(url2,'right');
        }
    }
    function ChaXun() {
        var mobileCardForm = document.getElementById("userLogForm");
        mobileCardForm.action = "user/account/queryAllUserInfoByCondition.do";
        mobileCardForm.submit();
    }
    function FirstPage() {
        var page = document.getElementById("page");
        var userLogForm = document.getElementById("userLogForm");
        page.value = 1;
        userLogForm.action = actionx;
        userLogForm.submit();
    }
    function PreviousPage() {
        var page = document.getElementById("page");
        page.value = parseInt(page.value) - 1;
        if(page.value <= 0){
            alert("当前为第一页！");
            page.value = parseInt(page.value) + 1;
        }else{
            var userLogForm = document.getElementById("userLogForm");
            userLogForm.action = actionx;
            userLogForm.submit();
        }

    }
    function NextPage() {
        //下一页
        var page = document.getElementById("page");
        page.value = parseInt(page.value) + 1;
        if(page.value >= (${maxPage}+1)){
            alert("当前为最后一页！");
            page.value = ${maxPage};
        }else{
            var userLogForm = document.getElementById("userLogForm");
            userLogForm.action = actionx;
            userLogForm.submit();
        }
    }
    function LastPage() {
        //最后一页
        var page = document.getElementById("page");
        var userLogForm = document.getElementById("userLogForm");
        page.value = ${maxPage};
        userLogForm.action = actionx;
        userLogForm.submit();
    }
    function JumpPage() {
        var page = document.getElementById("page");
        var jumpPage = document.getElementById("jumpPage");
        if(jumpPage.value<=0 || jumpPage.value >(${maxPage}) || jumpPage.value == ''){
            alert("请输入正确的页码！");
        }else{
            page.value = jumpPage.value;
            var userLogForm = document.getElementById("userLogForm");
            userLogForm.action = actionx;
            userLogForm.submit();
        }
    }
</script>
<div style="display: none" id = "test">
    <table border="1">
        <tr>
            <td width="150px" bgcolor="skyblue">登录账号</td>
            <td width="150px" id = "name"></td>

            <td width="150px" bgcolor="skyblue">登陆密码</td>
            <td width="150px" id = "password"></td>
        </tr>
        <tr>
            <td bgcolor="skyblue">用户所属公司</td>
            <td id = "company"></td>
            <td bgcolor="skyblue">用户真实姓名</td>
            <td id = "realName"></td>
        </tr>
        <tr>
            <td bgcolor="skyblue">联系QQ</td>
            <td id = "QQ"></td>
            <td bgcolor="skyblue">联系电话</td>
            <td id = "Phone"></td>
        </tr>
        <tr>
            <td bgcolor="skyblue" >用户身份证</td>
            <td id = "IDNumber"></td>
            <td bgcolor="skyblue" >店铺状态</td>
            <td id = "status"></td>

        </tr>

    </table>
</div>
<form id = "userLogForm" method="get" class = "layui-form">
    <div class = "hzsjtitle">您现在的位置：用户日志</div>
    <div class = "cardbg">
        <div class = "layui-form-item">
            <div class = "layui-input-inline"><input type="text" placeholder="请输入用户编号" name = "startID" id="startID" class = "layui-input" value = "${queryUserCondition.startID}"></div>
            <div class="layui-form-mid">-</div>
            <div class = "layui-input-inline"><input type="text" placeholder="请输入用户编号" name = "endID" id = "endID" class = "layui-input" value = "${queryUserCondition.endID}"></div>
            &nbsp;&nbsp;<input type = "button" value = "搜索查询" id = "searchseek" style="cursor: pointer" class="layui-btn layui-btn-normal" onclick="ChaXun()"/>
            &nbsp;&nbsp;<input type = "button" value = "高级查询" id = "higherseek" style="cursor: pointer" class="layui-btn layui-btn-normal"/>
        </div>
        <div id = "higherseek1" class="layui-form-item">
            <div class="layui-inline">
                <div class="layui-input-inline " style = "width: 100px">
                    <select name = "priority" id = "priority">
                        <option  value="-1" selected>用户权限</option>
                        <option  value="1">普通用户</option>
                        <option  value="0">管理员</option>
                    </select>
                </div>
                <div class="layui-input-inline " style = "width: 100px">
                    <select name = "charge" id = "charge">
                        <option  value="-1" selected>用户余额</option>
                        <option  value="0">正常</option>
                        <option  value="1">已欠费</option>
                    </select>
                </div>
                <div class = "layui-input-inline"><input type = "text" placeholder="请输入店铺名称" id = "storeName" name = "storeName" class = "layui-input" value = "${queryUserCondition.storeName}"></div>
            </div>
        </div>
        <br>
        <div id = "orderTable">
            <table border="1px" cellspacing="0" class="layui-table">
                <tr>
                    <td style="width: 400px;" align="center" bgcolor="#f0f8ff">用户编号</td>
                    <td style="width: 400px;" align="center" bgcolor="#f0f8ff">用户名</td>
                    <td style="width: 400px;" align="center" bgcolor="#f0f8ff">用户密码</td>
                    <td style="width: 400px;" align="center" bgcolor="#f0f8ff">用户权限</td>
                    <td style="width: 400px;" align="center" bgcolor="#f0f8ff">余额（元）</td>
                    <td style="width: 400px;" align="center" bgcolor="#f0f8ff">店铺名称</td>
                    <td style="width: 400px;" align="center" bgcolor="#f0f8ff">详情</td>
                    <td style="width: 400px;" align="center" bgcolor="#f0f8ff">操作</td>
                </tr>
                <c:forEach items="${userList}" var = "user">
                <tr>
                    <td style="width:400px;"align="center">${user.ID}</td>
                    <td style="width:400px;"align="center" name = "name">${user.name}</td>
                    <td style="width:400px;"align="center">${user.password}</td>
                    <td style="width:400px;"align="center">
                        <c:if test="${user.priority==0}">管理员</c:if>
                        <c:if test="${user.priority==1}">普通用户</c:if></td>
                    <td style="width:400px;"align="center">${user.charge}</td>
                    <td style="width:400px;"align="center">${user.storeName}</td>
                    <td style="width: 400px;" align="center"><input type = "button" value = "详情" class = "layui-btn layui-btn-primary layui-btn-xs" onclick="UserXQ('${user.ID}')"></td>
                    <td style="width: 400px;" align="center">
                        <a href = "javascript:void(0)" onclick="Change('${user.ID}')">修改信息</a>&nbsp;&nbsp;
                        <a href = "javascript:void(0)" onclick="DeleteUser('${user.ID}')">删除用户</a></td>
                    </c:forEach>
            </table>
            <span class = "page1">第${page}页 共${maxPage}页 每页${pageMax}条</span>
            <span class = "page2">
                <a href = "javascript:void(0);" onclick ="FirstPage()">首页</a>
                <a href = "javascript:void(0);" onclick="PreviousPage()">上一页</a>
                <input type = "text" id = "page" name = "page" value = "${page}" style = "display: none;"/>
                <a href = "javascript:void(0);" onclick="NextPage()">下一页</a>
                <a href = "javascript:void(0);" onclick="LastPage()">尾页</a>
                转到 <input type="text" id = "jumpPage" style="width: 25px;"> 页 <input type="button" value = "提交" onclick="JumpPage()" class = "layui-btn layui-btn-primary layui-btn-xs"/>
            </span>
        </div>
    </div>
</form>
<script type = "text/javascript">
    checkOption('priority','${queryUserCondition.priority}');
    checkOption('charge','${queryUserCondition.charge}');
</script>
</body>
</html>
