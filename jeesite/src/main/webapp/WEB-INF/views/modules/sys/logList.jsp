<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>角色管理</title>
<meta name="decorator" content="default"/>
<link href="${ctxStatic}/My97DatePicker/skin/WdatePicker.css" type="text/css"
	rel="stylesheet" />
<script src="${ctxStatic}/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
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
				<form id="searchForm" class="form-inline"
							action="${ctx}/sys/role/list" method="post">
				<div class="row">
					<div class="col-sm-12">
							<input id="pageNo" name="pageNo" type="hidden" value="1" /> <input
								id="pageSize" name="pageSize" type="hidden" value="10" /> <input
								id="orderBy" name="orderBy" type="hidden" value="" />
							<div class="form-group">
									<span>操作菜单：</span> 
									<input id="title" class="form-control input-sm" type="text"  value="${log.title}" maxlength="50" name="title"> 
									<span>用户ID：</span>
									<input id="createBy.id" class="form-control input-sm" type="text" value="${log.createBy.id}" maxlength="50" name="createBy.id">
									<span>URI：</span>
									 <input id="requestUri" class="form-control input-sm type="text" value="" maxlength="50" name="requestUri">
							</div>
						<br />
					</div>
				</div>
				
				<div class="row" style="padding-top:5px">
								<div class="col-sm-12">
										<div class="form-group"> 
														<span>日期范围： </span> 
									<input id="beginDate"
											name="beginDate" type="text" readonly="readonly"
											maxlength="20" class="laydate-icon form-control layer-date input-sm"
											value="<fmt:formatDate value="${log.beginDate}" pattern="yyyy-MM-dd"/>"
											onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" />
									<label> -- </label>
									 <input
											id="endDate" name="endDate" type="text" readonly="readonly"
											maxlength="20" class="laydate-icon form-control layer-date input-sm"
											value="<fmt:formatDate value="${log.endDate}" pattern="yyyy-MM-dd"/>"
											onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" />
									<label class="" for="exception">
									<div class="icheckbox_square-green" style="position: relative;">
									<input id="exception" class="i-checks" type="checkbox" value="1" name="exception" style="position: absolute; opacity: 0;">
									<ins class="iCheck-helper" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: rgb(255, 255, 255) none repeat scroll 0% 0%; border: 0px none; opacity: 0;"></ins>
									</div>
									只查询异常信息
									</label>
									</div>
								 </div>
								 </div>
						</form>
						


				<!-- 工具栏 -->
				<div class="row">
					<div class="col-sm-12">
						<div class="pull-left">
							<button class="btn btn-white btn-sm" onclick="deleteAll()"
								data-toggle="tooltip" data-placement="left">
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
									$(
											"#contentTable tbody tr td input.i-checks:checkbox")
											.each(
													function() {
														if (true == $(this).is(
																':checked')) {
															str += $(this)
																	.attr("id")
																	+ ",";
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
									top.layer
											.confirm(
													'确认要彻底删除数据吗?',
													{
														icon : 3,
														title : '系统提示'
													},
													function(index) {
														window.location = "${ctx}/sys/log/deleteAll?ids="
																+ ids;
														top.layer.close(index);
													});
								}
							</script>
							<button class="btn btn-white btn-sm" onclick="deleteAll()"
								data-toggle="tooltip" data-placement="left">
								<i class="fa fa-trash"> 清空</i>
							</button>
							<button class="btn btn-white btn-sm " data-toggle="tooltip"
								data-placement="left" onclick="search()" title="刷新">
								<i class="glyphicon glyphicon-repeat"></i> 刷新
							</button>
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
							<th>操作菜单</th><th>操作用户</th><th>所在公司</th><th>所在部门</th><th>URI</th><th>提交方式</th><th>操作者IP</th><th>操作时间</th>
							<shiro:hasPermission name="sys:log:edit">
								<th>操作</th>
							</shiro:hasPermission>
						</tr>
					</thead>
				<tbody><%request.setAttribute("strEnter", "\n");request.setAttribute("strTab", "\t");%>
						<c:forEach items="${page.list}" var="log">
							<tr>
								<td> <input type="checkbox" id="${log.id}" class="i-checks"></td>
								<td>${log.title}</td>
								<td>${log.createBy.name}</td>
								<td>${log.createBy.company.name}</td>
								<td>${log.createBy.office.name}</td>
								<td><strong>${log.requestUri}</strong></td>
								<td>${log.method}</td>
								<td>${log.remoteAddr}</td>
								<td><fmt:formatDate value="${log.createDate}" type="both" /></td>
							</tr>
							<c:if test="${not empty log.exception}">
								<tr>
									<td colspan="8"
										style="word-wrap: break-word; word-break: break-all;">
										<%-- 					用户代理: ${log.userAgent}<br/> --%> <%-- 					提交参数: ${fns:escapeHtml(log.params)} <br/> --%>
										异常信息: <br />
										${fn:replace(fn:replace(fns:escapeHtml(log.exception), strEnter, '<br/>'), strTab, '&nbsp; &nbsp; ')}
									</td>
								</tr>
							</c:if>
						</c:forEach>
					</tbody>
		</table>
		<div class="pagination">${page}</div>
			</div>
		</div>
	</div>
</body>
</html>