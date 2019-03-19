/*!
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 * 
 * 通用公共方法
 * @author ThinkGem
 * @version 2014-4-29
 */
$(document).ready(function() {
	try{
		// 链接去掉虚框
		$("a").bind("focus",function() {
			if(this.blur) {this.blur()};
		});
		//所有下拉框使用select2
		if($("select").length>0){
			$("select").select2();
		}
		
		
		//解决如果是火狐浏览器，同时加载的iframe不显示的问题
		var browser=myBrowser();
		if(browser=='FF'){
			//获取当前iframe的id
			var frameId = window.frameElement && window.frameElement.id || '';
			
			var charts=document.getElementsByClassName("chart");
			if(charts.length>0){
				var box = document.getElementsByClassName("chart")[0].firstElementChild;
				if(window.getComputedStyle(box)){
					
				}else{
					setTimeout(function(){
						location.reload(); 
						 $('#myTab a[href="#'+frameId+'"]',window.parent.document).tab('show');
						 $("div #"+frameId,window.parent.document).addClass("in active");
					},3000);
				}
			}
		}
		
	}catch(err){
	   document.writeln("捕捉到例外，开始执行catch块语句 --->");
　　 　　document.writeln("错误名称: " + err.name+" ---> ");
　　 　　document.writeln("错误信息: " + err.message+" ---> ");
	}
});

// 引入js和css文件
function include(id, path, file){
	if (document.getElementById(id)==null){
        var files = typeof file == "string" ? [file] : file;
        for (var i = 0; i < files.length; i++){
            var name = files[i].replace(/^\s|\s$/g, "");
            var att = name.split('.');
            var ext = att[att.length - 1].toLowerCase();
            var isCSS = ext == "css";
            var tag = isCSS ? "link" : "script";
            var attr = isCSS ? " type='text/css' rel='stylesheet' " : " type='text/javascript' ";
            var link = (isCSS ? "href" : "src") + "='" + path + name + "'";
            document.write("<" + tag + (i==0?" id="+id:"") + attr + link + "></" + tag + ">");
        }
	}
}

// 获取URL地址参数
function getQueryString(name, url) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    if (!url || url == ""){
	    url = window.location.search;
    }else{	
    	url = url.substring(url.indexOf("?"));
    }
    r = url.substr(1).match(reg)
    if (r != null) return unescape(r[2]); return null;
}

//获取字典标签
function getDictLabel(data, value, defaultValue){
	for (var i=0; i<data.length; i++){
		var row = data[i];
		if (row.value == value){
			return row.label;
		}
	}
	return defaultValue;
}

// 打开一个窗体
function windowOpen(url, name, width, height){
	var top=parseInt((window.screen.height-height)/2,10),left=parseInt((window.screen.width-width)/2,10),
		options="location=no,menubar=no,toolbar=no,dependent=yes,minimizable=no,modal=yes,alwaysRaised=yes,"+
		"resizable=yes,scrollbars=yes,"+"width="+width+",height="+height+",top="+top+",left="+left;
	window.open(url ,name , options);
}

// 恢复提示框显示
function resetTip(){
	top.$.jBox.tip.mess = null;
}

// 关闭提示框
function closeTip(){
	top.$.jBox.closeTip();
}

//显示提示框
function showTip(mess, type, timeout, lazytime){
	resetTip();
	setTimeout(function(){
		top.$.jBox.tip(mess, (type == undefined || type == '' ? 'info' : type), {opacity:0, 
			timeout:  timeout == undefined ? 2000 : timeout});
	}, lazytime == undefined ? 500 : lazytime);
}

// 显示加载框
function loading(mess){
	if (mess == undefined || mess == ""){
		mess = "正在提交，请稍等...";
	}
	resetTip();
	top.$.jBox.tip(mess,'loading',{opacity:0});
}

// 关闭提示框
function closeLoading(){
	// 恢复提示框显示
	resetTip();
	// 关闭提示框
	closeTip();
}

// 警告对话框
function alertx(mess, closed){
	top.$.jBox.info(mess, '提示', {closed:function(){
		if (typeof closed == 'function') {
			closed();
		}
	}});
	top.$('.jbox-body .jbox-icon').css('top','55px');
}

// 确认对话框
/*function confirmx(mess, href, closed){
	top.$.jBox.confirm(mess,'系统提示',function(v,h,f){
		alert(v);
		if(v=='ok'){
			if (typeof href == 'function') {
				href();
			}else{
				resetTip(); //loading();
				location = href;
			}
		}
	},{buttonsFocus:1, closed:function(){
		if (typeof closed == 'function') {
			closed();
		}
	}});
	top.$('.jbox-body .jbox-icon').css('top','55px');
	return false;
}*/

//确认对话框
function confirmx(mess, href, closed){
	top.layer.confirm(mess, {icon: 3, title:'系统提示'}, function(index){
	    //do something
		if (typeof href == 'function') {
			href();
		}else{
			resetTip(); //loading();
			location = href;
		}
	    top.layer.close(index);
	});
	
//	top.$.jBox.confirm(mess,'系统提示',function(v,h,f){
//		if(v=='ok'){
//			if (typeof href == 'function') {
//				href();
//			}else{
//				resetTip(); //loading();
//				location = href;
//			}
//		}
//	},{buttonsFocus:1, closed:function(){
//		if (typeof closed == 'function') {
//			closed();
//		}
//	}});
//	top.$('.jbox-body .jbox-icon').css('top','55px');
	return false;
}

// 提示输入对话框
function promptx(title, lable, href, closed){
	top.$.jBox("<div class='form-search' style='padding:20px;text-align:center;'>" + lable + "：<input type='text' id='txt' name='txt'/></div>", {
			title: title, submit: function (v, h, f){
	    if (f.txt == '') {
	        top.$.jBox.tip("请输入" + lable + "。", 'error');
	        return false;
	    }
		if (typeof href == 'function') {
			href();
		}else{
			resetTip(); //loading();
			location = href + encodeURIComponent(f.txt);
		}
	},closed:function(){
		if (typeof closed == 'function') {
			closed();
		}
	}});
	return false;
}

// 添加TAB页面
function addTabPage(title, url, closeable, $this, refresh){
	top.$.fn.jerichoTab.addTab({
        tabFirer: $this,
        title: title,
        closeable: closeable == undefined,
        data: {
            dataType: 'iframe',
            dataLink: url
        }
    }).loadData(refresh != undefined);
}

// cookie操作
function cookie(name, value, options) {
    if (typeof value != 'undefined') { // name and value given, set cookie
        options = options || {};
        if (value === null) {
            value = '';
            options.expires = -1;
        }
        var expires = '';
        if (options.expires && (typeof options.expires == 'number' || options.expires.toUTCString)) {
            var date;
            if (typeof options.expires == 'number') {
                date = new Date();
                date.setTime(date.getTime() + (options.expires * 24 * 60 * 60 * 1000));
            } else {
                date = options.expires;
            }
            expires = '; expires=' + date.toUTCString(); // use expires attribute, max-age is not supported by IE
        }
        var path = options.path ? '; path=' + options.path : '';
        var domain = options.domain ? '; domain=' + options.domain : '';
        var secure = options.secure ? '; secure' : '';
        document.cookie = [name, '=', encodeURIComponent(value), expires, path, domain, secure].join('');
    } else { // only name given, get cookie
        var cookieValue = null;
        if (document.cookie && document.cookie != '') {
            var cookies = document.cookie.split(';');
            for (var i = 0; i < cookies.length; i++) {
                var cookie = jQuery.trim(cookies[i]);
                // Does this cookie string begin with the name we want?
                if (cookie.substring(0, name.length + 1) == (name + '=')) {
                    cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                    break;
                }
            }
        }
        return cookieValue;
    }
}

// 数值前补零
function pad(num, n) {
    var len = num.toString().length;
    while(len < n) {
        num = "0" + num;
        len++;
    }
    return num;
}

// 转换为日期
function strToDate(date){
	return new Date(date.replace(/-/g,"/"));
}

// 日期加减
function addDate(date, dadd){  
	date = date.valueOf();
	date = date + dadd * 24 * 60 * 60 * 1000;
	return new Date(date);  
}

//截取字符串，区别汉字和英文
function abbr(name, maxLength){  
 if(!maxLength){  
     maxLength = 20;  
 }  
 if(name==null||name.length<1){  
     return "";  
 }  
 var w = 0;//字符串长度，一个汉字长度为2   
 var s = 0;//汉字个数   
 var p = false;//判断字符串当前循环的前一个字符是否为汉字   
 var b = false;//判断字符串当前循环的字符是否为汉字   
 var nameSub;  
 for (var i=0; i<name.length; i++) {  
    if(i>1 && b==false){  
         p = false;  
    }  
    if(i>1 && b==true){  
         p = true;  
    }  
    var c = name.charCodeAt(i);  
    //单字节加1   
    if ((c >= 0x0001 && c <= 0x007e) || (0xff60<=c && c<=0xff9f)) {  
         w++;  
         b = false;  
    }else {  
         w+=2;  
         s++;  
         b = true;  
    }  
    if(w>maxLength && i<=name.length-1){  
         if(b==true && p==true){  
             nameSub = name.substring(0,i-2)+"...";  
         }  
         if(b==false && p==false){  
             nameSub = name.substring(0,i-3)+"...";  
         }  
         if(b==true && p==false){  
             nameSub = name.substring(0,i-2)+"...";  
         }  
         if(p==true){  
             nameSub = name.substring(0,i-2)+"...";  
         }  
         break;  
    }  
 }  
 if(w<=maxLength){  
     return name;  
 }  
 return nameSub;  
}

//打开对话框(添加修改)
function openDialog(title,url,width,height,target){
	if(navigator.userAgent.match(/(iPhone|iPod|Android|ios)/i)){//如果是移动端，就使用自适应大小弹窗
		width='auto';
		height='auto';
	}else{//如果是PC端，根据用户设置的width和height显示。
	
	}
	top.layer.open({
	    type: 2,  
	    area: [width, height],
	    title: title,
        maxmin: true, //开启最大化最小化按钮
	    content: url ,
	    btn: ['确定', '关闭'],
	    yes: function(index, layero){
	    	 var body =top.layer.getChildFrame('body', index);
	         var iframeWin = layero.find('iframe')[0]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
	         var inputForm = body.find('#inputForm');
	         var top_iframe;
	         if(target){
	        	 top_iframe = target;//如果指定了iframe，则在改frame中跳转
	         }else{
//	        	  top_iframe = top.getActiveTab().attr("name"); //获取当前active的tab的iframe 
	        	var myTab=$("#myTab li" , parent.document);
	        	 var href="";
	        	 $.each(myTab,function(){
	        		 if($(this).hasClass("active")){
	        			 href=$(this).children("a").attr("href");
	        			 return false;
	        		 }
	        	 })
	        	 top_iframe =href.substring(1);
	         }
	         inputForm.attr("target",top_iframe);//表单提交成功后，从服务器返回的url在当前tab中展示
	         
	        if(iframeWin.contentWindow.doSubmit() ){
	        	// top.layer.close(index);//关闭对话框。
	        	  setTimeout(function(){top.layer.close(index)}, 100);//延时0.1秒，对应360 7.1版本bug
	         }
			
		  },
		  cancel: function(index){ 
	       }
	}); 	
}
//打开对话框(添加修改)
function openDialog4More(title,url,width,height,target){
	if(navigator.userAgent.match(/(iPhone|iPod|Android|ios)/i)){//如果是移动端，就使用自适应大小弹窗
		width='auto';
		height='auto';
	}else{//如果是PC端，根据用户设置的width和height显示。
	
	}
	top.layer.open({
	    type: 2,  
	    area: [width, height],
	    title: title,
        maxmin: true, //开启最大化最小化按钮
	    content: url ,
	    btn: ['保存方案','保存方案并生成代码', '关闭'],
	    btn1: function(index, layero){
	    	   $('#flag').val('0');
	    	 var body =top.layer.getChildFrame('body', index);
	         var iframeWin = layero.find('iframe')[0]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
	         var inputForm = body.find('#inputForm');
	         var top_iframe;
	         if(target){
	        	 top_iframe = target;//如果指定了iframe，则在改frame中跳转
	         }else{
//	        	  top_iframe = top.getActiveTab().attr("name"); //获取当前active的tab的iframe 
	        	var myTab=$("#myTab li" , parent.document);
	        	 var href="";
	        	 $.each(myTab,function(){
	        		 if($(this).hasClass("active")){
	        			 href=$(this).children("a").attr("href");
	        			 return false;
	        		 }
	        	 })
	        	 top_iframe =href.substring(1);
	         }
	         inputForm.attr("target",top_iframe);//表单提交成功后，从服务器返回的url在当前tab中展示
	         
	        if(iframeWin.contentWindow.doSubmit() ){
	        	// top.layer.close(index);//关闭对话框。
	        	  setTimeout(function(){top.layer.close(index)}, 100);//延时0.1秒，对应360 7.1版本bug
	         }
			
		  },
		  btn2: function(index, layero){
	    	   
	    	 var body =top.layer.getChildFrame('body', index);
	         var iframeWin = layero.find('iframe')[0]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
	         var inputForm = body.find('#inputForm');
	         var top_iframe;
	         if(target){
	        	 top_iframe = target;//如果指定了iframe，则在改frame中跳转
	         }else{
//	        	  top_iframe = top.getActiveTab().attr("name"); //获取当前active的tab的iframe 
	        	var myTab=$("#myTab li" , parent.document);
	        	 var href="";
	        	 $.each(myTab,function(){
	        		 if($(this).hasClass("active")){
	        			 href=$(this).children("a").attr("href");
	        			 return false;
	        		 }
	        	 })
	        	   var flag = body.find('#flag');
	        	 flag.val('1');
	        	 top_iframe =href.substring(1);
	         }
	         inputForm.attr("target",top_iframe);//表单提交成功后，从服务器返回的url在当前tab中展示
	         
	        if(iframeWin.contentWindow.doSubmit() ){
	        	// top.layer.close(index);//关闭对话框。
	        	  setTimeout(function(){top.layer.close(index)}, 100);//延时0.1秒，对应360 7.1版本bug
	         }
			
		  },
		  cancel: function(index){ 
	       }
	}); 	
}
//打开对话框(查看)
function openDialogView(title,url,width,height){
	if(navigator.userAgent.match(/(iPhone|iPod|Android|ios)/i)){//如果是移动端，就使用自适应大小弹窗
		width='auto';
		height='auto';
	}else{//如果是PC端，根据用户设置的width和height显示。
	
	}
	top.layer.open({
	    type: 2,  
	    area: [width, height],
	    title: title,
        maxmin: true, //开启最大化最小化按钮
	    content: url ,
	    btn: ['关闭'],
	    cancel: function(index){ 
	       }
	}); 
	
}

function search(){//查询，页码清零
	$("#pageNo").val(0);
	$("#searchForm").submit();
		return false;
}

function reset(){//重置，页码清零
	$("#pageNo").val(0);
	$("#searchForm div.form-group input").val("");
	$("#searchForm div.form-group select").val("");
	$("#searchForm").submit();
		return false;
	 }

function sortOrRefresh(){//刷新或者排序，页码不清零
	$("#searchForm").submit();
		return false;
}

function isArray(object){
    return object && typeof object==='object' &&
            Array == object.constructor;
}
function isIE() { //ie?      
	var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串
	var isOpera = userAgent.indexOf("Opera") > -1;
	if (userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1 && !isOpera) {
        return true;
    }else{
    	return false;
    }
}
//js得到浏览器的类型
function myBrowser(){
    var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串
    var isOpera = userAgent.indexOf("Opera") > -1;
    if (isOpera) {
        return "Opera"
    }; //判断是否Opera浏览器
    if (userAgent.indexOf("Firefox") > -1) {
        return "FF";
    } //判断是否Firefox浏览器
    if (userAgent.indexOf("Chrome") > -1){
	  return "Chrome";
	 }
    if (userAgent.indexOf("Safari") > -1) {
        return "Safari";
    } //判断是否Safari浏览器
    if (userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1 && !isOpera) {
        return "IE";
    }; //判断是否IE浏览器
}
//动态加载js，火狐浏览器
function load(js){
    var s = document.createElement('script');  
    s.setAttribute('type','text/javascript');  
    s.setAttribute('src',js);  
    var head = document.getElementsByTagName('head');  
    head[0].appendChild(s);  
}
//数据显示口径解释
function showExplain(msg){
	layer.msg(msg,
	 {
		 closeBtn:2,
		 time: 20000, //20s后自动关闭
 	 });
}


//将数字转化为千分位
function parseNum(num){  
	var num = num+ "";
	var reg=/(?=(?!\b)(\d{3})+$)/g; 
	if(num.indexOf(".") == -1){
		return num.replace(reg, ',');
	}else{
		//var zhengshu = num.substr(0,num.length-3);
		var zhengshu = num.substr(0,num.indexOf("."));
		//var xiaoshu = num.substr(num.length-3,3);
		var xiaoshu = num.substr(num.indexOf("."),3);
	    return zhengshu.replace(reg, ',')+xiaoshu;  
	}
} 

//时间和地域两张图表legened关联
function legendselectchangedFunc(params){
	var name = params.name;
	var flag = params.selected[name];
	if(flag){
		areaChart.dispatchAction({
		    type: 'legendSelect',
		    name: name
		});
		timeChart.dispatchAction({
		    type: 'legendSelect',
		    name: name
		})
	}else{
		areaChart.dispatchAction({
		    type: 'legendUnSelect',
		    name: name
		});
		timeChart.dispatchAction({
		    type: 'legendUnSelect',
		    name: name
		}) 
	}
}

//时间格式化
Date.prototype.format = function(fmt) { 
    var o = { 
       "M+" : this.getMonth()+1,                 //月份 
       "d+" : this.getDate(),                    //日 
       "h+" : this.getHours(),                   //小时 
       "m+" : this.getMinutes(),                 //分 
       "s+" : this.getSeconds(),                 //秒 
       "q+" : Math.floor((this.getMonth()+3)/3), //季度 
       "S"  : this.getMilliseconds()             //毫秒 
   }; 
   if(/(y+)/.test(fmt)) {
           fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
   }
    for(var k in o) {
       if(new RegExp("("+ k +")").test(fmt)){
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
        }
    }
   return fmt; 
}

//页面加水印
function watermark(settings) {
	   var height = document.body.scrollHeight;
	   var watermarkCols = parseInt(height/(100+80))+1;
     //默认设置
     var defaultSettings={
     		watermark_txt:"text",
             watermark_x:20,//水印起始位置x轴坐标
             watermark_y:20,//水印起始位置Y轴坐标
             /* watermark_rows:20,//水印行数
             watermark_cols:20,//水印列数 */
             watermark_rows:watermarkCols,//水印行数
             watermark_cols:watermarkCols,//水印列数
             watermark_x_space:200,//水印x轴间隔
             watermark_y_space:100,//水印y轴间隔
             watermark_color:'#aaa',//水印字体颜色
             watermark_alpha:0.4,//水印透明度
             watermark_fontsize:'15px',//水印字体大小
             watermark_font:'微软雅黑',//水印字体
             watermark_width:250,//水印宽度
             watermark_height:80,//水印长度
             watermark_angle:15//水印倾斜度数
     };
     //采用配置项替换默认值，作用类似jquery.extend
     if(arguments.length===1&&typeof arguments[0] ==="object" )
     {
         var src=arguments[0]||{};
         for(key in src)
         {
             if(src[key]&&defaultSettings[key]&&src[key]===defaultSettings[key])
                 continue;
             else if(src[key])
                 defaultSettings[key]=src[key];
         }
     }

     var oTemp = document.createDocumentFragment();

     //获取页面最大宽度
     var page_width = Math.max(document.body.scrollWidth,document.body.clientWidth);
     var cutWidth = page_width*0.0150;
     var page_width=page_width-cutWidth;
     //获取页面最大高度
     var page_height = Math.max(document.body.scrollHeight,document.body.clientHeight)+450;
     // var page_height = document.body.scrollHeight+document.body.scrollTop;
     //如果将水印列数设置为0，或水印列数设置过大，超过页面最大宽度，则重新计算水印列数和水印x轴间隔
     if (defaultSettings.watermark_cols == 0 || (parseInt(defaultSettings.watermark_x + defaultSettings.watermark_width *defaultSettings.watermark_cols + defaultSettings.watermark_x_space * (defaultSettings.watermark_cols - 1)) > page_width)) {
         defaultSettings.watermark_cols = parseInt((page_width-defaultSettings.watermark_x+defaultSettings.watermark_x_space) / (defaultSettings.watermark_width + defaultSettings.watermark_x_space));
         defaultSettings.watermark_x_space = parseInt((page_width - defaultSettings.watermark_x - defaultSettings.watermark_width * defaultSettings.watermark_cols) / (defaultSettings.watermark_cols - 1));
     }
     //如果将水印行数设置为0，或水印行数设置过大，超过页面最大长度，则重新计算水印行数和水印y轴间隔
     if (defaultSettings.watermark_rows == 0 || (parseInt(defaultSettings.watermark_y + defaultSettings.watermark_height * defaultSettings.watermark_rows + defaultSettings.watermark_y_space * (defaultSettings.watermark_rows - 1)) > page_height)) {
         defaultSettings.watermark_rows = parseInt((defaultSettings.watermark_y_space + page_height - defaultSettings.watermark_y) / (defaultSettings.watermark_height + defaultSettings.watermark_y_space));
         defaultSettings.watermark_y_space = parseInt(((page_height - defaultSettings.watermark_y) - defaultSettings.watermark_height * defaultSettings.watermark_rows) / (defaultSettings.watermark_rows - 1));
     }
     var x;
     var y;
     for (var i = 0; i < defaultSettings.watermark_rows; i++) {
         y = defaultSettings.watermark_y + (defaultSettings.watermark_y_space + defaultSettings.watermark_height) * i;
         for (var j = 0; j < defaultSettings.watermark_cols; j++) {
             x = defaultSettings.watermark_x + (defaultSettings.watermark_width + defaultSettings.watermark_x_space) * j;

             var mask_div = document.createElement('div');
             mask_div.id = 'mask_div' + i + j;
             mask_div.className = 'mask_div';
             
             mask_div.appendChild(document.createTextNode(defaultSettings.watermark_txt));
             //设置水印div倾斜显示
             mask_div.style.webkitTransform = "rotate(-" + defaultSettings.watermark_angle + "deg)";
             mask_div.style.MozTransform = "rotate(-" + defaultSettings.watermark_angle + "deg)";
             mask_div.style.msTransform = "rotate(-" + defaultSettings.watermark_angle + "deg)";
             mask_div.style.OTransform = "rotate(-" + defaultSettings.watermark_angle + "deg)";
             mask_div.style.transform = "rotate(-" + defaultSettings.watermark_angle + "deg)";
             mask_div.style.visibility = "";
             mask_div.style.position = "absolute";
             mask_div.style.left = x + 'px';
             mask_div.style.top = y + 'px';
             mask_div.style.overflow = "hidden";
             mask_div.style.zIndex = "9999";
             mask_div.style.pointerEvents='none';//pointer-events:none  让水印不遮挡页面的点击事件
             //mask_div.style.border="solid #eee 1px";
             mask_div.style.opacity = defaultSettings.watermark_alpha;
             mask_div.style.fontSize = defaultSettings.watermark_fontsize;
             mask_div.style.fontFamily = defaultSettings.watermark_font;
             mask_div.style.color = defaultSettings.watermark_color;
             mask_div.style.textAlign = "center";
             mask_div.style.width = defaultSettings.watermark_width + 'px';
             mask_div.style.height = defaultSettings.watermark_height + 'px';
             mask_div.style.display = "block";
             oTemp.appendChild(mask_div);
         };
     };
     document.body.appendChild(oTemp);
 }


