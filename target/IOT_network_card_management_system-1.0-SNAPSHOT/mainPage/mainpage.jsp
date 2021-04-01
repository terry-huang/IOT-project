<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String basePath = request.getScheme() + "://" +
            request.getServerName() + ":" +request.getServerPort() +
            request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>首页</title>
    <base href=<%=basePath%>/>
    <frameset rows="13%,87%" frameborder="0">
        <frame name="top" src="mainPage/topDisplay.do" />
        <frameset cols="10%,90%" frameborder="0">
            <frame name="left" src= "mainPage/leftDisplay.do"/>
            <frame name="right" src="mainPage/queryInfo.do" />
        </frameset>
    </frameset>
</head>

</html>
