<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>业务表管理</title>
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
				$("input[type=checkbox]").each(function(){
					$(this).after("<input type=\"hidden\" name=\""+$(this).attr("name")+"\" value=\""
							+( $(this).is(':checked')?"1":"0")+"\"/>");
					$(this).attr("name", "_"+$(this).attr("name"));
				});
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
<div class="wrapper wrapper-content">
			<form:form id="inputForm" modelAttribute="genTable" action="${ctx}/gen/genTable/save" method="post" class="form-horizontal">
				<form:hidden path="id"/>
				<sys:message content="${message}"/>
				<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer" style="font-size:13px">
		  			<tbody>	
			  			<tr>
			  				 <td  class=" active"><label class="pull-right">表名:</label></td>
					         <td class="width-35" >
					         	<form:input path="name" htmlEscape="false" maxlength="200" class="form-control required" readonly="true"/>
						    </td>
						    <td  class=" active"><label class="pull-right">说明:</label></td>
					         <td class="width-35" >
					         	<form:input path="comments" htmlEscape="false" maxlength="200" class="form-control required"/>
						    </td>
						     <td  class=" active"><label class="pull-right">类名:</label></td>
					         <td class="width-35" >
					         	<form:input path="className" htmlEscape="false" maxlength="200" class="form-control required"/>
						    </td>
			  			</tr>
			  			<tr>
			  				 <td  class=" active"><label class="pull-right">父表表名:</label></td>
					         <td class="width-35" >
								<select class="form-control select2"  name="parentTable" style="width: 100%;">
									<option value="">无</option>
									<c:forEach items="${tableList}" var="table">
									     <option value="${table.name}" <c:if test="${table.name eq genTable.parentTable}">selected="selected"</c:if>>${table.name}:"${table.comments}"</option>
									</c:forEach>
								</select>
						    </td>
						    <td  class=" active"><label class="pull-right">当前表外键:</label></td>
					         <td class="width-35" >
					         	<select class="form-control select2"  name="parentTableFk" style="width: 100%;">
					         		<option value="">无</option>
									<c:forEach items="${genTable.columnList}" var="table">
									     <option value="${table.name}" <c:if test="${table.name eq genTable.parentTableFk}">selected="selected"</c:if>>${table.name}:"${table.comments}"</option>
									</c:forEach>
								</select>
						    </td>
			  			</tr>
					</tbody>
				</table>
				<div class="control-group">
						<table id="contentTable" class="table table-striped table-bordered table-condensed">
							<thead><tr><th title="数据库字段名">列名</th><th title="默认读取数据库字段备注">说明</th><th title="数据库中设置的字段类型及长度">物理类型</th><th title="实体对象的属性字段类型">Java类型</th>
								<th title="实体对象的属性字段（对象名.属性名|属性名2|属性名3，例如：用户user.id|name|loginName，属性名2和属性名3为Join时关联查询的字段）">Java属性名称 <i class="icon-question-sign"></i></th>
								<th title="是否是数据库主键">主键</th><th title="字段是否可为空值，不可为空字段自动进行空值验证">可空</th><th title="选中后该字段被加入到insert语句里">插入</th>
								<th title="选中后该字段被加入到update语句里">编辑</th><th title="选中后该字段被加入到查询列表里">列表</th>
								<th title="选中后该字段被加入到查询条件里">查询</th><th title="该字段为查询字段时的查询匹配放松">查询匹配方式</th>
								<th title="字段在表单中显示的类型">显示表单类型</th><th title="显示表单类型设置为“下拉框、复选框、点选框”时，需设置字典的类型">字典类型</th><th>排序</th></tr></thead>
							<tbody>
							<c:forEach items="${genTable.columnList}" var="column" varStatus="vs">
								<tr${column.delFlag eq '1'?' class="error" title="已删除的列，保存之后消失！"':''}>
									<td nowrap>
										<input type="hidden" name="columnList[${vs.index}].id" value="${column.id}"/>
										<input type="hidden" name="columnList[${vs.index}].delFlag" value="${column.delFlag}"/>
										<input type="hidden" name="columnList[${vs.index}].genTable.id" value="${column.genTable.id}"/>
										<input type="hidden" name="columnList[${vs.index}].name" value="${column.name}"/>${column.name}
									</td>
									<td>
										<input type="text" name="columnList[${vs.index}].comments" value="${column.comments}" maxlength="200" class="required" style="width:100px;"/>
									</td>
									<td nowrap>
										<input type="hidden" name="columnList[${vs.index}].jdbcType" value="${column.jdbcType}"/>${column.jdbcType}
									</td>
									<td>
										<select name="columnList[${vs.index}].javaType" class="required input-mini" style="width:85px;*width:75px">
											<c:forEach items="${config.javaTypeList}" var="dict">
												<option value="${dict.value}" ${dict.value==column.javaType?'selected':''} title="${dict.description}">${dict.label}</option>
											</c:forEach>
										</select>
									</td>
									<td>
										<input type="text" name="columnList[${vs.index}].javaField" value="${column.javaField}" maxlength="200" class="required input-small"/>
									</td>
									<td>
										<input type="checkbox" class="i-checks" name="columnList[${vs.index}].isPk" value="1" ${column.isPk eq '1' ? 'checked' : ''}/>
									</td>
									<td>
										<input type="checkbox"   class="i-checks" name="columnList[${vs.index}].isNull" value="1" ${column.isNull eq '1' ? 'checked' : ''}/>
									</td>
									<td>
										<input type="checkbox" class="i-checks"  name="columnList[${vs.index}].isInsert" value="1" ${column.isInsert eq '1' ? 'checked' : ''}/>
									</td>
									<td>
										<input type="checkbox"  class="i-checks"  name="columnList[${vs.index}].isEdit" value="1" ${column.isEdit eq '1' ? 'checked' : ''}/>
									</td>
									<td>
										<input type="checkbox" class="i-checks"  name="columnList[${vs.index}].isList" value="1" ${column.isList eq '1' ? 'checked' : ''}/>
									</td>
									<td>
										<input type="checkbox" class="i-checks"  name="columnList[${vs.index}].isQuery" value="1" ${column.isQuery eq '1' ? 'checked' : ''}/>
									</td>
									<td>
										<select name="columnList[${vs.index}].queryType" class="required input-mini">
											<c:forEach items="${config.queryTypeList}" var="dict">
												<option value="${fns:escapeHtml(dict.value)}" ${fns:escapeHtml(dict.value)==column.queryType?'selected':''} title="${dict.description}">${fns:escapeHtml(dict.label)}</option>
											</c:forEach>
										</select>
									</td>
									<td>
										<select name="columnList[${vs.index}].showType" class="required" style="width:100px;">
											<c:forEach items="${config.showTypeList}" var="dict">
												<option value="${dict.value}" ${dict.value==column.showType?'selected':''} title="${dict.description}">${dict.label}</option>
											</c:forEach>
										</select>
									</td>
									<td>
										<input type="text" name="columnList[${vs.index}].dictType" value="${column.dictType}" maxlength="200" class="input-mini"/>
									</td>
									<td>
										<input type="text" name="columnList[${vs.index}].sort" value="${column.sort}" maxlength="200" class="required input-min digits"/>
									</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
					</div>
				<%-- <div class="form-actions">
					<shiro:hasPermission name="gen:genTable:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
					<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
				</div> --%>
			</form:form>
	</div>
</body>
</html>
