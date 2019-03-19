<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户管理</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}/common/StringUtil.js" type="text/javascript"></script>
	
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		
		function dosubmit(){
			$("#startYear").val($("#startYear",window.parent.document).val());
			$("#startMonth").val($("#startMonth",window.parent.document).val());
			$("#endYear").val($("#endYear",window.parent.document).val());
			$("#endMonth").val($("#endMonth",window.parent.document).val());
			$("#dwbm").val($("#dwbm",window.parent.document).val().toString());
			if($("#gsxz",window.parent.document).val()!= null){
				$("#gsxz").val($("#gsxz",window.parent.document).val()[0]);
			}else{
				$("#gsxz").val($("#gsxz",window.parent.document).val());
			}
			$("#searchForm").submit();
		}
	</script>
	<style type="text/css">
		.row{
			margin-right:0
		}
		
	</style>
</head>
<body>
<!-- 0:隐藏tip, 1隐藏box,不设置显示全部 -->
<script type="text/javascript">top.$.jBox.closeTip();</script>
	<form id="searchForm" class="form-inline" action="${ctx}/sys/ebitDa/list" method="post">
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				<input id="orderBy" name="orderBy" type="hidden" value="${page.orderBy}"/>
				<input id="startYear" name="startYear" type="hidden" value="${ebitDa.startYear}"/>
				<input id="startMonth" name="startMonth" type="hidden" value="${ebitDa.startMonth}"/>
				<input id="endYear" name="endYear" type="hidden" value="${ebitDa.endYear}"/>
				<input id="endMonth" name="endMonth" type="hidden" value="${ebitDa.endMonth}"/>
				<input id="dwbm" name="dwbm" type="hidden" value="${ebitDa.dwbm}"/>
				<input id="gsxz" name="gsxz" type="hidden" value="${ebitDa.gsxz}"/>
			</form>

	<div class="row" style="margin-right:-15px">
		<div class="col-xs-12">
			<div class="box">
				<div class="box-header">
					<h3 class="box-title" style="font-size: 14px">ebitda收入比表单</h3>
				</div>
				<!-- /.box-header -->
				<div class="box-body">
					<table id="example1"
						class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable"
						style="font-size: 13px; width: 100%">
						<thead>
							<tr>
								<th>单位名称</th>
								<th>单位性质</th>
								<th class="sort-column D_YEAR">年份</th>
								<th class="sort-column D_MONTH">月份</th>
								<th class="sort-column Z_EBITDA">EBITDA</th>
								<th class="sort-column Z_INCOME">经营收入</th>
								<th class="sort-column Z_EBITDA_RATE">EBITDA收入比</th>
							</tr>
						</thead>
						<tbody>
						
				
							<c:forEach items="${page.list}" var="ebitda">
								<tr>
									<td><a href="#"
										onclick="window.parent.onloadRightChart( '','','','',${ebitda.dwbm},'')">${ebitda.dwmc}</a></td>
									<c:if test="${ebitda.gsxz eq 'A'}"><td>股份</td></c:if>
									<c:if test="${ebitda.gsxz eq 'B'}"><td>网资</td></c:if>
									<c:if test="${ebitda.gsxz eq 'C'}"><td>存续</td></c:if>
									<td><a href="#"
										onclick="window.parent.onloadLeftChart(${ebitda.year}, '')">${ebitda.year}</a></td>
									<td>${ebitda.month}</td>
									<td>${ebitda.ebita}</td>
									<td>${ebitda.income}</td>
									<td name="ebitdaRateTd">${ebitda.ebitdaRate}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<div class="pagination">${page}</div>
				</div>
			</div>
		</div>
	</div>
					
				<script type="text/javascript">
					$(document).ready(function() {	
						var ebitdaRateTdArr =  $("td[name='ebitdaRateTd']");
						var breakPoint =$("#breakPoint",window.parent.document).val();
						for(var i = 0;i < ebitdaRateTdArr.length;i++){
							if($(ebitdaRateTdArr[i]).text() > breakPoint){
								$(ebitdaRateTdArr[i]).css("color","#cc5965");
							}
						}
					});
					$(document).ready(function() {
						var orderBy = $("#orderBy").val().split(" ");
						var sortCs=$(".sort-column");
						$.each(sortCs,function(){
						$(this).html($(this).html()+" <i class=\"fa fa-sort\"></i>");});
						$.each(sortCs,function(){
						if ($(this).hasClass(orderBy[0])){
						orderBy[1] = orderBy[1]&&orderBy[1].toUpperCase()=="DESC"?"down":"up";
						$(this).find("i").remove();
						$(this).html($(this).html()+" <i class=\"fa fa-sort-"+orderBy[1]+"\"></i>");
						}
					});
					$(".sort-column").click(function(){
						var order = $(this).attr("class").split(" ");
						var sort = $("#orderBy").val().split(" ");
						for(var i=0; i<order.length; i++){
						if (order[i] == "sort-column"){order = order[i+1]; break;}
								}
							if (order == sort[0]){
								sort = (sort[1]&&sort[1].toUpperCase()=="DESC"?"ASC":"DESC");
								$("#orderBy").val(order+" DESC"!=order+" "+sort?"":order+" "+sort);
							}else{
								$("#orderBy").val(order+" ASC");
								}
								sortOrRefresh();
								});
								});
					
					
					</script>
</body>
</html>