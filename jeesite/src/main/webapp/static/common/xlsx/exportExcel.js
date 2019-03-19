/**
 * 导出到excel,只能导出一个sheet
 * option : 图的option，通过option拿标题和数据
 * style ： 类型，根据当前的图，将类型分为三种，year(年)，month(月)，area（地域）
 * json ： 需要解析的json数据
 */
function excel(option,style,json){
	
	var lengend=[];
	for(var i=0;i < option.series;i++){
		lengend.push(option.series[i].name);
	}
	var title=option.title[0].text;
	
    
    //横着展现，即每个地市一行，总共是17行
	var json2Excel=[];
    //标题
	var excelT={};
	
	if(style=='month'){
		excelT["year"]="年";
		excelT["month"]="月";
	}else if(style=='year'){
		excelT["year"]="年";
	}else if(style=='area'){
		excelT["latnName"]="地市";
	}
    for(var k=0;k<lengend.length;k++){
    	excelT["zb"+k]=lengend[k];
    }
 	json2Excel.push(excelT);
 	
 	var raw={};
	for(var i=0;i<json[0].length;i++){
		raw={};
		for(var j=0;j<json.length;j++){
			if(j==0){
				if(style=='month'){
					raw["year"]=json[j][i].year;
					raw["month"]=json[j][i].month;
				}else if(style=='year'){
					raw["year"]=json[j][i].year;
				}else if(style=='area'){
					raw["latnName"]=json[j][i].latnName;
				}
				
			}
			raw["zb"+j]=json[j][i].idValue;
		}
		json2Excel.push(raw);
	}
    downloadExl(json2Excel,title,'xlsx');
}


var tmpDown; //导出的二进制对象
function downloadExl(json, title, type) {
	var columnWidh=[];//列宽，每个列都要设置
	
    var keyMap = []; //获取键
    for (var k in json[0]) {
        keyMap.push(k);
        /*if(k=='latnName'){
    	columnWidh.push({
        	wpx : 100
        });
	    }else{
	    	columnWidh.push({
	        	wpx : json[0][k].length*15
	        });
	    }*/
	    //暂时设置每个列宽都为100px
	    columnWidh.push({
	    	wpx : 100
	    });
    }
    var tmpdata = []; //用来保存转换好的json
    json.map(function (v, i) {
        return keyMap.map(function (k, j) {
            return Object.assign({}, {
                v: v[k],
                position: (j > 25 ? getCharCol(j) : String.fromCharCode(65 + j)) + (i + 1)
            });
        });
    }).reduce(function (prev, next) {
        return prev.concat(next);
    }).forEach(function (v, i) {
        /*return tmpdata[v.position] = {
            v: v.v
        };*/
    	if((v.position.indexOf("1")!=-1 && v.position.length == 2) || v.position.indexOf("A")!=-1){
			tmpdata[v.position] = {
		            v: v.v,
		            t: 's',//设置为字符串
		            
		        }; 
		}else{
			tmpdata[v.position] = {
		            v: v.v,
		            t: 'n',//设置为number
		            //z: '#,##0.00_',//不强制保留两位小数,千分位表示
		            z: '#,##0.00;[Red](#,##0.00)',//保留两位小数，千分位表示,负数使用红色字体
		            s:{ fgColor: '00FF0000',bgColor :'FF000000'}
					 
		        }; 
		}
	    return tmpdata;
	});

    var outputPos = Object.keys(tmpdata); //设置区域,比如表格从A1到D10
    var sheetNames = [];
    sheetNames.push(title);
    var sheets = {};
    sheets[title] = Object.assign({}, tmpdata, //内容
    {
        '!ref': outputPos[0] + ':' + outputPos[outputPos.length - 1], //设置填充区域
        '!cols':columnWidh
    });
    
    var tmpWB = {
        SheetNames: sheetNames, //保存的表标题
        Sheets: sheets
    };
    tmpDown = new Blob([s2ab(XLSX.write(tmpWB, { bookType: type == undefined ? 'xlsx' : type, bookSST: false, type: 'binary' } //这里的数据是用来定义导出的格式类型
    ))], {
        type: ""
    }); //创建二进制对象写入转换好的字节流
    document.getElementById("hf").download = title + ".xlsx";
    var href = URL.createObjectURL(tmpDown); //创建对象超链接
    document.getElementById("hf").href = href; //绑定a标签
    document.getElementById("hf").click(); //模拟点击实现下载
    setTimeout(function () {
        //延时释放
        URL.revokeObjectURL(tmpDown); //用URL.revokeObjectURL()来释放这个object URL
    }, 100);
}

/**
 * 导出到excel,同时导出两个sheet
 * option : 图的option，通过option拿标题和数据
 * style ： 类型，当前只有time这一个类型，导出年月数据和年份数据两个sheet
 * json ： 需要解析的json数据
 */
function excel2(option,style,json,json1){
	var lengend=option.legend[0].data;
	var title=option.title[0].text;
    
    //横着展现
	var json2Excel=[];//年月数据
	var json2Excel1=[];//年数据
    //标题
	var excelT={};
	var excelT1={};
	
	if(style=='time'){
		excelT["year"]="年";
		excelT["month"]="月";
		
		excelT1["year"]="年";
	}
    for(var k=0;k<lengend.length;k++){
    	excelT["zb"+k]=lengend[k];
    	excelT1["zb"+k]=lengend[k];
    }
 	json2Excel.push(excelT);
 	json2Excel1.push(excelT1);
 	
 	var raw={};
	for(var i=0;i<json[0].length;i++){
		raw={};
		for(var j=0;j<json.length;j++){
			if(j==0){
				if(style=='time'){
					raw["year"]=json[j][i].year;
					raw["month"]=json[j][i].month;
				}
			}
			raw["zb"+j]=json[j][i].idValue;
		}
		json2Excel.push(raw);
	}
	
	var raw1={};
	for(var i=0;i<json1[0].length;i++){
		raw1={};
		for(var j=0;j<json1.length;j++){
			if(j==0){
				if(style=='time'){
					raw1["year"]=json1[j][i].year;
				}
				
			}
			raw1["zb"+j]=json1[j][i].idValue;
		}
		json2Excel1.push(raw1);
	}
	download2Exl(json2Excel,json2Excel1,title,'xlsx');
}

var tmpDown; //导出的二进制对象
function download2Exl(json,json1, title, type) {
    var columnWidh=[];//列宽，每个列都要设置
    var keyMap = []; //获取键
    for (var k in json[0]) {
        keyMap.push(k);
	//暂时设置每个列宽都为100px
	    columnWidh.push({
	    	wpx : 100
	    });
    }
    var tmpdata = []; //用来保存转换好的json
    json.map(function (v, i) {
        return keyMap.map(function (k, j) {
            return Object.assign({}, {
                v: v[k],
                position: (j > 25 ? getCharCol(j) : String.fromCharCode(65 + j)) + (i + 1)
            });
        });
    }).reduce(function (prev, next) {
        return prev.concat(next);
    }).forEach(function (v, i) {
        if(v.position.indexOf("1")!=-1 && v.position.length == 2){
			tmpdata[v.position] = {
		            v: v.v,
		            t: 's',//设置为字符串
		            
		        }; 
		}else{
			tmpdata[v.position] = {
		            v: v.v,
		            t: 'n',//设置为number
		            z: '#,##0.00_',//不强制保留两位小数,千分位表示
		            s:{ fgColor: '00FF0000',bgColor :'FF000000'}
					 
		        }; 
		}
	    return tmpdata;
    });
    
     var columnWidh1=[];//列宽，每个列都要设置
    var keyMap1 = []; //获取键
    for (var k in json1[0]) {
        keyMap1.push(k);
	//暂时设置每个列宽都为100px
	    columnWidh1.push({
	    	wpx : 100
	    });
    }
    var tmpdata1 = []; //用来保存转换好的json
    json1.map(function (v, i) {
        return keyMap1.map(function (k, j) {
            return Object.assign({}, {
                v: v[k],
                position: (j > 25 ? getCharCol(j) : String.fromCharCode(65 + j)) + (i + 1)
            });
        });
    }).reduce(function (prev, next) {
        return prev.concat(next);
    }).forEach(function (v, i) {
        if(v.position.indexOf("1")!=-1 && v.position.length == 2){
			tmpdata1[v.position] = {
		            v: v.v,
		            t: 's',//设置为字符串
		            
		        }; 
		}else{
			tmpdata1[v.position] = {
		            v: v.v,
		            t: 'n',//设置为number
		            z: '#,##0.00_',//不强制保留两位小数,千分位表示
		            s:{ fgColor: '00FF0000',bgColor :'FF000000'}
					 
		        }; 
		}
	    return tmpdata1;
    });
    
    var outputPos = Object.keys(tmpdata); //设置区域,比如表格从A1到D10
    var outputPos1 = Object.keys(tmpdata1); //设置区域,比如表格从A1到D10
    var sheetNames = [];
    sheetNames.push("年月数据",'年份数据');
    var sheets = {};
    sheets['年月数据'] = Object.assign({}, tmpdata, //内容
    {
        '!ref': outputPos[0] + ':' + outputPos[outputPos.length - 1], //设置填充区域
        '!cols':columnWidh
    });
    sheets['年份数据'] = Object.assign({}, tmpdata1, //内容
    {
        '!ref': outputPos1[0] + ':' + outputPos1[outputPos1.length - 1], //设置填充区域
        '!cols':columnWidh1
    });
    var tmpWB = {
        SheetNames: sheetNames, //保存的表标题
        Sheets: sheets
    };
    tmpDown = new Blob([s2ab(XLSX.write(tmpWB, { bookType: type == undefined ? 'xlsx' : type, bookSST: false, type: 'binary' } //这里的数据是用来定义导出的格式类型
    ))], {
        type: ""
    }); //创建二进制对象写入转换好的字节流
    document.getElementById("hf").download = title + ".xlsx";
    var href = URL.createObjectURL(tmpDown); //创建对象超链接
    document.getElementById("hf").href = href; //绑定a标签
    document.getElementById("hf").click(); //模拟点击实现下载
    setTimeout(function () {
        //延时释放
        URL.revokeObjectURL(tmpDown); //用URL.revokeObjectURL()来释放这个object URL
    }, 100);
}




function s2ab(s) {
    //字符串转字符流
    var buf = new ArrayBuffer(s.length);
    var view = new Uint8Array(buf);
    for (var i = 0; i != s.length; ++i) view[i] = s.charCodeAt(i) & 0xFF;
    return buf;
}
// 将指定的自然数转换为26进制表示。映射关系：[0-25] -> [A-Z]。
function getCharCol(n) {
    var temCol = '',
        s = '',
        m = 0;
    while (n > 0) {
        m = n % 26 + 1;
        s = String.fromCharCode(m + 64) + s;
        n = (n - m) / 26;
    }
    return s;
}