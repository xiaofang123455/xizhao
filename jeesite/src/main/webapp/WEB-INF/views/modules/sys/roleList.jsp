<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>角色管理</title>
<meta name="decorator" content="default"/>
<script type="text/javascript">
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").submit();
		return false;
	}
</script>
</head>

<body class="gray-bg pace-done" style="font-size: 13px">
	<div class="wrapper wrapper-content"> 
		<div class="ibox">
			<div class="ibox-title">
				<h5>角色列表</h5>
			</div>
			<div class="ibox-content">
				<!-- 0:隐藏tip, 1隐藏box,不设置显示全部 -->
				<script type="text/javascript">
					top.$.jBox.closeTip();
				</script>

				<!-- 查询条件 -->
				<div class="row">
					<div class="col-sm-12">
						<form:form id="searchForm" class="form-inline" action="${ctx}/sys/role/list" method="post" modelAttribute="role">
							<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
							<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
							<input id="orderBy" name="orderBy" type="hidden" value="${page.orderBy}"/>
							<div class="form-group">
								<span>角色名称 ：</span> 
								<form:input class="form-control input-sm"  path="name" maxlength="50" />
							</div>
						</form:form>
						<br />
					</div>
				</div>
				<!-- 工具栏 -->
				<div class="row">
					<div class="col-sm-12">
						<div class="pull-left">
							<button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="search()" title="刷新">
								<i class="glyphicon glyphicon-repeat"></i> 刷新
							</button>
							<button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="left" onclick="add()" title="添加">
								<i class="fa fa-plus"></i> 添加
								<script type="text/javascript">
									function add() {
										openDialog("新增" + '角色',
												'${ctx}/sys/role/form',
												"800px", "500px");
									}
								</script>
							</button>
							<button class="btn btn-white btn-sm" data-toggle="tooltip"
								data-placement="left" onclick="edit()" title="修改">
								<i class="fa fa-file-text-o"></i> 修改
							</button>
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
								function edit() {
									var size = $(
											"#contentTable tbody tr td input.i-checks:checked")
											.size();
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
									var id = $(
											"#contentTable tbody tr td input.i-checks:checkbox:checked")
											.attr("id");
									openDialog("修改" + '角色',
											"${ctx}/sys/role/form?id=" + id,
											"800px", "500px");
								}
							</script>
							</button>
							<button class="btn btn-white btn-sm" onclick="deleteAll()" data-toggle="tooltip" data-placement="left">
								<i class="fa fa-trash-o"> 删除</i>
							</button>
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
								function deleteAll() {
									var str = "";
									var ids = "";
									$("#contentTable tbody tr td input.i-checks:checkbox").each(function() {
										if (true == $(this).is(':checked')) {
											str += $(this).attr("id")+ ",";
										}
									});
									if (str.substr(str.length - 1) == ',') {
										ids = str.substr(0, str.length - 1);
									}
									if (ids == "") {
										top.layer.alert('请至少选择一条数据!', {
											icon : 0,
											title : '警告'
										});
										return;
									}
									 confirmx('确认要彻底删除数据吗？', "${ctx}/sys/role/deleteAll?ids="+ids);
								}
							</script>
						</div>
						<div class="pull-right">
							<button class="btn btn-primary  btn-sm btn-rounded btn-outline"
								onclick="search()">
								<i class="fa fa-search"></i> 查询
							</button>
							<button class="btn btn-primary  btn-sm btn-rounded btn-outline"
								onclick="reset()">
								<i class="fa fa-refresh"></i> 重置
							</button>
						</div>
					</div>
				</div>

				<sys:message content="${message}" />
				<table id="contentTable"
					class="table table-striped table-bordered  table-hover table-condensed  dataTables-example dataTable no-footer"
					style="font-size: 13px">
					<thead>
						<tr>
							<th><input type="checkbox" class="i-checks"></th>
							<th>角色名称</th>
							<th>英文名称</th>
							<th>归属机构</th>
							<th>数据范围</th>
							<shiro:hasPermission name="sys:role:edit">
								<th>操作</th>
							</shiro:hasPermission>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${page.list}" var="role">
							<tr>
								<td><input type="checkbox" id="${role.id}" class="i-checks"></td>
								<td>
									<a onclick="openDialogView('查看角色', '${ctx}/sys/role/form?id=${role.id}','800px', '500px')" href="#">${role.name}</a>
								</td>
								<td>
									<a onclick="openDialogView('查看角色', '${ctx}/sys/role/form?id=${role.id}','800px', '500px')"  href="#">${role.enname}</a>
								</td>
								<td>${role.office.name}</td>
								<td>${fns:getDictLabel(role.dataScope, 'sys_data_scope', '无')}</td>
<%-- 								<shiro:hasPermission name="sys:role:edit">
 --%>									<td>
										<a class="btn btn-info btn-xs" onclick="openDialogView('查看角色', '${ctx}/sys/role/form?id=${role.id}','800px', '500px')"  href="#">
										 <i class="fa fa-search-plus"></i> 查看
										</a> 
										<%-- <c:choose>
											<c:when test="${(role.sysData eq fns:getDictValue('是', 'yes_no', '1') && fns:getUser().admin)||!(role.sysData eq fns:getDictValue('是', 'yes_no', '1'))}">
	 										 --%>  	<a class="btn btn-success btn-xs" onclick="openDialog('修改角色', '${ctx}/sys/role/form?id=${role.id}','800px', '500px')" href="#">
	 										  	<i class="fa fa-edit"></i> 修改</a>
										<%-- 	</c:when>
											<c:otherwise>
												<a class="btn btn-success btn-xs" href="#"><i class="fa fa-edit"></i> 修改</a>
											</c:otherwise>
										</c:choose>  --%>
										<a class="btn btn-danger btn-xs" onclick="return confirmx('确认要删除该角色吗？', this.href)" href="${ctx}/sys/role/delete?id=${role.id}"> 
											<i class="fa fa-trash"></i> 删除
										</a>
										<a class="btn btn-primary btn-xs" onclick="openDialog('权限设置', '${ctx}/sys/role/auth?id=${role.id}','350px', '500px')" href="#"> 
											<i class="fa fa-edit"></i> 权限设置
										</a>
										<a class="btn btn-warning btn-xs" onclick="openDialogView('分配用户', '${ctx}/sys/role/assign?id=${role.id}','800px', '600px')" href="#"> 
											<i class="glyphicon glyphicon-plus"></i> 分配用户
										</a>
									</td>
<%-- 								</shiro:hasPermission>
 --%>							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="pagination">${page}</div> 
			</div>
		</div>
	</div>
</body>
</html>