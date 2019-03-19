<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>审计财务数据分析系统 | 首页</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
	<meta name="decorator" content="blank"/>
	<script type="text/javascript">
	   /* 也是醉了，body就是不能解析class，非得动态添加 */
		$(document).ready(function() {
			$("body").addClass('hold-transition');
			$("body").addClass('skin-blue');
			$("body").addClass('sidebar-mini');
			
			$(".treeview-menu").click(function(){
				var href=$(this).attr("href");
				alert(href);
				if(href!=undefined&&href!='undefined'){
					return addTab($(this), true);
				}
				
			})
			
			/*页签  */
			$.fn.initJerichoTab({
                renderTo: '#myTabContent', uniqueId: 'jerichotab',
                contentCss: { 'height': $('#myTabContent').height() - 33 },
                tabs: [], loadOnce: true, tabWidth: 110, titleHeight: 33
            });
			
			function addTab($this, refresh){
				$(".jericho_tab").show();
				$("#mainFrame").hide();
				$.fn.jerichoTab.addTab({
	                tabFirer: $this,
	                title: $this.text(),
	                closeable: true,
	                data: {
	                    dataType: 'iframe',
	                    dataLink: $this.attr('href')
	                }
	            }).loadData(refresh);
				return false;
			}
		})
	</script>
	<script type="text/javascript">var ctx = '${ctx}', ctxStatic='${ctxStatic}';</script>
	</head>
<body class="hold-transition skin-blue sidebar-mini">
<!-- Site wrapper -->
<div class="wrapper">
  <header class="main-header">
    <!-- Logo -->
    <a href="index2.html" class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini"><b>A</b>LT</span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg"><b>财务数据</b>分析系统</span>
    </a>
    <!-- Header Navbar: style can be found in header.less -->
  </header>
  <!-- Left side column. contains the sidebar -->
  <aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
      <!-- Sidebar user panel -->
      <div class="user-panel">
        <div class="pull-left image">
          <img src="static/dist/img/avatar2.png" class="img-rounded" alt="User Image" style="max-width: 50%">
        </div>
        <div class="pull-left info" style="left:125px">
          <p> ${fns:getUser().loginName}</p>
          <!-- <a href="#">系统管理员</a> -->
          <a href="${ctx}/logout" title="退出登录">退出</a>
        </div>
      </div>
      <!-- sidebar menu: : style can be found in sidebar.less -->
				<ul class="sidebar-menu">
					<c:forEach items="${fns:getMenuList()}" var="menu" varStatus="idxStatus">
						<c:if test="${menu.parent.id eq '1'}">
							<li class="treeview">
								<a href="#"> 
									<c:if test="${menu.name eq '我的面板'}"><i class="fa fa-columns"></i> </c:if>
									<c:if test="${menu.name eq '在线办公'}"><i class="fa fa-desktop"></i> </c:if>
									<c:if test="${menu.name eq '内容管理'}"><i class="fa fa-file-text"></i> </c:if>
									<c:if test="${menu.name eq '系统设置'}"><i class="fa fa-cog"></i> </c:if>
									<c:if test="${menu.name eq '代码生成'}"><i class="fa fa-codepen"></i> </c:if>
									<span style="font-size: 14px;font-weight:600">${menu.name}</span> 
									<span class="pull-right-container"> 
										<i class="fa fa-angle-left pull-right"></i>
									</span>
								</a>
								
								<ul class="treeview-menu"  style="margin:0 30px">
									<c:forEach items="${menuList}" var="menu2">
								  		<c:if test="${menu2.parent.id eq menu.id}">
									  		<c:if test="${empty menu2.href}">
												<li><a style="font-size: 14px;font-weight:600">${menu2.name}</a>
												
												<ul class="treeview-menu" >
													<c:forEach items="${menuList}" var="menu3">
														<c:if test="${menu3.parent.id eq menu2.id}">
														     <li><a href="${fn:indexOf(menu3.href, '://') eq -1 ? ctx : ''}${menu3.href}"  data-id="${menu3.id}" target="mainFrame" style="font-size: 14px;font-weight:600"><i class="fa"></i> ${menu3.name}</a></li>
														</c:if>
										          	</c:forEach>
												</ul>
												</li>
											</c:if>
											<c:if test="${not empty menu2.href}">
												 <li><a href="${fn:indexOf(menu2.href, '://') eq -1 ? ctx : ''}${menu2.href}"  style="font-size: 14px;font-weight:600"  data-id="${menu2.id}" target="mainFrame"><i class="fa"></i> ${menu2.name}</a></li>
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
      <ul id="myTab" class="nav nav-tabs " style="font-size: 14px;font-weight: 600;border-bottom:3px solid #DDDDDD">
			   <li class="active">
			      <a href="#home" data-toggle="tab">
			         首页
			        <!--  <i class="fa fa-times-circle"></i> -->
			      </a>
			   </li>
			   <li>
			      <a href="#home" data-toggle="tab">
			         个人信息
			        <i class="fa fa-times-circle"></i>
			      </a>
			   </li>
			</ul>
     <!--  <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>  首页</a></li>
        <li><a href="#"></a></li>
        <li class="active"></li>-->
      </ol>
    </section>

    <!-- Main content -->
    <section class="content" style="padding-top:0">
      <!-- Default box -->
      <div class="box" style="border-top: 0">
<!--         <div class="box-header with-border" style="font-size: 14px;padding:0">
          <ul id="myTab" class="nav nav-tabs">
			   <li class="active">
			      <a href="#home" data-toggle="tab">
			         首页
			         <i class="fa fa-times-circle"></i>
			      </a>
			   </li>
			</ul>
        </div> -->
        <div class="tab-content" id="myTabContent" >
		   <div class="tab-pane fade in active" id="home">
		      <iframe id="mainFrame" name="mainFrame" src="a/sys/main/index" style="overflow:visible;" scrolling="yes" frameborder="no" width="100%" height="450px"></iframe>
		   </div>
		</div>
        </div>
        <!-- /.box-body -->
        <div class="box-footer">
         <strong>Copyright &copy; 2014-2016 <a href="http://almsaeedstudio.com">zbiti</a>.</strong>
        </div>
        <!-- /.box-footer-->
      </div>
      <!-- /.box -->

    </section>
    <!-- /.content -->
  </div>

</div>
</body>
</html>