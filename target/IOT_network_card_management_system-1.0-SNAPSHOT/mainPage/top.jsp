<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" +
            request.getServerName() + ":" +request.getServerPort() +
            request.getContextPath() + "/";
%>
<html >
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link href="../layui/css/layui.css" rel="stylesheet" />
    <script src = "../js/jquery-3.3.1.js"></script>
    <script src="../layui/layui.js"></script>
    <base href=<%=basePath%>/>
    <style type="text/css">
        .userName{
            font-weight: bolder;
            font-size: 15px;
            position: absolute;
            top: 10%;
            left: 1%;
        }
        .a1{
            text-decoration: none;
            color: black;
        }
        .title1{
            font-weight: bolder;
            font-size: 30px;
            position: absolute;
            top: 40%;
            left: 5%;
        }
        .toptips{
            font-size: 20px;
            position: absolute;
            top: 40%;
            left: 72%;
        }
        .toptips a{
            text-decoration: none;
            color:black;
        }
        .toptips a:hover{
            background: skyblue;
            color: #fff;
            width: 100px;
            height: 100px;
        }
    </style>
</head>
<body bgcolor="gainsboro">
<script type="text/javascript">
    layui.use("layer", function () {
        var layer = layui.layer;
        doit = function(){
            layer.open({
                title:"个人资料",
                type: 1,
                maxmin: true,
                area: ['700px', '600px'],
                content: $("#test")
            });
        }
    })
</script>
<div class = "title1" ><a class = "a1" href ="mainPage/queryInfo.do" target="right">物联网流量管理平台</a></div>
<div class = "userName">当前登陆用户为：${userName}</div>
<div class = "toptips">
    <a href = "mainPage/queryInfo.do" target="right">回到首页</a>
    <a href = "user/account/queryOneUserAllInfo.do" target="right">个人资料</a>
    <a href = "mainPage/changepwd.jsp" target="right">修改密码</a>
    <a href = "user/account/loginOutUser.do" target = "_top"  onclick="if(confirm('确定退出登录吗?')==false)return false;">退出登录</a>
</div>
</body>
</html>