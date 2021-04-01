<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri ="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
        .cardbg{
            position: absolute;
            top:50px;
            left:1%;
        }

        .page1{
            font-size: 15px;
            position: relative;
        }
        .page2{
            font-size: 15px;
            position: absolute;
            left: 75%;
        }
        a{
            text-decoration: underline;
            color: #1E9FFF;
        }
    </style>
    <script type = "text/javascript">
        function checkOption(id,value) {
            var select = document.getElementById(id);
            var options = select.options;
            for (var i =0;i<options.length;i++){
                if(options[i].value == value){
                    options[i].selected = true;
                    break;
                }
            }
        }
    </script>
</head>
<body bgcolor="white" >
<%
    String action = "accountTrade/processPendingOrder.do?";
    String actionx = (String) request.getAttribute("action");
%>
<script type="text/javascript">
    action = "<%=action%>";
    actionx = "<%=actionx%>";
    function accountXQ(str) {
        var action1 = action;
        action1 = action1 + "ID=" + str;
        //alert(action1);
        window.open(action1,'_self');
    }
    function ChaXun() {
        var startIDElt = document.getElementById("startID");
        var endIDElt = document.getElementById("endID");
        var startID = startIDElt.value;
        var endID = endIDElt.value;
        if(startID=="" && endID ==""){
            alert("请输入需要查询的ID！");
        }
        else {
            var page = document.getElementById("page");
            var accountOrderForm = document.getElementById("accountOrderForm");
            page.value = 1;
            accountOrderForm.action = "accountTrade/queryAccountTradeInfoByCondition.do";
            accountOrderForm.submit();
        }
    }
    function FirstPage() {
        var page = document.getElementById("page");
        var accountOrderForm = document.getElementById("accountOrderForm");
        page.value = 1;
        accountOrderForm.action = actionx;
        accountOrderForm.submit();
    }
    function PreviousPage() {
        var page = document.getElementById("page");
        page.value = parseInt(page.value) - 1;
        if(page.value <= 0){
            alert("当前为第一页！");
            page.value = parseInt(page.value) + 1;
        }else{
            var accountOrderForm = document.getElementById("accountOrderForm");
            accountOrderForm.action = actionx;
            accountOrderForm.submit();
        }

    }
    function NextPage() {
        //下一页
        var page = document.getElementById("page");
        page.value = parseInt(page.value) + 1;
        if(page.value >= (${maxPage}+1)){
            alert("当前为最后一页！");
            page.value = ${maxPage};
        }else{
            var accountOrderForm = document.getElementById("accountOrderForm");
            accountOrderForm.action = actionx;
            accountOrderForm.submit();
        }
    }
    function LastPage() {
        //最后一页
        var page = document.getElementById("page");
        var accountOrderForm = document.getElementById("accountOrderForm");
        page.value = ${maxPage};
        accountOrderForm.action = actionx;
        accountOrderForm.submit();
    }
    function JumpPage() {
        var page = document.getElementById("page");
        var jumpPage = document.getElementById("jumpPage");
        if(jumpPage.value<=0 || jumpPage.value >(${maxPage}) || jumpPage.value == ''){
            alert("请输入正确的页码！");
        }else{
            page.value = jumpPage.value;
            var accountOrderForm = document.getElementById("accountOrderForm");
            accountOrderForm.action = actionx;
            accountOrderForm.submit();
        }
    }
    window.onload = function(){
        layui.use('form', function() {
            var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
            form.render();
        });
        $("#higherseek").click(function(){
            $("#higherseek1").toggle();
        })
    }
</script>
<form id = "accountOrderForm" class = "layui-form">
    <div class = "hzsjtitle">您现在的位置：账户充值订单</div>
    <div class = "cardbg">
        <div class = "layui-form-item">
            <div class = "layui-input-inline"><input type = "text" id = "startID" name = "startID" placeholder="订单号" class = "layui-input" value = "${queryAccountTradeCondition.startID}"/></div>
            <div class="layui-form-mid">-</div>
            <div class = "layui-input-inline"><input type = "text" id = "endID" name="endID" placeholder="订单号" class = "layui-input" value = "${queryAccountTradeCondition.endID}"></div>
            &nbsp;&nbsp;<input type = "button" value = "搜索查询" id = "searchseek" style="cursor: pointer" onclick="ChaXun()" class="layui-btn layui-btn-normal"/></span>
            &nbsp;&nbsp;<input type = "button" value = "高级查询" id = "higherseek" style="cursor: pointer" class="layui-btn layui-btn-normal"/></span>
        </div>
        <input type="text" name = "type" value = "0" style="display: none;"/>
        <div id = "higherseek1" class="layui-form-item">
            <div class="layui-inline">
                <div class="layui-input-inline " style = "width: 100px">
                    <select name = "status" id = "status">
                        <option value = "-1" selected>状态</option>
                        <option value = "0">未受理</option>
                        <option value = "1">已受理</option>
                    </select>
                </div>
                <div class = "layui-input-inline" style="width: 100px">
                    <select name = "payment_method" id = "payment_method">
                        <option value = "-1" selected>支付方式</option>
                        <option value = "0">微信支付</option>
                        <option value = "1">支付宝支付</option>
                    </select>
                </div>
                <div class="layui-input-inline"><input type = "text" placeholder="充值金额" name = "startCharge_trade" class="layui-input" value="${queryAccountTradeCondition.startCharge_trade}"/></div>
                <div class="layui-form-mid">-</div>
                <div class = "layui-input-inline"><input type = "text" placeholder="充值金额" name = "endCharge_trade" class="layui-input" value="${queryAccountTradeCondition.endCharge_trade}"/></div>&nbsp;&nbsp;&nbsp;
                <div class = "layui-input-inline"><input type = "date" value = "${queryAccountTradeCondition.startCharge_time}" name = "startCharge_time" class="layui-input"/></div>
                <div class="layui-form-mid">-</div>
                <div class = "layui-input-inline"><input type = "date" value = "${queryAccountTradeCondition.endCharge_time}" name = "endCharge_time" class="layui-input"/></div>

            </div>
        </div>
        <div id = orderTable >
            <table border="1px" cellspacing="0" class = "layui-table">
                <tr>
                    <td style="width: 250px;" align="center" bgcolor="#f0f8ff">订单号码</td>
                    <td style="width: 250px;" align="center" bgcolor="#f0f8ff">充值金额</td>
                    <td style="width: 250px;" align="center" bgcolor="#f0f8ff">手续费</td>
                    <td style="width: 250px;" align="center" bgcolor="#f0f8ff">实际支付</td>
                    <td style="width: 250px;" align="center" bgcolor="#f0f8ff">支付方式</td>
                    <td style="width: 250px;" align="center" bgcolor="#f0f8ff">充值时间</td>
                    <td style="width: 250px;" align="center" bgcolor="#f0f8ff">操作</td>
                </tr>
                <c:forEach items="${accountTradeList}" var="accountTrade">
                    <tr>
                        <td style="width: 250px;" align="center">${accountTrade.ID}</td>
                        <td style="width: 250px;" align="center">${accountTrade.charge_trade}</td>
                        <td style="width: 250px;" align="center">${accountTrade.charge_server}</td>
                        <td style="width: 250px;" align="center">
                            <fmt:formatNumber type="number" value="${accountTrade.charge_trade+accountTrade.charge_server}"
                                              maxFractionDigits="2"/>
                        </td>
                        <td style="width: 250px;" align="center">
                            <c:if test="${accountTrade.payment_method == 0}">微信支付</c:if>
                            <c:if test="${accountTrade.payment_method == 1}">支付宝支付</c:if>
                        </td>
                        <td style="width: 250px;" align="center">
                            <c:if test="${accountTrade.status == 0}">未处理</c:if>
                            <c:if test="${accountTrade.status == 1}">${accountTrade.processing_time}</c:if>
                        </td>
                        <td style="width: 250px;" align="center">
                            <c:if test = "${accountTrade.status ==1}">已处理 </c:if>
                            <c:if test="${accountTrade.status == 0}"><input type = "button" value = "处理" class="layui-btn layui-btn-primary layui-btn-xs" onclick="accountXQ(${accountTrade.ID})"></c:if>
                        </td>
                    </tr>
                </c:forEach>
            </table>
            <span class = "page1">第${page}页 共${maxPage}页 每页${pageMax}条</span>
            <span class = "page2">
                <a href = "javascript:void(0);" onclick ="FirstPage()">首页</a>
                <a href = "javascript:void(0);" onclick="PreviousPage()">上一页</a>
                <input type = "text" id = "page" name = "page" value = "${page}" style = "display: none;"/>
                <a href = "javascript:void(0);" onclick="NextPage()">下一页</a>
                <a href = "javascript:void(0);" onclick="LastPage()">尾页</a>
                转到 <input type="text" id = "jumpPage" style="width: 25px;"> 页 <input type="button" value = "提交" class = "layui-btn layui-btn-primary layui-btn-xs" onclick="JumpPage()"/>
            </span>
        </div>
    </div>
</form>
<script type = "text/javascript">
    checkOption('status','${queryAccountTradeCondition.status}');
    checkOption('payment_method','${queryAccountTradeCondition.payment_method}');
</script>
</body>
</html>
