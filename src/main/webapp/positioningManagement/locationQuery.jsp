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
			.ICCIDseek{
				position:absolute;
				top:50px;
				left:1%;
			}
			.tjxx{
				position:absolute;
				top:80px;
				left:1%;
			}
		</style>
	</head>
	<body bgcolor="white" >
			<div class = "hzsjtitle">您现在的位置：地图定位</div>
			<div class = "ICCIDseek"><input type = "text" placeholder="请输入ICCID查询"></div>
			<div class = "tjxx"><input type = "button" value = "提交信息" id="tjxx">加载需要时间，请耐心等待</div>
			<hr color="darkgray" style="width: 100%; position: absolute; top:150px"></hr>
	</body>
</html>
