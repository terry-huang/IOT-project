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
        .hyzh{
            font-size: 15px;
            position:absolute;
            top:58px;
            left: 1%;
            font-weight: bolder;
        }
        .xingm{
            font-size: 15px;
            position:absolute;
            top:58px;
            left: 15%;
            font-weight: bolder;
        }
        .tjsj{
            font-size: 15px;
            position:absolute;
            top:58px;
            left: 35%;
            font-weight: bolder;
        }
        .dlIP{
            font-size: 15px;
            position:absolute;
            top:58px;
            left: 55%;
            font-weight: bolder;
        }
        .dlsj{
            font-size: 15px;
            position:absolute;
            top:58px;
            left: 75%;
            font-weight: bolder;
        }
        .caoz{
            font-size: 15px;
            position:absolute;
            top:58px;
            left: 90%;
            font-weight: bolder;
        }
    </style>
</head>
<body bgcolor="white" >
<div class = "hzsjtitle">您现在的位置：员工管理</div>
<div class = "refresh"><input type = "button" value = "刷新" id = "refresh"/></div>
<div class = "seek"><input type = "button" value = "查询" id = "seek"/></div>
<div class = "add"><input type = "button" value = "添加" id = "add"/></div>
<hr color = "darkgray" style="width: 100%; position: absolute; top: 50px"></hr>
<div class = "hyzh">会员账号</div>
<div class = "xingm">姓名</div>
<div class = "tjsj">添加时间</div>
<div class = "dlIP">登陆IP</div>
<div class = "dlsj">登陆时间</div>
<div class = "caoz">操作</div>
</body>
</html>
