<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>个人信息</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
	<style type="text/css">
	body{
	background-color:#f3f3f4
	}
.wrapper {
    padding: 0 20px;
}

.wrapper-content {
    padding: 20px;
}
	
	.ibox {
    clear: both;
    margin-bottom: 25px;
    margin-top: 0;
    padding: 0;
}
     .ibox-title {
	    -moz-border-bottom-colors: none;
	    -moz-border-left-colors: none;
	    -moz-border-right-colors: none;
	    -moz-border-top-colors: none;
	    background-color: #ffffff;
	    border-color: #e7eaec;
	    border-image: none;
	    border-style: solid solid none;
	    border-width: 4px 0px 0;
	    color: inherit;
	    margin-bottom: 0;
	    padding: 14px 15px 7px;
	    min-height: 48px;
	}
	
	.ibox-title .label {
    float: left;
    margin-left: 4px;
}

.ibox-tools {
    display: inline-block;
    float: right;
    margin-top: 0;
    position: relative;
    padding: 0;
}

.ibox-tools a {
    cursor: pointer;
    margin-left: 5px;
    color: #c4c4c4;
}

.ibox-content {
    background-color: #ffffff;
    color: inherit;
    padding: 15px 20px 20px 20px;
    border-color: #e7eaec;
    border-image: none;
    border-style: solid solid none;
    border-width: 1px 0px;
}


	</style>
</head>
<body>
<%-- 	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/sys/user/info">个人信息</a></li>
		<li><a href="${ctx}/sys/user/modifyPwd">修改密码</a></li>
	</ul><br/> --%>
	<div class="wrapper wrapper-content">
			<div class="row animated fadeInRight">
	<div class="col-sm-5">
					<div class="ibox float-e-margins">
						<div class="ibox-title">
							<h5>个人资料</h5>
							<div class="ibox-tools">
								<a class="dropdown-toggle" data-toggle="dropdown" href="#">
									编辑<i class="fa fa-wrench"></i>
								</a>
								<ul class="dropdown-menu dropdown-user">
									<li><a id="userImageBtn" data-toggle="modal" data-target="#register">更换头像</a>
									</li>
									<li><a id="userInfoBtn" data-toggle="modal" data-target="#register">编辑资料</a>
									</li>
								</ul>
							</div>
						</div>
						<div class="ibox-content">
							<div class="row">
								<div class="col-sm-4" style="margin-bottom: 10px;">
									<img alt="image" class="img-responsive" src="../../../static/dist/img/user3-128x128.jpg" />
								</div>
								<div class="col-sm-8">
									<div class="table-responsive">
										<table class="table table-bordered">
											<tbody>
												<tr>
													<td><strong>姓名</strong></td>
													<td>${user.name}</td>
												</tr>
												<tr>
													<td><strong>邮箱</strong></td>
													<td>${user.email}</td>
												</tr>
												<tr>
													<td><strong>手机</strong></td>
													<td>${user.phone}</td>
												</tr>
												<tr>
													<td><strong>电话</strong></td>
													<td>${user.mobile}</td>
												</tr>
												<tr>
													<td><strong>公司</strong></td>
													<td>${user.company.name}</td>
												</tr>
												<tr>
													<td><strong>部门</strong></td>
													<td>${user.office.name}</td>
												</tr>
												<tr>
													<td><strong>备注</strong></td>
													<td>${user.remarks}</td>
												</tr>
											</tbody>
										</table>
										<strong>上次登录</strong>
													IP: 49.77.15.97&nbsp;&nbsp;&nbsp;&nbsp;时间：${user.loginDate}
											
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-sm-5">
					<div class="ibox float-e-margins">
						<div class="ibox-title">
							<h5>注册信息</h5>
							<div class="ibox-tools">
								<a class="dropdown-toggle" data-toggle="dropdown" href="#">
									编辑<i class="fa fa-wrench"></i>
								</a>
								<ul class="dropdown-menu dropdown-user">
									<li><a id="userPassWordBtn" data-toggle="modal" data-target="#register">更换密码</a>
									</li>
									<li><a href="#" data-toggle="modal" data-target="#register">更换手机号</a>
									</li>
								</ul>
							</div>
						</div>
						<div class="ibox-content">
							<div class="row">
								<div class="col-sm-8">
									<div class="table-responsive">
										<table class="table table-bordered">
											<tbody>
												<tr>
													<td><strong>用户名</strong></td>
													<td>admin</td>
												</tr>
												<tr>
													<td><strong>注册手机号码</strong></td>
													<td>rr</td>
												</tr>
												<tr>
													<td><strong>用户角色</strong></td>
													<td>管理员,部门管理员,人事</td>
												</tr>
												<tr>
													<td><strong>用户类型</strong></td>
													<td>无</td>
												</tr>
											</tbody>
										</table>
									</div>
								
								</div>
								<!-- <div class="col-sm-4">
									<img width="100%" style="max-width:264px;" src="static/dist/img/user3-128x128.jpg">
								</div> -->
							</div>
						</div>
					</div>

				</div>
					</div>
		</div>
</body>
</html>