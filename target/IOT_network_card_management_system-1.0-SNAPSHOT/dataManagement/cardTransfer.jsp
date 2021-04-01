<%@ page import="java.util.List" %>
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
    <link href="${pageContext.request.contextPath}/layui/css/layui.css" rel="stylesheet" />
    <script src = "${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
    <script src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <base href=<%=basePath%>/>
    <style type="text/css">
        .hzsjtitle{
            width:1000px;
            height:1000px;
            position:absolute;
            top:18px;
            left: 1%;
        }
        .cardTranferTitle{
            position:absolute;
            top:48px;
            left: 1%;
        }
        #select{
            position:absolute;
            top:98px;
            left: 1%;
        }
        .cardTranferButton{
            position:absolute;
            top:158px;
            left: 1%;
        }
        select{
            height: 30px;
        }
    </style>
</head>
<body bgcolor="white" >
    <%
        List<String> ICCIDList = (List<String>)request.getAttribute("ICCIDList");
        String action = "card/transferCardToCustomer.do?";
        for(String ICCID:ICCIDList){
            action = action+"ICCID="+ICCID+"&";
        }
        // 然后就拼接user_ID就行
    %>
    <script type = text/javascript>
        action="<%=action%>";
        ICCID="<%=ICCIDList.get(0) %>";
        function fun() {
            var action1 = action;
            var userID=$("#cardTranferChoosed>option:selected").val();
            var tradeID = $("#orderChoosed>option:selected").val();
            action1=action1+"user_ID="+userID + "&" + "trade_ID=" + tradeID;
            //window.open(action1);
            $.ajax({
                url: action1,
                type: "get",
                /* dataType: "text",*/
                success: function (resp) {
                    alert(resp.msg);
                    window.open('mainPage/queryInfo.do','_self');
                },
                error : function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(XMLHttpRequest.status);
                    alert(XMLHttpRequest.readyState);
                    alert(textStatus);
                }
            })
        }
        loadTradeID = function(){
            var userID = $("#cardTranferChoosed>option:selected").val();
            $.ajax({
                url:"trade/queryUnProfessTradeByUser.do",
                data:{"user_ID":userID,
                      "type":0,
                      "ICCID":ICCID},
                dataType: "json",
                async:true,
                success:function (resp) {
                    $("#orderChoosed").empty();
                    $.each(resp,function(i,n){
                        for(var x=0;x<n.length;x++)    {
                            $("#orderChoosed").append("<option value='" + n[x] + "'>" + n[x] + "</option>");
                        }

                    })
                },
                error : function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(XMLHttpRequest.status);
                    alert(XMLHttpRequest.readyState);
                    alert(textStatus);
                }
            })
        };
    </script>
    <div class = "hzsjtitle">您现在的位置：卡片划拨</div>
    <div class = "cardTranferTitle">当前选择${amountBefore}张卡片，其中可划拨数量为${amountAfter}张，卡片必须回收到总店后才可以再划拨</div>
    <div id = "select">
    <select id = "cardTranferChoosed" onchange="loadTradeID()">
                <option value="0">选择商家</option>
                <c:forEach items = "${userList}" var = "user" >
                    <option value="${user.ID}">${user.name}</option>
                </c:forEach>
            </select>
            <select id = "orderChoosed">
                <option value="0">选择订单编号</option>
            </select>
    </div>
    <div class = "cardTranferButton">
        <input type = "button" value = "提交信息"  style="cursor: pointer" onclick="fun()" class = "layui-btn layui-btn-normal"/>
    </div>
    </body>
</html>
