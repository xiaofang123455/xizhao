
/**
 * 导出到excel,只能导出一个sheet
 * type ： 类型，根据当前的图，分为bar,line,pie等等
 * label ： 多为时间，地区,类型等等
 * option : 图的option，通过option拿标题和数据
 */
function exportExcel(type,label,option){
	var axisData = [];
	
	//legend存放的是表格的header,label为第一个header
	var legend = [label];
	//标题
	var title = option.title[0].text;
	//除大标题和小标题外每行第一个单元格的数据
	var axisData = [];
	//excel的数值数据
	var excelData = [];
	var series = option.series;
	
	if(type == 'bar' || type == 'line'){
		//判断使用的坐标轴为x轴还是y轴
	    if(option.xAxis[0].data != undefined && option.xAxis[0].data.length > 0){
	    	axisData = option.xAxis[0].data;
	    }else if(option.yAxis[0].data != undefined && option.yAxis[0].data.length > 0 ){
	    	axisData = option.yAxis[0].data;
	    }
	}else{
		 for(var j=0;j<series[0].data.length;j++){
			 axisData.push(series[0].data[j].name);
		 }
	}
    
	for(var i=0;i<series.length;i++){
		legend.push(series[i].name);
		excelData.push([]);
		 if(!isNaN(series[i].data[0])){
			 for(var j=0;j<series[i].data.length;j++){
				 excelData[i].push(series[i].data[j]);
			 }
   		 }else  if(!isNaN(series[i].data[0].value)){
   			 for(var j=0;j<series[i].data.length;j++){
   				excelData[i].push(series[i].data[j].value);
			 }
   		 }
	}
		
	var map = {};
	map.title = title;
	map.legend = legend;
	map.excelData = excelData;
	map.axisData = axisData;
	return map;
		 
}


/**
 * 导出年和月数据的excel,放在一个表格的两个sheet里面
 * option : 图的option，通过option拿标题和数据
 */
function exportTimeChartExcel(yearsOption,monthsOption){
	
	//legend存放的是表格的header,label为第一个header
	var yearLegend = ['年份'];
	var monthLegend = ['时间'];
	//标题
	var title = yearsOption.title[0].text;
	//除大标题和小标题外每行第一个单元格的数据
	var yearAxisData = [];
	var monthAxisData = [];
	//excel的数值数据
	var yearExcelData = [];
	var monthExcelData = [];
	
	var yearSeries = yearsOption.series;
	var monthSeries = monthsOption.series;
	
	if(yearsOption.xAxis[0].data != undefined && yearsOption.xAxis[0].data.length > 0){
		yearAxisData = yearsOption.xAxis[0].data;
	}else if(yearsOption.yAxis[0].data != undefined && yearsOption.yAxis[0].data.length > 0 ){
		yearAxisData = yearsOption.yAxis[0].data;
	}
	
	for(var i=0;i<yearSeries.length;i++){
		yearLegend.push(yearSeries[i].name);
		yearExcelData.push([]);
		 if(!isNaN(yearSeries[i].data[0])){
			 for(var j=0;j<yearSeries[i].data.length;j++){
				 yearExcelData[i].push(yearSeries[i].data[j]);
			 }
   		 }else  if(!isNaN(yearSeries[i].data[0].value)){
   			 for(var j=0;j<yearSeries[i].data.length;j++){
   				yearExcelData[i].push(yearSeries[i].data[j].value);
			 }
   		 }
	}
	
	
	if(monthsOption.xAxis[0].data != undefined && monthsOption.xAxis[0].data.length > 0){
		monthAxisData = monthsOption.xAxis[0].data;
	}else if(monthsOption.yAxis[0].data != undefined && monthsOption.yAxis[0].data.length > 0 ){
		monthAxisData = monthsOption.yAxis[0].data;
	}
	  

	for(var i=0;i<monthSeries.length;i++){
		monthLegend.push(monthSeries[i].name);
		monthExcelData.push([]);
		 if(!isNaN(monthSeries[i].data[0])){
			 for(var j=0;j<monthSeries[i].data.length;j++){
				 monthExcelData[i].push(monthSeries[i].data[j]);
			 }
   		 }else  if(!isNaN(monthSeries[i].data[0].value)){
   			 for(var j=0;j<monthSeries[i].data.length;j++){
   				monthExcelData[i].push(monthSeries[i].data[j].value);
			 }
   		 }
	}
	
	var map = {};
	
	//年份数据
	var yearMap = {};
	yearMap.title = title;
	yearMap.excelData = yearExcelData;
	yearMap.legend = yearLegend;
	yearMap.axisData = yearAxisData;

	//月份数据
	var monthMap = {};
	monthMap.title = title;
	monthMap.excelData = monthExcelData;
	monthMap.legend = monthLegend;
	monthMap.axisData = monthAxisData;
	
	map.yearMap = yearMap;
	map.monthMap = monthMap;

	return map;
		 
}

/**
 * 导出到excel,只能导出一个sheet
 * ctx：前缀
 * type ： 类型，根据当前的图，分为bar,line,pie等等
 * label ： 多为时间，地区,类型等等
 * chart : 该图表（补：当前这个图表只能拿到页面默认进来时，onclick中直接有chart可以使用，相当于说这个chart当前是无用的）
 */
function myExcel(ctx,chart,type,label){
	var myExcel = {
		    show: true,
		    title: '导出excel',
				icon: symbols.excel,
				iconStyle:{
					normal:{
						borderColor :'rgb(46,139,87)',
						borderWidth :1
					},
					emphasis:{
						borderColor :'rgb(46,139,87)',
						borderWidth :1
					}
				},
				onclick: function (currchart){
					var option=currchart.getOption();
					var map = exportExcel(type,label,option);
					document.location.href=ctx+"/exportExcelUtil/expertExcel?map="+JSON.stringify(map);
		    }
		};
	return myExcel;
}


/**
 * 导出到时间图表excel,可以导出年数据和月数据两个sheet
 * ctx：前缀
 * 注意点：myTimeExcel1和myTimeExcel2都是都出时间图表，
 * 		  但是myTimeExcel1在方法体里面有调用handleTimeData(),
 * 		  myTimeExcel2没有,根据jsp页面refreshTimeChart()前是否
 * 		  需要调用handleTimeData()，来判断使用哪种方法。
 */
function myTimeExcel1(ctx){
	var myExcel = {
	        show: true,
	        title: '导出excel',
	   		icon: symbols.excel,
	   		iconStyle:{
				normal:{
					borderColor :'rgb(46,139,87)',
					borderWidth :1
				},
				emphasis:{
					borderColor :'rgb(46,139,87)',
					borderWidth :1
				}
			},
			onclick: function (){
				if(isMonth){
					//月份数据
					var monthOption = timeChart.getOption();
					isMonth = false;
					handleTimeData();
    			    refreshTimeChart();
    			    //年份数据
					var yearOption = timeChart.getOption();
					isMonth = true;
					handleTimeData();
    			    refreshTimeChart();
					var map = exportTimeChartExcel(yearOption,monthOption);
   				document.location.href=ctx+"/exportExcelUtil/exportTimeChartExcel?yearMap="+JSON.stringify(map.yearMap)+"&monthMap="+JSON.stringify(map.monthMap);
            
				}else{
					//年份数据
					var yearOption = timeChart.getOption();
					isMonth = true;
					handleTimeData();
    			    refreshTimeChart();
    			    //月份数据
					var monthOption = timeChart.getOption();
					isMonth = false;
					handleTimeData();
    			    refreshTimeChart();
					var map = exportTimeChartExcel(yearOption,monthOption);
					document.location.href=ctx+"/exportExcelUtil/exportTimeChartExcel?yearMap="+JSON.stringify(map.yearMap)+"&monthMap="+JSON.stringify(map.monthMap);
				}
			}
	    };
	return myExcel;
}

/**
 * 导出到时间图表excel,可以导出年数据和月数据两个sheet
 * ctx：前缀
 * 注意点：myTimeExcel1和myTimeExcel2都是都出时间图表，
 * 		  但是myTimeExcel1在方法体里面有调用handleTimeData(),
 * 		  myTimeExcel2没有,根据jsp页面refreshTimeChart()前是否
 * 		  需要调用handleTimeData()，来判断使用哪种方法。
 */
function myTimeExcel2(ctx){
	var myExcel =  {
	    show: true,
	    title: '导出excel',
			icon: symbols.excel,
			iconStyle:{
				normal:{
					borderColor :'rgb(46,139,87)',
					borderWidth :1,
				},
				emphasis:{
					borderColor :'rgb(46,139,87)',
					borderWidth :1,
				}
			},
			onclick: function (){
				if(isMonth){
					//月份数据
					var monthOption = timeChart.getOption();
					isMonth=false;
					refreshTimeChart(years);
					//年份数据
					var yearOption = timeChart.getOption();
					isMonth=true;
					refreshTimeChart(months);
					var map = exportTimeChartExcel(yearOption,monthOption);
					document.location.href=ctx+"/exportExcelUtil/exportTimeChartExcel?yearMap="+JSON.stringify(map.yearMap)+"&monthMap="+JSON.stringify(map.monthMap);
				}else{
					//年份数据
					var yearOption = timeChart.getOption();
					isMonth=true;
					refreshTimeChart(months);
					//月份数据
					var monthOption = timeChart.getOption();
					isMonth=false;
					refreshTimeChart(years);
					var map = exportTimeChartExcel(yearOption,monthOption);
					document.location.href=ctx+"/exportExcelUtil/exportTimeChartExcel?yearMap="+JSON.stringify(map.yearMap)+"&monthMap="+JSON.stringify(map.monthMap);
	        
				}
			}
	};
return myExcel;
}
/*function exportTimeChartExcel(option,years,months){
	var axisData = [];
	
	//legend存放的是表格的header,label为第一个header
	var yearLegend = ['年份'];
	var monthLegend = ['时间'];
	//标题
	var title = option.title[0].text;
	//除大标题和小标题外每行第一个单元格的数据
	var yearAxisData = [];
	var monthAxisData = [];
	//excel的数值数据
	var yearExcelData = [];
	var monthExcelData = [];
	var series = option.series;
	
	if(series.length == 1){
		 for(var j=0;j<series.length;j++){
			 yearLegend.push(series[j].name);
			 monthLegend.push(series[j].name);
		 }
		 
		for(var i=0;i<years.length;i++){
			yearAxisData.push(years[i].year);
			yearExcelData.push(years[i].idValue);
		}
		for(var i=0;i<months.length;i++){
			monthAxisData.push(months[i].year+'年'+months[i].month+'月');
			monthExcelData.push(months[i].idValue);
		}
		monthExcelData = [monthExcelData];
		yearExcelData = [yearExcelData];
	}else{
		for(var i=0;i<series.length;i++){
			 yearLegend.push(series[j].name);
			 monthLegend.push(series[j].name);
			 yearExcelData.push([]);
			 monthExcelData.push([]);
			 for(var j=0;j<years[i].length;j++){
				 if(i == 0){
					 yearAxisData.push(years[i][j].year);
				 }
				 yearExcelData[i].push(years[i][j]);
			 }
			 
			 for(var j=0;j<months[i].length;j++){
				 if(i == 0){
					monthAxisData.push(months[i].year+'年'+months[i].month+'月');
				 }
				 monthExcelData[i].push(months[i][j]);
			 }
		}
	}
	
	var map = {};
	
	//年份数据
	var yearMap = {};
	yearMap.title = title;
	yearMap.excelData = yearExcelData;
	yearMap.legend = yearLegend;
	yearMap.axisData = yearAxisData;

	//月份数据
	var monthMap = {};
	monthMap.title = title;
	monthMap.excelData = monthExcelData;
	monthMap.legend = monthLegend;
	monthMap.axisData = monthAxisData;
	
	map.yearMap = yearMap;
	map.monthMap = monthMap;

	return map;
		 
}*/