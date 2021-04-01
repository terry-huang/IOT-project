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
	<base href=<%=basePath%>/>
	<link href="${pageContext.request.contextPath}/layui/css/layui.css" rel="stylesheet" />
	<script src = "${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
	<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
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
	<script>
		window.onload = function(){
			var ICCIDElt = document.getElementById("ICCID");
			var ICCIDErrorSpan = document.getElementById("ICCIDError");
			ICCIDElt.onblur = function () {
				var ICCID = ICCIDElt.value;
				if(ICCID == ""){
					ICCIDErrorSpan.innerText = "ICCID不能为空！"
				}
			}
			ICCIDElt.onfocus = function () {
				if(ICCIDErrorSpan.innerText != ""){
					ICCIDErrorSpan.innerText = "";
				}
			}
			var submitBtnElt = document.getElementById("submitBtn");
			submitBtnElt.onclick = function () {
				ICCIDElt.focus();
				ICCIDElt.blur();
				if(ICCIDErrorSpan.innerText ==""){
					var RenewFormElt = document.getElementById("RenewForm");
					RenewFormElt.action = "card/chooserAmountRechargeCard.do";
					RenewFormElt.submit();
				}
			}

		}
	</script>
		<div class = "hzsjtitle">您现在的位置：卡片续费</div>
		<hr color = "darkgray" style="width: 100%; position: absolute; top: 50px"></hr>
	<form id = "RenewForm">
		<div class = "table3">
			<table border="1px" cellspacing="0" class="layui-table">
				<tr >
					<td width = "1500px" colspan = "2" bgcolor="aliceblue" style="font-weight: bolder;">卡片续费</td>
				</tr>
				<tr>
					<td bgcolor="aliceblue" width = "200px">ICCID号码</td>
					<td  ><input type = "text" style = "width:600px; height:200px;" name = "ICCID" id = "ICCID"
					placeholder="请输入要续费的ICCID，可以输入一个或多个ICCID，多个ICCID使用“#”隔开">
					<span id = "ICCIDError"></span></td>
				</tr>
				<tr>
					<td bgcolor="aliceblue"></td>
					<td><input type = "button" value = "提交信息"  id = "submitBtn" style="cursor: pointer" class = "layui-btn layui-btn-normal layui-btn-sm"/></td>
				</tr>
			</table>
		</div>
	</form>
	</body>
</html>
