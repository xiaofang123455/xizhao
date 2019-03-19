<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		
		$(document).ready(function() {
			 $('.i-checks').iCheck({
	                checkboxClass: 'icheckbox_square-green',
	                radioClass: 'iradio_square-green',
	            });
		    $('#contentTable thead tr th input .i-checks').on('ifChecked', function(event){ //ifCreated 事件应该在插件初始化之前绑定 
		    	  $('#contentTable tbody tr td input .i-checks').iCheck('check');
		    	});
		    $('#contentTable thead tr th input .i-checks').on('ifUnchecked', function(event){ //ifCreated 事件应该在插件初始化之前绑定
		    	$('#contentTable tbody tr td input .i-checks').iCheck('uncheck');
		    	});
		});
	</script>
	<style type="text/css">
		.row{
			margin-right:0
		}
		
	</style>
</head>
<body>
	<div class="wrapper wrapper-content">
		<!-- 查询条件 -->
	<form:form id="searchForm" class="form-inline" action="${ctx}/sys/user/list" method="post" modelAttribute="user">
		<div class="row" style="padding-top:5px">
			<div class="col-sm-12">
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
				<!-- 支持排序 -->
				<div class="form-group">
				  	<span>登录名：</span>
					<form:input path="loginName" id="loginName" htmlEscape="false" maxlength="50" class="form-control input-sm"/> 
					<span>归属公司：</span>
					<sys:treeselect id="company" name="company.id" value="${user.company.id}" labelName="company.name" labelValue="${user.company.name}" 
							title="公司" url="/sys/office/treeData?type=1" cssClass="input-small" allowClear="true"/>		
					<span>姓名：</span>
					<form:input path="name" class=" form-control input-sm"  maxlength="50"/>
					</div>
					<div class="form-group">
					<span>归属部门：</span>
					<sys:treeselect id="office" name="office.id" value="${user.office.id}" labelName="office.name" labelValue="${user.office.name}" 
						title="部门" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>		
				</div> 
			</div>
		</div>
	 <br>
</form:form>
	<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
			<button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="sortOrRefresh()" title="刷新">
	       		<i class="glyphicon glyphicon-repeat"></i> 刷新
	    	</button>
			<button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="left" onclick="add()" title="添加">
				<i class="fa fa-plus"></i> 添加
			<script type="text/javascript">
				function add(){
					openDialog("新增"+'用户',"${ctx}/sys/user/form","800px", "500px","userContent");
				}
			</script>
			</button>
		<button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="left" onclick="edit()" title="修改">
			<i class="fa fa-file-text-o"></i> 修改
		</button> 
		<button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="left" onclick="updateEncryptedNo()" title="更新加密字段">
			<i class="fa fa-file-text-o"></i> 更新加密字段
		</button> 
		<script type="text/javascript">
		
		function updateEncryptedNo(){
			  window.location.href='${ctx}/sys/user/updateEncryptedNo';
		}
		
			function edit(){
				  var size = $("#contentTable tbody tr td input.i-checks:checked").size();
				  if(size == 0 ){
						top.layer.alert('请至少选择一条数据!', {icon: 0, title:'警告'});
						return;
					  }
				  if(size > 1 ){
						top.layer.alert('只能选择一条数据!', {icon: 0, title:'警告'});
						return;
					  }
				    var id =  $("#contentTable tbody tr td input .i-checks:checkbox:checked").attr("id");
				    openDialog("修改"+'用户',"${ctx}/sys/user/form?id="+id,"800px", "500px","userContent");
				}
			</script><!-- 编辑按钮 -->
			<button class="btn btn-white btn-sm" onclick="deleteAll()" data-toggle="tooltip" data-placement="top">
				<i class="fa fa-trash-o"> 删除</i>
              </button>

<script type="text/javascript">
	function deleteAll(){
		// var url = $(this).attr('data-url');
		  var str="";
		  var ids="";
		  $("#contentTable tbody tr td input.i-checks:checkbox").each(function(){
		    if(true == $(this).is(':checked')){
		      str+=$(this).attr("id")+",";
		    }
		  });
		  if(str.substr(str.length-1)== ','){
		    ids = str.substr(0,str.length-1);
		  }
		  if(ids == ""){
			top.layer.alert('请至少选择一条数据!', {icon: 0, title:'警告'});
			return;
		  }
		  confirmx('确认要彻底删除数据吗？', "${ctx}/sys/user/deleteAll?ids="+ids);
	}
</script><!-- 删除按钮 -->
	<button id="btnImport" class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" title="导入">
		<i class="fa fa-folder-open-o"></i> 导入</button>
	<div id="importBox" class="hide">
		<form id="importForm" action="${ctx}/sys/user/import" method="post" enctype="multipart/form-data"
			 style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
			<input id="uploadFile" name="file" type="file" style="width:330px"/>导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！<br/>　　
		</form>
	</div>
<script type="text/javascript">
$(document).ready(function() {
	$("#btnImport").click(function(){
		top.layer.open({
		    type: 1, 
		    area: [500, 300],
		    title:"导入数据",
		    content:$("#importBox").html() ,
		    btn: ['下载模板','确定', '关闭'],
			    btn1: function(index, layero){
				  window.location.href='${ctx}/sys/user/import/template';
				  },
			    btn2: function(index, layero){
				        var inputForm =top.$("#importForm");
				     //   var top_iframe = top.getActiveTab().attr("name");//获取当前active的tab的iframe 
				      //  inputForm.attr("target",top_iframe);//表单提交成功后，从服务器返回的url在当前tab中展示
				     	inputForm.attr("target","mainFrame");
	    	       		top.$("#importForm").submit();
					    top.layer.close(index);
				  },
				  btn3: function(index){ 
					  top.layer.close(index);
    	       }
		}); 
	});
});
</script>
<!-- 导入按钮 -->
<button id="btnExport" class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" title="导出"><i class="fa fa-file-excel-o"></i> 导出</button>
<script type="text/javascript">
$(document).ready(function() {
	$("#btnExport").click(function(){
		top.layer.confirm('确认要导出Excel吗?', {icon: 3, title:'系统提示'}, function(index){
		    //do something
		    	//导出之前备份
		    	var url =  $("#searchForm").attr("action");
		    	var pageNo =  $("#pageNo").val();
		    	var pageSize = $("#pageSize").val();
		    	//导出excel
		        $("#searchForm").attr("action","${ctx}/sys/user/export");
			    $("#pageNo").val(-1);
				$("#pageSize").val(-1);
				$("#searchForm").submit();

				//导出excel之后还原
				$("#searchForm").attr("action",url);
			    $("#pageNo").val(pageNo);
				$("#pageSize").val(pageSize);
		    top.layer.close(index);
		});
	});
});

</script><!-- 导出按钮 -->	   
		</div>
		<div class="pull-right">
			<button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="search()" ><i class="fa fa-search"></i> 查询</button>
			<button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="reset()" ><i class="fa fa-refresh"></i> 重置</button>
		</div>
	</div>
	</div>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable" style="font-size: 13px;width:98%">
		<thead>
			<tr>
				<th><input type="checkbox" class="i-checks"></th>
				<th class="sort-column login_name">登录名</th>
				<th  class="sort-column name">姓名</th>
				<th class="sort-column phone">电话</th>
				<th class="sort-column mobile">手机</th>
			    <th class="sort-column c.name">归属公司</th>
				<th class="sort-column o.name">归属部门</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="user">
			<tr>
				<td> <input type="checkbox" id="${user.id}" class="i-checks"></td>
				<td><a  href="#" onclick="openDialogView('查看用户', '${ctx}/sys/user/form?id=${user.id}','800px', '500px')">${user.loginName}</a></td>
				<td>${user.name}</td>
				<td>${user.phone}</td>
				<td>${user.mobile}</td>
				<td>${user.company.name}</td>
				<td>${user.office.name}</td>
				<td>
					<a href="#" onclick="openDialogView('查看用户', '${ctx}/sys/user/form?id=${user.id}','800px', '500px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
					<a href="#" onclick="openDialog('修改用户', '${ctx}/sys/user/form?id=${user.id}','800px', '500px', 'userContent')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
					<a href="${ctx}/sys/user/delete?id=${user.id}" onclick="return confirmx('确认要删除该用户吗？', this.href)" class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
    <div class="pagination">${page}</div>
  </div> 
</body>
</html>