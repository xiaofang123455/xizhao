<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>业务表管理</title>
	<meta name="decorator" content="default"/>
 	<link href="${ctxStatic}/plugins/select2/select2.min.css" rel="stylesheet" />
	<script src="${ctxStatic}/plugins/select2/select2.full.min.js" type="text/javascript"></script>
	<script	src="${ctxStatic}/plugins/validation/1.15.1/jquery.validate.min.js" type="text/javascript"></script>
 	<script src="${ctxStatic}/plugins/validation/1.15.1/localization/messages_zh.min.js"  type="text/javascript"></script>
	<link href="${ctxStatic}/jquery-validation/1.11.0/jquery.validate.min.css" type="text/css" rel="stylesheet" />	
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
	</script>
	<style type="text/css">
		.input-group {
		  display: block;
		  }
		  .form-horizontal .controls {
			margin-left: 180px;
			}
			.form-horizontal .controls {
			text-align: left;
			overflow-x: auto;
			overflow-y: hidden;
			}
			
			.form-horizontal .control-label {
  float: left;
  width: 160px;
  padding-top: 5px;
  text-align: right;
}

.form-horizontal .controls {
  *display: inline-block;
  *padding-left: 20px;
  margin-left: 180px;
  *margin-left: 0;
}
.control-group {padding-bottom:8px;margin-bottom:0;border-bottom:1px dotted #dddddd;} legend + .control-group {margin-top:8px;}
	</style>
</head>
<body>
<div class="wrapper wrapper-content">
		<form:form id="inputForm" modelAttribute="genTable" action="${ctx}/gen/genTable/save" method="post" class="form-horizontal">
			<form:hidden path="id"/>
			<sys:message content="${message}"/>
			<br/>
				<!-- 0:隐藏tip, 1隐藏box,不设置显示全部 -->
				<script type="text/javascript">top.$.jBox.closeTip();</script>
				<br/>
				<div class="control-group">
					<label class="control-label">表名:</label>
					<div class="controls">
						<select class="form-control select2"  name="name" style="width: 100%;">
							<c:forEach items="${tableList}" var="table">
							     <option value="${table.name}">${table.name}:${table.comments}"</option>
							</c:forEach>
						</select>
					</div>
				</div>
			<%-- <table class="table table-bordered  table-condensed dataTables-example dataTable no-footer" style="font-size:13px">
	   			<tbody>
		   			<tr>
			         <td  class=" active"><label class="pull-right">表名:</label></td>
			         <td>
						<div class="input-group">
							<select class="form-control select2"  name="name" style="width: 100%;">
								<c:forEach items="${tableList}" var="table">
								     <option value="${table.name}">${table.name}:${table.comments}"</option>
								</c:forEach>
							</select>
					    </div>
					</td>
			      </tr>
		      </tbody>
		      </table> --%>
			<!-- <div class="control-group">
				<div class="form-actions">
					<input id="btnSubmit" class="btn btn-primary" type="submit" value="下一步"/>&nbsp;
					<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
				</div>
			</div> -->
		</form:form>

	</div>
</body>
</html>
