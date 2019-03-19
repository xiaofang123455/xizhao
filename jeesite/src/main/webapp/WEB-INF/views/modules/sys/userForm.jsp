<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>用户管理</title>
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
			$("#no").focus();
			validateForm = $("#inputForm").validate({
				 rules: {
					loginName: {remote: "${ctx}/sys/user/checkLoginName?oldLoginName=" + encodeURIComponent('${user.loginName}')}//设置了远程验证，在初始化时必须预先调用一次。
				},
				messages: {
					loginName: {remote: "用户登录名已存在"},
					confirmNewPassword: {equalTo: "输入与上面相同的密码"}
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
			//$("#inputForm").validate().element($("#loginName")); 
		});
	</script>
</head>
<body>
	<form:form id="inputForm" class="form-horizontal" action="${ctx}/sys/user/save" method="post" modelAttribute="user">
		<form:hidden path="id" />
		<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer" style="font-size: 13px">
			<tbody>
				<tr>
					<td class="width-15 active">
						<label class="pull-right">
						<font color="red">*</font>头像：</label>
					</td>
					<td class="width-35">
					<form:hidden id="nameImage" path="photo" htmlEscape="false" maxlength="255" class="input-xlarge" />
					<ol id="nameImagePreview"></ol> 
					<a href="javascript:"onclick="nameImageFinderOpen();" class="btn btn-primary">选择</a>&nbsp;
					<a href="javascript:" onclick="nameImageDelAll();"class="btn btn-default">清除</a>
	<script type="text/javascript">
	function nameImageFinderOpen(){
		var date = new Date(), year = date.getFullYear(), month = (date.getMonth()+1)>9?date.getMonth()+1:"0"+(date.getMonth()+1);
		var url = "${ctxStatic}/ckfinder/ckfinder.html?type=images&start=images:/photo/"+year+"/"+month+
			"/&action=js&func=nameImageSelectAction&thumbFunc=nameImageThumbSelectAction&cb=nameImageCallback&dts=0&sm=0";
		windowOpen(url,"文件管理",1000,700);
		//top.$.jBox("iframe:"+url+"&pwMf=1", {title: "文件管理", width: 1000, height: 500, buttons:{'关闭': true}});
	}
	function nameImageSelectAction(fileUrl, data, allFiles){
		var url="", files=ckfinderAPI.getSelectedFiles();
		for(var i=0; i<files.length; i++){//
			url += files[i].getUrl();//
			if (i<files.length-1) url+="|";
		}//
		$("#nameImage").val(url);//
		nameImagePreview();
		//top.$.jBox.close();
	}
	function nameImageThumbSelectAction(fileUrl, data, allFiles){
		var url="", files=ckfinderAPI.getSelectedFiles();
		for(var i=0; i<files.length; i++){
			url += files[i].getThumbnailUrl();
			if (i<files.length-1) url+="|";
		}//
		$("#nameImage").val(url);//
		nameImagePreview();
		//top.$.jBox.close();
	}
	function nameImageCallback(api){
		ckfinderAPI = api;
	}
	function nameImageDel(obj){
		var url = $(obj).prev().attr("url");
		$("#nameImage").val($("#nameImage").val().replace("|"+url,"","").replace(url+"|","","").replace(url,"",""));
		nameImagePreview();
	}
	function nameImageDelAll(){
		$("#nameImage").val("");
		nameImagePreview();
	}
	function nameImagePreview(){
		var li, urls = $("#nameImage").val().split("|");
		$("#nameImagePreview").children().remove();
		for (var i=0; i<urls.length; i++){
			if (urls[i]!=""){//
				li = "<li><img src=\""+urls[i]+"\" url=\""+urls[i]+"\" style=\"max-width:100px;max-height:100px;_height:100px;border:0;padding:3px;\">";//
				li += "&nbsp;&nbsp;<a href=\"javascript:\" onclick=\"nameImageDel(this);\">×</a></li>";
				$("#nameImagePreview").append(li);
			}
		}
		if ($("#nameImagePreview").text() == ""){
			$("#nameImagePreview").html("<li style='list-style:none;padding-top:5px;'>无</li>");
		}
	}
	nameImagePreview();
</script></td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>归属公司:</label></td>
					<td class="width-35">
						<sys:treeselect id="company" name="company.id" value="${user.company.id}" labelName="company.name" labelValue="${user.company.name}" 
							title="公司" url="/sys/office/treeData?type=1" cssClass="input-small" allowClear="true"/>	
					</td>
				</tr>
				<tr>
					<td class="width-15 active" ><label class="pull-right"><font color="red">*</font>归属部门:</label></td>
					<td class="width-35">
						<sys:treeselect id="office" name="office.id" value="${user.office.id}" labelName="office.name" labelValue="${user.office.name}" 
							title="部门" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="false"/>	
					</td>
					<td  class=" width-15 active"><label class="pull-right"><font color="red">*</font>工号:</label></td>
					<td class="width-35"  >
						<form:input path="no" htmlEscape="false" maxlength="50" class="required form-control" />
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>姓名:</label></td>
					<td class="width-35">
						<form:input  path="name" htmlEscape="false" maxlength="50" class="required form-control" />
					</td>
					<td class="width-15 active">
						<label class="pull-right"><font color="red">*</font>登录名:</label>
					</td>
					<td class="width-35">
						<input id="oldLoginName" name="oldLoginName" type="hidden" value="${user.loginName}">
						<form:input path="loginName"   htmlEscape="false" maxlength="50" class="required userName form-control" />
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">密码:</label></td>
					<td>
						<input id="newPassword" name="newPassword" type="password" value="" maxlength="50" minlength="3"  class=" form-control" /> 
						<c:if test="${empty user.id}">
							<span class="help-inline"></span>
						</c:if> <c:if test="${not empty user.id}">
							<span class="help-inline">若不修改密码，请留空。</span>
						</c:if>
					</td>
					<td class="width-15 active"><label class="pull-right">确认密码:</label></td>
					<td class="width-35">
						<input id="confirmNewPassword" name="confirmNewPassword" type="password" value="" maxlength="50" minlength="3" equalTo="#newPassword" class="form-control" /> 
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">邮箱:</label></td>
					<td class="width-35">
						<form:input path="email" htmlEscape="false"  maxlength="100" class="form-control email" />
					</td>
					<td class="width-15 active"><label class="pull-right">电话:</label></td>
					<td class="width-35">
						<form:input path="phone" htmlEscape="false" maxlength="100" class="form-control" />
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">手机:</label></td>
					<td class="width-35">
						<form:input path="mobile" htmlEscape="false" maxlength="100" class="form-control  tel" />
					</td>
					<td class="width-15 active"><label class="pull-right">是否允许登录:</label></td>
					<td class="width-35">
						<form:select path="loginFlag" class="form-control m-b">
							<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" />
						</form:select>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">人员类型:</label></td>
					<td class="width-35">
						<form:select path="userType" class="input-xlarge form-control">
							<form:option value="" label="请选择人员类型"/>
							<form:options items="${fns:getDictList('sys_user_type')}" itemLabel="label" itemValue="value" htmlEscape="false" />
						</form:select>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>用户角色:</label></td>
					<td class="width-35">
						<form:checkboxes path="roleIdList" items="${allRoles}" itemLabel="name" itemValue="id" htmlEscape="false" class="required form-control i-checks " />
						 <input type="hidden" name="_roleIdList" value="on" /> 
						 <label id="roleIdList-error"	class="error" for="roleIdList"></label>
					 </td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">备注:</label></td>
					<td class="width-35">
						<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="input-xlarge form-control" />
					</td>
					<td class="width-15 active"><label class="pull-right"></label></td>
					<td></td>
				</tr>
				<tr>
					<td class="width-15"><label class="pull-right">创建时间:</label></td>
					<td class="width-35">
						<span class="lbl"> 
							<fmt:formatDate value="${user.createDate}" type="both" dateStyle="full" />
						</span>
					</td>
					<td class="width-15"><label class="pull-right">最后登陆:</label></td>
					<td class="width-35">
						<span class="lbl">${user.oldLoginIp }&nbsp;&nbsp;&nbsp;&nbsp;
							<fmt:formatDate value="${user.loginDate}" type="both"  dateStyle="full" />
						</span>
					</td>
				</tr>
			</tbody>
		</table>
	</form:form>
</body>
</html>