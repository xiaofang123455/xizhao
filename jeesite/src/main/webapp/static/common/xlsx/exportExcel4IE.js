/**
 * 导出到excel,只能导出一个sheet
 * option : 图的option，通过option拿标题和数据
 * style ： 类型，根据当前的图，将类型分为三种，year(年)，month(月)，area（地域）
 * json ： 需要解析的json数据
 */
function excel(option,style,json){
	var lengend=option.legend[0].data;
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
    downloadExl(json2Excel,title);
}

//IE浏览器下导出json数据到excel，支持xlsx
var idTmr;  
function downloadExl(json,title) {
    var oXL = new ActiveXObject("Excel.Application");  
    var oWB = oXL.Workbooks.Add();  
    var oSheet = oWB.Worksheets(1);
    var Lenr = json.length;  
    var keyMap = [];//获取键
    for(k in json[0]) {
        keyMap.push(k);
    }
    var Lenc = keyMap.length; 
    for (i = 0; i < Lenr; i++)  
    {        
        for (j = 0; j < Lenc; j++)  
        {  
            oSheet.Cells(i + 1, j + 1).value = json[i][keyMap[j]]; 
            //设置千分位表示
            var ifNum=Number(false);
            if (!isNaN(ifNum) && i!=0 && j!=0 )
            {
            	oSheet.Cells(i + 1, j + 1).NumberFormatLocal  = "#,##0.00;[红色]-#,##0.00";
            }
        };  
        oSheet.Columns(i+1).ColumnWidth =100; //列的宽度
        oSheet.Columns(i+1).HorizontalAlignment =-4108; //水平居中
        oSheet.Columns(i+1).VerticalAlignment =-4108; //垂直居中
    }  
    
    oSheet.name=title;
    oXL.Visible = true; 
    //oSheet.Columns("A:E").ColumnWidth =100; 
    oSheet.Columns.AutoFit;
    try {
        var fname = oXL.Application.GetSaveAsFilename(title+".xlsx", "Excel Spreadsheets (*.xlsx), *.xlsx");
    } catch (e) {
        print("Nested catch caught " + e);
    } finally {
        oWB.SaveAs(fname);
        oWB.Close(savechanges = false);
        //xls.visible = false;
        oXL.Quit();
        oXL = null;
        //结束excel进程，退出完成
        //window.setInterval("Cleanup();",1);
        idTmr = window.setInterval("Cleanup();", 1);

    }
}   
function Cleanup() {  
    window.clearInterval(idTmr);  
    CollectGarbage();  
}  


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


//IE浏览器下导出json数据到excel，支持xlsx
var idTmr;  
function download2Exl(json,json1, title) {
    var oXL = new ActiveXObject("Excel.Application");  
    var oWB = oXL.Workbooks.Add();  
    var oSheet = oWB.Worksheets(1);
    var Lenr = json.length;  
    var keyMap = [];//获取键
    for(k in json[0]) {
        keyMap.push(k);
    }
    var Lenc = keyMap.length; 
    for (i = 0; i < Lenr; i++)  
    {        
        for (j = 0; j < Lenc; j++)  
        {  
            oSheet.Cells(i + 1, j + 1).value = json[i][keyMap[j]]; 
            var ifNum=Number(false);
            if (!isNaN(ifNum) && i!=0 && j!=0  && j!=1)
            {
            	oSheet.Cells(i + 1, j + 1).NumberFormatLocal  = "#,##0.00;[红色]-#,##0.00";
            }
        }; 
        oSheet.Columns(i+1).ColumnWidth =100; //列的宽度
        oSheet.Columns(i+1).HorizontalAlignment =-4108; //水平居中
        oSheet.Columns(i+1).VerticalAlignment =-4108; //垂直居中
    }  
    
    var oSheet1 = oWB.Worksheets(2);
    var Lenr1 = json1.length;  
    var keyMap1 = [];//获取键
    for(k in json1[0]) {
        keyMap1.push(k);
    }
    var Lenc1 = keyMap1.length; 
    for (i = 0; i < Lenr1; i++)  
    {        
        for (j = 0; j < Lenc1; j++)  
        {  
            oSheet1.Cells(i + 1, j + 1).value = json1[i][keyMap1[j]]; 
            //设置数字显示为千分位
            var ifNum=Number(false);
            if (!isNaN(ifNum) && i!=0 && j!=0)
            {
            	oSheet1.Cells(i + 1, j + 1).NumberFormatLocal  = "#,##0.00;[红色]-#,##0.00";
            }
            
        }  
        oSheet1.Columns(i+1).ColumnWidth =100; //列的宽度
        oSheet1.Columns(i+1).HorizontalAlignment =-4108; //水平居中
        oSheet1.Columns(i+1).VerticalAlignment =-4108; //垂直居中
    }  
    
    oSheet.name="年月数据";
    oSheet.Columns.AutoFit;
    
    oSheet1.name="年份数据";
    oXL.Visible = true; 
    oSheet1.Columns.AutoFit;
    try {
        var fname = oXL.Application.GetSaveAsFilename(title+".xlsx", "Excel Spreadsheets (*.xlsx), *.xlsx");
    } catch (e) {
        print("Nested catch caught " + e);
    } finally {
        oWB.SaveAs(fname);
        oWB.Close(savechanges = false);
        //xls.visible = false;
        oXL.Quit();
        oXL = null;
        //结束excel进程，退出完成
        //window.setInterval("Cleanup();",1);
        idTmr = window.setInterval("Cleanup();", 1);

    }
}  