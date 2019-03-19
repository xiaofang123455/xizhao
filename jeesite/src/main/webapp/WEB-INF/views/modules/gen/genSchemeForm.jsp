<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>生成方案管理</title>
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
	$(document).ready(function() {
		$("#name").focus();
			validateForm = $("#inputForm").validate({
			submitHandler: function(form){
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
	});
		
		$(document).ready(function() {
			 $('.i-checks').iCheck({
	               checkboxClass: 'icheckbox_square-green',
	               radioClass: 'iradio_square-green',
	           });
		});
	</script>
</head>
<body>
	<form:form id="inputForm" modelAttribute="genScheme" action="${ctx}/gen/genScheme/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="flag"/>
		<sys:message content="${message}"/>
		<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer" style="font-size:13px">
  			<tbody>	
	  			<tr>
	  				 <td  class=" active"><label class="pull-right">方案名称:</label></td>
			         <td class="width-35" >
			         	<form:input path="name" htmlEscape="false" maxlength="200" class="form-control required" />
				    </td>
				    <td  class=" active"><label class="pull-right">模板分类:</label></td>
			         <td class="width-35" >
			         	<select class="form-control select2"  name="category" style="width: 100%;">
							<c:forEach items="${config.categoryList}" var="category">
							     <option value="${category.value}" <c:if test="${category.value eq genScheme.category}"> selected</c:if> >${category.label}</option>
							</c:forEach>
						</select>
			         	<span class="help-inline">
							生成结构：{包名}/{模块名}/{分层(dao,entity,service,web)}/{子模块名}/{java类}
						</span>
				    </td>
				    </tr>
				    <tr>
				     <td  class=" active"><label class="pull-right">生成包路径:</label></td>
			         <td class="width-35" >
			         	<form:input path="packageName" htmlEscape="false" maxlength="500" class="required form-control"/>
						<span class="help-inline">建议模块包：com.thinkgem.jeesite.modules</span>
				    </td>
				     <td  class=" active"><label class="pull-right">生成模块名:</label></td>
			         <td class="width-35" >
						<form:input path="moduleName" htmlEscape="false" maxlength="500" class="required form-control"/>
						<span class="help-inline">可理解为子系统名，例如 sys</span>
				    </td>
	  			</tr>
	  			<tr>
				    <td  class=" active"><label class="pull-right">生成子模块名:</label></td>
			         <td class="width-35" >
			         	<form:input path="subModuleName" htmlEscape="false" maxlength="500" class="form-control"/>
						<span class="help-inline">可选，分层下的文件夹，例如 </span>
				    </td>
				    <td  class=" active"><label class="pull-right">生成功能描述:</label></td>
			         <td class="width-35" >
			         	<form:input path="functionName" htmlEscape="false" maxlength="500" class="required form-control"/>
						<span class="help-inline">将设置到类描述</span>
				    </td>
	  			</tr>
	  			<tr>
	  			 	<td  class=" active"><label class="pull-right">生成功能名:</label></td>
			         <td class="width-35" >
			         	<form:input path="functionNameSimple" htmlEscape="false" maxlength="500" class="required form-control"/>
						<span class="help-inline">用作功能提示，如：保存“某某”成功</span>
				    </td>
				    <td  class=" active"><label class="pull-right">生成功能作者:</label></td>
			         <td class="width-35" >
			         	<form:input path="functionAuthor" htmlEscape="false" maxlength="500" class="required form-control"/>
						<span class="help-inline">功能开发者</span>
				    </td>
				    
	  			</tr>
	  			<tr>
	  				<td  class=" active"><label class="pull-right">业务表名:</label></td>
			         <td class="width-35" >
			         	<select class="form-control select2"  name="genTable.id" style="width: 100%;" id="genTable.id" value="genTable.id">
							<c:forEach items="${tableList}" var="table">
							     <option value="${table.id}" <c:if test="${table.id == genScheme.genTable.id}"> selected</c:if> >${table.nameAndComments}"</option>
							</c:forEach>
						</select>
						<span class="help-inline">生成的数据表，一对多情况下请选择主表。</span>
				    </td>
				    
				    <td  class=" active"><label class="pull-right">生成选项:</label></td>
			         <td class="width-35" >
			         	<form:checkbox path="replaceFile" label="是否替换现有文件" class="i-checks"/>
				    </td>
	  			</tr>
	  			<tr>
	  				<td  class=" active"><label class="pull-right">备注:</label></td>
			         <td class="width-35" >
			         	<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="200" class="form-control"/>
				    </td>
				    <td></td>
				    <td></td>
	  			</tr>
			</tbody>
		</table>
		<%-- <div class="form-actions">
			<shiro:hasPermission name="gen:genScheme:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保存方案" onclick="$('#flag').val('0');"/>&nbsp;
				<input id="btnSubmit" class="btn btn-danger" type="submit" value="保存并生成代码" onclick="$('#flag').val('1');"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div> --%>
	</form:form>
</body>
</html>
