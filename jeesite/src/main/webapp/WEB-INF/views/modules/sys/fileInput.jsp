<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>ftp文件上传</title>
	<meta name="decorator" content="default"/>
	<link href="${ctxStatic}/plugins/fileinput/css/fileinput.min.css" rel="stylesheet" /> 
	<script src="${ctxStatic}/jquery/jquery-2.2.3.min.js"  type="text/javascript"></script>

	<script src="${ctxStatic}/bootstrap/3.3.6/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="${ctxStatic}/plugins/fileinput/js/plugins/canvas-to-blob.js"></script>
	<script src="${ctxStatic}/plugins/fileinput/js/fileinput.min.js"></script>
	<script src="${ctxStatic}/plugins/fileinput/js/locales/zh.js"></script>
<body>
	<input type="file" class="file" id="myfiles" name="myfiles" multiple> <!--  accept="image/*" -->
<!-- 	<input  class="btn btn-default" type="button" value="下载" onclick="downLoadFile()" style="width:50px;height:30px"/> -->
	<script type="text/javascript">
	
	$("#myfiles").fileinput({  
		   language: 'zh', //设置语言
           uploadUrl:"${ctx}/sys/ftpFile/upload", //上传的地址
          /*  allowedFileExtensions : ['jpg', 'png','gif'],//接收的文件后缀, */
           maxFileCount: 100,
           enctype: 'multipart/form-data',
           showUpload: true, //是否显示上传按钮
           showCaption: false,//是否显示标题
           uploadAsync: true, //默认异步上传
           browseClass: "btn btn-primary", //按钮样式             
           previewFileIcon: "<i class='glyphicon glyphicon-king'></i>", 
           msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
	
	});//初始化 后 上传插件的样子 
	
	//* /异步上传返回结果处理

	$('#myfiles').on('fileerror', function(event, data, msg) {
	}); 
	//异步上传返回结果处理

	$("#myfiles").on("fileuploaded", function (e, data) {
           var obj = data.response;
           if (obj.state > 0) {
        	   top.layer.alert('上传成功');
           }
           else {
        	   top.layer.alert('上传失败');
           }
	 });
	
	
	/* function downLoadFile(){
		window.location.href="${ctx}/sys/fileInput/download";
	} */
 </script>
</body>
</html>