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
        #orderTable{
            position: absolute;
            top:68px;
            left:1%;

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
</head>
<body bgcolor="white" >
<%
    String actionx = (String) request.getAttribute("action");
%>
<script type = "text/javascript">
    actionx = "<%=actionx%>"
    function FirstPage() {
        var page = document.getElementById("page");
        var errorLogForm = document.getElementById("errorLogForm");
        page.value = 1;
        errorLogForm.action = actionx;
        errorLogForm.submit();
    }
    function PreviousPage() {
        var page = document.getElementById("page");
        page.value = parseInt(page.value) - 1;
        if(page.value <= 0){
            alert("当前为第一页！");
            page.value = parseInt(page.value) + 1;
        }else{
            var errorLogForm = document.getElementById("errorLogForm");
            errorLogForm.action = actionx;
            errorLogForm.submit();
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
            var errorLogForm = document.getElementById("errorLogForm");
            errorLogForm.action = actionx;
            errorLogForm.submit();
        }
    }
    function LastPage() {
        //最后一页
        var page = document.getElementById("page");
        var errorLogForm = document.getElementById("errorLogForm");
        page.value = ${maxPage};
        errorLogForm.action = actionx;
        errorLogForm.submit();
    }
    function JumpPage() {
        var page = document.getElementById("page");
        var jumpPage = document.getElementById("jumpPage");
        if(jumpPage.value<=0 || jumpPage.value >(${maxPage}) || jumpPage.value == ''){
            alert("请输入正确的页码！");
        }else{
            page.value = jumpPage.value;
            var errorLogForm = document.getElementById("errorLogForm");
            errorLogForm.action = actionx;
            errorLogForm.submit();
        }
    }
</script>
<form id = "errorLogForm">
<div class = "hzsjtitle">您现在的位置：错误日志</div>
<hr color = "darkgray" style="width: 100%; position: absolute; top: 50px" />
<div id = orderTable>
    <table border="1px" cellspacing="0" class="layui-table">
        <tr>
            <td style="width: 400px;" align="center" bgcolor="#f0f8ff">错误ID</td>
            <td style="width: 400px;" align="center" bgcolor="#f0f8ff">错误订单ID</td>
            <td style="width: 400px;" align="center" bgcolor="#f0f8ff">错误发生时间</td>
            <td style="width: 400px;" align="center" bgcolor="#f0f8ff">错误处理时间</td>
        </tr>
        <c:forEach items="${accountTradeErrorList}" var = "accountTradeError">
            <tr>
                <td style="width:400px;"align="center">${accountTradeError.ID}</td>
                <td style="width:400px;"align="center">${accountTradeError.trade_ID}</td>
                <td style="width:400px;"align="center">${accountTradeError.time}</td>
                <td style="width:400px;"align="center">
                    <c:if test="${accountTradeError.status ==0}">未处理</c:if>
                    <c:if test="${accountTradeError.status ==1}">${accountTradeError.processing_time}</c:if></td>
            </tr>
        </c:forEach>
    </table>
    <span class = "page1">第${page}页 共${maxPage}页 每页${pageMax}条</span>
    <span class = "page2">
                <a href = "javascript:void(0);" onclick ="FirstPage()">首页</a>
                <a href = "javascript:void(0);" onclick="PreviousPage()">上一页</a>
                <input type = "text" id = "page" name = "page" value = "${page}" style = "display: none;"/>
                <a href = "javascript:void(0);" onclick="NextPage()">下一页</a>
                <a href = "javascript:void(0);" onclick="LastPage()">尾页</a>
                转到 <input type="text" id = "jumpPage" style="width: 25px;"> 页 <input type="button" value = "提交" class = "layui-btn layui-btn-primary layui-btn-xs" onclick="JumpPage()"/>
            </span>
</div>
</form>
</body>
</html>
