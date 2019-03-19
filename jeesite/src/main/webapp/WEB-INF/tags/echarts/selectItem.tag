<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!--选择机构隐藏的下拉选项开始-->
	<div class="col-md-5 selectItemhidden" id="selectItem" style="display: none;" style="width:300px">
		<div class="box box-info">
			<form class="form-horizontal">
				<div class="box-body" id="selectSub">
					<div class="form-group">
						<div class=" col-sm-12">
							<div class="checkbox">
								<label> <input type="checkbox"  name="workspace"
								title="全国" 	value="">全国
								</label>
							</div>
						</div>
					</div>
					<div class="form-group">
					<div class=" col-sm-12">
							<div class="checkbox">
								<label> <input type="checkbox"  name="workspace"
									 value="1" title="华东">华东
								</label>
								<label><input type="checkbox" title="上海"   name="workspace"
									value="31"> 上海
								</label>
								<label><input type="checkbox" title="江苏"   name="workspace"
									value="32"> 江苏
								</label> 
								<label>  <input type="checkbox" title="浙江"   name="workspace"
									value="33"> 浙江
								</label>
								<label>  <input type="checkbox" title="安徽"   name="workspace"
									value="34"> 安徽
								</label>
								 <label> <input type="checkbox" title="山东"   name="workspace"
									value="37"> 山东
								</label> 
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class=" col-sm-12">
							<div class="checkbox">
								<label> <input type="checkbox"  name="workspace"
									 value="2" title="华南">华南
								</label>
								<label> <input type="checkbox" title="广东"   name="workspace"
									value="44"> 广东
								</label> <label> <input type="checkbox" title="广西"   name="workspace"
									value="45"> 广西
								</label> <label> <input type="checkbox" title="海南"   name="workspace"
									value="46">海南
								</label><label>  <input type="checkbox" title="福建"   name="workspace"
									value="35"> 福建
								</label> 
							</div>
						</div>
					</div>
									
					<div class="form-group">
						<div class="col-sm-12">
							<div class="checkbox">
								<label> <input type="checkbox"  name="workspace"
									 value="4" title="华北">华北
								</label>
								 <label>  <input type="checkbox" title="北京"   name="workspace"
									value="11"> 北京
								</label>  <label> <input type="checkbox" title="天津"   name="workspace"
									value="12"> 天津
								</label> <label>  <input type="checkbox" title="河北"   name="workspace"
									value="13"> 河北 
								</label><label> <input type="checkbox" title="山西"   name="workspace"
									value="14"> 山西
								</label>
								 <label> <input type="checkbox" title="内蒙古"   name="workspace"
									value="15"> 内蒙古
								</label>
							</div>
						</div>
					</div>
					
					<div class="form-group">
						<div class="col-sm-12">
							<div class="checkbox">
								<label> <input type="checkbox"  name="workspace"
									 value="3" title="华中">华中
								</label> <label>  <input type="checkbox" title="湖北"   name="workspace"
									value="42"> 湖北
								</label> <label>  <input type="checkbox" title="湖南"   name="workspace"
									value="43"> 湖南
								</label> <label>  <input type="checkbox" title="河南"   name="workspace"
									value="41"> 河南
								</label> <label> <input type="checkbox" title="江西"   name="workspace"
									value="36">江西
								</label>
							</div>
						</div>
					</div>
					
						<div class="form-group">
						<div class="col-sm-12">
							<div class="checkbox">
								<label> <input type="checkbox"  name="workspace"
									 value="5" title="西南">西南
								</label>
								<label>  <input type="checkbox" title="四川"   name="workspace"
									value="51"> 四川
								</label> <label>  <input type="checkbox" title="重庆"   name="workspace"
									value="50"> 重庆
								</label>  <label> <input type="checkbox" title="贵州"   name="workspace"
									value="52"> 贵州
								</label><label>  <input type="checkbox" title="云南"   name="workspace"
									value="53"> 云南
								</label><label> <input type="checkbox" title="西藏"   name="workspace"
									value="54"> 西藏
								</label>
							</div>
						</div>
					</div>
					
					<div class="form-group">
						<div class="col-sm-12">
							<div class="checkbox">
								<label> <input type="checkbox"  name="workspace"
									 value="7" title="东北">东北 
								</label><label>  <input type="checkbox" title="辽宁"   name="workspace"
									value="21"> 辽宁
								</label><label> <input type="checkbox" title="吉林"   name="workspace"
									value="22"> 吉林
								</label>
								<label> <input type="checkbox" title="黑龙江"   name="workspace"
									value="23"> 黑龙江</label> 
							</div>
						</div>
					</div>
					
					
						<div class="form-group">
						<div class="col-sm-12">
							<div class="checkbox">
								<label> <input type="checkbox"  name="workspace"
									 value="6" title="西北">西北  
								</label><label>  <input type="checkbox" title="陕西"   name="workspace"
									value="61"> 陕西
								</label><label>  <input type="checkbox" title="甘肃"   name="workspace"
									value="62"> 甘肃
								</label><label>  <input type="checkbox" title="新疆"   name="workspace"
									value="65"> 新疆
								</label>  <label>  <input type="checkbox" title="青海"   name="workspace"
									value="63"> 青海
								</label> <label>  <input type="checkbox" title="宁夏"   name="workspace"
									value="64"> 宁夏
								</label> 
							</div>
						</div>
					</div>
				
				</div>
				<div class="box-footer">
					<button type="reset" class="btn btn-default btn-sm" id="selectItemClose" onclick="cancel()">取消</button>
					<button type="button" class="btn btn-info pull-right btn-sm" id="addDwbm" onclick="add()">确定</button>
				</div>
			</form>
		</div>
	</div>