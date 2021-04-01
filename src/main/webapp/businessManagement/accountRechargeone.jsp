<%@ page import="java.net.Inet4Address" %>
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
<script type = "text/javascript">
	window.onload = function () {
		var accountElt = document.getElementById("charge_trade");
		var accountErrorSpan = document.getElementById("accountError");
		var PayMethodElt = document.getElementsByName("payment_method");
		var PayMethodErrorSpan = document.getElementById("PayMethodError");
		accountElt.onblur = function () {
			var account = accountElt.value;
			if (account == "") {
				accountErrorSpan.innerText = "充值金额不能为空！";
			}
			if(account > 9999999){
				accountErrorSpan.innerText = "最大充值金额为999,9999！";
			}
		}
		accountElt.onfocus = function () {
			if (accountErrorSpan.innerText != "") {
				accountErrorSpan.innerText = "";
			}
		}
		var submitBtnElt = document.getElementById("submitBtn");
		submitBtnElt.onclick = function () {
			for (var i = 0, count = 0; i < PayMethodElt.length; i++) {
				if (PayMethodElt[i].checked) {
					count++;
					var PayMethod = PayMethodElt[i].value;
				}
			}
			if (count == 0) {
				PayMethodErrorSpan.innerText = "请选择支付方式！";
			}
			accountElt.focus();
			accountElt.blur();
			if(accountErrorSpan.innerText =="" && PayMethodErrorSpan.innerText ==""){
				var accountFormElt = document.getElementById("accountFrom");
				accountFormElt.action = "accountTrade/accountRechargeTwo.do";
				accountFormElt.submit();
			}

		}
	}
	function Select() {
		var PayMethodErrorSpan = document.getElementById("PayMethodError");
		if(PayMethodErrorSpan.innerText !=""){
			PayMethodErrorSpan.innerText = "";
		}
	}
	function Pay(){
		var account = document.getElementById("charge_trade").value;
		document.getElementById("ServiceCharge").innerHTML = (account/1000).toFixed(2);
		document.getElementById("ActualPayment").innerHTML = (parseFloat(account) + parseFloat(account/1000)).toFixed(2);
	}
</script>
<div class = "hzsjtitle">您现在的位置：账户充值</div>
<hr color = "darkgray" style="width: 100%; position: absolute; top: 50px">
<div class = "table3">
	<form id = "accountFrom">
		<table border="1px" cellspacing="0" class = "layui-table">
			<tr>
				<td width = "1500px" colspan = "2" bgcolor="aliceblue" style="font-weight: bolder;">账户充值</td>
			</tr>
			<tr>
				<td bgcolor="aliceblue" width = "200px">账户余额</td>
				<td>${charge}</td>
			</tr>
			<tr>
				<td bgcolor="aliceblue" width = "200px">充值金额</td>
				<td><input type = "text" placeholder="请输入充值金额" id= "charge_trade" name = "charge_trade" oninput="Pay()" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')">&nbsp;元
					<span id = "accountError"></span></td>
			</tr>
			<tr>
				<td bgcolor="aliceblue">支付方式</td>
				<td><label><input name="payment_method" type="radio" value = "0" onclick="Select()"/>微信 </label>
					<label><input name="payment_method" type="radio" value = "1" onclick="Select()"/>支付宝 </label>
					<span id = "PayMethodError"></span>
				</td>
			</tr>
			<tr>
				<td bgcolor="aliceblue">手续费</td>
				<td id = "ServiceCharge"></td>
			</tr>
			<tr>
				<td bgcolor="aliceblue">实际支付</td>
				<td id = "ActualPayment"></td>
			</tr>
			<tr>
				<td bgcolor="aliceblue"></td>
				<td><input type="button" value = "提交充值信息" id = "submitBtn" class = "layui-btn layui-btn-normal layui-btn-sm"></td>
			</tr>
		</table>
	</form>
</div>

</body>
</html>
