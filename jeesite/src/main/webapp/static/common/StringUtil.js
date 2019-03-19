/*
 *AJDX调用后面的方法
 */
function Tool_Ajax(url,param,dataType)
{ 
	var resultData;
	var _dataType = dataType || "text";
	url += url.indexOf("?")>-1?"&":"?";
	$.ajax({
		   async: false, 
		   type: "post",
		   url: url + Math.random(),
		   data: param,
		   dataType: _dataType,
		   success:function(data){
		   		resultData=data;
		   }
	});
	return resultData;
};

/** 异步ajax */
function Tool_Ajax_Async(url,param,dataType){
	dataType = dataType || "text";
	url += url.indexOf("?")>-1?"&":"?";
	return $.ajax({
		   async: true, 
		   type: "post",
		   url: url + Math.random(),
		   data: param,
		   dataType: dataType/*, 
		   error: function (XMLHttpRequest, textStatus, errorThrown) {
			   if(XMLHttpRequest.responseText.indexOf("登录超时")>=0){
				   var x = XMLHttpRequest.responseText.split('|');
				   $.messager.alert("错误","ajax请求错误："+x[0],"error",function(){
					   window.parent.location.href= x[1];  
				   });
			   }else{
				   $.messager.alert("错误","ajax请求错误："+XMLHttpRequest.responseText,"error");
			   }
	       }*/
		});
};


/** ************************非空验证******************************************* */
// 验证字符串是否为空
String.prototype.isEmpty = function()
{

	if (this == null || this == "" || this == "undefined" || this.Trim() == "" || this.Trim().length == 0 || this == "''")
	{
		return false;
	}
	return true;
};
// 去掉字符串两端空格
String.prototype.Trim = function()
{

	return this.replace(/(^\s*)|(\s*$)/g, "");
};
// 去掉字符串左端空格
String.prototype.LTrim = function()
{

	return this.replace(/(^\s*)/g, "");
};
// 去掉字符串右端空格
String.prototype.RTrim = function()
{
		return this.replace(/(\s*$)/g, "");
};
//替换所有
String.prototype.replaceAll = function(s1,s2) { 
    return this.replace(new RegExp(s1,"gm"),s2); 
}


// 对于超长字符串的截取 加入 "..."
String.prototype.LSplit = function(len)
{
	return (this.length > len ? this.substring(0,len)+"..." : this);
};


// 判断字符串对象是否为null
function isStringNull(pram)
{
	param = (pram + '').Trim();
	if (isNull(pram) && (pram + '').isEmpty() && (pram + '').Trim() != 'null' && (pram + '').Trim() != 'NULL' && (pram + '').Trim() != 'undefined')
	{
		return true;
	}
	return false;
};

// 判断对象是否为null
function isNull(pram)
{
	if (typeof(pram) == "undefined" || pram == null)
	{
		return false;
	}
	return true;
};


/** ************REDIS数据处理******************** */
/**
 * 根据redis取出的json数组进行转换成一个新的json对象
 * 
 * @param arr
 *            从redis获取的数组
 */
function redisArrToJson(arr){
	var json={};
	if(isNull(arr) && arr!=""){
		if(typeof(arr)=="string")
			arr = $.parseJSON(arr);
		$.each(arr,function(i , v){
			json[v["key"]] = v["value"];
		});
	}
	return json;
};

/**
 * combobox自动选中 或虽入请选择
 * 
 * @param id
 *            combobox的id
 * @param strArr
 *            JSON数组字符串
 * @param 要选中的key值
 *            可选
 */
function setSelectCombo(id,strArr,key){
	if(!isStringNull(key)){// 为空默认加上请选择
		analyRedisArrayData(id,strArr);
		return;
	}
	var data=[];
	data.push({"value":"请选择","key":""});
	if(isStringNull(strArr)&&strArr!="[]"){
		var jsonArray=$.parseJSON(strArr);
		for(var i=0; i<jsonArray.length; i++){
			if(jsonArray[i].key==key){
				jsonArray[i].selected=true;
			}
			data.push(jsonArray[i]);
		}
	}
	$("#" +id).combobox({
		data:data,
		valueField:'key',
		textField:'value',
		panelHeight:'auto',
		editable:false
	});
};
/**
 * <input id="dd" class ="easyui-combobox"> combobox自动选中 扩展 json
 * {id:combobox的id,data:加载的数组,dataStr:加载的数组字符串,selectedKey:被选中的键,key:key键的对应,
 * value:value键的对应,name:初始化的名称,onSelect:选中的参数,joinable:是否加入请选选择默认true}
 */
function setSelectComboEx(json){
	// 默认值的设定
	if(!json.key)
		json.key="key";
	if(!json.value)
		json.value="value";
	if(!json.name)
		json.name="请选择";
	var data=[];
	// 默认加入空值域
	if(!isNull(json.joinable) || json.joinable){
		var defaultJson = {};
		var temp = json.value;
		defaultJson[temp] = json.name;
		temp = json.key;
		defaultJson[temp] = "";
		data.push(defaultJson);
	}
	// 数据源获取
	var jsonArray = json.data
	if(!jsonArray){
		jsonArray = $.parseJSON(json.dataStr);
	}
	var len = jsonArray.length;
	// 传入设定的selectedKey自动选中，否则选择空的那个
	if(json.selectedKey){
		for(var i=0; i<len; i++){
			if(jsonArray[i][json.key]==json.selectedKey){
				jsonArray[i].selected=true;
			}
			data.push(jsonArray[i]);
		}
	}else{
		for(var i=0; i<len; i++){
			data.push(jsonArray[i]);
		}
		// if(len==1){
			// data[1].selected=true;
		// }else{
			data[0].selected=true;
		// }
			
	}
	// 设定
	$("#" +json.id).combobox({
		data:data,
		valueField:json.key,
		textField:json.value,
		panelHeight:'auto',
		editable:false,
		onSelect:json.onSelect,
		onUnselect:json.onUnselect,
		multiple:json.multiple
	});
};

/**
 * 绑定计数与自动增长 textarea里加入maxlength属性
 * @param obj 绑定的对象  
 * @param init_height 初始化高度
 */
function bindTextare(obj,init_height){
	obj = obj ? obj instanceof jQuery ? obj : $(obj) : $("textarea");//默认是所有的textarea绑定
	init_height = init_height ? init_height : 80;//默认初始化最小高度为80
	$("textarea").css("overflow","hidden");
	var emDom ;
	obj.each(function(){
		$(this).height(init_height);
		if(!$(this).attr("maxlength")){return;}
		// 此处不能通用，根据不同页面进行调整
		if($(this).parent()[0].tagName=="TD" && $(this).parent().prev().length>0 && ($(this).parent().prev()[0].tagName=="TH" || $(this).parent().prev()[0].tagName=="TD")){
			if($(this).parent().prev().find('em').length==0){
				$(this).parent().prev().append("<br><span class='spnsty'>(剩余<em>"+$(this).attr("maxlength")+"</em>字)</span>");
			}else{
				$(this).parent().prev().find('em').text($(this).attr("maxlength"));
			}
			emDom = 1;//第一种情况 最新表单页面<th>注释</th><td><textarea>文字</textarea></td>
		}else{
			if($(this).prev()[0] && $(this).prev()[0].tagName=="TD"){
				if($(this).parent().siblings().find('em').length==0){
					$(this).parent().siblings().append("<br><span class='spnsty'>(剩余<em>"+$(this).attr("maxlength")+"</em>字)</span>");
				}
				emDom = 2;//<span>注释</span><textarea>文字</textarea> 前一个标签处
			}
			else{
				if($(this).prev().find('em').length==0){
					$(this).prev().append("<br><span class='spnsty'>(剩余<em>"+$(this).attr("maxlength")+"</em>字)</span>");
				}
				emDom = 3;
			}
		}
	});
	//判断浏览器   火狐浏览器 与IE11自动增长 且判断高度加10
	var hBrowser = false; 
	var IE8Browser= false;
	 if(navigator.userAgent.indexOf("Firefox") > 0 || navigator.userAgent.indexOf("rv:11.0") > 0){
		 hBrowser = true;
	 }else if(navigator.userAgent.split(";")[1].toLowerCase().indexOf("msie 8.0") > 0){
		 IE8Browser = true;
	 }
	init_height = hBrowser ? init_height -10 : init_height;
	obj.bind("keydown keyup input propertychange",function(event){
		//统一设定textarea的最小高度   修正 火狐 及IE11自动增长问题
		if(hBrowser){$(this).height(Math.max(init_height ,$(this).height()-20 ));}
		var textarea = this;
		//IE8进行延时处理
		if(IE8Browser){
			setTimeout(function(){changeTextarea(textarea,init_height)},1);
		}else{
			changeTextarea(textarea,init_height);
		}
    });
};
//改变textarea的高度及文本控制
function changeTextarea(obj,init_height){
	var textarea = $(obj);
	var height = Math.max(obj.scrollHeight,init_height); 
	//textarea.height(height);//alert(this.scrollHeight + "," +　$(this).height());
	obj.style.height = height+'px';
	var em;
	//定义三种情况 
	if(textarea.parent()[0].tagName=="TD" && textarea.parent().prev().length>0 && textarea.parent().prev()[0].tagName=="TH"){
		em = textarea.parent().prev().find("em")
	}else{
		if($(obj).prev()[0] && $(obj).prev()[0].tagName=="TD"){
			em = textarea.parent().siblings().find("em");
		}
		else{
			em = textarea.prev().find("em");
		}
	}
	var len =textarea.val().length;
	var lens = textarea.attr("maxlength")*1;
	var remain = lens - len;
	// 文字超出
	if(remain<0){
		var content = textarea.val().substring(0,lens);
		textarea.val(content);
	}else if(em.length>0){
		$(em).text(remain);
	}
};

/** ********自定义alert********* */
function myAlert(alertContent,type){
	if(!type)
		type="info";
	$.messager.alert("提示",alertContent,type);
	
};

/** ***********解决公用div弹出样式问题***************** */
/**
 * 动态加入样式文件
 */
function addCSS(path) {
    var link = document.createElement('link');
    link.type = 'text/css';
    link.rel = 'stylesheet';
    link.href = curProjectUrl + path;
    // document.getElementsByTagName("head")[0].appendChild(link);
    $("head").append(link);
};

/**
 * 获取URL参数值 url ：URL name ：参数名
 */
function Page_GetUrlParamValue(url, name)
{

	if (url == null || url == "")
	{
		msg_error_debug = "Page_GetUrlParamValue函数的第一个参数为空!";
		return null;
	}
	if (name == null || name == "")
	{
		msg_error_debug = "Page_GetUrlParamValue函数的第二个参数为空!";
		return null;
	}

	var s = unescape(url);
	var reg = new RegExp("&?" + name + "=([^&]*)", "i");
	var arr = s.match(reg);
	if (arr == null)
		return null;
	else
		return arr[1];
};

/**
 * 打开新的easyui-window窗口
 * 
 * @param
 * json{id:新窗口的DIV的id,title:窗口名称,url:窗口跳转的页面,top:离项部高度,width:宽度,height:高度}
 * 注：窗口div id 获取${param.winid}
 */
function openWin(json){
	var id = json.id;
	if(!isStringNull(id)){
		myAlert("传入参数不正确");
		return;
	}
	// 动态添加一个DIV <div id="selUserWin"></div>
	if($("#"+id).length > 0 && $("#"+id).hasClass("window-body")){
		$("#"+id).window("destroy",true);//销毁原有窗口
		$(".window-mask").remove();//移除模态
	}
	var win = $("<div id='"+id+"' style='overflow:hidden;'></div>");
	$("body").append(win);
	var modal = true;
	if(json.modal)
	{
		modal = json.modal;
	}
	// 窗口默认参数
	var winParam = {
			title:json.title || "",
		    zIndex:5,
		    collapsible:false,
		    minimizable:false,
		    maximizable:false,
		    resizable:false,
		    draggable:false,
		    shadow:false,
		    cache:false,
		    modal:modal,
			onClose:function(){ 
				  //if(loadSuccess)
					  //$("#"+id).window("destroy",true);
			},
		    onLoad:function(){
		    	if(isStringNull(json.position)){
		    		// 绝对定位  浮动  
		    		if(json.position == true){
		    			$(".window").css("position","fixed");
		    		}else{
		    			// 根据页面相对定位
				    	var top = $(document).scrollTop() + json.top*1 || 0; 
				    	var left = $(document).scrollLeft(); 
				    	$("#"+id).parent().css({"top":top+"px"});
				    	$(".window-shadow").css({"top":top+"px"});
		    		}
		    	}
		    	//$(document.activeElement).blur();
		    	changeMask(id);
		    }
		};
	// 窗口跳转的页面
	if(isStringNull(json.url)){
		var url = json.url;
		winParam.href = json.url;
	}
	$.extend(winParam,json);
	winParam.href += (winParam.href.indexOf("?")>0 ? "&winid="+id : "?winid="+id);
	$("#"+id).window(winParam);
};

function changeMask(id){
	//阴影层控制
	setTimeout(function(){
    	var height = Math.max($("#"+id).parent().height(), $(".window-mask").height(), $(document).height());
    	//alert($("#"+id).parent().height()+ " "+ $("#"+id).parent().parent().find(".window-mask").height()+" "+ $(document).height() +" " +height);
    	//$(".window-mask")[0].style.height = height +"px";//保证IE8
		$(".window-mask").height(height);
	},200);
};

var paramsG;
/**
 * 其它文档
 * 
 * @param params
 *            {bookmarks：模版标签赋值变量,callback:回调}
 */
function com_otherDoc(params){
	paramsG = params;
	var width = 1000;// window.screen.width-300; //窗口宽度
	var height = window.screen.height-200; // 窗口高度
	var resizable = "No"; // 是否可调整大小
	var wtop=(window.screen.height-height)/2;
	var wleft=(window.screen.width-width)/2;
	var url = curProjectUrl + "/template/otherDocCom.do?&height="+height+"&width="+width;
	window.open(url,"其它文档","height=" + height + ",width=" + width + ", resizable="+ resizable +",status=yes,center=yes,top=" + wtop + ",left=" + wleft);
};

/**
 * 设定只读的样式
 * 
 * @param dom
 *            指定节点之下的 不指定为整个body
 *            注：input 含有onclick 或onClick 属性 或者加有 nosetreadonly样式直接 不添加只读样式 
 */
function setReadonlyClass(dom){
	// 判断 是否是jquery对象
	if(dom)
	{
		dom  = dom instanceof jQuery ?dom:$(dom);// 转换为jquery对象
	}else
	{
		dom = $("body");
	}
	// 非下拉框的只读input
	dom.find("input[readonly='readonly']").each(function(){
		if(!$(this).attr("onclick") || !$(this).attr("onClick")){
			if($(this).hasClass("combo-text")){
				// 只读的下拉框不做任何操作 只对disabled加入样式
			}else{
				if(!$(this).hasClass("nosetreadonly"))
					$(this).addClass("validatebox-text200");
			}
		}
	});
	var $combo = dom.find(".combo-text");
	if($combo.length>0){
		// 对于默认的下拉框editable=false 移除disabled 加入 readonly
		dom.find(".combo-text[disabled='disabled']").addClass("combo-text200").removeAttr("disabled").attr("readonly","readonly");
	}
};

/* 验证信息的显示与隐藏 */
function NoticeViewerFun_rt(t,g){
	// 右上提示信息
	var obj = $(g), em = $(t);
	if(obj.is(':visible')){
		em.css({display:"block"});
		obj.slideUp(350);
	}else{
		if($(".NoticeError_G_rt .m p").length>0){
			em.css({display:"none"});
			obj.slideDown(350).show();
		}
	}
};

/**
 * 添加右上校验提示图标
 * 
 * @param o
 *            验证错误信息提示位置 此dom标签的下方（o可为标签id或标签对象）
 *            注：由于宽度限制至少是右边第二个按钮
 */
function NoticeError_Join(o){
	var $obj = typeof(o)==="string" ? $("#"+o) : o instanceof jQuery ? o : $(o);
	if($obj.length==0){return ! 1;}
	if($obj.parent().attr("id")=="zbiti_submit"){return ! 1;}
	$obj.wrap("<div style='position:relative;display:inline-block;z-index:999;over-flow:auto' class='zbiti_submit' id='zbiti_submit'></div>");
	var errFrame="<a title='点击展开错误提醒' href='javascript:;' class='NoticeError_T_rt' style='display: block;right:auto;bottom: -18px; position: absolute;margin-left:3px;'></a>"
		+"<div class='NoticeViewer NoticeError_G_rt' style='width: 400px;display: none;right:auto;top: 30px;margin-left: -260px;'>"
			+"<table>"
				+"<tbody><tr><td class='u' colspan='3'><table><tbody><tr><td class='u_l'>&nbsp;</td><td class='u_c'>&nbsp;</td><td class='u_i'>&nbsp;</td><td width='90' class='u_c'>&nbsp;</td><td class='u_r'>&nbsp;</td></tr></tbody></table></td></tr>"
					+"<tr class='c'><td class='c_l'>&nbsp;</td><td class='c_c'>"
						+"<div class='m'>"
							+"<b><a href='javascript:;'>关闭X</a>错误提醒</b>"
							//+"<p><strong>填表标题</strong><br><i class='i_com'></i> 未填内容、未填内容、未填内容、未填内容、未填内容</p>"
						+"</div>"
					+"</td><td class='c_r'>&nbsp;</td></tr>"
					+"<tr class='d'><td class='d_l'>&nbsp;</td><td class='d_c'>&nbsp;</td><td class='d_r'>&nbsp;</td></tr>"
				+"</tbody>"
			+"</table>"
			+"<div align='center' style='line-height:0;margin-top:-1px;'><a title='点击收缩错误提醒' href='javascript:;' class='up'></a></div>"
		+"</div>";
	$obj.parent().append(errFrame);
	
	//控制显示
	if($obj.is("hidden")){
		$obj.parent().hide();
	}
	
	// 错误提示_右上 [提交按钮]
	if($(".NoticeError_T_rt").length>0){
		function NoticeError_T_Fun_rt(){ NoticeViewerFun_rt(".NoticeError_T_rt",".NoticeError_G_rt"); }
		// NoticeError_T_Fun_rt(); //该函数为错误函数隐藏框按钮提醒
		$(".NoticeError_T_rt").click(function(){ NoticeError_T_Fun_rt(); });
		// 提交按钮点击
		// $("#asubmit").click(function(){ NoticeError_T_Fun_rt(); });
		$(".NoticeError_G_rt .m b a").click(function(){ NoticeError_T_Fun_rt();}); // 关闭按钮点击
		$(".NoticeError_G_rt .up").click(function(){ NoticeError_T_Fun_rt(); });
	}
};

/** 清除验证错误信息 */
function NoticeError_Clear(o){
	if(o){
		var $obj = typeof(o)==="string" ? $("#"+o) : o instanceof jQuery ? o : $(o);
		$obj.parent().find(".m p").remove();
	}else{
		$(".NoticeError_G_rt .m p").remove();
	}
};

/**
 * 显示错误信息 传入参数支持三种类型 字符串类型、字符串数组、json类型
 *    字符串类型直接显示文字
 *    字符串数组显示字符并换行
 *    json类型 其key 对应着错误信息的标题 value为其标题下的错误信息 (可以为数组)
 * @param e
 *            错误提示信息
 */
function NoticeError_Show(e){
	if(!e){return !1;}
	// 清除原有错误信息
	NoticeError_Clear();
	//添加的文字
	var p = "<p><i class='i_com'></i></p>";
	var $m = $(".NoticeError_G_rt .m");//添加验证信息的对象
	// 传入参数两种类型判断 字符串或 json类型
	//字符串 处理成数组
	if(typeof(e)==="string"){
		e = [e];
	}
	var arrayable = e instanceof Array;//是否为数组
	//没有验证提示的页面进行原始提示
	if($m.length==0){
		$.messager.alert("提示",(arrayable ? e.toString() : JSON.stringify(e)));
		return;
	}
	//遍历数组或json数组
	for(var i in e){
		var $p = $(p);
		if(arrayable){//数组形式 字符串数组
			if(!isStringNull(e[i])){continue;}
			$m.append($p.append(e[i]));
		}else{//json对象
			if(isStringNull(i)){
				$p = $p.prepend($("<strong style='font-weight: bold;'>"+i+"</strong><br/>"));
			}
			var s = e[i];
			s = typeof(s)==="string" ? [s] : s;
			for(var y in s){
				var $t = y==0 ? $p : $(p);//第一个添加标题 其它加入标点
				$m.append($t.append(s[y]));
			}
		}
	}
	// 显示验证提示信息
	$(".NoticeError_T_rt").css({display:"none"});
	if(!$(".NoticeError_G_rt").is(':visible'))
		$(".NoticeError_G_rt").slideUp(350).show();
};
/**
 * 销毁验证提示框
 * @param o 指定当时绑定的dom对象 不指定则删除页面所有
 */
function NoticeError_Destroy(o){
	if(o){
		var $obj = typeof(o)==="string" ? $("#"+o) : o instanceof jQuery ? o : $(o);
		if($obj.parent().hasClass("zbiti_submit")){
			var t = $obj.clone("true");//克隆dom对象 包括其绑定事件与方法
			$obj.parent().replaceWith(t);
		}
	}else{
		$(".NoticeError_T_rt,.NoticeError_G_rt").remove();
		var t = $($(".zbiti_submit").html()).clone("true");
		$(".zbiti_submit").replaceWith(t);
	}
};
/**
 * 隐藏验证提示框
 * @param o 指定当时绑定的dom对象 为空隐藏所有
 */
function NoticeError_Hidden(o){
	NoticeError_Clear(o);
	if(o){
		var $obj = typeof(o)==="string" ? $("#"+o) : o instanceof jQuery ? o : $(o);
		$obj.parent().find(".NoticeError_G_rt .up").click();
	}else{
		$(".NoticeError_G_rt .up").click();
	}
};


//写cookies 

function setCookie(name,value) 
{ 
  var Days = 30; 
  var exp = new Date(); 
  exp.setTime(exp.getTime() + Days*24*60*60*1000); 
  document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString(); 
};

//读取cookies 
function getCookie(name) 
{ 
  var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");

  if(arr=document.cookie.match(reg))

      return unescape(arr[2]); 
  else 
      return null; 
}; 

//删除cookies 
function delCookie(name) 
{ 
  var exp = new Date(); 
  exp.setTime(exp.getTime() - 1); 
  var cval=getCookie(name); 
  if(cval!=null) 
      document.cookie= name + "="+cval+";expires="+exp.toGMTString(); 
};

/*浮动    class='floatMenu'
 * target 目标对象  params{onFixed:固定之前的方法,cancelFixed:取消浮动后方法}
 *    */
function floatBarMenu(target,params){
	if(target.length>0){ 
		var width = target.width();
		var t =target.offset().top;
		var h = target.height();
		var mh = $('body').height();
		$(window).scroll(function(e){
			var s = $(document).scrollTop();
			if(s>t + h &&  $(document).height()-s > target.height()){
				//scrollBlur();
				target.css("position","fixed").css("top","0px");//.css("width",width+"px");
				target.hasClass("funcation") || target.find(".funcation").length>0 ? target.css("width",0.9 * 99.88 + "%").css("min-width","1000px") : target.css("width",width+"px");  
				if(params && params.onFixed && typeof params.onFixed === "function"){
					params.onFixed.call();
				}
			}else{
				target.css("position","static");//.css("width",width+"px");
				target.hasClass("funcation") || target.find(".funcation").length>0 ? target.css("width","99.88%").css("min-width","1000px") : target.css("width",width+"px");  
				if(params && params.cancelFixed && typeof params.cancelFixed === "function"){
					params.cancelFixed.call();
				}
			}
		});
	}
};
//滚动过程中失去焦点[共用]
function scrollBlur(){
	if($("input,textarea,select").length>0){
		$("input,textarea,select").blur();//所有选择元素失去焦点
	}
};

/**

 * 数字格式转换成千分位

 *@param{Object}num

 */

function commafy(num){
   if((num+"").Trim()==""){
      return"";
   }
   if(isNaN(num)){
      return"";
   }

   num = num+"";
   if(/^.*\..*$/.test(num)){
      var pointIndex =num.lastIndexOf(".");
      var intPart = num.substring(0,pointIndex);
      var pointPart =num.substring(pointIndex+1,num.length);
      intPart = intPart +"";
       var re =/(-?\d+)(\d{3})/
       while(re.test(intPart)){
          intPart =intPart.replace(re,"$1,$2")
       }
      num = intPart+"."+pointPart;
   }else{
      num = num +"";
       var re =/(-?\d+)(\d{3})/
       while(re.test(num)){
          num =num.replace(re,"$1,$2")
       }
   }
    return num;
};


/**

 * 去除千分位

 *@param{Object}num

 */
function delcommafy(num){
   if((num+"").Trim()==""){
      return"";
   }
   num=num.replace(/,/gi,'');
   returnnum;
};
/*
 * 合并zbiti后一个空的列  并使第一个加入 序号两字
 *  id 组装zitigrid 的 id  
 */
function clearzbitiGridLastEmptyCol(id){
	//去除最后个空列 并加上序号
	var table = $("#"+id+" table");
	if(table.length==0){return;}
	if(table.find(".rownum:visible").length)
		table.find("tr:first th:first").css("min-width","30px").text("序号");
	//最后一个th
	table.find("th:last").hide();
	//最后一个td
	
	table.find("tr").each(function(){
		var _this = $(this);
		_this.find("td:last:visible").hide();
	});
};
/*
 * 使grid 有横向滚动
 *  id 组装zitigrid 的 id  
 */
function autoZbitiGridX(id){
	//设置div滚动
	var table = $("#"+id+"_table");
	if(table.length==0){return;}
	table.css({"overflow":"auto"});
	table.find("table th,td").css({"white-space":"nowrap"});
	$(".middleft").css("padding-bottom","0");
	var height = table.height();
	table.height(height - (document.body.scrollHeight - parent.document.body.scrollHeight+120)-22);
};

/*
 * 根据机构id获取用户所在省份机构
 */
function queryOrgByOrgCode(orgCode){
	var url = curProjectUrl + "/org/queryByOrgCode.do";
	return Tool_Ajax(url,{orgCode:orgCode},"json");
};

/*
 * 项目总变量  
 */
var zbitiGlobal ={
		width : 1200,//默认宽
		height : 600,//默认高
		//居中显示
		window:""//窗口参数
};
/*
 * 设定窗口参数
 */
$(function(){
	//居中的显示 
	var wtop=(window.screen.height-zbitiGlobal.height)/2;
	var wleft=(window.screen.width-zbitiGlobal.width)/2;
	zbitiGlobal.window = "height="+zbitiGlobal.height+", width="+zbitiGlobal.width+",toolbar=no,menubar=no,resizable=yes,status=no,location=no,center=yes,scrollbars=yes,top=" + wtop + ",left=" + wleft;
});


	
