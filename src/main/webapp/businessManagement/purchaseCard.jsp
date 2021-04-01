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
        .refresh{
            position:absolute;
            top:18px;
            left: 95%;
        }
        .table3{
            position:absolute;
            top:60px;
            left: 1%;
        }
        span{
            color: red;
            font-size: 12px;
        }

    </style>
</head>
<body bgcolor="white" >
<%
    String action = "card/purchaseCard.do?";
    // 然后就拼接user_ID就行
%>
<script type = "text/javascript">

    action = "<%=action%>";
    function fun() {
        var amountval = document.getElementById("amount").value;
        var serverval = document.getElementById("server").value;
        var action1 = action + "server="+serverval +"&"+"amount=" + amountval ;
        var serverElt = document.getElementById("server");
        var serverErrorSpan = document.getElementById("serverError");
        var amountElt = document.getElementById("amount");
        var amountErrorSpan = document.getElementById("amountError");
        amountElt.onblur = function(){
            var amount = amountElt.value;
            if(amount == "") {
                amountErrorSpan.innerText = "请输入购买数量!";
            }
                if(amount == 0 && amount != "")
                    amountErrorSpan.innerText = "数量不能为零！";
        }
        amountElt.onfocus = function(){
            amountErrorSpan.innerText = " "
        }
        var servervalue = serverElt.value;
        serverElt.onchange = function () {
            serverErrorSpan.innerText = "";
        }
        if(serverval == -1)
            serverErrorSpan.innerText = "请选择运营商！"

        amountElt.focus();
        amountElt.blur();
        if(amountErrorSpan.innerText ==""&& serverErrorSpan.innerText=="") {
            $.ajax({
                url: action1,
                type: "get",
                success: function (resp) {
                    alert(resp.msg);
                    window.open('mainPage/queryInfo.do', '_self');
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(XMLHttpRequest.status);
                    alert(XMLHttpRequest.readyState);
                    alert(textStatus);
                }
            })
        }
    }
</script>
<div class = "hzsjtitle">您现在的位置：购买卡片</div>
<div class = "refresh"><input type = "button" value = "刷新" id = "refresh"/></div>
<hr color = "darkgray" style="width: 100%; position: absolute; top: 40px">
<div class = "table2">
</div>
<form id = "purchaseCardForm">
    <div class = "table3" >
        <table border="1px" cellspacing="0" id = "table" style = "width: 500px;" class = "layui-table">
            <tr>
                <td bgcolor="aliceblue" colspan="3" style="font-weight:bold">运营商卡片信息</td>
            </tr>
            <tr>
                <td bgcolor="aliceblue" align="center" style="font-weight:bold">运营商</td>
                <td bgcolor="aliceblue" align="center" style="font-weight:bold">单张金额（元）</td>
            </tr>
            <tr >
            <td align="center">移动</td>
            <td align="center">10</td>
        </tr>
            <tr >
                <td align="center">电信</td>
                <td align="center">10</td>
            </tr>
            <tr >
                <td align="center">联通</td>
                <td align="center">10</td>
            </tr>
        </table>
        <br><br>
        请选择要购买卡片的运营商：
        <select name="server" id = "server">
            <option value = "-1" selected>运营商</option>
            <option value = "0">移动</option>
            <option value = "1">电信</option>
            <option value = "2">联通</option>
        </select>&nbsp;<span id = "serverError"></span><br><br><br><br>


        请在下表输入购买卡片的数量<br><br>
        <table border="1px" cellspacing="0" style="width: 800px;" class = "layui-table">
            <tr>
                <td bgcolor="aliceblue" colspan="3" style="font-weight:bold">购买卡片</td>
            </tr>
            <tr >
                <td bgcolor="aliceblue" align = "center" style="font-weight:bold">单张金额（元）</td>
                <td bgcolor="aliceblue" align = "center" style="font-weight:bold">购买数量（张）</td>
            </tr>
            <tr >
                <td align = "center">10</td>
                <td align = "center" style="width: 500px;"><input type = "text" placeholder="请输入购买卡片的数量" id = "amount"/>
                    <span id = "amountError"></span></td>
            </tr>
        </table>
        <br>
        <input type = "button" value = "提交" id = "submitBtn1" onclick="fun()" class = "layui-btn layui-btn-normal"/>
    </div>
</form>
</body>
</html>
