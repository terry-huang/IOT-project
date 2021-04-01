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
				left: 85%;
			}
			.seek{
				position:absolute;
				top:18px;
				left: 90%;
			}
			.table2{
				position:absolute;
				top:100px;
			}
			.yclbutton{
				position:absolute;
				top:70px;
				left:2%;
			}
		</style>
	</head>
	<body bgcolor="white" >
		<div class = "hzsjtitle">您现在的位置：变动管理</div>
		<div class = "refresh"><input type = "button" value = "刷新" id = "refresh"/></div>
		<div class = "seek"><input type = "button" value = "查询" id = "seek"/></div>
		<hr color = "darkgray" style="width: 100%; position: absolute; top: 50px"></hr>
		<div class = "yclbutton"><input type = "button" value = "已处理" id = "yclbutton"></div>
		<div class = "table2">
			<table border="1px" cellspacing="0">
				<tr>
					<td width="200px" align="center"><input type = "checkbox"/></td>
					<td width="200px" align="center">ICCID</td>
					<td width="200px" align="center">业务号码</td>
					<td width="200px" align="center">所属商家</td>
					<td width="200px" align="center">运营商</td>
					<td width="200px" align="center">刷新时间</td>
					<td width="200px" align="center">状态</td>
					<td width="200px" align="center">详情</td>
				</tr>
				<tr>
					<td width="200px" align="center">&nbsp;</td>
					<td width="200px" align="center"></td>
					<td width="200px" align="center"></td>
					<td width="200px" align="center"></td>
					<td width="200px" align="center"></td>
					<td width="200px" align="center"></td>
					<td width="200px" align="center"></td>
					<td width="200px" align="center"></td>
				</tr>
				<tr>
					<td width="200px" align="center">&nbsp;</td>
					<td width="200px" align="center"></td>
					<td width="200px" align="center"></td>
					<td width="200px" align="center"></td>
					<td width="200px" align="center"></td>
					<td width="200px" align="center"></td>
					<td width="200px" align="center"></td>
					<td width="200px" align="center"></td>
				</tr>
				<tr>
					<td width="200px" align="center">&nbsp;</td>
					<td width="200px" align="center"></td>
					<td width="200px" align="center"></td>
					<td width="200px" align="center"></td>
					<td width="200px" align="center"></td>
					<td width="200px" align="center"></td>
					<td width="200px" align="center"></td>
					<td width="200px" align="center"></td>
				</tr>
				<tr>
					<td width="200px" align="center">&nbsp;</td>
					<td width="200px" align="center"></td>
					<td width="200px" align="center"></td>
					<td width="200px" align="center"></td>
					<td width="200px" align="center"></td>
					<td width="200px" align="center"></td>
					<td width="200px" align="center"></td>
					<td width="200px" align="center"></td>
				</tr>
				<tr>
					<td width="200px" align="center">&nbsp;</td>
					<td width="200px" align="center"></td>
					<td width="200px" align="center"></td>
					<td width="200px" align="center"></td>
					<td width="200px" align="center"></td>
					<td width="200px" align="center"></td>
					<td width="200px" align="center"></td>
					<td width="200px" align="center"></td>
				</tr>	
			</table>
		</div>
	</body>
</html>
