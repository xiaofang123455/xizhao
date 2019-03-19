<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<section id="user_section">
    <header>
        <nav class="left">
            <a href="#" data-icon="previous" data-target="back">返回</a>
        </nav>
        <h1 class="title">用户列表</h1>
    </header>
    <article class="active">
    	<!-- <div style="line-height:50px;padding:10px;">
    		手机端功能没有开发，请继续完善。<br/>
    		你如果有比较好的想法或扩展，也希望您共享出自己的一份代码。
    		请联系 thinkgem@163.com 谢谢！<br/>
    	</div> -->
    	<div class="row">
         	<div class="col-md-12 ">
            	<div class="chart">
                  <div id="mapChart" style="height:480px;width: 600px"></div>
              </div>
           </div>
         </div>
    </article>
    <script type="text/javascript">
	$('body').delegate('#user_section','pageinit',function(){
		alert('pageinit');
	});
	$('body').delegate('#user_section','pageshow',function(){
		alert('pageshow');
        var hash = J.Util.parseHash(location.hash);
        console.log(hash.param);
	});
	
	var mapChart = echarts.init(document.getElementById('mapChart'));
	mapChartoption = {
		    backgroundColor: '#2c343c',

		    title: {
		        text: 'Customized Pie',
		        left: 'center',
		        top: 20,
		        textStyle: {
		            color: '#ccc'
		        }
		    },

		    tooltip : {
		        trigger: 'item',
		        formatter: "{a} <br/>{b} : {c} ({d}%)"
		    },

		    visualMap: {
		        show: false,
		        min: 80,
		        max: 600,
		        inRange: {
		            colorLightness: [0, 1]
		        }
		    },
		    series : [
		        {
		            name:'访问来源',
		            type:'pie',
		            radius : '55%',
		            center: ['50%', '50%'],
		            data:[
		                {value:335, name:'直接访问'},
		                {value:310, name:'邮件营销'},
		                {value:274, name:'联盟广告'},
		                {value:235, name:'视频广告'},
		                {value:400, name:'搜索引擎'}
		            ].sort(function (a, b) { return a.value - b.value}),
		            roseType: 'angle',
		            label: {
		                normal: {
		                    textStyle: {
		                        color: 'rgba(255, 255, 255, 0.3)'
		                    }
		                }
		            },
		            labelLine: {
		                normal: {
		                    lineStyle: {
		                        color: 'rgba(255, 255, 255, 0.3)'
		                    },
		                    smooth: 0.2,
		                    length: 10,
		                    length2: 20
		                }
		            },
		            itemStyle: {
		                normal: {
		                    color: '#c23531',
		                    shadowBlur: 200,
		                    shadowColor: 'rgba(0, 0, 0, 0.5)'
		                }
		            },

		            animationType: 'scale',
		            animationEasing: 'elasticOut',
		            animationDelay: function (idx) {
		                return Math.random() * 200;
		            }
		        }
		    ]
		};
	mapChart.setOption(mapChartoption);
	</script>
</section>