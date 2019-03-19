<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>ftp上传文件管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			top.$.jBox.tip.mess = undefined;
		});
	
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
        
       	function refresh() {//刷新
			window.location = "${ctx}/sys/ftpFile/";
		}
	</script>
</head>
<body class="gray-bg pace-done" style="font-size: 13px">
	<div class="wrapper wrapper-content">
		<div class="ibox">
			<div class="ibox-title">
				<h5>文件下载</h5>
			</div>
			<div class="ibox-content">
				<!-- 查询条件 -->
				<div class="row">
					<div class="col-sm-12" style="padding-bottom: 6px;">
						<form:form id="searchForm" class="form-inline" action="${ctx}/sys/ftpFile/" method="post" modelAttribute="ftpFile" >
							<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
							<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
							<input	id="orderBy" name="orderBy" type="hidden" value="" /> 
			
							<div class="form-group">
									<span>文件名称：</span>
										<form:input path="fileRealName" htmlEscape="false" class=" form-control input-sm"   maxlength="64"/>
									<span>文件类型：</span>
										<form:input path="fileType" htmlEscape="false" class=" form-control input-sm"   maxlength="64"/>
							</div>
						</form:form>
					</div>
				</div>								
				<!-- 工具栏 -->
				<div class="row" style="margin-top:15px">
					<div class="col-sm-12">
						<div class="pull-left">
							<!-- <button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="left" onclick="add()" title="添加">
								<i class="fa fa-plus"></i> 上传文件
							</button>
							<script type="text/javascript">
								function add(){
									openDialog("新增"+'ftp上传文件','${ctx}/sys/ftpFile/form',"800px", "500px");
								}
							</script>
							-->
							<button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="left" onclick="edit()" title="下载文件">
								<i class="fa fa-file-text-o"></i> 下载文件
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
									function edit(){
				 					 	 var names="";
				 					 	$("#contentTable tbody tr td input.i-checks:checkbox").each(function(){
				   					 		if(true == $(this).is(':checked')){
				     				 		names+=$(this).attr("name")+",";
				   					 		}
				  						});
				  						if(names.substr(names.length-1)== ','){
				    						names = names.substr(0,names.length-1);
				 						 }
				 						 if(names == ""){
											top.layer.alert('请至少选择一条数据!', {icon: 0, title:'警告'});
										return;
					  				}
				 						window.location.href = "${ctx}/sys/ftpFile/downloadAll?names="+names;
								}
							</script> 
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
							function deleteAll(){
							 	 var str="";
		 					 	 var ids="";
		 					 	 var names="";
		 					 	$("#contentTable tbody tr td input.i-checks:checkbox").each(function(){
		   					 		if(true == $(this).is(':checked')){
		     				 		str+=$(this).attr("id")+",";
		     				 		names+=$(this).attr("name")+",";
		   					 		}
		  						});
		  						if(str.substr(str.length-1)== ','){
		    						ids = str.substr(0,str.length-1);
		    						names = names.substr(0,names.length-1);
		 						 }
		 						 if(ids == ""){
									top.layer.alert('请至少选择一条数据!', {icon: 0, title:'警告'});
								return;
			  				}
								confirmx('确认要彻底删除数据吗？', "${ctx}/sys/ftpFile/deleteAll?ids="+ids+"&names="+names);
							}
					</script>
							<button class="btn btn-white btn-sm " data-toggle="tooltip"
								data-placement="left" onclick="refresh()" title="刷新">
								<i class="glyphicon glyphicon-repeat"></i> 刷新
							</button>
						</div>
						<div class="pull-right">
							<button class="btn btn-primary  btn-sm btn-rounded btn-outline"
								onclick="search()">
								<!-- btn-rounded btn-outline -->
								<i class="fa fa-search"></i> 查询
							</button>
							<button class="btn btn-primary  btn-sm btn-rounded btn-outline"
								onclick="reset()">
								<i class="fa fa-refresh"></i> 重置
							</button>
						</div>
					</div>
				</div>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered  table-hover table-condensed  dataTables-example dataTable no-footer" style="font-size: 13px">
		<thead>			
			<tr>
				<th><input type="checkbox" class="i-checks"></th>
					<th>文件名称</th>
					<th>文件类型</th>
					<th>文件大小</th>
					<th>上传时间</th>
					<shiro:hasPermission name="sys:ftpFile:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="ftpFile">
			<tr>
				<td> <input type="checkbox" id="${ftpFile.id}" name="${ftpFile.fileName}" class="i-checks"></td>
				<td>${ftpFile.fileRealName} </td>
				<td>${ftpFile.fileType} </td>
				<td>${ftpFile.fileSize} </td>
				<td><fmt:formatDate value="${ftpFile.uploadDatetime}" type="both"  dateStyle="full" /> </td>
				
				<shiro:hasPermission name="sys:ftpFile:edit"><td>
					<a href="${ctx}/sys/ftpFile/download?fileName=${ftpFile.fileName}"  class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 下载该文件</a>
					<a href="${ctx}/sys/ftpFile/delete?id=${ftpFile.id}" onclick="return confirmx('确认要删除该ftp文件吗？', this.href)" class='btn btn-danger btn-xs'><i class="fa fa-trash"></i> 删除</a>
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