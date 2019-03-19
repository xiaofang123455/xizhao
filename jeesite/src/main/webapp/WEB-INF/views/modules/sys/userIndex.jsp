<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html style="overflow-x:auto;overflow-y:auto;">
<head>
	<title>用户管理</title>
 	<meta name="decorator" content="default"/> 
	<%@include file="/WEB-INF/views/include/treeview.jsp"%> 
	<style type="text/css">
		.ztree {overflow:auto;margin:0;_margin-top:10px;padding:10px 0 0 10px;}
	</style>
	<script type="text/javascript">
		function refresh(){//刷新
			window.location="${ctx}/sys/user/index";
		}
	</script>

</head>
<body>
	<sys:message content="${message}"/>
	<div class="wrapper wrapper-content">
		<div class="ibox" >
			<div class="ibox-title">
				<h5>用户管理</h5>
			</div>
			<div class="ibox-content">
				<div id="content" class="row">
					<div id="left"  style="background-color:#e7eaec" class="leftBox col-sm-2">
						<a onclick="refresh()" class="pull-right">
							<i class="fa fa-refresh"></i>
						</a>
						<div id="ztree" class="ztree leftBox-content"></div>
					</div>
					<div id="right"  class="col-sm-10 animated fadeInRight" style="padding-right: 0px;">
						<iframe id="userContent" name="userContent" src="${ctx}/sys/user/list"  style="width:100%" frameborder="0"></iframe>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		var setting = {data:{simpleData:{enable:true,idKey:"id",pIdKey:"pId",rootPId:'0'}},
			callback:{onClick:function(event, treeId, treeNode){
					var id = treeNode.id == '0' ? '' :treeNode.id;
					$('#userContent').attr("src","${ctx}/sys/user/list?office.id="+id+"&office.name="+treeNode.name);
				}
			}
		};
		
		function refreshTree(){
			$.getJSON("${ctx}/sys/office/treeData",function(data){
			 	for(var i=0;i<data.length;i++){
			 		if(i == 0){
			 			data[i].open = true;
			 		}
				} 
				$.fn.zTree.init($("#ztree"), setting, data);
			});
		}
		refreshTree();
		 
		var leftWidth =180; // 左侧窗口大小
		var htmlObj = $("html"), mainObj = $("#main");
		var frameObj = $("#left, #openClose, #right, #right iframe");
		function wSize(){
			var strs = getWindowSize().toString().split(",");
			htmlObj.css({"overflow-x":"hidden", "overflow-y":"hidden"});
			mainObj.css("width","auto");
			frameObj.height(strs[0]-115);
			var leftWidth = ($("#left").width() < 0 ? 0 : $("#left").width());
			$("#right").width($("#content").width()- leftWidth - $("#openClose").width()-55);
			$(".ztree").width(leftWidth - 10).height(frameObj.height() - 46);
		} 
	</script>
	<script src="${ctxStatic}/common/wsize.min.js" type="text/javascript"></script>
</body>
</html>