<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>${fns:getConfig('productName')}</title>
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <link href="${ctxStatic}/bootstrap/3.3.6/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
  <link rel="stylesheet" href="${ctxStatic}/dist/css/AdminLTE.min.css">
  <link rel="stylesheet" href="${ctxStatic}/plugins/iCheck/custom.css">
  <style type="text/css">
     body{padding:0;margin:0;}
     #bg{width:76%;height:100%;position:absolute;z-index:-2;}
     #login{width:360px;position:absolute;left:86%;top:40%;margin-left:-150px;margin-top:-250px}
     #dianxin{width:50%;position:absolute;left:60%;top:50%;margin-left:-150px;margin-top:-250px}
     .form-control{border-radius:6px;font-size:18px}
  </style>
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->
  <script src="${ctxStatic}/jquery/jquery-2.2.3.min.js" type="text/javascript"></script>
  <script src="${ctxStatic}/plugins/validation/1.15.1/jquery.validate.min.js"  type="text/javascript"></script>
  <script type="text/javascript" src="${ctxStatic}/iCheck/icheck.min.js"></script>
  <script type="text/javascript">
		$(document).ready(function() {
			$("#loginForm").validate({
				rules: {
					validateCode: {remote: "${pageContext.request.contextPath}/servlet/validateCodeServlet"}
				},
				messages: {
					username: {required: "请填写用户名."},password: {required: "请填写密码."},
					validateCode: {remote: "验证码不正确.", required: "请填写验证码."}
				},
				errorLabelContainer: "#messageBox",
				errorPlacement: function(error, element) {
					error.appendTo($("#loginError").parent());
				} 
			});
		});
		// 如果在框架或在对话框中，则弹出提示并跳转到首页
		if(self.frameElement && self.frameElement.tagName == "IFRAME" || $('#left').length > 0 || $('.jbox').length > 0){
			alert('未登录或登录超时。请重新登录，谢谢！');
			top.location = "${ctx}";
		}
	</script>
</head>
<body>
	<img id="bg" src="${ctxStatic}/images/bg1.jpg" />
	<div id="login">
		<div class="header">
			<div id="messageBox" class="alert alert-error ${empty message ? 'hide' : ''}"><button data-dismiss="alert" class="close">×</button>
				<label id="loginError" class="error">${message}</label>
			</div>
		</div>
		<img id="dianxin" src="${ctxStatic}/images/dianxin.jpg" />
		<div class="login-box">
			<div class="login-logo">
			    <a href="#" style="color: #0663a2"><b>${fns:getConfig('productName')}</b></a>
			</div>
			<form  id="loginForm"  action="${ctx}/login" method="post">
				<div class="login-box-body" style="font-size: 20px;padding-top:200px;" > <!-- visibility:hidden -->
					<!-- <p class="login-box-msg">用户登录</p> -->
					
				    <div class="form-group has-feedback">
				        <label class="input-label" for="username">登录名:</label>
				 		<input id="username" name="username"  type="text" class="form-control"   required  value="thinkgem"> <!--   -->
				       <!-- <input id="username" name="username"  type="text" class="form-control"   required value="test"> -->
				        <span class="glyphicon glyphicon-user form-control-feedback" style="line-height:74px;top: 15px"></span>
				    </div>
				    <div class="form-group has-feedback">
						<label class="input-label" for="password">密码：</label>
						<input type="password"  id="password" name="password"  class="form-control"  required  value="admin">  <!--  -->
						<!--<input type="password"  id="password" name="password"  class="form-control"  required value="123456"> -->
				        <span class="glyphicon glyphicon-lock form-control-feedback"  style="line-height:74px;top: 15px"></span>
				    </div>
				   <c:if test="${isValidateCodeLogin}">
					   <div class="validateCode">
							<label class="input-label mid" for="validateCode">验证码:</label>
							<sys:validateCode name="validateCode" inputCssStyle="margin-bottom:0;"/>
						</div>
					</c:if>
				    <div class="row" style="padding-top:20px">
				      	<div class="col-xs-12">
				        	<button type="submit" class="btn btn-primary btn-block btn-flat" style="font-size:20px;border-radius:6px">登录</button>
				      	</div>
				    </div>
				    <div class="row">
				    	<div class="col-xs-12" style="padding-top:20px;font-size: 16px">
					        <div class="checkbox icheck">
					          <label>
					          	  <input type="checkbox"> 记住我
					          </label>
					        </div>
					    </div>
				    </div>
				</div>
			</form>
		</div>
	</div>
	<div class="footer" align="center" style="width:100%;bottom: :0;position: absolute;bottom:0;background-color: rgba(0,0,0,0.6);padding: 20px 0;color: #fff;font-size: 16px">
		<div>
			Copyright &copy; 2016-${fns:getConfig('copyrightYear')} <a href="${pageContext.request.contextPath}${fns:getFrontPath()}" ><b>${fns:getConfig('productName')}</b></a> - Powered By <a href="http://www.zbiti.com/" target="_blank" ><b>
中博信息技术研究院有限公司</b></a> ${fns:getConfig('version')} 
		</div>
		
	</div>
	<script>
	  $(function () {
	    $('input').iCheck({
	      checkboxClass: 'icheckbox_square-blue',
	      radioClass: 'iradio_square-blue',
	      increaseArea: '20%' // optional
	    });
	    
	  });
	</script>
</body>
</html>
