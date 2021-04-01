<%@ page import="java.net.Inet4Address" %>
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
    <link href="${pageContext.request.contextPath}/layui/css/layui.css" rel="stylesheet" />
    <script src = "${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
    <script src="${pageContext.request.contextPath}/layui/layui.js"></script>
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
        .table3{
            position:absolute;
            top:60px;
            left: 1%;
        }
        .ddhm{
            font-size: 15px;
            position:absolute;
            top:255px;
            left: 2%;
            font-weight: bolder;
        }
        .czje{
            font-size: 15px;
            position:absolute;
            top:255px;
            left: 15%;
            font-weight: bolder;
        }
        .sxf{
            font-size: 15px;
            position:absolute;
            top:255px;
            left: 25%;
            font-weight: bolder;
        }
        .sjzf{
            font-size: 15px;
            position:absolute;
            top:255px;
            left:35%;
            font-weight: bolder;
        }
        .czsj{
            font-size: 15px;
            position:absolute;
            top:255px;
            left: 45%;
            font-weight: bolder;
        }
        .zffs{
            font-size: 15px;
            position:absolute;
            top:255px;
            left: 60%;
            font-weight: bolder;
        }
        .zhuangt{
            font-size: 15px;
            position:absolute;
            top:255px;
            left: 75%;
            font-weight: bolder;
        }
        .beiz{
            font-size: 15px;
            position:absolute;
            top:255px;
            left:90%;
            font-weight: bolder;
        }
    </style>
    <%
        Integer server = Integer.valueOf((String) request.getAttribute("server"));
        String Server = null;
        if (server == 0){
            Server = "移动";
        }else if (server == 1){
            Server = "电信";
        }else if (server == 2){
            Server = "联通";
        }
        int i = 1;
    %>
</head>
<body bgcolor="white" >
<div class = "hzsjtitle">您现在的位置：新增卡片信息</div>
<div class = "refresh"><input type = "button" value = "刷新" id = "refresh"/></div>
<hr color = "darkgray" style="width: 100%; position: absolute; top: 40px"></hr>
<div class = "table3">
    本次新增了${amount}张卡片，卡片的运营商为<%=Server%>，以下为新增卡片的ICCID。
    <br>
    <br>
    <table border="1px" cellspacing="0" class="layui-table">

        <tr>
            <td width = "100px" align="center" bgcolor="#f0f8ff">序号</td>
            <td  width = "500px" align="center" bgcolor="#f0f8ff">ICCID</td>
        </tr>

        <c:forEach items="${ICCIDList}" var="ICCID">
            <tr>
                <td width = "100px" align="center"><%=i++%></td>
                <td  width = "500px" align="center">${ICCID}</td>
            </tr>
        </c:forEach>

    </table>
    <br>
    注：本表仅显示新增卡片的部分信息，若要查看卡片的详细信息，请点击对应的运营商卡片进行查看。
</div>

</body>
</html>
