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
			.jine{
				font-size: 15px;
				position:absolute;
				top:255px;
				left: 2%;
				font-weight: bolder;
			}
			.yue{
				font-size: 15px;
				position:absolute;
				top:255px;
				left: 20%;
				font-weight: bolder;
			}
			.shij{
				font-size: 15px;
				position:absolute;
				top:255px;
				left: 40%;
				font-weight: bolder;
			}
			.zhuangt{
				font-size: 15px;
				position:absolute;
				top:255px;
				left: 60%;
				font-weight: bolder;
			}
			.zhangh{
				font-size: 15px;
				position:absolute;
				top:255px;
				left:80%;
				font-weight: bolder;
			}
		</style>
	</head>
	<body bgcolor="white" >
			<div class = "hzsjtitle">您现在的位置：提现管理</div>
			<div class = "refresh"><input type = "button" value = "刷新" id = "refresh"/></div>
			<hr color = "darkgray" style="width: 100%; position: absolute; top: 50px"></hr>
			<div class = "table3">
				<table border="1px" cellspacing="0">
					<tr >
						<td width = "1500px" colspan = "2" bgcolor="aliceblue" style="font-weight: bolder;">当前账户余额：0.00元</td>
					</tr>
					<tr>
						<td bgcolor="aliceblue" width = "200px">提现金额</td>
						<td ><input type = "text" placeholder="0">元</td>
					</tr>
					<tr>
						<td bgcolor="aliceblue">收款人</td>
						<td><input type = "text"/></td>
					</tr>
					<tr>
						<td bgcolor="aliceblue">收款银行</td>
						<td><input type = "text"/></td>
					</tr>
					<tr>
						<td bgcolor="aliceblue">收款账号</td>
						<td><input type = "text"/></td>
					</tr>
					<tr>
						<td bgcolor="aliceblue"></td>
						<td><input type="button" value = "提交" id = "submitBtn1"></td>
					</tr>
					<tr>
						<td bgcolor="aliceblue" >温馨提示</td>
						<td>每次提现不能小于50元，每提现一次收取2元手续费。正常工作日24小时内提现到账，节假日顺延。</td>
					</tr>
				</table>
			</div>
			<div class = "jine">金额</div>
			<div class = "yue">余额</div>
			<div class = "zhuangt">状态</div>
			<div class = "shij">时间</div>
			<div class = "zhangh">账号</div>
			<hr color="darkgray" style="width: 100%; position: absolute; top: 240px"></hr>
	</body>
</html>
