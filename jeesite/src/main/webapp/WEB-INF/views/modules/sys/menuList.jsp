<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>菜单管理</title>
<meta name="decorator" content="default" />  
<%@include file="/WEB-INF/views/include/treetable.jsp"%>
<script type="text/javascript">
	$(document).ready(function() {
		$("#treeTable").treeTable().show();
	});
	function updateSort() {
		loading('正在提交，请稍等...');
		$("#listForm").attr("action", "${ctx}/sys/menu/updateSort");
		$("#listForm").submit();
	}
	function refresh() {//刷新
		window.location = "${ctx}/sys/menu/";
	}
</script>
</head>
<body>
	<div class="wrapper wrapper-content">
		<div class="ibox">
			<div class="ibox-title">
				<h5>菜单列表</h5>
			</div>
			<div class="ibox-content">
				<!-- 工具栏 -->
				<div class="row">
					<div class="col-sm-12">
						<div class="pull-left">
							<button class="btn btn-white btn-sm" data-toggle="tooltip"
								data-placement="left" onclick="add()" title="添加">
								<i class="fa fa-plus"></i> 添加
							</button>
							<script type="text/javascript">
								function add() {
									openDialog("新增" + '菜单',"${ctx}//sys/menu/form", "800px","500px", "");
								}
							</script>
							<!-- 增加按钮 -->
							<button id="btnSubmit" class="btn btn-white btn-sm "
								data-toggle="tooltip" data-placement="left"
								onclick="updateSort()" title="保存排序">
								<i class="fa fa-save"></i> 保存排序
							</button>
							<button class="btn btn-white btn-sm " data-toggle="tooltip"
								data-placement="left" onclick="refresh()" title="刷新">
								<i class="glyphicon glyphicon-repeat"></i> 刷新
							</button>
						</div>
					</div>
				</div>
				<sys:message content="${message}"/>
				<form:form id="listForm" method="post">
					<table id="treeTable"
						class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable tree_table"
						style="font-size: 13px">
						<thead>
							<tr>
								<th>名称</th>
								<th>链接</th>
								<th style="text-align: center;">排序</th>
								<th>可见</th>
								<th>权限标识</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${list}" var="menu">
								<tr id="${menu.id}"
									pId="${menu.parent.id ne '1'?menu.parent.id:'0'}">
									<td nowrap>
										<a onclick="openDialogView('${menu.name}', '${ctx}/sys/menu/form?id=${menu.id}','800px', '500px')" href="#">${menu.name}</a>
									</td>
									<td title="${menu.href}">${fns:abbr(menu.href,30)}</td>
									<td style="text-align: center;">
									<shiro:hasPermission name="sys:menu:edit">
										<input type="hidden" name="ids" value="${menu.id}" />
										<input name="sorts" type="text" class="form-control" value="${menu.sort}" style="width: 100px; margin: 0; padding: 0; text-align: center;">
									</shiro:hasPermission> 
									<shiro:lacksPermission name="sys:menu:edit">
										${menu.sort}
									</shiro:lacksPermission></td>
									<td>${menu.isShow eq '1'?'显示':'隐藏'}</td>
									<td title="${menu.permission}">${fns:abbr(menu.permission,30)}</td>
									<shiro:hasPermission name="sys:menu:edit">
										<td nowrap="">
											<a class="btn btn-info btn-xs" onclick="openDialogView('查看菜单', '${ctx}/sys/menu/form?id=${menu.id}','800px', '500px')" href="#"><i class="fa fa-search-plus"></i> 查看</a> 
											<a class="btn btn-success btn-xs" onclick="openDialog('修改菜单', '${ctx}/sys/menu/form?id=${menu.id}','800px', '500px')" href="#"><i class="fa fa-edit"></i> 修改</a> 
											<a class="btn btn-danger btn-xs" onclick="return confirmx('要删除该菜单及所有子菜单项吗？', this.href)" href="${ctx}/sys/menu/delete?id=${menu.id}"><i class="fa fa-trash"></i> 删除</a>										
											<a class="btn btn-primary btn-xs" onclick="openDialog('添加下级菜单', '${ctx}/sys/menu/form?parent.id=${menu.id}','800px', '500px')" href="#"><i class="fa fa-plus"></i> 添加下级菜单</a>
										</td>
									</shiro:hasPermission>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</form:form>
			</div>
		</div>
	</div>
</body>
</html>