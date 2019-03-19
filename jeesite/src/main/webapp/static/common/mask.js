/*!
 * 遮盖层的自定义
 * @author zxy
 * @date 2017-3-23
 */
//显示遮盖层,如果没有div的高
function showMask(tableDiv){
	//判断是否存在该遮盖层，如果不存在，则创建
	var descDiv;
	var maskName = tableDiv+'Mask';
	if(document.getElementById(maskName)){
		descDiv = document.getElementById(maskName);
	}else{
		descDiv = document.createElement('div');
		document.body.append(descDiv);
	}
   
    //获取输入框dom元素
    var text = document.getElementById(tableDiv);

    //计算div的确切位置
    var seatX = text.getBoundingClientRect().left+document.documentElement.scrollLeft;
    var seatY = text.getBoundingClientRect().top+document.documentElement.scrollTop;
    
    //给div设置样式，比如大小、位置
    var cssStr = "z-index:5;width:"+text.offsetWidth+"px;height:"+text.offsetHeight+"px; background-color: rgb(243,243,243);  z-index:1001;  -moz-opacity: 0.7;  opacity:.70;  filter: alpha(opacity=70);position:absolute;left:" 
    + seatX + 'px;top:' + seatY + 'px;';
   //将样式添加到div上，显示div
    descDiv.style.cssText = cssStr;
    descDiv.id = maskName;
    descDiv.style.display = 'block';
}
//显示遮盖层,给定高度
function showMaskH(tableDiv,height){
	//判断是否存在该遮盖层，如果不存在，则创建
	var descDiv;
	var maskName = tableDiv+'Mask';
	if(document.getElementById(maskName)){
		descDiv = document.getElementById(maskName);
	}else{
		descDiv = document.createElement('div');
		document.body.append(descDiv);
	}
   
    //获取输入框dom元素
    var text = document.getElementById(tableDiv);

    //计算div的确切位置
    var seatX = text.getBoundingClientRect().left+document.documentElement.scrollLeft;
    var seatY = text.getBoundingClientRect().top+document.documentElement.scrollTop;
    
    //给div设置样式，比如大小、位置
   /* var cssStr = "z-index:5;width:"+text.offsetWidth+"px;height:"+height+"px; background-color: rgb(243,243,243);  z-index:1001;  -moz-opacity: 0.7;  opacity:.70;  filter: alpha(opacity=70);position:absolute;left:" 
    + seatX + 'px;top:' + seatY + 'px;';*/
    
   //将样式添加到div上，显示div
    //descDiv.style.cssText = cssStr;
    descDiv.style.width=text.offsetWidth+"px";
    descDiv.style.height=height+"px";
    descDiv.style.left=seatX+"px";
    descDiv.style.top=seatY+"px";
    descDiv.id = maskName;
    descDiv.style.display = 'block';
}
//隐藏遮盖层
function hideMask(tableDiv){
	var maskName = tableDiv+'Mask';
	setTimeout( function(){
		document.getElementById(maskName).style.display = 'none';
	}, 1000 );
}

