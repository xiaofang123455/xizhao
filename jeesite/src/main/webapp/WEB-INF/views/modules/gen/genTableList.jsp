<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>业务表管理</title>
<meta name="decorator" content="default"/>
<script type="text/javascript">
	function page(n,s){
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").submit();
       	return false;
       }
</script>
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
</script>
</head>
<body class="gray-bg pace-done" style="font-size: 13px">
	<div class="wrapper wrapper-content">
		<div class="ibox">
			<div class="ibox-title">
				<h5>业务表列表</h5>
			</div>
			<div class="ibox-content">
				<!-- 0:隐藏tip, 1隐藏box,不设置显示全部 -->
				<script type="text/javascript">
					top.$.jBox.closeTip();
				</script>
				<!--查询条件-->
				<div class="row">
					<div class="col-sm-12">
						<form id="searchForm" class="form-inline" action="${ctx}/gen/genTable/" method="post">
							 <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
							<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
							<input id="orderBy" name="orderBy" type="hidden" value="${page.orderBy}"/>

							<script type="text/javascript">
								$(document).ready(function() {
									var orderBy = $("#orderBy").val().split(" ");
									$(".sort-column").each(function() {
										$(this).html($(this).html()+ " <i class=\"fa fa-sort\"></i>");
									});
									$(".sort-column").each(function() {
										if ($(this).hasClass(orderBy[0])) {
											orderBy[1] = orderBy[1]&& orderBy[1].toUpperCase() == "DESC" ? "down": "up";
											$(this).find("i").remove();
											$(this).html($(this).html()+ " <i class=\"fa fa-sort-"+orderBy[1]+"\"></i>");
										}
									});
									$(".sort-column").click(function() {
										var order = $(this).attr("class").split(" ");
										var sort = $("#orderBy").val().split(" ");
										for (var i = 0; i < order.length; i++) {
											if (order[i] == "sort-column") {
												order = order[i + 1];
												break;
											}
										}
										if (order == sort[0]) {
											sort = (sort[1]&& sort[1].toUpperCase() == "DESC" ? "ASC": "DESC");
											$("#orderBy").val(order+ " DESC" != order+ " "+ sort ? "": order+ " "+ sort);
										} else {
											$("#orderBy").val(order+ " ASC");
										}
										page();
									});
								});
							</script>
							<div class="form-group">
								<span>表名：</span>
								<input id="nameLike" name="nameLike" class=" form-control input-sm" type="text"  maxlength="50" /> 
								<span>说明：</span>
								<input id="comments" name="comments" class=" form-control input-sm" type="text"  maxlength="50" /> 
								<span>父表表名：</span>
								<input id="parentTable" name="parentTable" class=" form-control input-sm" type="text"  maxlength="50" />
							</div>
						</form>
						<br />
					</div>
				</div>

				<!-- 工具栏 -->
				<div class="row">
					<div class="col-sm-12">
						<div class="pull-left">
							<button class="btn btn-white btn-sm " data-toggle="tooltip" 	data-placement="left" title="添加"
								onclick="openDialog('新增表单','${ctx}/gen/genTable/select','700px', '500px')">
								<i class="fa fa fa-plus"></i> 添加
							</button>
							<button class="btn btn-white btn-sm" data-toggle="tooltip"
								data-placement="left" onclick="edit()" title="修改">
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
									openDialog("修改" + '表单',"${ctx}/gen/genTable/form?id=" + id,"80%", "80%", "");
								}
							</script>
							<!-- 编辑按钮 -->
							<!-- <button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" title="生成代码" onclick="genCode()">
								<i class="fa fa-folder-open-o"></i> 生成代码
							</button>
							<button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" title="创建菜单" onclick="createMenu()">
								<i class="fa fa-folder-open-o"></i> 创建菜单
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

				<table id="contentTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable" style="font-size: 13px">
					<thead>
						<tr>
							<th><input type="checkbox" class="i-checks"></th>
							<!-- <th class="sort-column table_type">表类型</th> -->
							<th class="sort-column name">表名</th>
							<th>说明</th>
							<th class="sort-column class_name">类名</th>
							<th class="sort-column parent_table">主表</th>
							<!-- <th class="sort-column isSync">同步数据库</th> -->
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${page.list}" var="genTable">
							<tr>
								<td><input type="checkbox" id="${genTable.id}" class="i-checks"></td>
								<%-- <td>${genTable.id}</td> --%>
								<td>
									<a href="#" onclick="openDialogView('查看表单', '${ctx}/gen/genTable/form?id=${genTable.id}','80%', '80%')">${genTable.name}</a>
								</td>
								<td>${genTable.comments}</td>
								<td>${genTable.className}</td>
								<td title="点击查询子表"><a href="#" onclick="openDialogView('查看子表', '${ctx}/gen/genTable/form?id=${genTable.id}','80%', '80%')">${genTable.parentTable}</a></td>
								<!-- <td>已同步</td> -->
								<td>
									<a href="#" onclick="openDialog('修改业务表', '${ctx}/gen/genTable/form?id=${genTable.id}','80%', '80%')" class="btn btn-success btn-xs">
										<i class="fa fa-edit"></i>修改</a> 
									<a href="${ctx}/gen/genTable/delete?id=${genTable.id}" onclick="return confirmx('确认要移除该条记录吗？', this.href)" class="btn btn-warning btn-xs">
										<i class="fa fa-trash"></i>移除</a> 
									<%-- <a href="${ctx}/gen/genTable/deleteDb?id=${genTable.id}" onclick="return confirmx('确认要删除该条记录并删除对应的数据库表吗？', this.href)" class="btn btn-danger btn-xs">
										<i class="fa fa-trash"></i>删除</a> 
									<a href="${ctx}/gen/genTable/synchDb?id=${genTable.id}" onclick="return confirmx('确认要强制同步数据库吗？同步数据库将删除所有数据重新建表！', this.href)" class="btn btn-info btn-xs">
										<i class="fa fa-database"></i>同步数据库</a></td> --%>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<!-- 分页代码 -->
				<div class="pagination">${page}</div>
				</div>
			</div>
		</div>
</body>
</html>
