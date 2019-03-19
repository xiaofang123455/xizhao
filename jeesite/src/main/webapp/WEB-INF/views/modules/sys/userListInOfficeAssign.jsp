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
		<form id="searchForm" class="form-inline" action="${ctx}/sys/office/users" method="post">
					<input id="pageNo" name="pageNo" type="hidden"
					value="${page.pageNo}" /> <input id="pageSize" name="pageSize"
					type="hidden" value="${page.pageSize}" /> <input id="orderBy"
					name="orderBy" type="hidden" value="${page.orderBy}" />
					<input id="office.id" name="office.id" type="hidden" />
			
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
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable" style="font-size: 13px;width:98%">
		<thead>
			<tr>
				<th><input type="checkbox" class="i-checks"></th>
				<th>登录名</th>
				<th>姓名</th>
			    <th>归属区域</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="user" varStatus="status">
			<tr class="tr">
				<td> <input type="checkbox" id="${user.id}" class="i-checks"></td>
				<td>${user.loginName}</td>
				<td class="name">${user.name}</td>
				<td>${user.office.name}</td>
		
			</tr>
		</c:forEach>
		</tbody>
		<tfoot></tfoot>
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
			document.getElementById("office.id").value = officeIdVal;
			$("#searchForm").submit();
		}
		
		
		function selectUser(){
			  var size = $("#contentTable tbody tr td input.i-checks:checked").size();
			  if(size == 0 ){
					top.layer.alert('请至少选择一条数据!', {icon: 0, title:'警告'});
					return;
				  }
			  if(size > 1 ){
					top.layer.alert('只能选择一条数据!', {icon: 0, title:'警告'});
					return;
				  }
			  var id =  $("#contentTable tbody tr td input.i-checks:checkbox:checked").attr("id");
			  var name = $("#contentTable tbody tr td input.i-checks:checked").parent().parent().parent().children("td.name").text();
			  var user = new Object();
			  user.id = id;
			  user.name = name;
			 return user;
			   
		}
		
	</script>
</body>
</html>