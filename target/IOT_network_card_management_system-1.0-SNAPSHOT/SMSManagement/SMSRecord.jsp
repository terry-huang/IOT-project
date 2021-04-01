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
			.add{
				position:absolute;
				top:18px;
				left: 95%;
			}
			.ICCID{
				font-size: 15px;
				position:absolute;
				top:58px;
				left: 1%;
				font-weight: bolder;
			}
			.sjmc{
				font-size: 15px;
				position:absolute;
				top:58px;
				left: 20%;
				font-weight: bolder;
			}
			.dxnr{
				font-size: 15px;
				position:absolute;
				top:58px;
				left: 40%;
				font-weight: bolder;
			}
			.tjsj{
				font-size: 15px;
				position:absolute;
				top:58px;
				left: 60%;
				font-weight: bolder;
			}
			.zhuangt{
				font-size: 15px;
				position:absolute;
				top:58px;
				left: 80%;
				font-weight: bolder;
			}
		</style>
	</head>
	<body bgcolor="white" >
			<div class = "hzsjtitle">您现在的位置：短信记录</div>
			<div class = "refresh"><input type = "button" value = "刷新" id = "refresh"/></div>
			<div class = "seek"><input type = "button" value = "查询" id = "seek"/></div>
			<div class = "ICCID">ICCID</div>
			<div class = "sjmc">商家名称</div>
			<div class = "dxnr">短信内容</div>
			<div class = "tjsj">添加时间</div>
			<div class = "zhuangt">状态</div>
			<hr color="darkgray" style="width: 100%; position: absolute; top: 80px"></hr>
	</body>
</html>
