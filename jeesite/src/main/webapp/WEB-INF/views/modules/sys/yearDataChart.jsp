<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title></title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}/common/StringUtil.js" type="text/javascript"></script>
	<script src="${ctxStatic}/chart/Chart.js" type="text/javascript"></script>
	<script type="text/javascript">
	$(document).ready(
			function() {
				showYearData('${year}','${dwbm}');
				doyear();
				$("#year").val(2015); 
			});
	
	function doyear(){
		var select = document.getElementById("year");
		var thisYear = new Date().getFullYear();
		var minYear = thisYear-50;
		for(var i=thisYear;i>=minYear;i--){
			var option = document.createElement("option");
			option.value = i;
			option.innerText = i;
			select.appendChild(option);
		}
	}
	
	function showYearData(year,dwbm) {
		if(window.myBar!= undefined || window.myBar != null){
			window.myBar.destroy();
		}
		
		var wealth = [];
		var debt = [];
		var debtRadio = [];
		var xAxes = [];
		var textLabel = '';
		var yearData = Tool_Ajax('${ctx}/sys/ebitDa/showYearDataChart', {
				'dwbm' : dwbm,
				'year' : year
			}, 'json');
		
		var specificData = Tool_Ajax('${ctx}/sys/ebitDa/showSpecificDataChart', {
			'dwbm' : dwbm,
			'year' : year
		}, 'json');
	
		if(yearData.length > 0){
			textLabel = '${dwmc}' +'${year}'+'EBITDA收入比趋势';
		}
		for (var i = yearData.length-1; i >=0; i--) {
			wealth.push(yearData[i].ebita);
			debt.push(yearData[i].income);
			debtRadio.push(yearData[i].ebitdaRate);
			xAxes.push(yearData[i].year+"-"+yearData[i].month);
		}
		var barChartData = {
			labels : xAxes,
			datasets : [
			{
				type : 'bar',
				label : 'ebitada值',
				backgroundColor : "rgba(151,187,205,0.5)",
				data : wealth,
				yAxisID : "y-axis-1"
			},
			 {
				type : 'line',
				label : '比率',
				lineTension : 0,
				fill : false,
				backgroundColor : "rgba(220,220,220,0.5)",
				data : debtRadio,
				borderColor : "rgba(151,187,205,0.5)",
				borderWidth : 2,
				yAxisID : "y-axis-2",
			}, {
				type : 'bar',
				label : '总收入',
				backgroundColor : "rgba(220,220,220,0.5)",
				data : debt,
				yAxisID : "y-axis-1"
			}
			]

		};
		var ctx = document.getElementById("canvas").getContext("2d");
		var barConfig = {
			type : 'bar',
			data : barChartData,
			options : {   
					tooltips: {
              			  mode: 'single',
              			   callbacks: {
              				 afterLabel: function(tooltipItem, data) {
              					//ebitda值
              					if(tooltipItem.datasetIndex == 0){
              						var AEbitda = 'A_'+tooltipItem.xLabel.replace("-","_")+'_'+'ebitda';
              						var BEbitda = 'B_'+tooltipItem.xLabel.replace("-","_")+'_'+'ebitda';
              						var CEbitda = 'C_'+tooltipItem.xLabel.replace("-","_")+'_'+'ebitda';
              						var AEbitdaData = specificData[AEbitda];
              						var BEbitdaData = specificData[BEbitda];
              						var CEbitdaData = specificData[CEbitda];
              						if(!AEbitdaData.isEmpty()){
              							AEbitdaData = "0";
              						}
              						if(!BEbitdaData.isEmpty()){
              							BEbitdaData = "0";
              						}
              						if(!CEbitdaData.isEmpty()){
              							CEbitdaData = "0";
              						}
              						var str = "股份:"+AEbitdaData
              								  +"网资:"+BEbitdaData
              								  +"存续:"+CEbitdaData;
                  					return str;
              					}
              					//总收入
              					if(tooltipItem.datasetIndex == 2){
              						var AIncome = 'A_'+tooltipItem.xLabel.replace("-","_")+'_'+'income';
              						var BIncome = 'B_'+tooltipItem.xLabel.replace("-","_")+'_'+'income';
              						var CIncome = 'C_'+tooltipItem.xLabel.replace("-","_")+'_'+'income';
              						var AIncomeData = specificData[AIncome];
              						var BIncomeData = specificData[BIncome];
              						var CIncomeData = specificData[CIncome];
              						if(!AIncomeData.isEmpty()){
              							AIncomeData = "0";
              						}
              						if(!BIncomeData.isEmpty()){
              							BIncomeData = "0";
              						}
              						if(!CIncomeData.isEmpty()){
              							CIncomeData = "0";
              						}
              						var str = "股份:"+AIncomeData
              								  +"网资:"+BIncomeData
              								  +"存续:"+CIncomeData;
                  					return str;
              					}
              					
              					}
        				}
        			},
					responsive : true,
					legend : {
						position : 'bottom',
					},
					title : {
						display : true,
						text : textLabel
					},
					scales : {
						xAxes : [ {
							display : true,
							position : "bottom",
							scaleLabel : {
								display : true,
							},
						} ],
						yAxes : [ {
							display : true,
							type : "linear",
							display : true,
							position : "left",
							id : "y-axis-1",
							ticks: {
			        			userCallback: function(tick) {
			        				if(tick == 0){
			        					return tick.toString();
			        				}else{
			        					return parseInt(tick/1000000000).toString() + "亿";
			        				}
			        				
			        			}
		        			},
						}, {
							display : true,
							scaleLabel : {
								display : true,
							},
							 ticks : {
								beginAtZero : true
							}, 
							type : "linear",
							display : true,
							position : "right",
							reverse : true,
							id : "y-axis-2",
							gridLines : {
								drawOnChartArea : false, // only want the grid lines for one axis to show up
							},
					} ],
				},
			}
		}
		window.myBar = new Chart(ctx,barConfig);
	};
	
	$(document).ready(function(){
		$('#year').change(function(){
			var year=$(this).children('option:selected').val();//这就是selected的值
			showYearData(year,${dwbm});
			})
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
			<sys:message content="${message}"/>
			<br/>
				<!-- 0:隐藏tip, 1隐藏box,不设置显示全部 -->
				<script type="text/javascript">top.$.jBox.closeTip();</script>
				<br/>
				<div class="control-group" style="padding-left:320px">
					<div class="controls">
						<label class="control-label">年份:</label>
						<select class="form-control select2"  name="year" id="year" style="width: 30%;">
						</select>
					</div> 
				</div>
		<section class="content">
			<div class="row">
				<div class="box box-success" style="padding-left:15px">
					<div class="box-body"  style="padding: 0,height: 230px" >
						<div class="chart">
							<canvas id="canvas"></canvas>
						</div>
					</div>
				</div>
			</div>
		</section>

	</div>
</body>
</html>
