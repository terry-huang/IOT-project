<%@ page import="java.util.List" %>
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
    <link href="${pageContext.request.contextPath}/layui/css/layui.css" rel="stylesheet" />
    <script src = "${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
    <script src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <base href=<%=basePath%>/>
    <style type="text/css">
        .hzsjtitle{
            width:1000px;
            height:1000px;
            position:absolute;
            top:18px;
            left: 1%;
        }
        .cardRecoverTitle{
            position:absolute;
            top:48px;
            left: 1%;
        }
        .cardRecoverButton{
            position:absolute;
            top:88px;
            left: 1%;
        }
    </style>
</head>
<body bgcolor="white" >
<%
    List<String> ICCIDList = (List<String>)request.getAttribute("ICCIDList");
    String action = "card/recoverCard.do?";
    for(String ICCID:ICCIDList){
        action = action+"ICCID="+ICCID+"&";
    }
    // 然后就拼接user_ID就行
%>
<script type = text/javascript>
    action="<%=action%>";
    function fun() {
        var action1 = action;
        $.ajax({
            url: action1,
            type: "get",
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




</script>
<div class = "hzsjtitle">您现在的位置：卡片回收</div>
<div class = "cardRecoverTitle">当前选择${amountBefore}张卡片，其中符合回收条件的数量为${amountAfter}张</div>
<div class = "cardRecoverButton">
    <input type = "button" value = "确定回收"  style="cursor: pointer" onclick="fun()" class = "layui-btn layui-btn-normal"/>
</div>
</body>
</html>
