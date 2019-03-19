<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>${fns:getConfig('productName')}</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<!--  <meta name="decorator" content="default"/>  -->

 
<link rel="stylesheet" href="${ctxStatic}/dist/css/skins/_all-skins.min.css" type="text/css" />
<link rel="stylesheet" href="${ctxStatic}/dist/css/AdminLTE.min.css" type="text/css" />
 <link href="${ctxStatic}/bootstrap/3.3.6/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="${ctxStatic}/plugins/awesome/4.6.0/css/font-awesome.min.css" rel="stylesheet" /> 
<link href="${ctxStatic}/common/style.css" type="text/css" rel="stylesheet" />
<link rel="stylesheet" href="${ctxStatic}/plugins/datatables/dataTables.bootstrap.css">
<link href="${ctxStatic}/common/pagination.css" type="text/css" rel="stylesheet" />
<link href="${ctxStatic}/plugins/iCheck/custom.css" rel="stylesheet">
<link href="${ctxStatic}/plugins/select2/select2.min.css" rel="stylesheet" />

<script src="${ctxStatic}/jquery/jquery-2.2.3.min.js"  type="text/javascript"></script>
<script src="${ctxStatic}/plugins/layer/layer.js"></script>
<script src="${ctxStatic}/jquery-jbox/2.3/jquery.jBox-2.3.js" type="text/javascript"></script> 
<script src="${ctxStatic}/common/jeesite.js" type="text/javascript"></script>
<script src="${ctxStatic}/plugins/validation/1.15.1/jquery.validate.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/plugins/validation/1.15.1/localization/messages_zh.min.js"  type="text/javascript"></script>
<script src="${ctxStatic}/plugins/iCheck/icheck.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/plugins/select2/select2.full.min.js"  type="text/javascript"></script>
<script src="${ctxStatic}/common/mustache.min.js" type="text/javascript"></script>

<script src="${ctxStatic}/bootstrap/3.3.6/js/bootstrap.min.js"  type="text/javascript"></script>
<script src="${ctxStatic}/common/xlsx/excel.js"  type="text/javascript"></script>
<script src="${ctxStatic}/common/StringUtil.js" type="text/javascript"></script>

<script src="${ctxStatic}/bootstrap/3.3.6/js/bootstrap.min.js"  type="text/javascript"></script>
<script src="${ctxStatic}/dist/js/app.min.js" type="text/javascript"></script> 
<link href="${ctxStatic}/jquery-jbox/2.3/Skins/Bootstrap/jbox.min.css" rel="stylesheet" />
<style type="text/css">
	body
	{
		font:15px '\5FAE\8F6F\96C5\9ED1',Tahoma,Arial,Helvetica,sans-serif
	} 
	
	.skin-blue .wrapper,
	.skin-blue .main-sidebar,
	.skin-blue .left-side {
	  background-color: rgba(13, 60, 84,1);
	}
	.skin-blue .sidebar-menu > li:hover > a,
	.skin-blue .sidebar-menu > li.active > a {
	  color: #ffffff;
	  background: rgba(13, 60, 84,1);
	  border-left-color: #3c8dbc;
	}
	
	.skin-blue .sidebar-menu>li>.treeview-menu
	{
		background: rgba(13, 60, 84,1);
	}
	</style>
	<script type="text/javascript">
	   /* 也是醉了，body就是不能解析class，非得动态添加 */
		$(document).ready(function() {
			$("body").addClass('hold-transition');
			$("body").addClass('skin-blue');
			$("body").addClass('sidebar-mini');		
			
			//添加ifram
			$(".J_menuItem").click(function(){
				var dataUrl = $(this).attr('href'),
		        dataIndex = $(this).attr('data-id'),
		        menuName = $.trim($(this).text()),
		        flag = true;
				 if (dataUrl == undefined || $.trim(dataUrl).length == 0) return false;
				    // 选项卡菜单已存在
				    var tabs=$('#myTab li');
				    for(var i=0;i<tabs.length;i++){
				    	var tab=tabs[i];
				    	var tabA=$(tab).children("a");
				        if ($(tabA).attr('href') == "#iframe"+dataIndex) {
				            if (!$(tab).hasClass('active')) {
				                $(tab).addClass('active').siblings().removeClass('active');
				                $('#myTab a[href="#'+$(tabA).attr('href')+'"]').tab('show');
				                $("#myTabContent div").each(function(){
				                	if($(this).hasClass("in active")){
				                		$(this).removeClass("in active");
				                	}
				                })
				                $("div #iframe"+dataIndex).addClass("in active");
				            }
				            flag = false;
				            return false;
				        }
				    }
				    
				    // 选项卡菜单不存在
				    if (flag) {
				    	var strMyTab='<li> <a class="J_menuTab" href="#iframe' + dataIndex +'" data-toggle="tab">'+ menuName + '<i class="fa fa-times-circle"  onclick="javascript:closeTab(this);"></i></a></li>' ;
				    	var strmyTabContent ='<div class="tab-pane fade in active" id="iframe' + dataIndex +'"><iframe id="iframe' + dataIndex +'" name="iframe'+ dataIndex +'" src="'+dataUrl+'" style="width:100%;height:100%" frameborder="no" ></iframe></div>';
				        $("#myTab").append(strMyTab);
				        $("#myTabContent").append(strmyTabContent);
				       $("#myTabContent div").each(function () {
			                if ($(this).hasClass('active')) {
			                    $(this).removeClass('active');
			                }
			            });
				        $('#myTab a[href="#iframe'+dataIndex+'"]').tab('show');
				        wSize();
				    }
				    return false;
			});
			$.each($(""))
		})
		
		function closeTab(obj){
			var href=$(obj).parent().attr("href");
			$(href).remove();
			$(obj).parent().parent().remove();
			$('#myTab a[href="#home"]').tab('show');
	   }
	</script>

	</head>
<body class="hold-transition skin-blue sidebar-mini">
<!-- Site wrapper -->
<div class="wrapper" >
  <header class="main-header" >
    <!-- Logo -->
    <a class="logo">
      <span class="logo-lg"><b>${fns:getConfig('productName')}</b></span>
      <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button" >
        <span class="sr-only">Toggle navigation</span>
      </a>
    </a>
    <!-- Header Navbar: style can be found in header.less -->
  </header>
  <!-- Left side column. contains the sidebar -->
  <aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
      <!-- Sidebar user panel -->
      <div class="user-panel" style="margin-right: 40px;height:80px;">
        <%-- <div class="pull-left image">
        <c:if test="${fns:getUser().photo == null || fns:getUser().photo ==''}">
              <img src="${ctxStatic}/dist/img/user4.jpg" class="img-rounded" alt="User Image" style="max-width: 50%">
        </c:if>
        <c:if test="${fns:getUser().photo != null && fns:getUser().photo !=''}">
		      <img src=" ${fns:getUser().photo}" class="img-rounded" alt="User Image" style="max-width: 50%">
        </c:if>
        </div> --%>
        <div class="pull-left info" style="left:25px">
          <p>欢迎您， ${fns:getUser().name}</p>
          <!-- <a href="#">系统管理员</a> -->
           <a href="${ctx}/logout" title="退出登录">退出</a>
          <a onclick="jumpToChangePass()"  href="javascript:void(0);" title="修改密碼">修改密碼</a><%-- ${ctx}/changePass   onclick="()" --%>
        </div>
      </div>
      <script type="text/javascript">
      		function jumpToChangePass(){
      			var target="";
      	 	 	top.layer.open({
      			    type: 2,  
      			    area: ["40%", "40%"],
      			    title: '修改用户密码',
      		        maxmin: true, //开启最大化最小化按钮
      			    content: "${ctx}/sys/user/jumpToChangePass" ,
      			    btn: ['确定', '关闭'],
      			    yes: function(index, layero){
      			 	 var body =top.layer.getChildFrame('body', index);
      		         var iframeWin = layero.find('iframe')[0]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
      	 	         var inputForm = body.find('#inputForm');
      		         var top_iframe;
      		         if(target){
      		        	 top_iframe = target;//如果指定了iframe，则在改frame中跳转
      		         }else{
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
      		       //  inputForm.attr("target",top_iframe);//表单提交成功后，从服务器返回的url在当前tab中展示 
      		         
      		        if(iframeWin.contentWindow.doSubmit() ){
      		        	// top.layer.close(index);//关闭对话框。
      		        	top.layer.alert('保存用户密码成功', {icon : 0,title : '警告'});
      		        	  setTimeout(function(){top.layer.close(index)}, 100);//延时0.1秒，对应360 7.1版本bug
      		         }
      			  },
      				  cancel: function(index){ 
      			       }
      			});   
      			// openDialog("修改用户密码","${ctx}/sys/user/jumpToChangePass","40%", "40%","");
      		}
      </script>
      <!-- sidebar menu: : style can be found in sidebar.less -->
				<ul class="sidebar-menu" >
					<c:forEach items="${fns:getMenuList()}" var="menu" varStatus="idxStatus">
						<c:if test="${menu.parent.id eq '1'}">
							<li class="treeview">
								<a href="#"> 
									<c:if test="${not empty menu.icon}">
										<i class="fa ${menu.icon} fa-${menu.icon}"></i>
									</c:if>
									<span style="font-weight:600">${menu.name}</span> 
									<span class="pull-right-container"> 
										<i class="fa fa-angle-left pull-right"></i>
									</span>
								</a>
								
								<ul class="treeview-menu"  style="margin:0 30px">
									<c:forEach items="${menuList}" var="menu2">
								  		<c:if test="${menu2.parent.id eq menu.id}">
									  		<c:if test="${empty menu2.href}">
												<li>
												<a style="font-size: 14px;font-weight:600">
													<c:if test="${not empty menu2.icon}">
														<i class="fa ${menu2.icon} fa-${menu2.icon}"></i>
													</c:if>${menu2.name}
													<span class="pull-right-container"> 
														<i class="fa fa-angle-left pull-right"></i>
													</span>
												</a>
												<ul class="treeview-menu" >
													<c:forEach items="${menuList}" var="menu3">
														<c:if test="${menu3.parent.id eq menu2.id}">
															<c:if test="${empty menu3.href}">
																<li>
																<a style="font-size: 14px;font-weight:600">
																	<c:if test="${not empty menu3.icon}">
																		<i class="fa ${menu3.icon} fa-${menu3.icon}"></i>
																	</c:if>${menu3.name}
																	<span class="pull-right-container"> 
																		<i class="fa fa-angle-left pull-right"></i>
																	</span>
																</a>
																<ul class="treeview-menu" >
																	<c:forEach items="${menuList}" var="menu4">
																		<c:if test="${menu4.parent.id eq menu3.id}">
																		     <li><a class="J_menuItem" href="${fn:indexOf(menu4.href, '://') eq -1 ? ctx : ''}${menu4.href}"  data-id="${menu4.id}" target="mainFrame" style="font-size: 14px;font-weight:600">
																		     <c:if test="${not empty menu4.icon}">
																				<i class="fa ${menu4.icon} fa-${menu4.icon}"></i>
																			</c:if>${menu4.name}</a></li>
																		</c:if>
														          	</c:forEach>
																</ul>
																</li>
															 </c:if>
															 <c:if test="${not empty menu3.href}">
																 <li><a class="J_menuItem"  href="${fn:indexOf(menu3.href, '://') eq -1 ? ctx : ''}${menu3.href}"  style="font-size: 14px;font-weight:600"  data-id="${menu3.id}" target="mainFrame">
																 	<c:if test="${not empty menu3.icon}">
																		<i class="fa ${menu3.icon} fa-${menu3.icon}"></i>
																	</c:if>${menu3.name}</a></li>
															</c:if>
														 </c:if>
										          	</c:forEach>
												</ul>
												</li>
											</c:if>
											<c:if test="${not empty menu2.href}">
												 <li><a class="J_menuItem"  href="${fn:indexOf(menu2.href, '://') eq -1 ? ctx : ''}${menu2.href}"  style="font-size: 14px;font-weight:600"  data-id="${menu2.id}" target="mainFrame">
												 	<c:if test="${not empty menu2.icon}">
														<i class="fa ${menu2.icon} fa-${menu2.icon}"></i>
													</c:if>${menu2.name}</a></li>
											</c:if>
										</c:if>
						          	</c:forEach>
								</ul>
							</li>
						</c:if>
					</c:forEach>
				</ul>
			</section>
    <!-- /.sidebar -->
  </aside>

  <!-- =============================================== -->

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header" style="padding-top: 10px">
     <!--  <h1>
       审计
        <small>财务数据分析系统</small>
      </h1> -->
      <ul id="myTab" class="nav nav-tabs " style="font-size: 15px;font-weight: 600">
			   <li class="active">
			      <a href="#home" data-toggle="tab" class="J_menuTab">
			         首页
			      </a>
			   </li>
		</ul>
    </section>

    <!-- Main content -->
    <section class="content" style="padding-top:0;font-size: 14px;padding-bottom: 0px;">
      <!-- Default box -->
      <div class="box" style="border-top: 0;margin-bottom: 0px;">
        <div class="tab-content" id="myTabContent" >
		   <div class="tab-pane fade in active"  id="home">
		       <iframe id="mainFrame" name="mainFrame" src="${ctx}/main/index"  style="width:100%;height:100%"  frameborder="no" ></iframe>
        </div>
        </div>
        </div>
        <!-- /.box-body -->
      <!-- /.box -->
    </section>
    <!-- /.content -->
  </div>
</div>
<!--选择机构隐藏的下拉选项结束-->
<script type="text/javascript">  
	var leftWidth = 160; // 左侧窗口大小
	var htmlObj = $("html"), mainObj = $("#myTabContent");
	var frameObj = $(".main-sidebar,  #myTabContent, #myTabContent div[class='tab-pane fade in active'] iframe");
	function wSize(){
		var minHeight = 500, minWidth = 980;
		var strs = getWindowSize().toString().split(",");
		htmlObj.css({"overflow-x":strs[1] < minWidth ? "auto" : "hidden", "overflow-y":strs[0] < minHeight ? "auto" : "hidden"});
		mainObj.css("width",strs[1] < minWidth ? minWidth - 10 : "auto");
		$("#myTabContent div[class='tab-pane fade in active'] iframe").height((strs[0] < minHeight ? minHeight : strs[0])  - (strs[1] < minWidth ? 42 : 28)-30); 
		if(myBrowser()=='IE'){
			reSizeF11();
		}
	}
	function reSizeF11(){
		var minHeight = 500, minWidth = 980;
		var strs = getWindowSize().toString().split(",");
		htmlObj.css({"overflow-x":strs[1] < minWidth ? "auto" : "hidden", "overflow-y":strs[0] < minHeight ? "auto" : "hidden"});
		mainObj.css("width",strs[1] < minWidth ? minWidth - 10 : "auto");
		var iframes=$("#myTabContent div[class^='tab-pane'] iframe");
		iframes.each(function(){
			$(this).height((strs[0] < minHeight ? minHeight : strs[0])  - (strs[1] < minWidth ? 42 : 28)-30);
		})
	}
	$(window).resize(function() {
		reSizeF11();
		});
	
	
</script> 
	<script src="${ctxStatic}/common/wsize.min.js" type="text/javascript"></script>
</body>
</html>
