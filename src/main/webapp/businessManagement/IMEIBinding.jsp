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
			.table4{
				position:absolute;
				top:50px;
				left: 45%;
			}
		</style>
	</head>
	<body bgcolor="white" >
			<div class = "hzsjtitle">您现在的位置：IMEI号绑定</div>
			<div class = "table4">
				<table>
					<tr>
						<td align="center">IMEI号机卡绑定/变更</td>
					</tr>
					<tr>
						<td align="center"><input type = "text" placeholder="请输入要办理的ICCID" style="width: 200px;"></td>
					</tr>
					<tr>
						<td align="center"><input type = "text" placeholder="请输入新的IMEI号前8位或14位" style = "width: 200px;"></td>
					</tr>
					<tr>
						<td align="center"><input type = "button" value = "绑定变更" id = "bangding"
						></td>
					</tr>
					<tr>
						<td align="center"><input type = "button" value = "批量变更" id = "piliang"
						></td>
					</tr>
				</table>
			</div>
	</body>
</html>
