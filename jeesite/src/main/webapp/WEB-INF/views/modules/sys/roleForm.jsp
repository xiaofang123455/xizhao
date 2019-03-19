<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>角色管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		var validateForm;
		function doSubmit(){//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
		  if(validateForm.form()){
			  $("#inputForm").submit();
			  return true;
		  }
		  return false;
		}
		
		$(document).ready(function(){
			$("#name").focus();
			validateForm = $("#inputForm").validate({
				rules: {
					name: {remote: "${ctx}/sys/role/checkName?oldName=" + encodeURIComponent("${role.name}")}
				},
				messages: {
					name: {remote: "角色名已存在"}
				},
				submitHandler:function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		 $("#inputForm").validate().element($("#name")); 
		});
	</script>
</head>
<body>
	<form:form id="inputForm" class="form-horizontal" action="${ctx}/sys/role/save" method="post"  modelAttribute="role">
		<form:input type="hidden" path="id"/>
		<script type="text/javascript">top.$.jBox.closeTip();</script>
		<table
			class="table table-bordered  table-condensed dataTables-example dataTable no-footer"
			style="font-size: 13px">
			<tbody>
				<tr>
					<td class="width-15 active">
						<label class="pull-right">归属机构:</label>
					</td>
					<td class="width-35">
						<sys:treeselect id="office" name="office.id" value="${role.office.id}" labelName="office.name" labelValue="${role.office.name}"
						title="机构" url="/sys/office/treeData" cssClass="required"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font
							color="red">*</font>角色名称:</label></td>
					<td class="width-35"><input id="oldName" name="oldName"
						class="form-control required" type="hidden" value="${role.name}" />
						<form:input path="name" class="form-control required"
							maxlength="50" /></td>
				<tr>
					<td class="width-15 active">
						<label class="pull-right"><font color="red">*</font>英文名称:</label>
					</td>
					<td class="width-35">
					<input id="oldEnname" name="oldEnname" type="hidden" value="${role.enname}"> 
						<form:input maxlength="50" class="form-control" path="enname" aria-required="true" aria-invalid="false" />
					</td>
					<td class="width-15 active"><label class="pull-right">角色类型:</label>
					</td>
					<td class="width-35">
						<select name="roleType" class="form-control ">
								<option value="assignment"
									<c:if test="${role.roleType == 'assignment'}"> selected</c:if>>任务分配</option>
								<option value="security-role"
									<c:if test="${role.roleType == 'security-role'}"> selected</c:if>>管理角色</option>
								<option value="user"
									<c:if test="${role.roleType == 'user'}"> selected</c:if>>普通角色</option>
						</select> <span class="help-inline"
						title="activiti有3种预定义的组类型：security-role、assignment、user 如果使用Activiti Explorer，需要security-role才能看到manage页签，需要assignment才能claim任务">
							工作流组用户组类型（任务分配：assignment、管理角色：security-role、普通角色：user）</span></td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">是否系统数据:</label>
					</td>
					<td class="width-35">
						<form:select path="sysData" class="form-control m-b">
							<form:options items="${fns:getDictList('yes_no')}" temLabel="label" itemValue="value" htmlEscape="false" />
						</form:select> <span class="help-inline">“是”代表此数据只有超级管理员能进行修改，“否”则表示拥有角色修改人员的权限都能进行修改</span>

					</td>
					<td class="width-15 active">
						<label class="pull-right">是否可用:</label>
					</td>
					<td class="width-35">
						<form:select path="useable" class="form-control m-b">
							<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" />
						</form:select> 
						<script type="text/javascript">
							$(document).ready(function() {
								$("#useable").select2();
							});
						</script> 
						<span class="help-inline">“是”代表此数据可用，“否”则表示此数据不可用</span>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">数据范围:</label></td>
					<td class="width-35">
						<form:select path="dataScope" class="form-control m-b">
							<form:options items="${fns:getDictList('sys_data_scope')}" itemLabel="label" itemValue="value" htmlEscape="false" />
						</form:select>
					</td>
					<td class="width-15 active"><label class="pull-right">备注:</label></td>
					<td class="width-35">
						<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class=" form-control" />
					</td>
				</tr>
			</tbody>
		</table>
	</form:form>
</body>
</html>