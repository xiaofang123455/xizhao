<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>菜单管理</title>	
	<meta name="decorator" content="default"/>
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
 			//设置显示隐藏的单选按钮
 			var isShowV=$("#isShowV").val();
 			$("input:radio[value='"+isShowV+"']").attr('checked','true');
 			
		});
		
	</script>

</head>
<body>
	<form:form id="inputForm" class="form-horizontal" action="${ctx}/sys/menu/save" method="post" modelAttribute="menu">
			<form:hidden path="id"/>
	<input id="isShowV" type="hidden" value="${menu.isShow}"/>
		<!-- 0:隐藏tip, 1隐藏box,不设置显示全部 -->
		<script type="text/javascript">top.$.jBox.closeTip();</script>
		<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer" style="font-size:13px">
		   <tbody>
		      <tr>
		         <td  class="width-15 active"><label class="pull-right">上级菜单:</label></td>
		         <td class="width-35" >
		         	<sys:treeselect id="menu" name="parent.id" value="${menu.parent.id}" labelName="parent.name" labelValue="${menu.parent.name}"
					title="菜单" url="/sys/menu/treeData" extId="${menu.id}" cssClass="required"/>
				 </td>
		         <td  class="width-15 active"><label class="pull-right"><font color="red">*</font> 名称:</label></td>
		         <td  class="width-35" ><form:input path="name"   class="required form-control"  maxlength="50"/></td>
		      </tr>
		      <tr>
		         <td  class="width-15 active"><label class="pull-right">链接:</label></td>
		         <td class="width-35" ><form:input id="href" path="href" class="form-control " maxlength="2000"/>
					<span class="help-inline">点击菜单跳转的页面</span></td>
		         <td  class="width-15 active"><label class="pull-right">目标:</label></td>
		         <td  class="width-35" ><form:input id="target" path="target" class="form-control "  maxlength="10"/>
					<span class="help-inline">链接打开的目标窗口，默认：mainFrame</span></td>
		      </tr>
		      <tr>
		         <td  class="width-15 active"><label class="pull-right">图标:</label></td>
		         <td class="width-35" >
		         	<sys:iconselect id="icon" name="icon" value="${menu.icon}"/>
				 </td>
		         <td  class="width-15 active"><label class="pull-right">排序:</label></td>
		         <td  class="width-35" ><form:input path="sort"   class="required digits form-control " maxlength="50"/>
					<span class="help-inline">排列顺序，升序。</span></td>
		      </tr>
		      <tr>
		         <td  class="width-15 active"><label class="pull-right">可见:</label></td>
		         <td class="width-35" >
			         <span>
				         <input id="isShow1" name="isShow" class="required i-checks" type="radio"  value="1"  <c:if test="${menu.isShow eq '1'}">checked="checked"</c:if>/>
				         <label for="isShow1">显示</label>
			         </span>
			         <span>
				         <input id="isShow2" name="isShow" class="required i-checks " type="radio" value="0" <c:if test="${menu.isShow eq '0'}">checked="checked"</c:if>/>
				         <label for="isShow2">隐藏</label>
			         </span> 
					<span class="help-inline">该菜单或操作是否显示到系统菜单中</span></td>
		         <td  class="width-15 active"><label class="pull-right">权限标识:</label></td>
		         <td  class="width-35" ><form:input id="permission" path="permission" class="form-control " maxlength="100"/>
					<span class="help-inline">控制器中定义的权限标识，如：@RequiresPermissions("权限标识")</span></td>
		      </tr>
		      <tr>
		         <td  class="width-15 active"><label class="pull-right">备注:</label></td>
		         <td class="width-35" >
	         	<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="input-xxlarge form-control"/>
		         </td>
		         <td  class="width-15 active"><label class="pull-right"></label></td>
		         <td  class="width-35" ></td>
		      </tr>
		    </tbody>
		  </table>
	</form:form>
</body>
</html>