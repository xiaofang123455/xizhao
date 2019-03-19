<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <meta name="decorator" content="default"/> -->
<title>首页 </title>
<script src="${ctxStatic}/jquery/jquery-2.2.3.min.js"  type="text/javascript"></script>
<link href="${ctxStatic}/bootstrap/3.3.6/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="${ctxStatic}/plugins/awesome/4.6.0/css/font-awesome.min.css" rel="stylesheet" /> 
<link href="${ctxStatic}/common/style.css" type="text/css" rel="stylesheet" />
<link rel="stylesheet" href="${ctxStatic}/plugins/datatables/dataTables.bootstrap.css">
<link href="${ctxStatic}/common/pagination.css" type="text/css" rel="stylesheet" />
<link rel="stylesheet" href="${ctxStatic}/dist/css/AdminLTE.min.css">
<meta name="viewport" content="width=device-width, initial-scale=1" />

<style>
	body {background-color: #f3f3f3;margin-bottom:30px;}
    .content{padding:0;}
    .col-md-2,.col-md-3,.col-md-4{padding-right: 0px;padding-left: 10px;}
    .box {
		border-top: 0px;
		margin-bottom: 10px;
	}
</style>
</head>
<script language="javascript">
//输入你希望根据页面高度自动调整高度的iframe的名称的列表
//用逗号把每个iframe的ID分隔. 例如: ["myframe1", "myframe2"]，可以只有一个窗体，则不用逗号。
//定义iframe的ID
var iframeids=["mainTodoList","mainHistoric"];
//如果用户的浏览器不支持iframe是否将iframe隐藏 yes 表示隐藏，no表示不隐藏
var iframehide="yes";
function dyniframesize()
{
	var dyniframe=new Array()
	for (i=0; i<iframeids.length; i++)
	{
		if (document.getElementById)
		{
			//自动调整iframe高度
			dyniframe[dyniframe.length] = document.getElementById(iframeids[i]);
			if (dyniframe[i] && !window.opera)
		{
		dyniframe[i].style.display="block";
		if (dyniframe[i].contentDocument && dyniframe[i].contentDocument.body.offsetHeight) //如果用户的浏览器是NetScape
		dyniframe[i].height = dyniframe[i].contentDocument.body.offsetHeight;
		else if (dyniframe[i].Document && dyniframe[i].Document.body.scrollHeight) //如果用户的浏览器是IE
		dyniframe[i].height = dyniframe[i].Document.body.scrollHeight;
	}
}
//根据设定的参数来处理不支持iframe的浏览器的显示问题
	if ((document.all || document.getElementById) && iframehide=="no"){
		var tempobj=document.all? document.all[iframeids[i]] : document.getElementById(iframeids[i]);
		tempobj.style.display="block";
	}
}
}
	if (window.addEventListener)
		window.addEventListener("load", dyniframesize, false);
	else if (window.attachEvent)
		window.attachEvent("onload", dyniframesize);
	else
		window.onload=dyniframesize;
</script>
<body class="hold-transition skin-blue sidebar-mini"> 
  <div >
 <%--  <c:if test="${!empty flag}"> --%>
	  <a href="${ctx}/main/index" id="mainButton" class="btn btn-success btn-xs" style="float:right" style="display:none">跳转到首页</a>
<%--   </c:if> --%>
  
    <div style="margin-bottom:20px">
		  <iframe id="mainTodoList" name="mainTodoList" src="${ctx}/act/task/mainTodoList"  style="width:100%;"  frameborder="no" ></iframe>
   </div>
    <div >
      	 <iframe id="mainHistoric" name="mainHistoric" src="${ctx }/act/task/mainHistoric"  style="width:100%;"  frameborder="no" ></iframe>
    </div>
  </div>
</div>
</body>
<script language="javascript">
	/*  if(window.frameElement.name != undefined &&  window.frameElement.name == "mainFrame"){
		$("#mainButton").show();
	}
	  */
	 var myTab=$("#myTab li", parent.document);
	 var href="";
	 $.each(myTab,function(){
		 if($(this).hasClass("active")){
			 href=$(this).children("a").attr("href");
			 return false;
		 }
	 })
	var top_iframe =href.substring(1);
	if(top_iframe == "home"){
			$("#mainButton").show();
	}else{
		$("#mainButton").hide();
	}
	 
</script>
</html>