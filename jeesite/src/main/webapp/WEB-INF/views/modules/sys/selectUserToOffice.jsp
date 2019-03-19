<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>分配角色</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treeview.jsp" %>
	<script type="text/javascript">

	var officeTree;
	var selectedTree;//zTree已选择对象
	
	// 初始化
	$(document).ready(function(){
		officeTree = $.fn.zTree.init($("#officeTree"), setting, officeNodes);
	});

	var setting = {view: {selectedMulti:false,nameIsHTML:true,showTitle:false,dblClickExpand:false},
			data: {simpleData: {enable: true}},
			callback: {onClick: treeOnClick}};
	
	var officeNodes=[
            <c:forEach items="${officeList}" var="office">
            {id:"${office.id}",
             pId:"${not empty office.parent?office.parent.id:0}", 
             name:"${office.name}"},
            </c:forEach>];

		//点击选择项回调
		function treeOnClick(event, treeId, treeNode, clickFlag){
			$.fn.zTree.getZTreeObj(treeId).expandNode(treeNode);
			if("officeTree"==treeId){
				$("#officeId").val(treeNode.id);
			    document.getElementById("userListInOfficeAssign").contentWindow.dosubmit();
			}
		};
		
		

		function selectUser(){
			var user = document.getElementById("userListInOfficeAssign").contentWindow.selectUser();
			return user;
		};
		
		
		function SetWinHeight(obj) 
		{ 
			var win=obj; 
			if (document.getElementById) 
			{ 
			if (win && !window.opera) 
			{ 
			if (win.contentDocument && win.contentDocument.body.offsetHeight) 
			win.height = win.contentDocument.body.offsetHeight; 
			else if(win.Document && win.Document.body.scrollHeight) 
			win.height = win.Document.body.scrollHeight; 
		} 
		} 
		} 

	    function changeFrameHeight(){
	        var ifm= document.getElementById("userListInOfficeAssign"); 
	        ifm.height=document.documentElement.clientHeight;

	    }
	    
	</script>
</head>
<body class="pace-done">
	<div id="assignRole" class="row wrapper wrapper-content">
		<div class="col-sm-4">
			<input id="officeId" type="hidden" name="officeId"/>
			<p>所在区域：</p>
			<div id="officeTree" class="ztree"></div>
		</div>
		<div class="col-sm-8" style="padding-left:16px;border-left: 1px solid #A8A8A8;">
			<p>待选人员：</p>
			<div style="padding-right: 0px;overflow:auto;" >
				<iframe id="userListInOfficeAssign" name="userListInOfficeAssign" src="${ctx}/sys/office/users"  style="width:100%"  frameborder="0" scrolling="no" onload="changeFrameHeight()"></iframe>
			</div>
		</div>
	</div>
</body>
</html>
