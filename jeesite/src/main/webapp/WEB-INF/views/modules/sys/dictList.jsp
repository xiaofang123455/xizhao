<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>字典管理</title>
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
				<h5>字典列表</h5>
			</div>
			<div class="ibox-content">
				<!-- 查询条件 -->
				<div class="row">
					<div class="col-sm-12">
						<form:form id="searchForm" class="form-inline" action="${ctx}/sys/dict/list" method="post" modelAttribute="dict">
							 <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
							<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
							<input id="orderBy" name="orderBy" type="hidden" value="${page.orderBy}"/>
							<div class="form-group">
								<span>类型：</span> 
								<select id="type" name="type" class="form-control m-b">
									<option value="" label="" />
									<c:forEach var="typeName" items="${typeList}">
										<option value="${typeName}"  <c:if test="${dict.type == typeName }">selected</c:if>>${typeName}</option>
									</c:forEach>
								</select> 
								<span>描述 ：</span> 
								<form:input  path="description" class="form-control"   maxlength="50" />
							</div>
						</form:form>
						<br />
					</div>
				</div>


				<!-- 工具栏 -->
				<div class="row">
					<div class="col-sm-12">
						<div class="pull-left">
							<button class="btn btn-white btn-sm " data-toggle="tooltip"
								data-placement="left" onclick="sortOrRefresh()" title="刷新">
								<i class="glyphicon glyphicon-repeat"></i> 刷新
							</button>
							<button class="btn btn-white btn-sm" data-toggle="tooltip"
								data-placement="left" onclick="add()" title="添加">
								<i class="fa fa-plus"></i> 添加
								<script type="text/javascript">
									function add() {
										openDialog("新增" + '字典','${ctx}/sys/dict/form',"800px", "500px");
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
									var size = $("#contentTable tbody tr td input.i-checks:checked").size();
									if (size == 0) {
										top.layer.alert('请至少选择一条数据!', {icon : 0,title : '警告'});
										return;
									}
									if (size > 1) {
										top.layer.alert('只能选择一条数据!', {icon : 0,title : '警告'});
										return;
									}
									var id = $("#contentTable tbody tr td input.i-checks:checkbox:checked").attr("id");
									openDialog("修改" + '字典',"${ctx}/sys/dict/form?id=" + id,"800px", "500px");
								}
							</script>
							</button>
							<button class="btn btn-white btn-sm" onclick="deleteAll()"
								data-toggle="tooltip" data-placement="left">
								<i class="fa fa-trash-o"> 删除</i>
							</button>
							<script type="text/javascript">
								function deleteAll() {
									var str = "";
									var ids = "";
									$("#contentTable tbody tr td input.i-checks:checkbox").each(function() {
										if (true == $(this).is(':checked')) {str += $(this).attr("id")+ ",";
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
									 confirmx('确认要删除该字典吗？', "${ctx}/sys/dict/deleteAll?ids="+ ids)
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
					class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable"
					style="font-size: 13px">
					<thead>
						<tr>
							<th><input type="checkbox" class="i-checks"></th>
							<th >键值</th>
							<th>标签</th>
							<th >类型</th>
							<th >描述</th>
							<th >排序</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${page.list}" var="dict">
							<tr>
								<td><input type="checkbox" id="${dict.id}" class="i-checks">
								</td>
								<td>${dict.value}</td>
								<td><a href="#" onclick="openDialogView('查看字典', '${ctx}/sys/dict/form?id=${dict.id}','800px', '500px')">${dict.label}</a></td>
								<td><a href="javascript:"
									onclick="$('#type').val('${dict.type}');$('#searchForm').submit();return false;">${dict.type}</a></td>
								<td>${dict.description}</td>
								<td>${dict.sort}</td>
								<shiro:hasPermission name="sys:dict:edit">
									<td nowrap="">
										<a class="btn btn-success btn-xs" onclick="openDialog('修改字典', '${ctx}/sys/dict/form?id=${dict.id}','800px', '500px')"
											href="#"><i class="fa fa-edit"></i> 修改</a> 
										<a class="btn btn-danger btn-xs" href="${ctx}/sys/dict/delete?id=${dict.id}&type=${dict.type}" onclick="return confirmx('确认要删除该字典吗？', this.href)">
											<i class="fa fa-trash"></i> 删除</a> 
										<a class="btn btn-primary btn-xs" onclick="openDialog('添加键值', '${ctx}/sys/dict/form?type=${dict.type}&sort=${dict.sort+10}&description=${dict.description}','800px', '500px')"
											href="#"><i class="fa fa-plus"></i>添加键值</a>
									</td>
								</shiro:hasPermission>
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