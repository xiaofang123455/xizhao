<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>区域管理</title>
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
				 rules: {
						code: {remote: "${ctx}/sys/area/checkAreaCode?oldCode=" + encodeURIComponent('${area.code}')}//设置了远程验证，在初始化时必须预先调用一次。
					},
					messages: {
						code: {remote: "区域编码已存在"}
					}, 
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
		 $("#inputForm").validate().element($("#code")); 
		});
	</script>

</head>
<body>
	<form:form id="inputForm" class="form-horizontal" action="${ctx}/sys/area/save" method="post" modelAttribute="area">
		<form:hidden path="id"/>
		<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
		   <tbody>
		      <tr>
		         <td  class="width-15 active"><label class="pull-right">上级区域:</label></td>
		         <td class="width-35" >
		         	<sys:treeselect id="area" name="parent.id" value="${area.parent.id}" labelName="parent.name" labelValue="${area.parent.name}"
					title="区域" url="/sys/area/treeData" extId="${area.id}" cssClass="" allowClear="true"/>
				</td>
		         <td  class="width-15 active"><label class="pull-right">区域名称:</label></td>
		         <td  class="width-35" ><form:input  path="name" class="form-control required"   maxlength="50"/></td>
		      </tr>
		      <tr>
		         <td  class="width-15 active"><label class="pull-right"><font color="red">*</font>区域编码:</label></td>
		         <td class="width-35" >
		         <input id="oldCode" name="oldCode" type="hidden" value="${area.code}">
		         <form:input path="code" class="form-control" maxlength="50"/></td>
		         <td  class="width-15 active"><label class="pull-right">区域类型:</label></td>
		         <td  class="width-35" >
					<form:select path="type" class="form-control m-b">
						<form:options items="${fns:getDictList('sys_area_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</td>
		      </tr>
			  <tr>
		         <td  class="width-15 active"><label class="pull-right">备注:</label></td>
		         <td class="width-35" ><form:textarea  path="remarks" maxlength="200" class="form-control" rows="3"  htmlEscape="false" /></td>
		         <td  class="width-15 active"><label class="pull-right"></label></td>
		         <td  class="width-35" ></td>
		      </tr>
		</tbody>
		</table>
	</form:form>
</body>
</html>