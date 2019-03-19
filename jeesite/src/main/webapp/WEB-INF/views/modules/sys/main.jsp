<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="decorator" content="default"/>
<title>首页</title>
<link rel="stylesheet" href="${ctxStatic}/dist/css/AdminLTE.min.css">
<script src="${ctxStatic}/plugins/echarts/3.2.3/echarts.min.js"></script>
<script src="${ctxStatic}/plugins/echarts/3.2.3/china.js"></script>
<script src="${ctxStatic}/plugins/echarts/symbols.js"></script>
<script src="${ctxStatic}/common/StringUtil.js" type="text/javascript"></script>
<script src="${ctxStatic}/common/dvCustom.js"></script>
<script src="${ctxStatic}/common/mask.js" type="text/javascript"></script>
<meta name="viewport" content="width=device-width, initial-scale=1" />
 <style>
        body {
            background-color:  #ffffff/*rgb(238,238,238) */ /*rgb(13, 60, 84)*/ ;
        }
        .divClass{
		border: 1px solid #666666;
		margin-left:15px;
		height:100%;
		float:left;
		width:18%; 
	}
	
	.col-md-3{
		padding-right: 10px;
		padding-left: 5px;
		width:24.7%;
	}
        span {
            font-size: 24px;
            color: #333/* rgb(255, 255, 255) */;
            text-decoration: none;
            text-align: left;
            font-family: Microsoft YaHei;
        }
        .commonTr {
            height:30px;
            color:#333/* rgb(255,255,255) */;
            font-size: 12px;
        }

        .td{
            border-bottom:2px solid #666666;
            border-top:1px solid #666666;
            font-size:14px
        }


    table.buttom {
        font-family: Microsoft YaHei/* verdana,arial,sans-serif */;
        font-size:11px;
        color: #333/* rgb(255, 255, 255) */;
        border-collapse: collapse;
    }
    
    .buttom td {
        border: 1px solid #666666;
        padding: 8px;
        text-align: center;
    }
    
     .buttom tr {
       height:30px;
    } 
    
      .buttom td div {
        height:15px;
        float: left;
    } 
    
    .lastTr{
   		 border-bottom:1px solid #666666;
    }
    
    .selectedBtn{
   		 width: 100px;
   		 height: 25px;
   		 border: 1px solid rgb(0, 255, 252);
   		 background-color: rgba(97, 160, 168,0.8)
    }
     .unselectedBtn{
     	width: 100px;
   		 height: 25px;
   		 border: 1px solid rgb(19,90,110);
   		 background-color:rgba(97, 160, 168,0.8)
    }
    
    .sjfxTable tr:nth-last-child(1) td{
     border-bottom:1px solid #666666;
    }
    </style>
</head>
<body>
<div class="wrapper wrapper-content">
    <section class="content" style="padding-top:0">
        <div class="row" style="margin-left:-10px"><!--style="height: 330px"-->
            <div class="col-md-6 ">
	            <div class="row">
	            	 <div class="col-md-12 ">
              		  <span>首页</span>
           			 </div>
	            </div>
               		
</body>
</html>