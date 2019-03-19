/*!
 * 图表dataview自定义的方法，根据不同的图表进行命名
 * 每个图表对应两个方法，一个是optionToContent,一个是contentToOption
 * @author zxy
 * @date 2016-12-9
 */
/**********************矩形图******************begin****************/
//矩形图的dataview自定义方法optionToContent
function otcBar(xName,opt){
    var series = opt.series;//数据
    var axisData = [];//坐标轴
    var inputPercent = 0  //input输入框百分比
    
    inputPercent =  Math.round(100/((series.length+1)*2)*100)/100;
    
    //判断使用的坐标轴为x轴还是y轴
    if(opt.xAxis[0].data != undefined && opt.xAxis[0].data.length > 0){
    	axisData = opt.xAxis[0].data;
    }else if(opt.yAxis[0].data != undefined && opt.yAxis[0].data.length > 0 ){
    	axisData = opt.yAxis[0].data;
    }
   
   //样式
    var table ='<style type="text/css">table.gridtable {font-family: verdana,arial,sans-serif;font-size:11px;color:#333333;border-width: 1px;border-color: #666666;border-collapse: collapse;width:100%;}'
    +'table.gridtable th {border-width: 1px;border-style: solid;border-color: #666666;text-align:center;}'
    +' table.gridtable td {border-width: 1px;border-style: solid;border-color: #666666;text-align:center;}'
    +' input{width:100%;text-align:center;border:1px;}'
    +'table tr:nth-child(odd){background-color:#d4e3e5;}table tr:nth-child(even){background:#c3dde0;}</style>';
    
    //如果只有各个series都只有一条数据,那就不分两行显示
    var flag = true;
    for(var i = 0; i < series.length; i = i+1){
		 if(series[i].data.length > 1){
			 flag = false;
		 }
	 }
    if(flag){
        table += '<table class="gridtable" ><tr>';
   		table+= '<th>'+xName+'</th>';
   		 for(var i = 0; i < series.length; i = i+1){
   			 table+='<th>' + series[i].name + '</th>';
   		 }
        table+= '</tr>';
        table += '<tr>';
    	table += '<td  style="width:'+inputPercent*2+'%" >' + axisData[0] + '</td>';
        for(var i = 0; i < series.length; i = i+1){
    		if(series[i].data[0]!='undefined'&&series[i].data[0]!=undefined){
				 if(!isNaN(series[i].data[0])){
	       			 table+= '<td style="width:'+inputPercent*2+'%" > <input  type="text" value="' + series[i].data[0] + '"/></td>';
	       		 }else  if(!isNaN(series[i].data[0].value)){
	       			 table+= '<td style="width:'+inputPercent*2+'%" > <input type="text" value="' + series[i].data[0].value + '"/></td>';
	       		 }
			}else{
				 table+= '<td style="width:'+inputPercent*2+'%" > <input type="text" value="0"/></td>';
			}
  		 }
        table += '</tr></table>'
        	return table;
    }
    
    //标题
    table += '<table class="gridtable" ><tr>';
	 for(var k=0;k<2;k++){
		 table+= '<th>'+xName+'</th>';
		 for(var i = 0; i < series.length; i = i+1){
			 table+='<th>' + series[i].name + '</th>';
		 }
	 }
     table+= '</tr>';
     //内容
     var length=1;
      for(var j=0;j<series.length; j = j+1){
    	  if(length<series[j].data.length){
    		  length=series[j].data.length;
    	  }
      }
	 for (var i = 0, l = length; i < l; i = i+2) {
	        table += '<tr>';
        	table += '<td  style="width:'+inputPercent+'%" >' + axisData[i] + '</td>';
    		for(var j=0;j<series.length; j = j+1){
    			if(series[j].data[i]!='undefined'&&series[j].data[i]!=undefined){
    				 if(!isNaN(series[j].data[i])){
            			 table+= '<td style="width:'+inputPercent+'%" > <input  type="text" value="' + series[j].data[i] + '"/></td>';
            		 }else  if(!isNaN(series[j].data[i].value)){
            			 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value="' + series[j].data[i].value + '"/></td>';
            		 }else{
            			 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value=查无数据></td>';
            		 }
    			}else{
    				 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value="0"/></td>';
    			}
    	      }
    		if(i<length-1){
    			table += '<td style="width:'+inputPercent+'%" >' + axisData[i+1] + '</td>'
            	for(var j=0;j<series.length; j = j+1){
	            		if(series[j].data[i+1]!='undefined'&&series[j].data[i+1]!=undefined){
		       				 if(!isNaN(series[j].data[i+1])){
		               			 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value="' + series[j].data[i+1] + '"/></td>';
		               		 }else  if(!isNaN(series[j].data[i+1].value)){
		               			 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value="' + series[j].data[i+1].value + '"/></td>';
		               		 }else{
		               			 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value=查无数据></td>';
		               		 }
		       			}else{
		       				 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value="0"/></td>';
		       			}
        	      }
    		}
	       table += '</tr>';
    }
    table += '</table>';
    return table;
}

/*
 * 矩形图的dataview自定义方法optionToContent，之前是一行显示两个数据，
       但是由于有些legened过多，导致每一个值的td宽度太小，值显示不全
**/
function otcOneLineBar(xName,opt){
    var series = opt.series;//数据
    var axisData = [];//坐标轴
    var inputPercent = 0  //input输入框百分比
    
    inputPercent =  Math.round(100/(series.length+1)*100)/100;
    
    //判断使用的坐标轴为x轴还是y轴
    if(opt.xAxis[0].data != undefined && opt.xAxis[0].data.length > 0){
    	axisData = opt.xAxis[0].data;
    }else if(opt.yAxis[0].data != undefined && opt.yAxis[0].data.length > 0 ){
    	axisData = opt.yAxis[0].data;
    }
   
   //样式
    var table ='<style type="text/css">table.gridtable {font-family: verdana,arial,sans-serif;font-size:11px;color:#333333;border-width: 1px;border-color: #666666;border-collapse: collapse;width:100%;}'
    +'table.gridtable th {border-width: 1px;border-style: solid;border-color: #666666;text-align:center;}'
    +' table.gridtable td {border-width: 1px;border-style: solid;border-color: #666666;text-align:center;}'
    +' input{width:100%;text-align:center;border:1px;}'
    +'table tr:nth-child(odd){background-color:#d4e3e5;}table tr:nth-child(even){background:#c3dde0;}</style>';
    
    
    //标题
    table += '<table class="gridtable" ><tr>';
	 table+= '<th>'+xName+'</th>';
	 for(var i = 0; i < series.length; i = i+1){
		 table+='<th>' + series[i].name + '</th>';
	 }
     table+= '</tr>';
     
     
     //内容
     var length=1;
      for(var j=0;j<series.length; j = j+1){
    	  if(length<series[j].data.length){
    		  length=series[j].data.length;
    	  }
      }
      for (var i = 0, l = length; i < l; i = i+1) {
	     table += '<tr>';
      	table += '<td  style="width:'+inputPercent+'%" >' + axisData[i] + '</td>';
  		for(var j=0;j<series.length; j = j+1){
  			if(series[j].data[i]!='undefined'&&series[j].data[i]!=undefined){
  				 if(!isNaN(series[j].data[i])){
          			 table+= '<td style="width:'+inputPercent+'%" > <input  type="text" value="' + series[j].data[i] + '"/></td>';
          		 }else  if(!isNaN(series[j].data[i].value)){
          			 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value="' + series[j].data[i].value + '"/></td>';
          		 }else{
          			 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value=查无数据></td>';
          		 }
  			}else{
  				 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value="0"/></td>';
  			}
  	      }
  }
  table += '</table>';
    return table;
}


/*
 * 	只显示前面两个series的方法
**/
function otcTwoSeriesBar(xName,opt){
    var series = opt.series;//数据
    
    //取前两个series
    var tempSeries = [];
    for(var i = 0; i < 2; i = i+1){
    	tempSeries.push(series[i]);
    }
    series = tempSeries;
    
inputPercent =  Math.round(100/((series.length+1)*2)*100)/100;
    
    //判断使用的坐标轴为x轴还是y轴
    if(opt.xAxis[0].data != undefined && opt.xAxis[0].data.length > 0){
    	axisData = opt.xAxis[0].data;
    }else if(opt.yAxis[0].data != undefined && opt.yAxis[0].data.length > 0 ){
    	axisData = opt.yAxis[0].data;
    }
   
   //样式
    var table ='<style type="text/css">table.gridtable {font-family: verdana,arial,sans-serif;font-size:11px;color:#333333;border-width: 1px;border-color: #666666;border-collapse: collapse;width:100%;}'
    +'table.gridtable th {border-width: 1px;border-style: solid;border-color: #666666;text-align:center;}'
    +' table.gridtable td {border-width: 1px;border-style: solid;border-color: #666666;text-align:center;}'
    +' input{width:100%;text-align:center;border:1px;}'
    +'table tr:nth-child(odd){background-color:#d4e3e5;}table tr:nth-child(even){background:#c3dde0;}</style>';
    
    //如果只有各个series都只有一条数据,那就不分两行显示
    var flag = true;
    for(var i = 0; i < series.length; i = i+1){
		 if(series[i].data.length > 1){
			 flag = false;
		 }
	 }
    if(flag){
        table += '<table class="gridtable" ><tr>';
   		table+= '<th>'+xName+'</th>';
   		 for(var i = 0; i < series.length; i = i+1){
   			 table+='<th>' + series[i].name + '</th>';
   		 }
        table+= '</tr>';
        table += '<tr>';
    	table += '<td  style="width:'+inputPercent*2+'%" >' + axisData[0] + '</td>';
        for(var i = 0; i < series.length; i = i+1){
    		if(series[i].data[0]!='undefined'&&series[i].data[0]!=undefined){
				 if(!isNaN(series[i].data[0])){
	       			 table+= '<td style="width:'+inputPercent*2+'%" > <input  type="text" value="' + series[i].data[0] + '"/></td>';
	       		 }else  if(!isNaN(series[i].data[0].value)){
	       			 table+= '<td style="width:'+inputPercent*2+'%" > <input type="text" value="' + series[i].data[0].value + '"/></td>';
	       		 }
			}else{
				 table+= '<td style="width:'+inputPercent*2+'%" > <input type="text" value="0"/></td>';
			}
  		 }
        table += '</tr></table>'
        	return table;
    }
    
    //标题
    table += '<table class="gridtable" ><tr>';
	 for(var k=0;k<2;k++){
		 table+= '<th>'+xName+'</th>';
		 for(var i = 0; i < series.length; i = i+1){
			 table+='<th>' + series[i].name + '</th>';
		 }
	 }
     table+= '</tr>';
     //内容
     var length=1;
      for(var j=0;j<series.length; j = j+1){
    	  if(length<series[j].data.length){
    		  length=series[j].data.length;
    	  }
      }
	 for (var i = 0, l = length; i < l; i = i+2) {
	        table += '<tr>';
        	table += '<td  style="width:'+inputPercent+'%" >' + axisData[i] + '</td>';
    		for(var j=0;j<series.length; j = j+1){
    			if(series[j].data[i]!='undefined'&&series[j].data[i]!=undefined){
    				 if(!isNaN(series[j].data[i])){
            			 table+= '<td style="width:'+inputPercent+'%" > <input  type="text" value="' + series[j].data[i] + '"/></td>';
            		 }else  if(!isNaN(series[j].data[i].value)){
            			 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value="' + series[j].data[i].value + '"/></td>';
            		 }else{
            			 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value=查无数据></td>';
            		 }
    			}else{
    				 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value="0"/></td>';
    			}
    	      }
    		if(i<length-1){
    			table += '<td style="width:'+inputPercent+'%" >' + axisData[i+1] + '</td>'
            	for(var j=0;j<series.length; j = j+1){
	            		if(series[j].data[i+1]!='undefined'&&series[j].data[i+1]!=undefined){
		       				 if(!isNaN(series[j].data[i+1])){
		               			 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value="' + series[j].data[i+1] + '"/></td>';
		               		 }else  if(!isNaN(series[j].data[i+1].value)){
		               			 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value="' + series[j].data[i+1].value + '"/></td>';
		               		 }else{
		               			 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value=查无数据></td>';
		               		 }
		       			}else{
		       				 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value="0"/></td>';
		       			}
        	      }
    		}
	       table += '</tr>';
    }
    table += '</table>';
    return table;
}

function ctoBar(HTMLDomElement,option){
	var nodes = HTMLDomElement.getElementsByTagName("input");
	var series = option.series;//数据
	var seriesLength=series.length;
	
	for(var k=0;k<seriesLength;k++){
		option.series[k].data=[];
	}
	
	for(var i=0;i<nodes.length;i++){
		if(nodes[i].value == "查无数据"){
			option.series[i%seriesLength].data.push(undefined);
		}else if(!isNaN(parseInt(nodes[i].value))){
			var nodeValue=parseInt(nodes[i].value);
			option.series[i%seriesLength].data.push(nodeValue);
		}
	}
	return option;
}


/*
 * 	专属湖北审计-积分管理-积分计提分析的方法
**/
function ctoJFJTBar(HTMLDomElement,option){
	var nodes = HTMLDomElement.getElementsByTagName("input");
	var series = option.series;//数据
	var seriesLength=series.length;
	
	for(var k=0;k<seriesLength;k++){
		option.series[k].data=[];
	}
	
	for(var i=0;i<nodes.length;i++){
		if(nodes[i].value == "查无数据"){
			option.series[i%2].data.push(undefined);
		}else if(!isNaN(parseInt(nodes[i].value))){
			var nodeValue=parseInt(nodes[i].value);
			option.series[i%2].data.push(nodeValue);
		}
	}
	//data1是新增积分的数据
	var data1= option.series[0].data;
	//data2是失效积分的数据
	var data2= option.series[1].data;
	//data辅助用的series
	var data=[];
	for(var i=0;i<data1.length;i++){
		if(data1[i]<data2[i]){
			data.push(data1[i])
		}else{
			data.push(data2[i])
		}
	}
	option.series[2].data = data;
	return option;
}

/**********************矩形图******************end****************/


/**********************地图******************begin****************/
function otcMap(xName,opt){
    var series = opt.series;
    var legend=opt.legend[0];
    var k;
    var seriesName="";
    if(legend==undefined || legend.data.length==1){
    	k=0;
    }else{
    	var legendSelected=opt.legend[0].selected;
    	for(var j=0;j<series.length;j++){
        	seriesName=series[j].name;
        	for(var key in legendSelected){
        		if(legendSelected[key] && key==seriesName){
        			k=j;
        			break;
        		}
        	};
        	if(!isNaN(k)){
        		break;
        	};
        };
    }
   
    
    var data = [];
    //数据过滤
    for (var i = 0, l = series[k].data.length; i < l; i = i+1) {
	    if(!isNaN(series[k].data[i].value) &&  series[k].data[i].name != undefined &&  series[k].data[i].name != 'undefined'){
	    	data.push(series[k].data[i]);
	    }
    }
    //样式
    var table ='<style type="text/css">table.gridtable {font-family: verdana,arial,sans-serif;font-size:11px;color:#333333;border-width: 1px;border-color: #666666;border-collapse: collapse;width:100%;}'
        +'table.gridtable th {border-width: 1px;border-style: solid;border-color: #666666;text-align:center;}'
        +' table.gridtable td {border-width: 1px;border-style: solid;border-color: #666666;text-align:center;}'
        +' input{width:100%;text-align:center;border:1px;}'
        +'table tr:nth-child(odd){background-color:#d4e3e5;}table tr:nth-child(even){background:#c3dde0;}</style>';
    //标题

    
   
    //如果数据只有一个
    if(data.length == 1){
        table += '<table class="gridtable" >'
			 + '<tr>'
			 +'<th align="center">'+xName+'</th>'
            + '<th align="center">' + series[k].name + '</th>'
            + '</tr>';
        //内容
        table += '<tr>';
    	table += '<td  style="width:50%">' + data[0].name + '</td>'
             + '<td  style="width:50%"><input type="text" name="'+data[0].name+'" value="' + data[0].value + '"';
    	if(data[0].procode = 'undefined'&& data[0].procode!=undefined){
    		table += 'procode ="'+data[0].procode+'" /></td>';
    	}else{
    		table += 'orgcode ="'+data[0].orgcode+'" /></td>';
    	}
      	table += '</tr>';
        table += '</table>';
        return table;
    }
    
    
    
    //如果数据只有两个
    if(data.length == 2){
        table += '<table class="gridtable" >'
			 + '<tr>'
			 +'<th align="center">'+xName+'</th>'
            + '<th align="center">' + series[k].name + '</th>'
            +'<th align="center">'+xName+'</th>'
            + '<th align="center">' + series[k].name + '</th>'
            + '</tr>';
        //内容
        for (var i = 0, l = data.length; i < l; i = i+2) {
    	        table += '<tr>';
    	        if(i < data.length){
    	        	table += '<td  style="width:25.00%">' + data[i].name + '</td>'
    	                 + '<td  style="width:25.00%"><input type="text" name="'+data[i].name+'" value="' + data[i].value + '"';
    	        	if(data[i].procode = 'undefined'&& data[i].procode!=undefined){
    	        		table += 'procode ="'+data[i].procode+'" /></td>';
    	        	}else{
    	        		table += 'orgcode ="'+data[i].orgcode+'" /></td>';
    	        	}
    	    	}
    	        if(i+1 < data.length && !isNaN(data[i+1].value) && data[i+1].name != undefined && data[i+1].name != 'undefined'){
    	        	table += '<td  style="width:25.00%">' + data[i+1].name + '</td>'
    	        		+ '<td  style="width:25.00%"><input type="text" name="'+data[i+1].name+'" value="' + data[i+1].value + '"';
    	        	if(data[i+1].procode = 'undefined'&& data[i+1].procode!=undefined){
    	        		table += 'procode ="'+data[i+1].procode+'" /></td>';
    	        	}else{
    	        		table += 'orgcode ="'+data[i+1].orgcode+'" /></td>';
    	        	}
    	    	}
    	      	table += '</tr>';
        }
        table += '</table>';
        return table;
    }
    
    
    //如果数据只有三个以上
    table += '<table class="gridtable" >'
    			 + '<tr>'
    			 +'<th align="center">'+xName+'</th>'
                 + '<th align="center">' + series[k].name + '</th>'
                 +'<th align="center">'+xName+'</th>'
                 + '<th align="center">' + series[k].name + '</th>'
                 +'<th align="center">'+xName+'</th>'
                 + '<th align="center">' + series[k].name + '</th>'
                 + '</tr>';
    //内容
    for (var i = 0, l = data.length; i < l; i = i+3) {
	        table += '<tr>';
	        if(i < data.length){
	        	table += '<td  style="width:16.67%">' + data[i].name + '</td>'
	                 + '<td  style="width:16.67%"><input type="text" name="'+data[i].name+'" value="' + data[i].value + '"';
	        	if(data[i].procode = 'undefined'&& data[i].procode!=undefined){
	        		table += 'procode ="'+data[i].procode+'" /></td>';
	        	}else{
	        		table += 'orgcode ="'+data[i].orgcode+'" /></td>';
	        	}
	    	}
	        if(i+1 < data.length && !isNaN(data[i+1].value) && data[i+1].name != undefined && data[i+1].name != 'undefined'){
	        	table += '<td  style="width:16.67%">' + data[i+1].name + '</td>'
	        		+ '<td  style="width:16.67%"><input type="text" name="'+data[i+1].name+'" value="' + data[i+1].value + '"';
	        	if(data[i+1].procode = 'undefined'&& data[i+1].procode!=undefined){
	        		table += 'procode ="'+data[i+1].procode+'" /></td>';
	        	}else{
	        		table += 'orgcode ="'+data[i+1].orgcode+'" /></td>';
	        	}
	    	}
	        if(i+2 < data.length && !isNaN(data[i+2].value) && data[i+2].name != undefined && data[i+2].name != 'undefined'){
	        	table += '<td  style="width:16.67%">' + data[i+2].name + '</td>'
                	+ '<td  style="width:16.67%"><input type="text" name="'+data[i+2].name+'" value="' + data[i+2].value + '"';
	        	if(data[i+2].procode = 'undefined'&& data[i+2].procode!=undefined){
	        		table += 'procode ="'+data[i+2].procode+'" /></td>';
	        	}else{
	        		table += 'orgcode ="'+data[i+2].orgcode+'" /></td>';
	        	}
	    	}
	      	table += '</tr>';
    }
    table += '</table>';
  return table;
}

function ctoMap(HTMLDomElement,option){
	
	var k = 0;//selected的index
	var seriesName = '';
	var series = option.series;
	var legendSelected=option.legend[0].selected;
	for(var j=0;j<series.length;j++){
    	seriesName=series[j].name;
    	for(var key in legendSelected){
    		if(legendSelected[key] && key==seriesName){
    			k=j;
    			break;
    		}
    	};
    };
	
    
 	var nodes = HTMLDomElement.getElementsByTagName("input");
	var data = [];
	var max = nodes[0].value,min = nodes[0].value;
	for(var i=0;i<nodes.length;i++){
		var nodeValue=parseInt(nodes[i].value);
		if(max < nodeValue){
			max = nodeValue;
		}
		if(min > nodeValue){
			min = nodeValue;
		}
		data.push({name:nodes[i].getAttribute("name"),value:nodeValue,procode:nodes[i].getAttribute("procode")});
	}
	//让最大值和最小值的标志不重合
	if(max == min){
		min = 0;
	}
	option.series[k].data = data;
	if(option.visualMap[k] == undefined || option.visualMap[k] == 'undefined'){
		k = 0;
	}
	var visualMapType= option.visualMap[k].type;
	if(visualMapType=='piecewise'){
		var pieces=option.visualMap[k].pieces.reverse();
		var newPieces=[];
		pieces[0].min=min;
		pieces[0].max=parseInt(max/pieces.length);
		newPieces.push(pieces[pieces.length-1]);
		for(var i=1;i<pieces.length;i++){
			pieces[i].min=parseInt(max/pieces.length*i);
			pieces[i].max=parseInt(max/pieces.length*(i+1));
			newPieces.push(pieces[pieces.length-1-i]);
		}
		option.visualMap[k].pieces=newPieces;
	}else{
		option.visualMap[k].max = max;
		option.visualMap[k].min = min;
	    option.visualMap[k].range = [min,max]; 
	    option.visualMap[k].calculable=true;
	}
	return option;
}
/**********************地图******************end****************/




/**********************仪表图******************begin****************/
function otcGauge(xName,opt){
    var series = opt.series;
    //样式
    var table ='<style type="text/css">table.gridtable {font-family: verdana,arial,sans-serif;font-size:11px;color:#333333;border-width: 1px;border-color: #666666;border-collapse: collapse;width:100%;}'
        +'table.gridtable th {border-width: 1px;border-style: solid;border-color: #666666;text-align:center;}'
        +' table.gridtable td {border-width: 1px;border-style: solid;border-color: #666666;text-align:center;}'
        +' input{width:100%;text-align:center;border:1px;}'
        +'table tr:nth-child(odd){background-color:#d4e3e5;}table tr:nth-child(even){background:#c3dde0;}</style>';
    //标题
    table += '<table class="gridtable" >'
    			 + '<tr>'
    			 +'<th >'+xName+'</th>'
                 + '<th >' +series[0].data[0].name+ '</th>'
                 + '</tr>';
    //内容
	for(var i=0;i<series.length;i++){
	   table += '<tr> <td  style="width:50%">'+series[0].name+'</td> '
	            + '<td  style="width:50%"><input type="text" value="' + series[i].data[0].value + '" /></td></tr>';
	}
	table+='</table>';
  return table;
}

function ctoGauge(HTMLDomElement,option){
 	var nodes = HTMLDomElement.getElementsByTagName("input");
 	for(var i=0;i<nodes.length;i++){
 		option.series[i].data[0].value = parseInt(nodes[i].value);
	}
	return option;
}
/**********************仪表图******************end****************/



/**********************饼图******************begin****************/
function otcPie(xName,opt){
	  var series = opt.series;
	  //样式
	  var table ='<style type="text/css">table.gridtable {font-family: verdana,arial,sans-serif;font-size:11px;color:#333333;border-width: 1px;border-color: #666666;border-collapse: collapse;width:100%;}'
	      +'table.gridtable th {border-width: 1px;border-style: solid;border-color: #666666;text-align:center;}'
	      +' table.gridtable td {border-width: 1px;border-style: solid;border-color: #666666;text-align:center;}'
	      +' input{width:100%;text-align:center;border:1px;}'
	      +'table tr:nth-child(odd){background-color:#d4e3e5;}table tr:nth-child(even){background:#c3dde0;}</style>';
	  //标题
	  table += '<table class="gridtable" >'
			 + '<tr>'
			 +'<th>'+xName+'</th>'
	        + '<th>' +series[0].name+ '</th>'
	        + '</tr>';
	  //内容
	  for (var i = 0, l = series[0].data.length; i < l; i = i+1) {
		  table += '<tr><td style="width:50%">'+series[0].data[i].name+''
	         	   +'<td style="width:50%" > <input  type="text" value="' + series[0].data[i].value + '"/></td>';
	  }
	  table += '</tr>';
	  table += '</table>';
	return table;
	}

	function ctoPie(HTMLDomElement,option){
		var nodes = HTMLDomElement.getElementsByTagName("input");
		for(var i=0;i < nodes.length;i++){
			option.series[0].data[i] = parseInt(nodes[i].value);
		}
		return option;
	}

/**********************饼图******************end****************/

/**********************多重饼图******************begin****************/
function otcMultiplePie(xName,opt){
	  var series = opt.series;
	  //样式
	  var table ='<style type="text/css">table.gridtable {font-family: verdana,arial,sans-serif;font-size:11px;color:#333333;border-width: 1px;border-color: #666666;border-collapse: collapse;width:100%;}'
	      +'table.gridtable th {border-width: 1px;border-style: solid;border-color: #666666;text-align:center;}'
	      +' table.gridtable td {border-width: 1px;border-style: solid;border-color: #666666;text-align:center;}'
	      +' input{width:100%;text-align:center;border:1px;}'
	      +'table tr:nth-child(odd){background-color:#d4e3e5;}table tr:nth-child(even){background:#c3dde0;}</style>';
	  
	  if(series.length == 2){
		  table += '<table class="gridtable" >';
		  for (var i = 0, l = series[1].data.length; i < l; i = i+2) {
			  if(i < series[1].data.length){
				  table += '<tr><td style="width:25%">'+series[1].data[i].name+''
	        	   +'<td style="width:25%" > <input  type="text" value="' + series[1].data[i].value + '"/></td>';
			  }
			  if(i+1 < series[1].data.length){
				  table += '<td style="width:25%">'+series[1].data[i+1].name+''
	        	   +'<td style="width:25%" > <input  type="text" value="' + series[1].data[i+1].value + '"/></td></tr>';
			  }
		  }
		  table += '</table>';
	  }
	  
	  if(series.length == 3){
		  table += '<table class="gridtable" >';
		  var firstPieLength = series[1].data.length;
		  var  inputPercent =  Math.round(100/(firstPieLength*2)*100)/100;
		  table += '<tr>';
		  for (var i = 0, l = series[1].data.length; i < l; i = i+1) {
			  table += '<td style="width:'+inputPercent+'%">'+series[1].data[i].name+''
			  		+'<td style="width:'+inputPercent+'%" > <input  type="text" name="firstPie" value="' + series[1].data[i].value + '"/></td>';
		  }
		  table +='<tr/></table>';
		  table += '<hr/>';
		  table += '<table class="gridtable" >';
		  
		  for (var i = 0, l = series[2].data.length; i < l; i = i+2) {
			  if(i < series[2].data.length){
				  table += '<tr><td style="width:25%">'+series[2].data[i].name+''
	        	   +'<td style="width:25%" > <input  type="text" value="' + series[2].data[i].value + '"/></td>';
			  }
			  if(i+1 < series[2].data.length){
				  table += '<td style="width:25%">'+series[2].data[i+1].name+''
	        	   +'<td style="width:25%" > <input  type="text" value="' + series[2].data[i+1].value + '"/></td><tr/>';
			  }
		  }
	  }
	return table;
	}

	
	function ctoMultiplePie(HTMLDomElement,option){
		var series = option.series;
		var indexFirstPie = 0;var indexSecondPie = 0;
		var nodes = HTMLDomElement.getElementsByTagName("input");
		if(series.length == 2){
			for(var i=0;i < nodes.length;i++){
				option.series[1].data[i] = parseInt(nodes[i].value);
			}
		 }else{
			 for(var i=0;i < nodes.length;i++){
				 var nodeName = nodes[i].name;
				 if(nodes[i].name == "firstPie"){
					 option.series[1].data[indexFirstPie++] = parseInt(nodes[i].value);
				 }else{
					 option.series[2].data[indexSecondPie++] = parseInt(nodes[i].value);
				 }
			}
		 }
		return option;
	}

/**********************多重饼图******************end****************/


/**********************散点图和矩形图或条形图的混合图表******************begin****************/
function otcHunheScatter(xName,opt){
  var series = opt.series;//数据
  var axisData = [];//坐标轴
  var inputPercent = 0  //input输入框百分比
  
  inputPercent =  Math.round(100/((series.length+1)*2)*100)/100;
  
  //判断使用的坐标轴为x轴还是y轴
  if(opt.xAxis[0].data != undefined && opt.xAxis[0].data.length > 0){
  	axisData = opt.xAxis[0].data;
  }else if(opt.yAxis[0].data != undefined && opt.yAxis[0].data.length > 0 ){
  	axisData = opt.yAxis[0].data;
  }
 
 //样式
  var table ='<style type="text/css">table.gridtable {font-family: verdana,arial,sans-serif;font-size:11px;color:#333333;border-width: 1px;border-color: #666666;border-collapse: collapse;width:100%;}'
  +'table.gridtable th {border-width: 1px;border-style: solid;border-color: #666666;text-align:center;}'
  +' table.gridtable td {border-width: 1px;border-style: solid;border-color: #666666;text-align:center;}'
  +' input{width:100%;text-align:center;border:1px;}'
  +'table tr:nth-child(odd){background-color:#d4e3e5;}table tr:nth-child(even){background:#c3dde0;}</style>';
  
  //如果只有各个series都只有一条数据,那就不分两行显示
  var flag = true;
  for(var i = 0; i < series.length; i = i+1){
		 if(series[i].data.length > 1){
			 flag = false;
		 }
	 }
  if(flag){
      table += '<table class="gridtable" ><tr>';
 		table+= '<th>'+xName+'</th>';
 		 for(var i = 0; i < series.length; i = i+1){
 			 table+='<th>' + series[i].name + '</th>';
 		 }
   table+= '</tr>';
   
   
   table += '<tr>';
   table += '<td  style="width:'+inputPercent*2+'%" >' + axisData[0] + '</td>';
      for(var i = 0; i < series.length; i = i+1){
  		if(series[i].data[0]!='undefined'&&series[i].data[0]!=undefined){
  			if(series[i].type == 'scatter'){
  				 if(!isNaN(series[i].data[0])){
	       			 table+= '<td style="width:'+inputPercent*2+'%" > <input  type="text" value="' + series[i].data[0] + '"/></td>';
	       		 }else  if(!isNaN(series[i].data[0][2])){
	       			 table+= '<td style="width:'+inputPercent*2+'%" > <input type="text" value="' + series[i].data[0][2] + '"/></td>';
	       		 }else  if(!isNaN(series[i].data[0].value[2])){
	       			 table+= '<td style="width:'+inputPercent*2+'%" > <input type="text" value="' + series[i].data[0].value[2] + '"/></td>';
	       		 }
  			}else{
  				 if(!isNaN(series[i].data[0])){
	       			 table+= '<td style="width:'+inputPercent*2+'%" > <input  type="text" value="' + series[i].data[0] + '"/></td>';
	       		 }else  if(!isNaN(series[i].data[0].value)){
	       			 table+= '<td style="width:'+inputPercent*2+'%" > <input type="text" value="' + series[i].data[0].value + '"/></td>';
	       		 }
  			}
  		}else{
			 table+= '<td style="width:'+inputPercent*2+'%" > <input type="text" value="0"/></td>';
		}
		 }
      table += '</tr></table>'
      	return table;
  }
  
  //标题
  table += '<table class="gridtable" ><tr>';
	 for(var k=0;k<2;k++){
		 table+= '<th>'+xName+'</th>';
		 for(var i = 0; i < series.length; i = i+1){
			 table+='<th>' + series[i].name + '</th>';
		 }
	 }
   table+= '</tr>';
   //内容
   var length=1;
    for(var j=0;j<series.length; j = j+1){
  	  if(length<series[j].data.length){
  		  length=series[j].data.length;
  	  }
    }
	 for (var i = 0, l = length; i < l; i = i+2) {
	        table += '<tr>';
      	table += '<td  style="width:'+inputPercent+'%" >' + axisData[i] + '</td>';
  		for(var j=0;j<series.length; j = j+1){
  			if(series[j].data[i]!='undefined'&&series[j].data[i]!=undefined){
  				if(series[j].type == 'scatter'){
  	  				 if(!isNaN(series[j].data[0])){
  		       			 table+= '<td style="width:'+inputPercent+'%" > <input  type="text" value="' + series[j].data[i] + '"/></td>';
  		       		 }else  if(!isNaN(series[j].data[0][2])){
  		       			 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value="' + series[j].data[i][2] + '"/></td>';
  		       		 }else  if(!isNaN(series[j].data[0].value[2])){
  		       			 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value="' + series[j].data[i].value[2] + '"/></td>';
  		       		 }
  	  			}else{
  	  				 if(!isNaN(series[j].data[0])){
  		       			 table+= '<td style="width:'+inputPercent+'%" > <input  type="text" value="' + series[j].data[i] + '"/></td>';
  		       		 }else  if(!isNaN(series[j].data[0].value)){
  		       			 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value="' + series[j].data[i].value + '"/></td>';
  		       		 }
  	  			}
  			}else{
  				 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value="0"/></td>';
  			}
  	      }
  		if(i<length-1){
  			table += '<td style="width:'+inputPercent+'%" >' + axisData[i+1] + '</td>'
          	for(var j=0;j<series.length; j = j+1){
	            		if(series[j].data[i+1]!='undefined'&&series[j].data[i+1]!=undefined){
	            			if(series[j].type == 'scatter'){
	         	  				 if(!isNaN(series[j].data[0])){
	         		       			 table+= '<td style="width:'+inputPercent+'%" > <input  type="text" value="' + series[j].data[i+1] + '"/></td>';
	         		       		 }else  if(!isNaN(series[j].data[0][2])){
	         		       			 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value="' + series[j].data[i+1][2] + '"/></td>';
	         		       		 }else  if(!isNaN(series[j].data[0].value[2])){
	          		       			 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value="' + series[j].data[i+1].value[2] + '"/></td>';
	          		       		 }
	         	  			}else{
	         	  				 if(!isNaN(series[j].data[0])){
	         		       			 table+= '<td style="width:'+inputPercent+'%" > <input  type="text" value="' + series[j].data[i+1] + '"/></td>';
	         		       		 }else  if(!isNaN(series[j].data[0].value)){
	         		       			 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value="' + series[j].data[i+1].value + '"/></td>';
	         		       		 }
	         	  			}
		       			}else{
		       				 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value="0"/></td>';
		       			}
      	      }
  		}
	       table += '</tr>';
  }
  table += '</table>';
  return table;
}

function ctoHunheScatter(HTMLDomElement,option){
	var nodes = HTMLDomElement.getElementsByTagName("input");
	var series = option.series;//数据
	var seriesLength=series.length;
	var seriesIndex = 0;
	var scatterData = [];
	for(var k=0;k<seriesLength;k++){
		if(option.series[k].type == 'scatter'){
			seriesIndex = k;
			scatterData = option.series[k].data;
		}
		option.series[k].data=[];
	}
	

	if (!isNaN(scatterData[0])) {
		for (var i = 0; i < nodes.length; i++) {
			var nodeValue = parseInt(nodes[i].value);
			option.series[i % seriesLength].data.push(nodeValue);
		}
	}
	
	var j = 0;
	if(!isNaN(scatterData[0][2])){
		for(var i=0;i<nodes.length;i++){
			var nodeValue=parseInt(nodes[i].value);
			if(i%seriesLength != seriesIndex){
				option.series[i%seriesLength].data.push(nodeValue);
			}else{
				scatterData[j][2] = nodeValue;
				j++;
				}
			}
		option.series[seriesIndex].data = scatterData;
		}
	
	
	if(!isNaN(scatterData[0].value[2])){
		for(var i=0;i<nodes.length;i++){
			var nodeValue=parseInt(nodes[i].value);
			if(i%seriesLength != seriesIndex){
				option.series[i%seriesLength].data.push(nodeValue);
			}else{
				scatterData[j].value[2] = nodeValue;
				j++;
				}
			}
		option.series[seriesIndex].data = scatterData;
		}
	
	return option;
}



/**********************雷达图******************begin****************/
function otcRadar(xName,opt){
    var series = opt.series;
    var data = series[0].data[0].value;
    var inputPercent =  Math.round(100/(data.length+1)*100)/100;

    //样式
    var table ='<style type="text/css">table.gridtable {font-family: verdana,arial,sans-serif;font-size:11px;color:#333333;border-width: 1px;border-color: #666666;border-collapse: collapse;width:100%;}'
        +'table.gridtable th {border-width: 1px;border-style: solid;border-color: #666666;text-align:center;}'
        +' table.gridtable td {border-width: 1px;border-style: solid;border-color: #666666;text-align:center;}'
        +' input{width:100%;text-align:center;border:1px;}'
        +'table tr:nth-child(odd){background-color:#d4e3e5;}table tr:nth-child(even){background:#c3dde0;}</style>';
    //标题
    
    table += '<table class="gridtable" >'
    			 + '<tr>'
    			 +'<th >'+xName+'</th>';
      table+='<th>初审金额</th><th>审定金额</th></tr>'; 
      table += '<tr> <td  style="width:33%">'+series[0].name+'</td> ';
	  table +='<td  style="width:33%"><input type="text" value="' + data[0] + '" /></td>';
	  table +='<td  style="width:33%"><input type="text" value="' + data[1] + '" /></td>';
	  table += '<tr><th>'+xName+'</th><th>审减金额</th><th>审减率</th></tr>';
	  table += '<tr> <td  style="width:33%">'+series[0].name+'</td> ';
	  table +='<td  style="width:33%"><input type="text" value="' + data[2] + '" /></td>';
	  table +='<td  style="width:33%"><input type="text" value="' + data[3] + '" /></td>';
	  table+='</tr></table>';
  return table;
}

function ctoRadar(HTMLDomElement,option){
 	var nodes = HTMLDomElement.getElementsByTagName("input");
 	option.series[0].data[0].value = [];
 	var data = [];
 	for(var i=0;i<nodes.length;i++){
 		data.push(parseInt(nodes[i].value));
	}
 	option.series[0].data[0].value = data;
	return option;
}
/**********************雷达图******************end****************/

/**********************多个Series的雷达图******************begin****************/
function otcMultiSeriesRadar(xName,opt){
    var data =  opt.series[0].data;
    var indicator = opt.radar[0].indicator;
    var length = indicator.length;
    var inputPercent =  Math.round(100/(length+1+3)*100)/100;

    //样式
    var table ='<style type="text/css">table.gridtable {font-family: verdana,arial,sans-serif;font-size:11px;color:#333333;border-width: 1px;border-color: #666666;border-collapse: collapse;width:100%;}'
        +'table.gridtable th {border-width: 1px;border-style: solid;border-color: #666666;text-align:center;}'
        +' table.gridtable td {border-width: 1px;border-style: solid;border-color: #666666;text-align:center;}'
        +' input{width:100%;text-align:center;border:1px;}'
        +'table tr:nth-child(odd){background-color:#d4e3e5;}table tr:nth-child(even){background:#c3dde0;}</style>';
    //标题
    
    table += '<table class="gridtable" >';
	table +='<tr>'+'<th>'+xName+'</th>';
	for(var i=0;i<length;i++){
		table +='<th>'+indicator[i].name+'</th>';
	}
	table +='</tr>';
	
    for(var i=0;i<data.length;i++){
    	table +='<tr>';
    	table +='<td style="width:'+inputPercent+'%">'+data[i].name+'</td>';
    	for(var j=0;j<data[i].value.length;j++){
    		if(data[i].value[j].toString().length > 10){
    			table +='<td  style="width:'+inputPercent*2+'%"><input type="text" value="' + data[i].value[j] + '" /></td>';
    		}else{
    			table +='<td  style="width:'+inputPercent+'%"><input type="text" value="' + data[i].value[j] + '" /></td>';
    		}
    	}
    	table +='</tr>';
    }
    table+='</tr></table>';
  return table;
}

function ctoMultiSeriesRadar(HTMLDomElement,option){
 	var nodes = HTMLDomElement.getElementsByTagName("input");
 	var data = option.series[0].data;
 	var length = option.series[0].data[0].value.length;
	for(var i=0;i<data.length;i++){
		option.series[0].data[i].value = [];
	}
 	for(var i=0;i<nodes.length;i=i+length){
 		var nodeValue=nodes[i].value;
 		option.series[0].data[i%length].value.push(nodeValue);
	}
	return option;
}
/**********************雷达图******************end****************/

/**********************漏斗图*******************begin****************/
function ctoFunnel(HTMLDomElement,option){
 	var nodes = HTMLDomElement.getElementsByTagName("input");
	var data = [];
	var max = nodes[0].value,min = nodes[0].value,sum = 0;
	for(var i=0;i<nodes.length;i++){
		var nodeValue=nodes[i].value;
		sum+=nodeValue;
		if(max < nodeValue){
			max = nodeValue;
		}
		if(min > nodeValue){
			min = nodeValue;
		}
		data.push({name:nodes[i].getAttribute("name"),value:nodeValue});
	}
	option.series[0].data = data;
 	option.series[0].max = max;
	option.series[0].min = min;
    option.series[0].label = {
				        normal: {
				            show: true,
				            formatter:function(params){
				            	return params.name+":"+params.value+"("+Math.round(params.value/sum*100)+"%)";
				            } ,
				        },
					    emphasis: {
					        textStyle: {
					            fontSize: 20
					        }
					    }
				        }; 
	return option;
}
/**********************漏斗图******************end****************/


/**********************飞行的散状图******************begin****************/
function otcEffectScatter(xName,opt){
    var series = opt.series;
    var data = series[series.length-1].data;
    var inputPercent =  Math.round(100/(data.length)*100)/100;

    //样式
    var table ='<style type="text/css">table.gridtable {font-family: verdana,arial,sans-serif;font-size:11px;color:#333333;border-width: 1px;border-color: #666666;border-collapse: collapse;width:100%;}'
        +'table.gridtable th {border-width: 1px;border-style: solid;border-color: #666666;text-align:center;}'
        +' table.gridtable td {border-width: 1px;border-style: solid;border-color: #666666;text-align:center;}'
        +' input{width:100%;text-align:center;border:1px;}'
        +'table tr:nth-child(odd){background-color:#d4e3e5;}table tr:nth-child(even){background:#c3dde0;}</style>';
    //标题
    
    table += '<table class="gridtable" ><tr><th>'+xName+'</th>';
    for(var i=0;i<data.length-1;i++){
    	table+='<th>'+data[i].name+'</th>';
    }
    table += '</tr>';
      table += '<tr> <td  style="width:'+inputPercent+'%">'+series[series.length-1].name+'</td> ';
    //内容
	for(var i=0;i<data.length-1;i++){
		table +='<td  style="width:'+inputPercent+'%"><input type="text" value="' + data[i].value[2] + '" /></td>';
	}
	table+='</tr></table>';
  return table;
}

function ctoEffectScatter(HTMLDomElement,option){
 	var nodes = HTMLDomElement.getElementsByTagName("input");
 	 var series = option.series;
 	for(var i=0;i<nodes.length;i++){
 		var nodeValue=parseInt(nodes[i].value);
 		option.series[series.length-1].data[i].value[2] = nodeValue;
	}
	return option;
}
/**********************飞行的散状图******************end****************/


/**********************矩形图和饼图的混合图******************begin****************/
//矩形图的dataview自定义方法optionToContent
function otcBarAndPie(xName,opt){
  var series = opt.series;//数据
  var pieData = series[series.length-1].data;
  var axisData = [];//坐标轴
  var inputPercent = 0  //input输入框百分比
  
  //inputPercent =  Math.round(100/((series.length+1+pieData.length)*2)*100)/100;
  inputPercent =  Math.round(100/((series.length)*2)*100)/100;
  
  //判断使用的坐标轴为x轴还是y轴
  if(opt.xAxis[0].data != undefined && opt.xAxis[0].data.length > 0){
  	axisData = opt.xAxis[0].data;
  }else if(opt.yAxis[0].data != undefined && opt.yAxis[0].data.length > 0 ){
  	axisData = opt.yAxis[0].data;
  }
 
 //样式
  var table ='<style type="text/css">table.gridtable {font-family: verdana,arial,sans-serif;font-size:11px;color:#333333;border-width: 1px;border-color: #666666;border-collapse: collapse;width:100%;}'
  +'table.gridtable th {border-width: 1px;border-style: solid;border-color: #666666;text-align:center;}'
  +' table.gridtable td {border-width: 1px;border-style: solid;border-color: #666666;text-align:center;}'
  +' input{width:100%;text-align:center;border:1px;}'
  +'table tr:nth-child(odd){background-color:#d4e3e5;}table tr:nth-child(even){background:#c3dde0;}</style>';
  
  
  //标题
  table += '<table class="gridtable" ><tr>';
	 for(var k=0;k<2;k++){
		 table+= '<th>'+xName+'</th>';
		 for(var i = 0; i < series.length-1; i = i+1){
			 table+='<th>' + series[i].name + '</th>';
		 }
	 }
   table+= '</tr>';
   //内容
   var length=1;
    for(var j=0;j<series.length; j = j+1){
  	  if(length<series[j].data.length){
  		  length=series[j].data.length;
  	  }
    }
	 for (var i = 0, l = length; i < l; i = i+2) {
	        table += '<tr>';
      	table += '<td  style="width:'+inputPercent+'%" >' + axisData[i] + '</td>';
  		for(var j=0;j<series.length-1; j = j+1){
  			if(series[j].data[i]!='undefined'&&series[j].data[i]!=undefined){
  				 if(!isNaN(series[j].data[i])){
          			 table+= '<td style="width:'+inputPercent+'%" > <input  type="text" value="' + series[j].data[i] + '"/></td>';
          		 }else  if(!isNaN(series[j].data[i].value)){
          			 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value="' + series[j].data[i].value + '"/></td>';
          		 }
  			}else{
  				 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value="0"/></td>';
  			}
  	      }
  		if(i<length-1){
  			table += '<td style="width:'+inputPercent+'%" >' + axisData[i+1] + '</td>'
          	for(var j=0;j<series.length-1; j = j+1){
	            		if(series[j].data[i+1]!='undefined'&&series[j].data[i+1]!=undefined){
		       				 if(!isNaN(series[j].data[i+1])){
		               			 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value="' + series[j].data[i+1] + '"/></td>';
		               		 }else  if(!isNaN(series[j].data[i+1].value)){
		               			 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value="' + series[j].data[i+1].value + '"/></td>';
		               		 }
		       			}else{
		       				 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value="0"/></td>';
		       			}
      	      }
  		}
	       table += '</tr>';
  }
  table += '</table>';
  return table;
}



function ctoBarAndPie(HTMLDomElement,option){
	var nodes = HTMLDomElement.getElementsByTagName("input");
	var series = option.series;//数据
	var seriesLength=series.length;
	//var length =  seriesLength-1+series[seriesLength-1].length;
	
	for(var k=0;k<seriesLength-1;k++){
		option.series[k].data=[];
	}
	var iteItemCount=0,siteItemCount =0;
	for(var i=0;i<nodes.length;i++){
		var nodeValue=parseInt(nodes[i].value);
		if(i%seriesLength == 0){
			siteItemCount+= nodeValue;
			option.series[i%seriesLength].data.push(nodeValue);
		}else if(i%seriesLength == 1){
			iteItemCount+=iteItemCount;
			option.series[i%seriesLength].data.push(nodeValue);
		}
	}
	
	option.series[seriesLength-1].data[0] = siteItemCount;
	option.series[seriesLength-1].data[1] = iteItemCount-siteItemCount;
	return option;
}
/**********************矩形图和饼图的混合图******************end****************/


/**********************当地市地图没有值时，显示地市地图为一整块
 * 
 * 	isJustOne：是否地市无知
 * 	tooltipFormatter：tooltipFormatter
 * 	areaColor：地图一整块显示的颜色
 * 	option：地图的option
 * 	dataViewMapName：数据视图otcMap的一个参数
 * 
 * ******************end****************/
function ifMapHaveMoreOneData(isJustOne,areaColor,option,dataViewMapName){
	if(isJustOne){
	var provinceMapsData=[],inRangeColor =[];
		tooltip4Pro={
	            trigger: 'item',
		        formatter: "该省份没有数据存在",
		        confine :true
		        };
		itemStyle4Pro= {
                normal: {
                	borderWidth: 0,
                	areaColor: areaColor,
                },
                emphasis: {
                    areaColor: areaColor,
                }
            };
		label4Pro={
            normal: {
                show: false
            },
            emphasis: {
                show: false
            }
        };
		colorPro = [areaColor];
		dataView =  {
            	show:false,
            	readonly:'false',
            };
	}else {
		var tooltip4Pro={
				trigger : 'item',
				formatter:function(p){
					if(p.data.value != undefined && p.data.value != 'undefined'){
						return p.seriesName+"<br/>"+p.data.name+"："+p.data.value;
					}else {
						return p.seriesName+"<br/>"+p.data.name+"：无数据";
					}
				}
			};
	
        	itemStyle4Pro={
                	normal:{
                		borderType:'solid',
                		label:{show:false},
                	},
                	 emphasis:{
                		 label:{show:false}
                	}
                };
        	
		label4Pro={
            normal: {
                show: true
            },
            emphasis: {
                show: true
            }
        };
		
		dataView = {
        	show:true,
        	readonly:'false',
        	optionToContent: function(opt) {
        		var table=otcMap(dataViewMapName,opt);
        		return table;
        	},
        	 contentToOption:function(HTMLDomElement,option) {
                var opt=ctoMap(HTMLDomElement,option);
                return opt;
             }
        };
		
		
	};
		option.tooltip = tooltip4Pro;
		option.color = [areaColor];
		option.series[0].itemStyle = itemStyle4Pro;
		option.series[0].label = label4Pro;
		return option;
}
/**********************矩形图和饼图的混合图******************end****************/


/**********************集约化---异地审计分析的省份图表专门写******************start****************/
//矩形图的dataview自定义方法optionToContent
function otcLdRYidiAuditProBar(xName,opt){
    var oldseries = opt.series;//数据
    var series = [];
    for(var i=1;i<oldseries.length;i=i+2){
    	series.push(oldseries[i]);
    }
    var axisData = [];//坐标轴
    var inputPercent = 0  //input输入框百分比
    
    inputPercent =  Math.round(100/((series.length+1)*2)*100)/100;
    
    //判断使用的坐标轴为x轴还是y轴
    if(opt.xAxis[0].data != undefined && opt.xAxis[0].data.length > 0){
    	axisData = opt.xAxis[0].data;
    }else if(opt.yAxis[0].data != undefined && opt.yAxis[0].data.length > 0 ){
    	axisData = opt.yAxis[0].data;
    }
   
   //样式
    var table ='<style type="text/css">table.gridtable {font-family: verdana,arial,sans-serif;font-size:11px;color:#333333;border-width: 1px;border-color: #666666;border-collapse: collapse;width:100%;}'
    +'table.gridtable th {border-width: 1px;border-style: solid;border-color: #666666;text-align:center;}'
    +' table.gridtable td {border-width: 1px;border-style: solid;border-color: #666666;text-align:center;}'
    +' input{width:100%;text-align:center;border:1px;}'
    +'table tr:nth-child(odd){background-color:#d4e3e5;}table tr:nth-child(even){background:#c3dde0;}</style>';
    
    //如果只有各个series都只有一条数据,那就不分两行显示
    var flag = true;
    for(var i = 0; i < series.length; i = i+1){
		 if(series[i].data.length > 1){
			 flag = false;
		 }
	 }
    if(flag){
        table += '<table class="gridtable" ><tr>';
   		table+= '<th>'+xName+'</th>';
   		 for(var i = 0; i < series.length; i = i+1){
   			 table+='<th>' + series[i].name + '</th>';
   		 }
        table+= '</tr>';
        table += '<tr>';
    	table += '<td  style="width:'+inputPercent*2+'%" >' + axisData[0] + '</td>';
        for(var i = 0; i < series.length; i = i+1){
    		if(series[i].data[0]!='undefined'&&series[i].data[0]!=undefined){
				 if(!isNaN(series[i].data[0])){
	       			 table+= '<td style="width:'+inputPercent*2+'%" > <input  type="text" value="' + series[i].data[0] + '"/></td>';
	       		 }else  if(!isNaN(series[i].data[0].value)){
	       			 table+= '<td style="width:'+inputPercent*2+'%" > <input type="text" value="' + series[i].data[0].value + '"/></td>';
	       		 }
			}else{
				 table+= '<td style="width:'+inputPercent*2+'%" > <input type="text" value="0"/></td>';
			}
  		 }
        table += '</tr></table>'
        	return table;
    }
    
    //标题
    table += '<table class="gridtable" ><tr>';
	 for(var k=0;k<2;k++){
		 table+= '<th>'+xName+'</th>';
		 for(var i = 0; i < series.length; i = i+1){
			 table+='<th>' + series[i].name + '</th>';
		 }
	 }
     table+= '</tr>';
     //内容
     var length=1;
      for(var j=0;j<series.length; j = j+1){
    	  if(length<series[j].data.length){
    		  length=series[j].data.length;
    	  }
      }
	 for (var i = 0, l = length; i < l; i = i+2) {
	        table += '<tr>';
        	table += '<td  style="width:'+inputPercent+'%" >' + axisData[i] + '</td>';
    		for(var j=0;j<series.length; j = j+1){
    			if(series[j].data[i]!='undefined'&&series[j].data[i]!=undefined){
    				 if(!isNaN(series[j].data[i])){
            			 table+= '<td style="width:'+inputPercent+'%" > <input  type="text" value="' + series[j].data[i] + '"/></td>';
            		 }else  if(!isNaN(series[j].data[i].value)){
            			 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value="' + series[j].data[i].value + '"/></td>';
            		 }else{
            			 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value=查无数据></td>';
            		 }
    			}else{
    				 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value="0"/></td>';
    			}
    	      }
    		if(i<length-1){
    			table += '<td style="width:'+inputPercent+'%" >' + axisData[i+1] + '</td>'
            	for(var j=0;j<series.length; j = j+1){
	            		if(series[j].data[i+1]!='undefined'&&series[j].data[i+1]!=undefined){
		       				 if(!isNaN(series[j].data[i+1])){
		               			 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value="' + series[j].data[i+1] + '"/></td>';
		               		 }else  if(!isNaN(series[j].data[i+1].value)){
		               			 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value="' + series[j].data[i+1].value + '"/></td>';
		               		 }else{
		               			 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value=查无数据></td>';
		               		 }
		       			}else{
		       				 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value="0"/></td>';
		       			}
        	      }
    		}
	       table += '</tr>';
    }
    table += '</table>';
    return table;
}

function ctoLdRYidiAuditProBar(HTMLDomElement,option){
	var nodes = HTMLDomElement.getElementsByTagName("input");
	var series = option.series;//数据
	var seriesLength=series.length/2;
	
	for(var k=0;k<seriesLength;k++){
		option.series[k].data=[];
	}
	
	for(var i=0;i<nodes.length;i++){
		 if(!isNaN(parseInt(nodes[i].value))){
			var nodeValue=parseInt(nodes[i].value);
			option.series[i%seriesLength*2].data.push(nodeValue);
			option.series[i%seriesLength*2+1].data.push(nodeValue);
		}
		 
	}
	return option;
}
/**********************集约化---异地审计分析的省份图表专门写******************start****************/

//矩形图的dataview自定义方法optionToContent
function otcLdRYidiAuditTimeBar(xName,opt){
    var oldseries = opt.series;//数据
    var series = [];
    for(var i=1;i<oldseries.length;i=i+1){
    	series.push(oldseries[i]);
    }
    var axisData = [];//坐标轴
    var inputPercent = 0  //input输入框百分比
    
    inputPercent =  Math.round(100/((series.length+1)*2)*100)/100;
    
    //判断使用的坐标轴为x轴还是y轴
    if(opt.xAxis[0].data != undefined && opt.xAxis[0].data.length > 0){
    	axisData = opt.xAxis[0].data;
    }else if(opt.yAxis[0].data != undefined && opt.yAxis[0].data.length > 0 ){
    	axisData = opt.yAxis[0].data;
    }
   
   //样式
    var table ='<style type="text/css">table.gridtable {font-family: verdana,arial,sans-serif;font-size:11px;color:#333333;border-width: 1px;border-color: #666666;border-collapse: collapse;width:100%;}'
    +'table.gridtable th {border-width: 1px;border-style: solid;border-color: #666666;text-align:center;}'
    +' table.gridtable td {border-width: 1px;border-style: solid;border-color: #666666;text-align:center;}'
    +' input{width:100%;text-align:center;border:1px;}'
    +'table tr:nth-child(odd){background-color:#d4e3e5;}table tr:nth-child(even){background:#c3dde0;}</style>';
    
    //如果只有各个series都只有一条数据,那就不分两行显示
    var flag = true;
    for(var i = 0; i < series.length; i = i+1){
		 if(series[i].data.length > 1){
			 flag = false;
		 }
	 }
    if(flag){
        table += '<table class="gridtable" ><tr>';
   		table+= '<th>'+xName+'</th>';
   		 for(var i = 0; i < series.length; i = i+1){
   			 table+='<th>' + series[i].name + '</th>';
   		 }
        table+= '</tr>';
        table += '<tr>';
    	table += '<td  style="width:'+inputPercent*2+'%" >' + axisData[0] + '</td>';
        for(var i = 0; i < series.length; i = i+1){
    		if(series[i].data[0]!='undefined'&&series[i].data[0]!=undefined){
				 if(!isNaN(series[i].data[0])){
	       			 table+= '<td style="width:'+inputPercent*2+'%" > <input  type="text" value="' + series[i].data[0] + '"/></td>';
	       		 }else  if(!isNaN(series[i].data[0].value)){
	       			 table+= '<td style="width:'+inputPercent*2+'%" > <input type="text" value="' + series[i].data[0].value + '"/></td>';
	       		 }
			}else{
				 table+= '<td style="width:'+inputPercent*2+'%" > <input type="text" value="0"/></td>';
			}
  		 }
        table += '</tr></table>'
        	return table;
    }
    
    //标题
    table += '<table class="gridtable" ><tr>';
	 for(var k=0;k<2;k++){
		 table+= '<th>'+xName+'</th>';
		 for(var i = 0; i < series.length; i = i+1){
			 table+='<th>' + series[i].name + '</th>';
		 }
	 }
     table+= '</tr>';
     //内容
     var length=1;
      for(var j=0;j<series.length; j = j+1){
    	  if(length<series[j].data.length){
    		  length=series[j].data.length;
    	  }
      }
	 for (var i = 0, l = length; i < l; i = i+2) {
	        table += '<tr>';
        	table += '<td  style="width:'+inputPercent+'%" >' + axisData[i] + '</td>';
    		for(var j=0;j<series.length; j = j+1){
    			if(series[j].data[i]!='undefined'&&series[j].data[i]!=undefined){
    				 if(!isNaN(series[j].data[i])){
            			 table+= '<td style="width:'+inputPercent+'%" > <input  type="text" value="' + series[j].data[i] + '"/></td>';
            		 }else  if(!isNaN(series[j].data[i].value)){
            			 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value="' + series[j].data[i].value + '"/></td>';
            		 }else{
            			 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value=查无数据></td>';
            		 }
    			}else{
    				 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value="0"/></td>';
    			}
    	      }
    		if(i<length-1){
    			table += '<td style="width:'+inputPercent+'%" >' + axisData[i+1] + '</td>'
            	for(var j=0;j<series.length; j = j+1){
	            		if(series[j].data[i+1]!='undefined'&&series[j].data[i+1]!=undefined){
		       				 if(!isNaN(series[j].data[i+1])){
		               			 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value="' + series[j].data[i+1] + '"/></td>';
		               		 }else  if(!isNaN(series[j].data[i+1].value)){
		               			 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value="' + series[j].data[i+1].value + '"/></td>';
		               		 }else{
		               			 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value=查无数据></td>';
		               		 }
		       			}else{
		       				 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value="0"/></td>';
		       			}
        	      }
    		}
	       table += '</tr>';
    }
    table += '</table>';
    return table;
}

function ctoLdRYidiAuditTimeBar(HTMLDomElement,option){
	var nodes = HTMLDomElement.getElementsByTagName("input");
	var series = option.series;//数据
	var seriesLength=series.length-1;
	
	for(var k=0;k<seriesLength;k++){
		option.series[k].data=[];
	}
	
	for(var i=0;i<nodes.length;i++){
		 if(!isNaN(parseInt(nodes[i].value))){
			var nodeValue=parseInt(nodes[i].value);
			option.series[i%seriesLength+1].data.push(nodeValue);
		}
		 
	}
	return option;
}
/**********************饼图******************begin****************/
function otcTimePie(xName,opt){
  var series = opt.series[1];
  //样式
  var table ='<style type="text/css">table.gridtable {font-family: verdana,arial,sans-serif;font-size:11px;color:#333333;border-width: 1px;border-color: #666666;border-collapse: collapse;width:100%;}'
      +'table.gridtable th {border-width: 1px;border-style: solid;border-color: #666666;text-align:center;}'
      +' table.gridtable td {border-width: 1px;border-style: solid;border-color: #666666;text-align:center;}'
      +' input{width:100%;text-align:center;border:1px;}'
      +'table tr:nth-child(odd){background-color:#d4e3e5;}table tr:nth-child(even){background:#c3dde0;}</style>';
  //标题
  table += '<table class="gridtable" >'
		 + '<tr>'
		 +'<th>'+xName+'</th>'
        + '<th>' +series.name+ '</th>'
        + '</tr>';
  //内容
  for (var i = 0, l = series.data.length; i < l; i = i+1) {
	  table += '<tr><td style="width:50%">'+series.data[i].name+''
         	   +'<td style="width:50%" > <input  type="text" value="' + series.data[i].value + '"/></td>';
  }
  table += '</tr>';
  table += '</table>';
return table;
}

function ctoTimePie(HTMLDomElement,option){
	var nodes = HTMLDomElement.getElementsByTagName("input");
	for(var i=0;i < nodes.length;i++){
		option.series[1].data[i] = parseInt(nodes[i].value);
	}
	return option;
}


/**********************饼图******************end****************/

/**********************湖北审计数据集市——重点销售费用结构及同比分析——饼状图******************begin****************/
function otcCbzdxsfyjgPie(xName,opt){
  var series = [];//数据
  series.push(opt.series[0]);
  series.push(opt.series[1]);
  //样式
  var table ='<style type="text/css">table.gridtable {font-family: verdana,arial,sans-serif;font-size:11px;color:#333333;border-width: 1px;border-color: #666666;border-collapse: collapse;width:100%;}'
      +'table.gridtable th {border-width: 1px;border-style: solid;border-color: #666666;text-align:center;}'
      +' table.gridtable td {border-width: 1px;border-style: solid;border-color: #666666;text-align:center;}'
      +' input{width:100%;text-align:center;border:1px;}'
      +'table tr:nth-child(odd){background-color:#d4e3e5;}table tr:nth-child(even){background:#c3dde0;}</style>';
  //标题
  table += '<table class="gridtable" >'
		 + '<tr>'
		 +'<th>'+xName+'</th>'
        + '<th>' +series[0].name+ '</th>'
        + '<th>' +series[1].name+ '</th>'
        + '</tr>';
  //内容
  for (var i = 0, l = series[0].data.length; i < l; i = i+1) {
	  table += '<tr><td style="width:33%">'+series[0].data[i].name+''
         	   +'<td style="width:33%" > <input  type="text" value="' + series[0].data[i].value + '"/></td>'
         	  +'<td style="width:33%" > <input  type="text" value="' + series[1].data[i].value + '"/></td></tr>';
  }
  table += '</table>';
return table;
}

function ctoCbzdxsfyjgPie(HTMLDomElement,option){
	var nodes = HTMLDomElement.getElementsByTagName("input");
	
	for(var k=0;k<2;k++){
		option.series[k].data=[];
	}
	for(var i=0;i < nodes.length;i++){
		option.series[i%2].data.push(nodes[i].value);
	}
	return option;
}


/**********************饼图******************end****************/


/**********************被审计单位分析矩形图******************begin****************/
//矩形图的dataview自定义方法optionToContent
function otcJyhbeisjdwBar(xName,opt){
  var series = [];//数据
  series.push(opt.series[0]);
  series.push(opt.series[1]);
  var axisData = [];//坐标轴
  var inputPercent = 0  //input输入框百分比
  
  inputPercent =  Math.round(100/((series.length+1)*2)*100)/100;
  
  //判断使用的坐标轴为x轴还是y轴
  if(opt.xAxis[0].data != undefined && opt.xAxis[0].data.length > 0){
  	axisData = opt.xAxis[0].data;
  }else if(opt.yAxis[0].data != undefined && opt.yAxis[0].data.length > 0 ){
  	axisData = opt.yAxis[0].data;
  }
 
 //样式
  var table ='<style type="text/css">table.gridtable {font-family: verdana,arial,sans-serif;font-size:11px;color:#333333;border-width: 1px;border-color: #666666;border-collapse: collapse;width:100%;}'
  +'table.gridtable th {border-width: 1px;border-style: solid;border-color: #666666;text-align:center;}'
  +' table.gridtable td {border-width: 1px;border-style: solid;border-color: #666666;text-align:center;}'
  +' input{width:100%;text-align:center;border:1px;}'
  +'table tr:nth-child(odd){background-color:#d4e3e5;}table tr:nth-child(even){background:#c3dde0;}</style>';
  
  //如果只有各个series都只有一条数据,那就不分两行显示
  var flag = true;
  for(var i = 0; i < series.length; i = i+1){
		 if(series[i].data.length > 1){
			 flag = false;
		 }
	 }
  if(flag){
      table += '<table class="gridtable" ><tr>';
 		table+= '<th>'+xName+'</th>';
 		 for(var i = 0; i < series.length; i = i+1){
 			 table+='<th>' + series[i].name + '</th>';
 		 }
      table+= '</tr>';
      table += '<tr>';
  	table += '<td  style="width:'+inputPercent*2+'%" >' + axisData[0] + '</td>';
      for(var i = 0; i < series.length; i = i+1){
  		if(series[i].data[0]!='undefined'&&series[i].data[0]!=undefined){
				 if(!isNaN(series[i].data[0])){
	       			 table+= '<td style="width:'+inputPercent*2+'%" > <input  type="text" value="' + series[i].data[0] + '"/></td>';
	       		 }else  if(!isNaN(series[i].data[0].value)){
	       			 table+= '<td style="width:'+inputPercent*2+'%" > <input type="text" value="' + series[i].data[0].value + '"/></td>';
	       		 }
			}else{
				 table+= '<td style="width:'+inputPercent*2+'%" > <input type="text" value="0"/></td>';
			}
		 }
      table += '</tr></table>'
      	return table;
  }
  
  //标题
  table += '<table class="gridtable" ><tr>';
	 for(var k=0;k<2;k++){
		 table+= '<th>'+xName+'</th>';
		 for(var i = 0; i < series.length; i = i+1){
			 table+='<th>' + series[i].name + '</th>';
		 }
	 }
   table+= '</tr>';
   //内容
   var length=1;
    for(var j=0;j<series.length; j = j+1){
  	  if(length<series[j].data.length){
  		  length=series[j].data.length;
  	  }
    }
	 for (var i = 0, l = length; i < l; i = i+2) {
	        table += '<tr>';
      	table += '<td  style="width:'+inputPercent+'%" >' + axisData[i] + '</td>';
  		for(var j=0;j<series.length; j = j+1){
  			if(series[j].data[i]!='undefined'&&series[j].data[i]!=undefined){
  				 if(!isNaN(series[j].data[i])){
          			 table+= '<td style="width:'+inputPercent+'%" > <input  type="text" value="' + series[j].data[i] + '"/></td>';
          		 }else  if(!isNaN(series[j].data[i].value)){
          			 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value="' + series[j].data[i].value + '"/></td>';
          		 }else{
          			 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value=查无数据></td>';
          		 }
  			}else{
  				 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value="0"/></td>';
  			}
  	      }
  		if(i<length-1){
  			table += '<td style="width:'+inputPercent+'%" >' + axisData[i+1] + '</td>'
          	for(var j=0;j<series.length; j = j+1){
	            		if(series[j].data[i+1]!='undefined'&&series[j].data[i+1]!=undefined){
		       				 if(!isNaN(series[j].data[i+1])){
		               			 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value="' + series[j].data[i+1] + '"/></td>';
		               		 }else  if(!isNaN(series[j].data[i+1].value)){
		               			 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value="' + series[j].data[i+1].value + '"/></td>';
		               		 }else{
		               			 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value=查无数据></td>';
		               		 }
		       			}else{
		       				 table+= '<td style="width:'+inputPercent+'%" > <input type="text" value="0"/></td>';
		       			}
      	      }
  		}
	       table += '</tr>';
  }
  table += '</table>';
  return table;
}

function ctoJyhbeisjdwBar(HTMLDomElement,option){
	var nodes = HTMLDomElement.getElementsByTagName("input");
	var series = option.series;//数据
	var seriesLength=2;
	
	for(var k=0;k<seriesLength;k++){
		option.series[k].data=[];
	}
	
	for(var i=0;i<nodes.length;i++){
		if(nodes[i].value == "查无数据"){
			option.series[i%seriesLength].data.push(undefined);
		}else if(!isNaN(parseInt(nodes[i].value))){
			var nodeValue=parseInt(nodes[i].value);
			option.series[i%seriesLength].data.push(nodeValue);
		}
	}
	return option;
}
/**********************被审计单位分析矩形图******************end****************/


/**********************地图******************begin****************/
function otcDoubleMap(xName,opt){
    var series = opt.series;
    var data = [];
    //数据过滤
    for (var i = 0, l = series[0].data.length; i < l; i = i+1) {
	    if(!isNaN(series[0].data[i].value) &&  series[0].data[i].name != undefined &&  series[0].data[i].name != 'undefined'){
	    	data.push(series[0].data[i]);
	    }
    }

    //样式
    var table ='<style type="text/css">table.gridtable {font-family: verdana,arial,sans-serif;font-size:11px;color:#333333;border-width: 1px;border-color: #666666;border-collapse: collapse;width:100%;}'
        +'table.gridtable th {border-width: 1px;border-style: solid;border-color: #666666;text-align:center;}'
        +' table.gridtable td {border-width: 1px;border-style: solid;border-color: #666666;text-align:center;}'
        +' input{width:100%;text-align:center;border:1px;}'
        +'table tr:nth-child(odd){background-color:#d4e3e5;}table tr:nth-child(even){background:#c3dde0;}</style>';
    //标题

    
    //如果数据只有三个以上
    table += '<table class="gridtable" >'
    			 + '<tr>'
    			 +'<th align="center">'+xName+'</th>'
                 + '<th align="center"> 风险点频次 </th>'
                 +'<th align="center">问题金额</th>'
                 +'<th align="center">'+xName+'</th>'
                 + '<th align="center"> 风险点频次 </th>'
                 +'<th align="center">问题金额</th>'
                 + '</tr>';
    //内容
    for (var i = 0, l = data.length; i < l; i = i+2) {
	        table += '<tr>';
	        if(i < data.length){
	        	table += '<td  style="width:16.67%">' + data[i].name + '</td>'
	                 + '<td  style="width:16.67%"><input type="text" name="'+data[i].name+'" value="' + data[i].value + '"';
	        	if(data[i].procode = 'undefined'&& data[i].procode!=undefined){
	        		table += 'procode ="'+data[i].procode+'" /></td>';
	        	}else{
	        		table += 'orgcode ="'+data[i].orgcode+'" /></td>';
	        	}
	        	table += '<td  style="width:16.67%"><input type="text" name="'+data[i].name+'" value="' + data[i].problemMoeny + '"'+'/></td>';
	    	}
	        if(i+1 < data.length && !isNaN(data[i+1].value) && data[i+1].name != undefined && data[i+1].name != 'undefined'){
	        	table += '<td  style="width:16.67%">' + data[i+1].name + '</td>'
	        		+ '<td  style="width:16.67%"><input type="text" name="'+data[i+1].name+'" value="' + data[i+1].value + '"';
	        	if(data[i+1].procode = 'undefined'&& data[i+1].procode!=undefined){
	        		table += 'procode ="'+data[i+1].procode+'" /></td>';
	        	}else{
	        		table += 'orgcode ="'+data[i+1].orgcode+'" /></td>';
	        	}
	        	table += '<td  style="width:16.67%"><input type="text" name="'+data[i+1].name+'" value="' + data[i+1].problemMoeny + '"'+'/></td>';
	    	}
	      	table += '</tr>';
    }
    table += '</table>';
  return table;
}

function ctoDoubleMap(HTMLDomElement,option){
 	var nodes = HTMLDomElement.getElementsByTagName("input");
	var countdata = [];	var moneydata = [];
	var max = nodes[0].value,min = nodes[0].value;
	for(var i=0;i<nodes.length;i++){
		var nodeValue=parseInt(nodes[i].value);
		if(max < nodeValue){
			max = nodeValue;
		}
		if(min > nodeValue){
			min = nodeValue;
		}
		if(i%2 == 0){
			countdata.push({name:nodes[i].getAttribute("name"),value:nodeValue,procode:nodes[i].getAttribute("procode")});
		}else{
			moneydata.push({name:nodes[i].getAttribute("name"),value:nodeValue,procode:nodes[i].getAttribute("procode")});
		}
	}
	option.series[0].data = countdata;
	option.series[1].data = moneydata;
	var visualMapType= option.visualMap[0].type;
	if(visualMapType=='piecewise'){
		var pieces=option.visualMap[0].pieces.reverse();
		var newPieces=[];
		pieces[0].min=min;
		pieces[0].max=parseInt(max/pieces.length);
		newPieces.push(pieces[pieces.length-1]);
		for(var i=1;i<pieces.length;i++){
			pieces[i].min=parseInt(max/pieces.length*i);
			pieces[i].max=parseInt(max/pieces.length*(i+1));
			newPieces.push(pieces[pieces.length-1-i]);
		}
		option.visualMap[0].pieces=newPieces;
	}else{
		option.visualMap[0].max = max;
		option.visualMap[0].min = min;
	    option.visualMap[0].range = [min,max]; 
	    option.visualMap[0].calculable=true;
	}
	return option;
}

/**********************地图******************end****************/

