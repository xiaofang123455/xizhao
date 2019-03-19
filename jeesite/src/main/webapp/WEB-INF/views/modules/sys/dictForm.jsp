<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>字典管理</title>
<meta name="decorator" content="default"/>

<script type="text/javascript">
	var validateForm;
	function doSubmit() {//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
		if (validateForm.form()) {
			$("#inputForm").submit();
			return true;
		}
		return false;
	}

	$(document).ready(function() {
		$("#type").focus();
		//list页面工具栏的添加，保证类型不为空
		$("#type").blur(function(){
			var lable=$(this).parent("td").children("label[class='error']");
			if($(lable).length>0){
				if($(this).val()==""){
					$(this).parent("td").children("label[class='error']").text("请先填写类型");
	                $(this).focus();
				}else{
					$(this).parent("td").children("label[class='error']").remove();
				}
			}else{
				if($(this).val()==""){
					$(this).parent("td").append('<label id="value-error" class="error" for="value">请先填写类型</label>');
	                $(this).focus();
				}
			}
		});
		validateForm = $("#inputForm").validate({
			focusInvalid:true,
			 rules: {
				 label: {
					 remote : {
						 depends : function(element) {  //如果类型不为空，触发验证事件
                             return $("#type").val() != "";  
                         },  
                         param : {  //后台处理程序
                        	url: "${ctx}/sys/dict/checkLabelByType",     //后台处理程序
 						    type: "post",               //数据发送方式
 						    dataType: "json",           //接受数据格式   
 						    data: {                     //要传递的数据
 						    	oldLabel:'${dict.label}',
 						    	type: function() {
 						    		var returnValue="${dict.type}";
 						    		if(returnValue==''){
 						    			returnValue=$("#type").val();
 						    		}
 						            return returnValue;
 						        }
 						    }  
                         }
                     }
				 },//设置了远程验证，在初始化时必须预先调用一次。
				 value: {
					 remote : {
						 depends : function(element) {  //如果类型不为空，触发验证事件
							 
							 return $("#type").val() != "";  
                         },
                         param : {  //后台处理程序
                        	url: "${ctx}/sys/dict/checkValueByType",     
 						    type: "post",               //数据发送方式
 						    dataType: "json",           //接受数据格式   
 						    data: {                     //要传递的数据
 						    	oldValue :encodeURIComponent('${dict.value}'),
 						    	type: function() {
 						    		var returnValue="${dict.type}";
 						    		if(returnValue==''){
 						    			returnValue=$("#type").val();
 						    		}
 						            return returnValue;
 						        }
 						    }  
                         }
                       },
				 }
			 },
			messages: {
				label: {remote: "标签名已存在"},
				value: {remote: "键值已存在"},
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
		//$("#inputForm").validate().element($("#label"));
		//$("#inputForm").validate().element($("#value"));
	});

</script>
</head>
<body>
	<form:form id="inputForm" modelAttribute="dict" action="${ctx}/sys/dict/save" method="post" class="form-horizontal"> 
		<form:hidden path="id"/>
		<sys:message content="${message}" />
		<!-- 0:隐藏tip, 1隐藏box,不设置显示全部 -->
		<script type="text/javascript">
			top.$.jBox.closeTip();
		</script>
		<table
			class="table table-bordered  table-condensed dataTables-example dataTable no-footer"
			style="font-size: 13px">
			<tbody>
				<tr>
					<td class="width-15 active">
						<label class="pull-right"><font color="red">*</font>类型:</label>
					</td>
					<td class="width-35">
						<form:input path="type" class="form-control required " maxlength="50" />
					</td>
					<td class="width-15 active">
						<label class="pull-right"><font color="red">*</font>键值:</label>
					</td>
					<td class="width-35">
						<input id="oldValue" name="oldValue" type="hidden" value="${dict.value}"> 
						<form:input path="value" class="form-control required " maxlength="70" />
					</td>
					
				</tr>

				<tr>
					<td class="width-15 active">
						<label class="pull-right"><font color="red">*</font>标签:</label>
					</td>
					<td class="width-35">
						<input id="oldLabel" name="oldLabel" type="hidden" value="${dict.label}"> 
						<form:input  path="label" class="form-control required " maxlength="70"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font
							color="red">*</font>描述:</label></td>
					<td class="width-35"><form:input path="description"
							class="form-control required " maxlength="50" /></td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font
							color="red">*</font>排序:</label></td>
					<td class="width-35"><form:input path="sort"
							class="form-control required " maxlength="50" /></td>
					<td class="width-15 active"><label class="pull-right">备注:</label></td>
					<td class="width-35"><form:textarea id="remarks"
							class="form-control" rows="3" maxlength="200" path="remarks" /></td>
				</tr>
			</tbody></table>
			</form:form>
</body>
</html>