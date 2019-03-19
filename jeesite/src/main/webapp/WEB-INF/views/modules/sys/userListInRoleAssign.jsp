<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>选择用户</title>
	<meta name="decorator" content="default"/>
</head>
	<style type="text/css">
		.row{
			margin-right:0
		}
		.form-control-inline {
   		 width:120px;
   		 display:inline;
}
	</style>
<body>
		<form id="assignRoleToUser" action="${ctx}/sys/role/assignRoleToUser" method="post" class="hide">
			<input type="hidden" name="id" value="${user.role.id}"/>
			<input type="hidden" name="office.id" value="${user.office.id}"/>
			<input id="ids" type="hidden" name="ids" value=""/>
		</form>
		<form id="searchForm" class="form-inline" action="${ctx}/sys/role/users" method="post">
					<input id="pageNo" name="pageNo" type="hidden"
					value="${page.pageNo}" /> <input id="pageSize" name="pageSize"
					type="hidden" value="${page.pageSize}" /> <input id="orderBy"
					name="orderBy" type="hidden" value="${page.orderBy}" />
					<input id="office.id" name="office.id" type="hidden" />
					<input id="role.id" name="role.id" type="hidden"/>
			
			 <div class="form-group">
			<span>登录名：</span>
			<input name="loginName" id="loginName" htmlEscape="false"
						maxlength="20" class="form-control input-sm"  style="width:120px;display:inline;"/>
			<button id="assignButton"
						class="btn btn-outline btn-primary btn-sm form-control-inline" type="button"
						title="查询人员" onclick="dosubmit()" style="width:80px">
						<i class="fa fa-search search"></i> 查询人员
			</button>
			</div>
		</form>
	<br>

	<sys:message content="${message}"/>
	<button id="assignButton"
						class="btn btn-outline btn-primary btn-sm form-control-inline" type="button"
						title="添加勾选人员" onclick="selectUser()" style="width:100px;">
						<i class="fa fa-plus plus"></i> 添加勾选人员
	</button>
	<table id="contentTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable" style="font-size: 13px;width:98%">
		<thead>
			<tr>
				<th><input type="checkbox" class="i-checks"></th>
				<th>登录名</th>
				<th>姓名</th>
			    <th>归属公司</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="user" varStatus="status">
			<tr>
				<td> <input type="checkbox" id="${user.id}" class="i-checks"></td>
				<td>${user.loginName}</td>
				<td>${user.name}</td>
				<td>${user.company.name}</td>
		
			</tr>
		</c:forEach>
		</tbody>
	</table>
    <div class="pagination">${page}</div>
  </div> 
</div>
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
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		
		function dosubmit(){
			var officeIdVal = $("#officeId",window.parent.document).val();
			var roleIdVal = $("#roleId",window.parent.document).val();
			document.getElementById("office.id").value = officeIdVal;
			document.getElementById("role.id").value = roleIdVal;
			$("#searchForm").submit();
		}
		
		
		function selectUser(){
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
			  $("#ids").val(ids);
			  $('#assignRoleToUser').submit();
			  window.parent.document.getElementById("selectedUserListInRoleAssign").contentWindow.dosubmit();
			   
		}
		
	 	function doanothersubmit(){
		
		} 
	</script>
</body>
</html>