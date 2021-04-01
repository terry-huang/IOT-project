<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" +
            request.getServerName() + ":" +request.getServerPort() +
            request.getContextPath() + "/";
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>首页</title>
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
    <form action = "mainPage/queryInfo.do">
        <table id = "table1" width = "30%"  border = "1px" cellspacing = "0" bordercolor = "skyblue" >
            <tr height = "50" bgcolor = "skyblue">
                <td>账户余额</td>
            </tr>
            <tr height = "100">
                <td align = "center">${charge}元
                    <a href="accountTrade/queryAccountTradeAllInfo.do?type=0&page=1">明细</a>
                    <a href="businessManagement/withdrawManagement.jsp">提现</a>
                    <a href="accountTrade/accountRechargeOne.do">充值</a>
            </tr>
        </table>
        <table id = "table2" width = "30%"  border = "1px" cellspacing = "0" bordercolor = "skyblue"  >
            <tr height = "50" bgcolor = "skyblue">
                <td>订单信息</td>
            </tr>
            <tr height = "100">
                <td align = "center">已下订单${tradeAmount}单 未处理${tradeAmount-processTradeAmount}单 已处理${processTradeAmount}单</td>
            </tr>
        </table>
        <table id = "table3" width = "30%"  border = "1px" cellspacing = "0" bordercolor = "skyblue"  >
            <tr height = "50" bgcolor = "skyblue">
                <td>库存信息</td>
            </tr>
            <tr height = "100">
                <td align = "center">移动${mobileCardAmount}张 电信${telecomCardAmount}张 联通${unicomCardAmount}张</td>
            </tr>
        </table>
        <table id = "table4" width = "94%"  border = "1px" cellspacing = "0" bordercolor = "skyblue">
            <tr height = "50" bgcolor = "skyblue">
                <td>SIM卡基本数据</td>
            </tr>
            <tr height = "300">
                <td>SIM卡基本数据</td>
            </tr>
        </table>
    </form>
</body>
</html>
