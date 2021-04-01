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
			.taocanfr{
				font-size: 15px;
				position: absolute;
				top:50px;
				left: 1%;
			}
		</style>
	</head>
	<body bgcolor="white" >
		<div class = "hzsjtitle">您现在的位置：套餐管理-套餐续费价格查询</div>
		<div class = "refresh"><input type = "button" value = "刷新" id = "refresh"/></div>
		<div class = "taocanfr">
			移动-移动测试卡-价格：0元，利润：<input type="text" value="0"/>元&nbsp;<input type = "button" value = "提交" id = "submitBtn0" ><br><br>
			联通-联通测试卡-价格：0元，利润：<input type="text" value="0"/>元&nbsp;<input type = "button" value = "提交" id = "submitBtn1"><br><br>
			电信-234G通用定向对讲（一年）-价格：3元，利润：<input type="text" value="0"/>元&nbsp;<input type = "button" value = "提交" id = "submitBtn2"><br><br>
			电信-电信48G/累计12个月/通用流量-价格：234元，利润：<input type="text" value="0"/>元&nbsp;<input type = "button" value = "提交" id = "submitBtn3"><br><br>
			电信-电信视频监控5G/首月-价格：0元，利润：<input type="text" value="0"/>元&nbsp;<input type = "button" value = "提交" id = "submitBtn4"><br><br>
			电信-电信视频监控20G/月-价格：70元，利润：<input type="text" value="0"/>元&nbsp;<input type = "button" value = "提交" id = "submitBtn5"><br><br>
		</div>
	</body>
</html>
