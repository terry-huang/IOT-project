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
		}
		#RenewPriceError{
			color: red;
			font-size:12px;
		}
		input{
			border: 1px solid #9F9F9F;
		}
	</style>
</head>
<body bgcolor="white" >
<%
	List<String> ICCIDList = (List<String>)request.getAttribute("ICCIDList");
	String action = "card/rechargeCard.do?";  //这要改吗
	for(String ICCID:ICCIDList){
		action = action+"ICCID="+ICCID+"&";
	}
	// 然后就拼接user_ID就行
%>
<script type = text/javascript>
		action="<%=action%>";
		window.onload = function () {
			var RenewPriceElt = document.getElementById("RenewPrice");
			var RenewPriceErrorSpan = document.getElementById("RenewPriceError");
			RenewPriceElt.onblur = function () {
				var RenewPrice = RenewPriceElt.value; //1
				RenewPrice = RenewPrice.trim();
				if (RenewPrice === "") {
					RenewPriceErrorSpan.innerText = "续费价格不能为空";
				} else {
					var regExp = /^[0-9]*$/;
					var ok = regExp.test(RenewPrice);
					if (!ok) {
						RenewPriceErrorSpan.innerText = "续费价格只能为数字";
					}
				}
			}
			RenewPriceElt.onfocus = function () {
				RenewPriceErrorSpan.innerText = "";
			}
		}

	function fun() {
		var RenewPriceElt = document.getElementById("RenewPrice");
		var RenewPriceErrorSpan = document.getElementById("RenewPriceError");
		var action1 = action;
		var charge_trade = $("#RenewPrice").val();
		action1 = action1 + "charge_trade=" + charge_trade;
		RenewPriceElt.focus();
		RenewPriceElt.blur();
		if (RenewPriceErrorSpan.innerText == "") {
			//window.open(action1);
			$.ajax({
				url: action1,
				type: "get",
				/* dataType: "text",*/
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

<div class = "hzsjtitle">您现在的位置：卡片续费</div>
<div class = "refresh"><input type = "button" value = "刷新" id = "refresh"/></div>
<hr color = "darkgray" style="width: 100%; position: absolute; top: 50px"></hr>
<div class = "table3">
	<form id = "RenewForm">
	<table border="1px" cellspacing="0" class = "layui-table">
		<tr >
			<td width = "1500px" colspan = "2" bgcolor="aliceblue" style="font-weight: bolder;">卡片续费</td>
		</tr>
		<tr>
			<td bgcolor="aliceblue" width = "200px">账户余额</td>
			<td >${user.charge}</td>
		</tr>
		<tr>
			<td bgcolor="aliceblue" width = "200px">ICCID</td>
			<td><c:forEach items="${ICCIDList}" var="ICCID">
				${ICCID}<br/>
			</c:forEach>
			</td>
		</tr>
		<tr>
			<td bgcolor="aliceblue" width = "200px" >续费金额</td>
			<td><input type="text" id = "RenewPrice"/>&nbsp;&nbsp;元<span class = "RenewPriceError" id = "RenewPriceError" ></span></td>

		</tr>
		<tr>
			<td bgcolor="aliceblue"></td>
			<td><input type="button" value = "提交" id = "submitBtn1" style="cursor: pointer" onclick = "fun()" class = "layui-btn layui-btn-normal layui-btn-sm"></td>
		</tr>
	</table>
	</form>
</div>
</body>
</html>
