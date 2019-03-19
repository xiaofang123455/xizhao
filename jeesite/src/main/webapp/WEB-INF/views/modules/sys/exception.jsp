<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录超时</title>
</head>
<body style="text-align: center;margin-top: 10%;">
<div style="
    width: 50%;
    margin-left: 25%;
    margin-right: 25%;
    margin-top: 15%;
">
	<div>
		<table>
			<tr>
				<td>
					<img src="${ctxStatic}/plugins/echarts/3.2.3/images/QQ.png"/>
				</td>
				<td style="margin-top:-50px; font-family: Microsoft YaHei;">
					<span style="font-size: 23px;display: block;color:rgb(135,145,154);">${message}</span>
					
					<!-- <span style="font-size: 15px;display: block;color:rgb(111,111,111);padding-top:10px">操作超时,请稍后再试</span> -->
					
				</td>
			</tr>
		</table>
		
	</div>
		
	</div>
</body>
</html>