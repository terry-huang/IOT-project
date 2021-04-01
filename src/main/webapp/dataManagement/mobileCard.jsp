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
        .hzsjtitle {
            width: 1000px;
            height: 1000px;
            position: absolute;
            top: 18px;
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
            position: relative;
            left: 65%;
        }
        a{
            text-decoration: underline;
            color: #1E9FFF;

        }

    </style>
</head>
<body>
<%
    String action = (String) request.getAttribute("action");
    int recordedCardAmount = 0;
    if (request.getAttribute("recordedCardAmount") != null){
        recordedCardAmount = (int) request.getAttribute("recordedCardAmount");
    }
%>
<script type = "text/javascript">
    actionx = "<%=action%>";
    recordedCardAmount = "<%=recordedCardAmount%>";
    $(document).ready(function() {
        layui.use('form', function() {
            var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
            form.render();
        });

        $("#higherseek").click(function () {
            $("#higherseek1").toggle();
        });
        $(".cardhuabo").click(function(){
            var ICCIDs = document.getElementsByName("ICCID");
            for(var i = 0,count=0;i<ICCIDs.length;i++){
                if(ICCIDs[i].checked == true){
                    count++;
                }
            }
            if(count ==0 && ${recordedCardAmount==0}){
                alert("请选择卡片！")
            }else{
                var mobileCardForm = document.getElementById("mobileCardForm");
                mobileCardForm.action = "card/chooseTransferCustomer.do"
                mobileCardForm.submit();
            }
        });


        $(".cardhuishou").click(function () {
            var ICCIDs = document.getElementsByName("ICCID");
            for(var i = 0,count=0;i<ICCIDs.length;i++){
                if(ICCIDs[i].checked == true){
                    count++;
                }
            }
            if(count ==0 && ${recordedCardAmount==0}){
                alert("请选择卡片！")
            }else {
                var mobileCardForm = document.getElementById("mobileCardForm");
                mobileCardForm.action = "card/chooseRecoverCard.do"
                mobileCardForm.submit();
            }
        });
        $(".cardxufei").click(function(){
            var mobileCardForm = document.getElementById("mobileCardForm");
            window.open('businessManagement/cardsRenewalone.jsp','_self');
        })
        var i =0;
        var CardICCIDs = new Array();
        <c:forEach items="${recordedCard}" var = "recordedCard1">
                CardICCIDs[i] = "${recordedCard1}";
                //alert(CardICCIDs[i]); //把选中的卡片存入数组中
                i++;
        </c:forEach>
        var AllCardICCIDs = new Array();
        var firstchk = document.getElementById("firstchk");
        var ICCIDs = document.getElementsByName("ICCID");
        var j = 0;
        //获取所有卡片的ICCID
        <c:forEach items="${cardDisplayInfoList}" var = "cardDisplayInfo">
                AllCardICCIDs[j] = "${cardDisplayInfo.ICCID}";
               // alert(AllCardICCIDs[j]); //当前页面的所有卡片
                j++;
        </c:forEach>
       // alert("${recordedCardAmount}")
        var checkamount = 0;
        var all = ICCIDs.length;
        for (var k = 0; k<AllCardICCIDs.length; k++){
            for (var n = 0; n<CardICCIDs.length; n++){
                if (AllCardICCIDs[k]==CardICCIDs[n]){ //ICCID相等
                    ICCIDs[k].checked = true;
                    checkamount++;
                    break;
                }
            }
        }
        if(all == checkamount){
            firstchk.checked = true;
        }
        else{
            firstchk.checked = false;
        }
       // alert(checkamount);
        firstchk.onclick = function() {
            if (firstchk.checked) {
                var ICCIDs = document.getElementsByName("ICCID");
                for (var i = 0; i < ICCIDs.length; i++) {
                    ICCIDs[i].checked = true;
                    document.getElementById("count").innerHTML = ICCIDs.length + parseInt(recordedCardAmount);
                }
            } else {
                var ICCIDs = document.getElementsByName("ICCID");
                for (var i = 0; i < ICCIDs.length; i++) {
                    ICCIDs[i].checked = false;
                    document.getElementById("count").innerHTML = 0 + parseInt(recordedCardAmount);
                }
            }
        }
        //recordedCardAmount不包括当前页选中的卡片
       // document.getElementById("count").innerHTML = 1;
        for(var i =0;i<ICCIDs.length;i++){
            var checkCount1 = 0; //当前页选中的卡片数量
            for(var i =0;i<ICCIDs.length;i++){
                if(ICCIDs[i].checked){
                    checkCount1++;
                }
            }
        }
        for(var i =0;i<ICCIDs.length;i++){
            ICCIDs[i].onclick = function () {
                var checkCount2 = 0;
                for(var i =0;i<ICCIDs.length;i++){
                    if(ICCIDs[i].checked){
                        checkCount2++;
                       // alert(checkCount2);
                    }
                }
                if(all == checkCount2){
                    firstchk.checked = true;
                }
                else{
                    firstchk.checked = false;
                }
                document.getElementById("count").innerHTML = checkCount2+parseInt(recordedCardAmount);
            }
        }

    });

    function CardXQ(str) {
        $.ajax({
            url: "card/queryDetailedCardInfo.do",
            type: "post",
            data: {'ICCID': str},
            dataType: "json",
            success: function (resp) {
                $("#user_storeName").text (resp.cardDisplayInfo.user_storeName);
                $("#IMEInumber").text (resp.cardDisplayInfo.IMEInumber);
                $("#ICCID").text (resp.ICCID);
                ICCID = resp.ICCID;
                $("#business_number").text(resp.cardDisplayInfo.business_number);
                $("#setStatus").text(resp.cardDisplayInfo.setStatus);
                $("#trade_ID").text(resp.cardDisplayInfo.trade_ID);
                $("#flow").text(resp.cardDisplayInfo.flow);
                $("#flow_used").text(resp.cardDisplayInfo.flow_used);
                $("#charge_used").text(resp.cardDisplayInfo.charge_used);
                $("#charge_current").text(resp.cardDisplayInfo.charge_current);
                $("#set_name").text(resp.cardDisplayInfo.set_name);
                $("#start_time").text(resp.cardDisplayInfo.start_time);
                $("#tips").text(resp.msg);
                $("#time").text(resp.time);
                layui.use('table', function () {
                    var table = layui.table;
                    layer.open({
                        type: 1 //Page层类型
                        , area: ['800px', '500px']
                        , title: '卡片详情'
                        , maxmin: true //允许全屏最小化
                        , content:  $("#test")
                    })
                })
            },
            error : function (XMLHttpRequest, textStatus, errorThrown) {
                alert(XMLHttpRequest.status);
                alert(XMLHttpRequest.readyState);
                alert(textStatus);
            }
        })
    }
    function Remark() {
        var remarktext = document.getElementById("remarktext").value;
        $.ajax({
            url:"card/updateRemark.do",
            type:"post",
            data:{'remark':remarktext,
                'ICCID':ICCID},
            success: function (resp) {
                if(resp.msg == 1)
                {
                    alert("修改失败！");
                }
                if(resp.msg ==0)
                {
                    alert("修改成功！");
                    $("."+ICCID).text(remarktext);
                }
                // alert(111);
            },
            error : function (XMLHttpRequest, textStatus, errorThrown) {
                alert(XMLHttpRequest.status);
                alert(XMLHttpRequest.readyState);
                alert(textStatus);
            }
        })
    }
    function ChaXun() {
        var startICCIDElt = document.getElementById("startICCID");
        var endICCIDElt = document.getElementById("endICCID");
        var startICCID = startICCIDElt.value;
        var endICCID = endICCIDElt.value;
        if(startICCID=="" && endICCID ==""){
            alert("请输入需要查询的ICCID！");
        }
        else{
            var page = document.getElementById("page");
            var mobileCardForm = document.getElementById("mobileCardForm");
            page.value = 1;
            mobileCardForm.action = "card/queryCardInfoByCondition.do";
            mobileCardForm.submit();
        }

    }
    function FirstPage() {
        var page = document.getElementById("page");
        var mobileCardForm = document.getElementById("mobileCardForm");
        page.value = 1;
        mobileCardForm.action = actionx;
        mobileCardForm.submit();
    }
    function PreviousPage() {

        var page = document.getElementById("page");
        page.value = parseInt(page.value) - 1;
        if(page.value <= 0){
            alert("当前为第一页！");
            page.value = parseInt(page.value) + 1;
        }else{
            var mobileCardForm = document.getElementById("mobileCardForm");
            mobileCardForm.action = actionx;
            mobileCardForm.submit();
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
            var mobileCardForm = document.getElementById("mobileCardForm");
            mobileCardForm.action = actionx;
            mobileCardForm.submit();
        }
    }
    function LastPage() {
        //最后一页
        var page = document.getElementById("page");
        var mobileCardForm = document.getElementById("mobileCardForm");
        page.value = ${maxPage};
        mobileCardForm.action = actionx;
        mobileCardForm.submit();
    }
    function JumpPage() {
        var page = document.getElementById("page");
        var jumpPage = document.getElementById("jumpPage");
        var presentPage = document.getElementById("presentPage");
        if(jumpPage.value<=0 || jumpPage.value >(${maxPage}) || jumpPage.value == ''){
            alert("请输入正确的页码！");
        }else{
            presentPage.value = page.value;
            page.value = jumpPage.value;
            var mobileCardForm = document.getElementById("mobileCardForm");
            mobileCardForm.action = actionx;
            mobileCardForm.submit();
        }
    }

</script>

<div style="display: none;" id="test">
    <table border="1" class = "layui-table"  lay-size="sm">
        <tr>
            <td colspan="4" bgcolor="skyblue" style="font-weight:bold">基本属性</td>
        </tr>
        <tr>
            <td style="font-weight:bold">所属商家</td>
            <td id = "user_storeName"></td>
            <td style="font-weight:bold">IMEI</td>
            <td id = "IMEInumber"></td>
        </tr>
        <tr>
            <td style="font-weight:bold">ICCID</td>
            <td id = "ICCID"> </td>
            <td style="font-weight:bold">业务号码</td>
            <td id = "business_number"> </td>
        <tr>
            <td style="font-weight:bold">订单编号</td>
            <td colspan="3" id = "trade_ID"></td>
        </tr>
        <tr>
            <td style="font-weight:bold">套餐状态</td>
            <td id = "setStatus"></td>
            <td style="font-weight:bold">激活时间</td>
            <td id = "start_time"></td>
        </tr>
        <tr>
            <td style="font-weight:bold">使用金额（元）</td>
            <td id = "charge_used"></td>
            <td style="font-weight:bold">剩余金额（元）</td>
            <td id = "charge_current"></td>
        </tr>
        <tr>
            <td style="font-weight:bold">温馨提示</td>
            <td colspan="3" id = "tips"></td>
        </tr>
        <tr>
            <td colspan="4" bgcolor="skyblue" style="font-weight:bold">套餐使用情况</td>
        </tr>
        <tr>
            <td style="font-weight:bold">套餐名称</td>
            <td colspan="3" id = "set_name"></td>
        </tr>
        <tr>
            <td style="font-weight:bold">套餐使用期限</td>
            <td colspan="3" id = "time"></td>
        </tr>
        <tr>
            <td colspan="4" bgcolor="skyblue" style="font-weight:bold">流量使用情况</td>
        </tr>
        <tr>
            <td style="font-weight:bold">总流量（M）</td>
            <td id = "flow"></td>
            <td style="font-weight:bold">已使用流量（M）</td>
            <td id = "flow_used"></td>
        </tr>
        <tr>
            <td style="font-weight:bold">修改备注</td>
            <td colspan="2" ><input type = "text" placeholder="请输入备注" id = "remarktext"/></td>
            <td><input type = "button" value = "提交" onclick="Remark()"/></td>
        </tr>
    </table>
</div>
<form id = "mobileCardForm" method = "get" class="layui-form">
    <div class = "hzsjtitle">您现在的位置：移动卡片</div>
    <div class = "cardbg">
        <div class = "layui-form-item">
            <div class = "layui-input-inline"><input type = "text" id = "startICCID" name = "startICCID" placeholder="ICCID" class="layui-input" autocomplete="off" style="width: 200px;"/></div>
            <div class="layui-form-mid">-</div>
            <div class = "layui-input-inline"><input type = "text" id = "endICCID" name="endICCID" placeholder="ICCID" class="layui-input" style="width: 200px;"></div>
            &nbsp;&nbsp;<span class = "searchseek"><input type = "button" value = "搜索查询" id = "searchseek" style="cursor: pointer" class="layui-btn layui-btn-normal" onclick="ChaXun()"/></span>
            &nbsp;&nbsp;<span class = "higherseek"><input type = "button" value = "高级查询" id = "higherseek" style="cursor: pointer" class="layui-btn layui-btn-normal"/></span>
        </div>
        <input type="text" name = "server" value = "0" style="display: none;"/>
        <div id = "higherseek1" class="layui-form-item">
            <div class="layui-inline">
                <div class="layui-input-inline " style = "width: 100px">
                    <select  name = "select0" >
                        <option   value="0">按订单号</option>
                        <option  value="1">按商家</option>
                        <option  value="2">按IMEI</option>
                        <option  value="3">按备注</option>
                    </select>
                </div>
                <div class="layui-input-inline " style = "width: 200px"> <input type = "text" name = "input0" placeholder="关键词" class="layui-input"/></div>
                <div class="layui-input-inline " style = "width: 200px">
                    <select name = "select1">
                        <option value="0">卡片激活时间</option>
                        <option value="1">套餐开始时间</option>
                        <option value="2">套餐到期时间</option>
                    </select>
                </div>
                <div class = "layui-input-inline"><input type="date" value="2020-01-01" name = "input1" class = "layui-input" style="width: 150px"/></div>
            </div>
            <br>
            <div class="layui-input-inline " style = "width: 100px">
                <select>
                    <option value="运营商" selected>运营商</option>
                    <option value="移动">移动</option>
                    <option value="电信">电信</option>
                    <option value="联通">联通</option>
                </select>
            </div>
            <div class="layui-input-inline " style = "width: 100px">
                <select>
                    <option value="状态" selected>状态</option>
                    <option value="静默期">静默期</option>
                    <option value="已激活">已激活</option>
                    <option value="已禁用">已禁用</option>
                    <option value="已过期">已过期</option>
                    <option value="已作废">已作废</option>
                    <option value="测试期">测试期</option>
                    <option value="其他">其他</option>
                </select>
            </div>
            <div class="layui-input-inline " style = "width: 100px">
                <select>
                    <option value="套餐到期" selected>套餐到期</option>
                    <option value="未到期">未到期</option>
                    <option value="即将到期">即将到期</option>
                    <option value="已到期">已到期</option>
                </select>
            </div>
            <div class="layui-input-inline " style = "width: 100px">
                <select>
                    <option value="流量超出" selected>流量超出</option>
                    <option value="未超出">未超出</option>
                    <option value="即将超出">即将超出</option>
                    <option value="已超出">已超出</option>
                </select>
            </div>
            <div class="layui-input-inline " style = "width: 100px">
                <select>
                    <option value="沉默期限" selected>沉默期限</option>
                    <option value="未到期限">未到期限</option>
                    <option value="即将超期">即将超期</option>
                    <option value="已超期限">已超期限</option>
                </select>
            </div>
        </div>
        <br>
        <span class = "shengcheng"><input type = "button" value = "生成二维码" id = "shengcheng" style="cursor: pointer" class="layui-btn layui-btn-normal"/></span>
        <span class = "cardxufei"><input type = "button" value = "卡片充值" id = "cardxufei" style="cursor: pointer" class="layui-btn layui-btn-normal"/></span>
        <c:if test="${priority==0}">
        <span class = "cardhuabo"><input type = "button" value = "卡片划拨" id = "cardhuabo" style="cursor: pointer" class="layui-btn layui-btn-normal"/></span>
        <span class = "cardhuishou"><input type = "button" value = "卡片回收" id = "cardhuishou" style="cursor: pointer" class="layui-btn layui-btn-normal"/></span></c:if>
        当前已选择卡片：<span id = "count">${recordedCardAmount+0}</span>张
        <br>
        <div class = "table1">
            <table border="1px" cellspacing="0" class="layui-table">
                <tr>
                    <td width="200px" align="center"><input type = "checkbox" id = "firstchk" lay-ignore/></td>
                    <td width="200px" align="center" bgcolor="#f0f8ff">ICCID</td>
                    <td width="200px" align="center" bgcolor="#f0f8ff">业务号码</td>
                    <td width="200px" align="center" bgcolor="#f0f8ff">所属商家</td>
                    <td width="200px" align="center" bgcolor="#f0f8ff">主套餐</td>
                    <td width="200px" align="center" bgcolor="#f0f8ff">有效期</td>
                    <td width="200px" align="center" bgcolor="#f0f8ff">状态</td>
                    <td width="200px" align="center" bgcolor="#f0f8ff" >备注</td>
                    <td width="200px" align="center" bgcolor="#f0f8ff">操作</td>
                </tr>
                <c:forEach items = "${cardDisplayInfoList}" var = "mobileCard" >
                    <tr>
                        <td width="150px" align="center"><input type="checkbox" name = "ICCID" value = "${mobileCard.ICCID}" lay-ignore/>&nbsp;</td>
                        <td width="150px" align="center">${mobileCard.ICCID}</td>
                        <td width="150px" align="center">${mobileCard.business_number}</td>
                        <td width="150px" align="center">${mobileCard.user_storeName}</td>
                        <td width="150px" align="center">${mobileCard.set_name}</td>
                        <td width="150px" align="center">${mobileCard.start_time}到${mobileCard.end_time}</td>
                        <td width="150px" align="center">${mobileCard.setStatus}</td>
                        <td width="150px" align="center" class = "${mobileCard.ICCID}">${mobileCard.remark}</td>
                        <td width="150px" align="center"><input type = "button" value = "详情"  class = "layui-btn layui-btn-primary layui-btn-xs"  style="cursor: pointer"onclick="CardXQ('${mobileCard.ICCID}')" /></td>
                    </tr>
                </c:forEach>

                </tr>
            </table>
            <br>
            <span class = "page1">第${page}页 共${maxPage}页 每页${pageMax}条</span>
            <span class = "page2">
                <a href = "javascript:void(0);" onclick ="FirstPage()">首页</a>
                <a href = "javascript:void(0);" onclick="PreviousPage()">上一页</a>
                <input type = "text" id = "page" name = "page" value = "${page}" style = "display: none;"/>
                <input type = "text" id = "presentPage" name = "presentPage" value = "${page}" style = "display: none";>
                <a href = "javascript:void(0);" onclick="NextPage()">下一页</a>
                <a href = "javascript:void(0);" onclick="LastPage()">尾页</a>
                转到 <input type="text" id = "jumpPage" style="width: 25px;"> 页 <input type="button" value = "提交" class = "layui-btn layui-btn-primary layui-btn-xs" onclick="JumpPage()"/>
            </span>
        </div>
    </div>
</form>
</body>

</html>
