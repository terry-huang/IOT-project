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
        input{
            border: 1px solid #9F9F9F;
        }
        span{
            color: red;
            font-size: 12px;
        }
    </style>
</head>
<body bgcolor="white" >
<script type = "text/javascript">
    window.onload = function () {
        var ICCIDElt = document.getElementById("ICCID");
        var ICCIDErrorSpan = document.getElementById("ICCIDError");
        var business_numberElt = document.getElementById("business_number");
        var business_numberErrorSpan = document.getElementById("business_numberError");
        var costElt = document.getElementById("cost");
        var costErrorSpan = document.getElementById("costError");
        var priceElt = document.getElementById("price");
        var priceErrorSpan = document.getElementById("priceError");
        ICCIDElt.onblur = function(){
            var ICCID = ICCIDElt.value;
            if(ICCID == "")
            {
                ICCIDErrorSpan.innerText = "ICCID不能为空！";
            }
        }
        ICCIDElt.onfocus = function(){
            ICCIDErrorSpan.innerText ="";
        }
        business_numberElt.onblur = function(){
            var business_number = business_numberElt.value;

            if(business_number =="")
            {
                business_numberErrorSpan.innerText = "业务号码不能为空！";
            }
        }
        business_numberElt.onfocus = function(){
            business_numberErrorSpan.innerText = " ";
        }
        costElt.onblur = function(){
            var cost = costElt.value;
            if(cost == "")
            {
                costErrorSpan.innerText = "卡片成本不能为空！";
            }
        }
        costElt.onfocus = function(){
            costErrorSpan.innerText = " ";
        }
        priceElt.onblur = function(){
            var price = priceElt.value;
            if(price == "")
            {
                priceErrorSpan.innerText = "卡片售价不能为空！"
            }
        }
        priceElt.onfocus = function(){
            priceErrorSpan.innerText = " "
        }
        var submitBtn1Elt = document.getElementById("submitBtn1");
        submitBtn1Elt.onclick = function () {
            ICCIDElt.focus();
            ICCIDElt.blur();
            business_numberElt.focus();
            business_numberElt.blur();
            costElt.focus();
            costElt.blur();
            priceElt.focus();
            priceElt.blur();
            var cost = costElt.value;
            var price = priceElt.value;
            if(parseInt(cost) > parseInt(price))
            {
                priceErrorSpan.innerText = "卡片售价不能低于卡片成本！"
            }

            if(ICCIDErrorSpan.innerText =="" && business_numberErrorSpan.innerText == "" && costErrorSpan.innerText =="" && priceErrorSpan.innerText =="")
            {
                var insertNewcardFormElt = document.getElementById("insertNewcardForm");
                insertNewcardFormElt.action = 'card/registerCard.do';
                insertNewcardFormElt.submit();
            }
        }
    }
</script>
<div class = "hzsjtitle">您现在的位置：登记卡片</div>
<div class = "refresh"><input type = "button" value = "刷新" id = "refresh"/></div>
<hr color = "darkgray" style="width: 100%; position: absolute; top: 40px">
<form id = "insertNewcardForm">
    <div class = "table3">
        请选择要插入卡片的运营商：
        <select name="server">
            <option value = "0">移动</option>
            <option value = "1">电信</option>
            <option value = "2">联通</option>
        </select><br><br>
        <table border="1px" cellspacing="0" class = "layui-table" >
            <tr >
                <td width = "1500px" colspan = "2" bgcolor="aliceblue" style="font-weight: bolder;">登记卡片</td>
            </tr>
            <tr>
                <td bgcolor="aliceblue" width = "100px" align="center">ICCID</td>
                <td ><input type = "text" style="width: 600px; height:200px;" placeholder="请输入要插入卡片的ICCID，如果要批量插入，则各ICCID之间使用“#”隔开" name = "ICCID" id = "ICCID" >
                    <span id = "ICCIDError"></span></td>

            </tr>
            <tr>
                <td bgcolor="aliceblue" align="center">业务号码</td>
                <td><input type = "text" style="width: 600px;" placeholder="请输入卡片的业务号码，如果批量登记，则输入第一张卡片的业务号码即可" name = "business_number" id = "business_number" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')">
                    <span id = "business_numberError"></span></td>
            </tr>
            <tr>
                <td bgcolor="aliceblue" align="center">有效起始时间</td>
                <td><input type="date" value="2020-01-01" name = "start_time"/></td>
            </tr>
            <tr>
                <td bgcolor="aliceblue" align="center">有效截止时间</td>
                <td><input type="date" value="2020-01-01" name = "end_time"/></td>
            </tr>
            <tr>
                <td bgcolor="aliceblue" align="center">卡片成本</td>
                <td><input type = "text" style="width: 600px;" placeholder="请输入卡片的成本，输入数字即可" name = "cost" id = "cost" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')">
                    <span id = "costError"></span></td>
            </tr>
            <tr>
                <td bgcolor="aliceblue" align="center">卡片售价</td>
                <td><input type = "text" style="width: 600px;" placeholder="请输入卡片的售价，输入数字即可" name = "price" id= "price" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')">
                    <span id = "priceError"></span></td>
            </tr>
            <tr>
                <td bgcolor="aliceblue"></td>
                <td><input type="button" value = "提交" id = "submitBtn1" style="cursor: pointer" class = "layui-btn layui-btn-normal layui-btn-sm"></td>
            </tr>
        </table>
    </div>
</form>
</body>
</html>
