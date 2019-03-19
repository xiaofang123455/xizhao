<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
	<head>  
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<title>${fns:getConfig('productName')}</title>
		<script src="${ctxStatic}/jquery/jquery-2.2.3.min.js" type="text/javascript"></script>
	</head>
	<body >
		<script>
			$(function () {
				document.getElementById("loginForm").submit();
			});
		</script>
		<form  id="loginForm"  action="${ctx}/login" method="post" style="display: none">
			<div class="login-box-body" style="font-size: 20px;padding-top:200px">
			    <div class="form-group has-feedback">
			       <label class="input-label" for="username">登录名:</label>
			       <input id="username" name="username"  type="text" class="form-control"   required value="${userName}"> 
			       <span class="glyphicon glyphicon-user form-control-feedback" style="line-height:74px;top: 15px"></span>
			    </div>
			    <div class="form-group has-feedback">
					<label class="input-label" for="password">密码：</label>
					<input type="password"  id="password" name="password"  class="form-control"  required value="888888"> 
					<input type="hidden" name="encryptedNo"  class="form-control" value="${encryptedNo}" > 
					<span class="glyphicon glyphicon-lock form-control-feedback"  style="line-height:74px;top: 15px"></span>
			    </div>
			    <div class="row" style="padding-top:20px">
			      	<div class="col-xs-12">
			        	<button type="submit" class="btn btn-primary btn-block btn-flat" style="font-size:20px;border-radius:6px">登录</button>
			      	</div>
			    </div>
			</div>
		</form>

</body>
</html>