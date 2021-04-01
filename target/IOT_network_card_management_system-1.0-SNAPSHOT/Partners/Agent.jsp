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
        .dlzh{
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
        .lxdh{
            font-size: 15px;
            position:absolute;
            top:58px;
            left: 40%;
            font-weight: bolder;
        }
        .yue{
            font-size: 15px;
            position:absolute;
            top:58px;
            left: 60%;
            font-weight: bolder;
        }
        .caoz{
            font-size: 15px;
            position:absolute;
            top:58px;
            left: 80%;
            font-weight: bolder;
        }
        .tjdls{
            display: none;
            position: absolute;
            top: 25%;
            left: 25%;
            width: 55%;
            height: 20%;
            padding: 20px;
            border: 1px solid ;
            background-color: white;
        }
        #xgzhxx{
            display: none;
            position: absolute;
            top: 10%;
            left: 15%;
            width: 70%;
            height: 40%;
            padding: 20px;
            border: 1px solid ;
            background-color: white;
        }
        #xgpwd{
            display: none;
            position: absolute;
            top: 10%;
            left: 15%;
            width: 70%;
            height: 40%;
            padding: 20px;
            border: 1px solid ;
            background-color: white;
        }
    </style>
</head>
<body bgcolor="white" >
<!--<script type="text/javascript">
    $(document).ready(function(){
        $("#firstpage").click(function(){
            window.open("002-首页.html","_self");
        })
        $("#profile").click(function(){
            document.getElementById("xgzhxx").style.display = "block";
        })
        $("#profile").blur(function(){
            document.getElementById("xgzhxx").style.display = "none";
        })
        $("#changepwd").click(function(){
            document.getElementById("xgpwd").style.display = "block";
        })
        $("#submitBtnpwd").click(function(){
            //提交
            document.getElementById("xgpwd").style.display = "none";
        })
        $("#exit").click(function(){
            if (confirm("是否确认退出？")== true){
                window.open("001-登录.html","_self");
            }
        })
        $("#refresh").click(function(){
            alert("刷新");
        })
        $("#seek").click(function(){
            alert("查找");
        })
        $("#add").click(function(){
            //添加代理商
            document.getElementById("tjdls").style.display = "block";
        })
        $("#submitBtndls").click(function(){
            //提交
            document.getElementById("tjdls").style.display = "none";
        })
    })
</script>-->
<div class = "hzsjtitle">您现在的位置：代理商管理</div>
<div class = "refresh"><input type = "button" value = "刷新" id = "refresh"/></div>
<div class = "seek"><input type = "button" value = "查询" id = "seek"/></div>
<div class = "add"><input type = "button" value = "添加" id = "add"/></div>
<hr color = "darkgray" style="width: 100%; position: absolute; top: 50px"></hr>
<div class = "dlzh">登陆账号</div>
<div class = "sjmc">商家名称</div>
<div class = "lxdh">联系电话</div>
<div class = "yue">余额</div>
<div class = "caoz">操作</div>
</body>
</html>
