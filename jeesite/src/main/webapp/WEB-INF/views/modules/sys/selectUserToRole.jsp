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
			    document.getElementById("userListInRoleAssign").contentWindow.dosubmit();
			}
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
	        var ifm= document.getElementById("userListInRoleAssign"); 
	        ifm.height=document.documentElement.clientHeight+30;

	    }
	    
	    function changeFrameHeight1(){
	        var ifm= document.getElementById("selectedUserListInRoleAssign"); 
	        ifm.height=document.documentElement.clientHeight+30;
	    }

	    window.onresize=function(){  
	         changeFrameHeight(); 
	         changeFrameHeight1();

	    };
	    
	</script>
</head>
<body class="pace-done">
	<div id="assignRole" class="row wrapper wrapper-content">
		<div class="col-sm-2" style="width:16%; float: left;">
			<input id="roleId" type="hidden" name="roleId" value="${role.id}"/>
			<input id="officeId" type="hidden" name="officeId"/>
			<p>所在部门：</p>
			<div id="officeTree" class="ztree"></div>
		</div>
		<div class="col-sm-5" style="width:40%;float: left;padding-left:16px;border-left: 1px solid #A8A8A8;border-right: 1px solid #A8A8A8;">
			<p>待选人员：</p>
			<div style="padding-right: 0px;overflow:auto;" >
				<iframe id="userListInRoleAssign" name="userListInRoleAssign" src="${ctx}/sys/role/users?role.id=${role.id}"  style="width:100%"  frameborder="0" scrolling="no" onload="changeFrameHeight()"></iframe>
			</div>
		</div>
		<div class="col-sm-5" style="width:40%;float: right;padding-right: 0px;overflow:auto;">
			<p>已选人员:</p>
				<div style="padding-right: 0px;" >
				<iframe id="selectedUserListInRoleAssign" name="selectedUserListInRoleAssign" src="${ctx}/sys/role/getSelectedUsers?role.id=${role.id}"  style="width:100%"  frameborder="0" scrolling="no"  onload="changeFrameHeight1()"></iframe>
			</div>
		</div>
	</div>
</body>
</html>
