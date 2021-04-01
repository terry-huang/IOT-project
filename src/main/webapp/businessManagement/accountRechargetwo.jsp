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
        #tips{
            position:absolute;
            top:60px;
            left:1%;
        }
        #submitBtn{
            position: absolute;
            top:100px;
            left:1%;
        }
        span{
            color: red;
            font-size: 12px;
        }
    </style>
</head>
<body bgcolor="white" >
<%
    String action = "accountTrade/accountRechargeThree.do?ID="+request.getAttribute("ID")+"&charge="+request.getAttribute("charge");
%>
<script type = "text/javascript">
    action = "<%=action%>";
    function fun() {
        var action1 = action;
        $.ajax({
            url: action1,
            type:"get",
            success:function(resp){
                if(resp.tag ==0){
                    alert(resp.msg);
                    window.open('accountTrade/queryAccountTradeAllInfo.do?type=0&page=1','_self');
                }
               if(resp.tag ==1){
                   alert(resp.msg);
                   window.open('accountTrade/queryAccountTradeAllInfo.do?type=0&page=1','_self');
               }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(XMLHttpRequest.status);
                alert(XMLHttpRequest.readyState);
                alert(textStatus);
            }
        })
    }
</script>
<div class = "hzsjtitle">您现在的位置：账户充值</div>
<hr color = "darkgray" style="width: 100%; position: absolute; top: 40px">
<p id = "tips">本次订单ID为${ID}，充值${charge}元，手续费${charge_server}元，实际支付${chargeReal}元，请打开手机支付宝扫描下面的二维码支付，支付完成后即时到账，点左边菜单帐户充值即可看见余额变动。</p>
<input type="button" id = "submitBtn" value="提交" onclick="fun()"class = "layui-btn layui-btn-normal" />
</body>
</html>
