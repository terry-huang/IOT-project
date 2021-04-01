<%--
  Created by IntelliJ IDEA.
  User: deer Terry
  Date: 2020/7/7
  Time: 11:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" +
            request.getServerName() + ":" + request.getServerPort()+
            request.getContextPath() + "/";
%>
<html>
<head>
    <meta charset="utf-8">
    <title>物联网连接服务平台</title>
</head>
<body>
${result}
</body>
</html>