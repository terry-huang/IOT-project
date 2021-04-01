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
		}
		span{
			color: red;
			font-size: 12px;
		}
		input{
			border: 1px solid #9F9F9F;
		}
	</style>
</head>
<body bgcolor="white" >
<script>
	function fun() {
		var ICCIDElt = document.getElementById("ICCID");
		var ICCIDErrorSpan = document.getElementById("ICCIDError");
		var remarktextElt = document.getElementById("remarktext");
		var remarktextErrorSpan = document.getElementById("remarktextError");
		ICCIDElt.onblur = function () {
			var ICCID = ICCIDElt.value;
			if(ICCID == ""){
				ICCIDErrorSpan.innerText = "ICCID不能为空！"
			}
		}
		ICCIDElt.onfocus = function () {
			if(ICCIDErrorSpan.innerText != ""){
				ICCIDErrorSpan.innerText = "";
			}
		}
		remarktextElt.onblur = function(){
			var remarktext = remarktextElt.value;
			if(remarktext == ""){
				remarktextErrorSpan.innerText = "备注不能为空！";
			}
		}
		remarktextElt.onfocus = function(){
			if(remarktextErrorSpan.innerText != ""){
				remarktextErrorSpan.innerText = "";
			}
		}
		ICCIDElt.focus();
		ICCIDElt.blur();
		remarktextElt.focus();
		remarktextElt.blur();
		if(ICCIDErrorSpan.innerText == "" && remarktextErrorSpan.innerText ==""){
			var ICCID = ICCIDElt.value;
			var remarktext = remarktextElt.value;
			$.ajax({
				url: "card/updateRemark.do",
				type: "get",
				data: {'remark':remarktext,
						'ICCID':ICCID},
				success: function (resp) {
					//alert(111);
					if((resp.msg)==0){
						alert("修改成功！");
					}else if((resg.msg)==1){
						alert("修改失败！");
					}
					window.open('mainPage/queryInfo.do', '_self');
				},
				error: function (XMLHttpRequest, textStatus, errorThrown) {
					alert(XMLHttpRequest.status);
					alert(XMLHttpRequest.readyState);
					alert(textStatus);
				}
			})
		}

	}
</script>
<div class = "hzsjtitle">您现在的位置：批量备注</div>
<div class = "refresh"><input type = "button" value = "刷新" id = "refresh"/></div>
<hr color = "darkgray" style="width: 100%; position: absolute; top: 50px"></hr>
<form id = "RemarkForm">
	<div class = "table3">
		<table border="1px" cellspacing="0" class = "layui-table">
			<tr >
				<td width = "1500px" colspan = "2" bgcolor="aliceblue" style="font-weight: bolder;">批量备注</td>
			</tr>
			<tr>
				<td bgcolor="aliceblue" width = "200px">ICCID号码</td>
				<td ><input type = "text" style = "width:600px; height:200px;" name = "ICCID" id = "ICCID"
							 placeholder="请输入要备注的ICCID，可以输入一个或多个ICCID，多个ICCID使用“#”隔开">
				<span id = "ICCIDError"></span></td>
			</tr>
			<tr>
				<td bgcolor="aliceblue" width = "200px">备注内容</td>
				<td ><input type = "text" style = "width:600px; " name = "remark" id = "remarktext"
							placeholder="请输入备注内容">
				<span id = "remarktextError"></span></td>
			</tr>
			<tr>
				<td bgcolor="aliceblue"></td>
				<td><input type = "button" value = "提交信息"  id = "submitBtn" style="cursor: pointer" onclick="fun()" class = "layui-btn layui-btn-normal layui-btn-sm"/></td>
			</tr>
		</table>
	</div>
</form>
</body>
</html>
