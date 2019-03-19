<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>选择用户</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<script type="text/javascript">
	function dosubmit(){
		  $('#searchForm').submit();
	}
	function page(n,s){
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").submit();
    	return false;
    }
	
	</script>
<div class="wrapper wrapper-content">
	<form id="searchForm" class="form-inline" action="${ctx}/sys/role/getSelectedUsers" method="post">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" /> 
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" /> 
		<input id="orderBy" name="orderBy" type="hidden" value="${page.orderBy}" />
		<input type="hidden" name="role.id" value="${user.role.id}"/>
	</form>
	<table id="contentTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable" style="font-size: 13px;width:98%">
		<thead>
			<tr>
				<th>登录名</th>
				<th>姓名</th>
			    <th>归属公司</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="user" varStatus="status">
			<tr>
				<td>${user.loginName}</td>
				<td>${user.name}</td>
				<td>${user.company.name}</td>
				<%--  <th><a href="${ctx}/sys/user/delete?id=${user.id}" onclick="return confirmx('确认要删除该用户吗？', this.href)" class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 撤销</a></th> --%>
			</tr>
		</c:forEach>
		</tbody>
	</table>
    <div class="pagination">${page}</div>
  </div> 
</div>
</body>
</html>