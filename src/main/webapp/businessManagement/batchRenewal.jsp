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
		</style>
	</head>
	<body bgcolor="white" >
			<div class = "hzsjtitle">您现在的位置：批量续费</div>
			<div class = "refresh"><input type = "button" value = "刷新" id = "refresh"/></div>
			<hr color = "darkgray" style="width: 100%; position: absolute; top: 50px"></hr>
			<div class = "table3">
				<table border="1px" cellspacing="0">
					<tr >
						<td width = "1500px" colspan = "2" bgcolor="aliceblue" style="font-weight: bolder;">批量续费</td>
					</tr>
					<tr>
						<td bgcolor="aliceblue">ICCID号码</td>
						<td height ="200px"><input type = "text" style="width:700px; height:200px;" 
						placeholder="可以直接复制EXCEL中整列ICCID;手动输入ICCID;一行一个.连号的ICCID用#连接,最多只能执行5000条记录."></td>
					</tr>
					<tr>
						<td bgcolor="aliceblue">操作说明</td>
						<td>本次共输入0条记录，可输入5000条记录</td>
					</tr>
					<tr>
						<td bgcolor="aliceblue"></td>
						<td><input type="button" value = "提交" id = "submitBtn1"></td>
					</tr>
				</table>
			</div>
	</body>
</html>
