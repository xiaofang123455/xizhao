<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>修改用戶密碼</title>
<meta name="decorator" content="default" />

<script type="text/javascript">
		 $(document).ready(function() {
			 $('.i-checks').iCheck({
	                checkboxClass: 'icheckbox_square-green',
	                radioClass: 'iradio_square-green',
	            });
		});
	</script>
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
			validateForm = $("#inputForm").validate({
				/*  rules: {
					loginName: {remote: "${ctx}/sys/user/checkLoginName?oldLoginName=" + encodeURIComponent('${user.loginName}')}//设置了远程验证，在初始化时必须预先调用一次。
				}, */
				messages: {
					confirmNewPassword: {equalTo: "输入与上面相同的密码"}
				}, 
			 	submitHandler: function(form){
				//	loading('正在提交，请稍等...');
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
	</script>
</head>
<body>
	<form id="inputForm" class="form-horizontal" action="${ctx}/sys/user/changePass" method="post" >
		<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer" style="font-size: 13px">
			<tbody>
				<tr>
					<td class="active" style="width:40%; text-align: center;"><label >密码:</label></td>
					<td>
						<input id="newPassword" name="newPassword" type="password" value="" maxlength="50" minlength="3"  class=" form-control" /> 
						<c:if test="${empty user.id}">
							<span class="help-inline"></span>
						</c:if> <c:if test="${not empty user.id}">
							<span class="help-inline">若不修改密码，请留空。</span>
						</c:if>
					</td>
					</tr>
				<tr>
					<td class="active" style="width:40%; text-align: center;"><label>确认密码:</label></td> <!-- class="pull-right" -->
					<td style="width:60%">
						<input id="confirmNewPassword" name="confirmNewPassword" type="password" value="" maxlength="50" minlength="3" equalTo="#newPassword" class="form-control" /> 
					</td>
				</tr>
				
			</tbody>
		</table>
	</form>
</body>
</html>