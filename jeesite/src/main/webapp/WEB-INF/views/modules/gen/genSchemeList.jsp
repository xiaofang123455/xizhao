<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>生成方案管理</title>
	<meta name="decorator" content="default"/>
	<link href="${ctxStatic}/plugins/iCheck/custom.css" rel="stylesheet">
	<script src="${ctxStatic}/plugins/iCheck/icheck.min.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			 $('.i-checks').iCheck({
	             checkboxClass: 'icheckbox_square-green',
	             radioClass: 'iradio_square-green',
	         });
		    $('#contentTable thead tr th input.i-checks').on('ifChecked', function(event){ //ifCreated 事件应该在插件初始化之前绑定 
		    	  $('#contentTable tbody tr td input.i-checks').iCheck('check');
	    	});
		    $('#contentTable thead tr th input.i-checks').on('ifUnchecked', function(event){ //ifCreated 事件应该在插件初始化之前绑定
		    	$('#contentTable tbody tr td input.i-checks').iCheck('uncheck');
	    	});
		});
		
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		
	</script>
</head>
<body>
<div class="wrapper wrapper-content">
	<div class="ibox">
		<div class="ibox-title">
			<h5>生成方案列表</h5>
		</div>
		<div class="ibox-content">
			<!-- 0:隐藏tip, 1隐藏box,不设置显示全部 -->
			<script type="text/javascript">
				top.$.jBox.closeTip();
			</script>
			<!--查询条件-->
			<div class="row">
				<div class="col-sm-12">
					<form:form id="searchForm" modelAttribute="genScheme" action="${ctx}/gen/genScheme/" method="post" class="form-inline">
						<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
						<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
						<div class="form-group">
							<span>方案名称:</span>
							<input id="name" name="name" class=" form-control input-sm" type="text"  maxlength="50" /> 
						</div>
					</form:form>
					<br/>
					</div>
				</div>
				
				<!-- 工具栏 -->
				<div class="row">
					<div class="col-sm-12">
						<div class="pull-left">
							<button class="btn btn-white btn-sm" data-toggle="tooltip" 	data-placement="left" onclick="add()" title="添加">
								<i class="fa fa-plus"></i> 添加
							</button>
							<script type="text/javascript">
								function add() {
									openDialog4More("新增" + '生成方案',"${ctx}/gen/genScheme/form", "70%","80%", "");
								}
							</script>
							<button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="left" onclick="edit()" title="修改">
								<i class="fa fa-file-text-o"></i> 修改
							</button>
							<script type="text/javascript">
								function edit() {
									var size = $("#contentTable tbody tr td input.i-checks:checked").size();
									if (size == 0) {
										top.layer.alert('请至少选择一条数据!', {
											icon : 0,
											title : '警告'
										});
										return;
									}
									if (size > 1) {
										top.layer.alert('只能选择一条数据!', {
											icon : 0,
											title : '警告'
										});
										return;
									}
									var id = $("#contentTable tbody tr td input.i-checks:checkbox:checked").attr("id");
									openDialog4More("修改" + '生成方案',"${ctx}/gen/genScheme/form?id=" + id,"80%", "80%", "");
								}
							</script>
							<!-- <button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" title="生成代码" onclick="genCode()">
								<i class="fa fa-folder-open-o"></i> 生成代码
							</button> -->
							<button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="sortOrRefresh()" title="刷新">
								<i class="glyphicon glyphicon-repeat"></i> 刷新
							</button>
						</div>
						<div class="pull-right">
							<button class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="search()">
								<i class="fa fa-search"></i> 查询
							</button>
							<button class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="reset()">
								<i class="fa fa-refresh"></i> 重置
							</button>
						</div>
					</div>
				</div>
				
			<sys:message content="${message}"/>
			<table id="contentTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable" style="font-size: 13px">
			<thead>
				<tr>
				    <th><input type="checkbox" class="i-checks"></th>
					<th>方案名称</th>
					<th>生成模块</th>
					<th>模块名</th>
					<th>功能名</th>
					<th>功能作者</th>
					<shiro:hasPermission name="gen:genScheme:edit"><th>操作</th></shiro:hasPermission>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${page.list}" var="genScheme">
				<tr>
					<td><input type="checkbox" id="${genScheme.id}" class="i-checks"></td>
					<td><a href="#" onclick="openDialogView('查看生成方案', '${ctx}/gen/genScheme/form?id=${genScheme.id}','70%', '80%')" >${genScheme.name}</a></td>
					<td>${genScheme.packageName}</td>
					<td>${genScheme.moduleName}${not empty genScheme.subModuleName?'.':''}${genScheme.subModuleName}</td>
					<td>${genScheme.functionName}</td>
					<td>${genScheme.functionAuthor}</td>
					<shiro:hasPermission name="gen:genScheme:edit"><td>
						<a href="#" onclick='openDialog4More("修改" +"生成方案","${ctx}/gen/genScheme/form?id=${genScheme.id}","80%", "80%", "")' class="btn btn-success btn-xs">
							<i class="fa fa-edit"></i>修改</a> 
						<a href="${ctx}/gen/genScheme/delete?id=${genScheme.id}" onclick="return confirmx('确认要删除该条记录吗？', this.href)" class="btn btn-warning btn-xs">
							<i class="fa fa-trash"></i>删除</a> 
					</td></shiro:hasPermission>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<div class="pagination">${page}</div>
	</div>
	</div>
	</div>
</body>
</html>
