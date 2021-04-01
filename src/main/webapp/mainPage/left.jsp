<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri ="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    String basePath = request.getScheme() + "://" +
            request.getServerName() + ":" +request.getServerPort() +
            request.getContextPath() + "/";
%>
<html >
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <base href=<%=basePath%>/>
    <meta name = "renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <script src = "${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
    <link href="${pageContext.request.contextPath}/layui/css/layui.css" rel="stylesheet" media="all"/>
    <script src="${pageContext.request.contextPath}/layui/layui.js"></script>
</head>
<style>
    .layui-this > a {
        background-color: #01AAED !important;
    }
</style>
<body>
<script>
    layui.use('element',function(){
        var element = layui.element;
        element.on('nav(demo)',function (elem){
            layer.msg(elem.text());
        });
    });
</script>
<ul class="layui-nav layui-nav-tree layui-inline layui-nav-side layui-bg-blue" style="margin-right: 10px;" lay-filter="demo">
    <li class="layui-nav-item">
        <a href="javascript:;">数据管理</a>
        <dl class="layui-nav-child ">
            <dd><a href="card/queryAllCardInfo.do?server=0&page=1&presentPage=0" target="right">移动卡片</a></dd>
            <dd><a href="card/queryAllCardInfo.do?server=1&page=1&presentPage=0" target="right">电信卡片</a></dd>
            <dd><a href="card/queryAllCardInfo.do?server=2&page=1&presentPage=0" target="right">联通卡片</a></dd>
        </dl>
    </li>
    <li class="layui-nav-item">
        <a href="javascript:;">订单管理</a>
        <dl class="layui-nav-child">
            <dd><a href ="trade/queryEasyRenewalTrade.do?type=0&page=1" target="right">卡片购买订单</a></dd>
            <dd><a href ="trade/queryEasyRenewalTrade.do?type=1&page=1" target="right">卡片充值订单</a></dd>
            <dd><a href ="accountTrade/queryAccountTradeAllInfo.do?type=0&page=1" target="right">账户充值订单</a></dd>
 <%--           <dd><a href ="accountTrade/queryAccountTradeAllInfo.do?type=1&page=1" target="right">账户提现订单</a></dd>--%>
        </dl>
    </li>
    <li class="layui-nav-item">
        <a href="javascript:;">业务办理</a>
        <dl class="layui-nav-child">
            <dd>
                <c:if test = "${priority ==0}">
                <a href="businessManagement/insertNewcardone.jsp" target="right">登记卡片</a>
                </c:if>
            </dd>
            <dd>
                <c:if test = "${priority ==1}">
                <a href="businessManagement/purchaseCard.jsp" target="right">购买卡片</a>
                </c:if>
            </dd>
            <dd><a href="businessManagement/cardsRenewalone.jsp" target="right">卡片续费</a></dd>
            <dd><a href="accountTrade/accountRechargeOne.do" target="right">账户充值</a></dd>
<%--            <dd><a href="businessManagement/withdrawManagement.jsp" target="right">提现管理</a></dd>
            <dd><a href="businessManagement/SetMealShare.jsp" target="right">套餐分润</a></dd>--%>
            <dd><a href="businessManagement/batchRemarks.jsp" target="right">批量备注</a></dd>
        </dl>
    </li>
    <c:if test = "${priority==0}">
        <li class = "layui-nav-item">
            <a href="javascript:;">日志管理</a>
            <dl class = "layui-nav-child">
                <dd><a href="user/account/queryAllUserInfo.do?page=1" target="right">用户日志</a></dd>
                <dd><a href="accountTradeError/showErrorInfo.do?page=1" target="right">错误日志</a></dd>
            </dl>
        </li>
    </c:if>
</ul>
</body>
</html>