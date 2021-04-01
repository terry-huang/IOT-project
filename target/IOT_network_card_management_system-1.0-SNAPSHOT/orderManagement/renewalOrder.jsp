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
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
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
        #higherseek1{
            display: none;
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
</head>
<body bgcolor="white" >
<%
    String action = (String) request.getAttribute("action");
%>
<script type = "text/javascript">
    actionx = "<%=action%>";
    window.onload = function(){
        layui.use('form', function() {
            var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
            form.render();
        });
        $("#higherseek").click(function(){
            $("#higherseek1").toggle();
        })
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
            var renewalOrderForm = document.getElementById("renewalOrderForm");
            page.value = 1;
            renewalOrderForm.action = "trade/queryTradeInfoByCondition.do";
            renewalOrderForm.submit();
        }
    }
    function FirstPage() {
        var page = document.getElementById("page");
        var renewalOrderForm = document.getElementById("renewalOrderForm");
        page.value = 1;
        renewalOrderForm.action = actionx;
        renewalOrderForm.submit();
    }
    function PreviousPage() {
        var page = document.getElementById("page");
        page.value = parseInt(page.value) - 1;
        if(page.value <= 0){
            alert("当前为第一页！");
            page.value = parseInt(page.value) + 1;
        }else{
            var renewalOrderForm = document.getElementById("renewalOrderForm");
            renewalOrderForm.action = actionx;
            renewalOrderForm.submit();
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
            var renewalOrderForm = document.getElementById("renewalOrderForm");
            renewalOrderForm.action = actionx;
            renewalOrderForm.submit();
        }
    }
    function LastPage() {
        //最后一页
        var page = document.getElementById("page");
        var renewalOrderForm = document.getElementById("renewalOrderForm");
        page.value = ${maxPage};
        renewalOrderForm.action = actionx;
        renewalOrderForm.submit();
    }
    function JumpPage() {
        var page = document.getElementById("page");
        var jumpPage = document.getElementById("jumpPage");
        if(jumpPage.value<=0 || jumpPage.value >(${maxPage}) || jumpPage.value == ''){
            alert("请输入正确的页码！");
        }else{
            page.value = jumpPage.value;
            var renewalOrderForm = document.getElementById("renewalOrderForm");
            renewalOrderForm.action = actionx;
            renewalOrderForm.submit();
        }
    }
</script>
<form id = "renewalOrderForm" class = "layui-form">
    <div class = "hzsjtitle">您现在的位置：卡片充值订单</div>
    <div class = "cardbg">
        <div class = "layui-form-item">
            <div class = "layui-input-inline"><input type = "text" name = "startID" id = "startID" placeholder="订单号" class="layui-input"/></div>
            <div class="layui-form-mid">-</div>
            <div class = "layui-input-inline"><input type = "text" name = "endID" id="endID" placeholder="订单号" class="layui-input"></div>
            &nbsp;&nbsp;<input type = "button" value = "搜索查询" id = "searchseek" style="cursor: pointer" class="layui-btn layui-btn-normal" onclick="ChaXun()"/>
            &nbsp;&nbsp;<input type = "button" value = "高级查询" id = "higherseek" style="cursor: pointer" class="layui-btn layui-btn-normal"/>
        </div>
        <input type="text" name = "type" value = "1" style="display: none;"/>
        <div id = "higherseek1" class="layui-form-item">
            <div class="layui-inline">
                <div class="layui-input-inline " style = "width: 100px">
                    <select name = "status">
                        <option value = "-1" selected>状态</option>
                        <option value = "0">未受理</option>
                        <option value = "1">已受理</option>
                    </select>
                </div>
                <div class = "layui-input-inline" style="width: 100px">
                    <select name = "select0">
                        <option value = "0">按商家</option>
                        <option value = "1">按ICCID</option>
                        <option value = "2">按业务号码</option>
                        <option value = "3">按套餐名称</option>
                    </select>
                </div>
                <div class="layui-input-inline"><input type = "text" placeholder="关键词" name = "input0" class = "layui-input"/></div>
                <div class="layui-input-inline " style = "width: 100px">
                    <select name = "server">
                        <option value = "-1" selected>运营商</option>
                        <option value = "0">移动</option>
                        <option value = "1">电信</option>
                        <option value = "2">联通</option>
                    </select>
                </div>
                <label class="layui-form-label">购买时间：</label>
                <div class="layui-input-inline"><input type = "date" value = "2020-01-01" name = "startCharge_time" class = "layui-input"/></div>
                <div class="layui-form-mid">-</div>
                <div class = "layui-input-inline"><input type = "date" value = "2020-01-01" name = "endCharge_time" class = "layui-input"/></div>
            </div>
        </div>
        <div id = orderTable>
            <table border="1px" cellspacing="0" class="layui-table">
                <tr>
                    <td style="width: 250px;" align="center" bgcolor="#f0f8ff">订单号码</td>
                    <td style="width: 250px;" align="center" bgcolor="#f0f8ff">所属商家</td>
                    <td style="width: 250px;" align="center" bgcolor="#f0f8ff">金额</td>
                    <td style="width: 250px;" align="center" bgcolor="#f0f8ff">数量</td>
                    <td style="width: 250px;" align="center" bgcolor="#f0f8ff">充值时间</td>
                </tr>

                <c:forEach items="${tradeDisplayInfoList}" var="tradeDisplayInfo">
                    <tr>
                        <td style="width: 250px;" align="center">${tradeDisplayInfo.trade_ID}</td>
                        <td style="width: 250px;" align="center">${tradeDisplayInfo.user_name}</td>
                        <td style="width: 250px;" align="center">${tradeDisplayInfo.charge_trade}</td>
                        <td style="width: 250px;" align="center">${tradeDisplayInfo.number}</td>
                        <td style="width: 250px;" align="center">${tradeDisplayInfo.charge_time}</td>
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
                转到 <input type="text" id = "jumpPage" style="width: 25px;"> 页 <input type="button" value = "提交" class = "layui-btn layui-btn-primary layui-btn-xs"onclick="JumpPage()"/>
            </span>
        </div>
    </div>
</form>
</body>
</html>
