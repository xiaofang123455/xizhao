 package com.thinkgem.jeesite.modules.echarts.hubei;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.thinkgem.jeesite.common.web.BaseController;
@Controller
@RequestMapping(value = "${adminPath}/echarts/hubei")
public class HubeiController extends BaseController {
	
	/***********************************收入********************************/
	//收入结构占比---按收入来源
	@RequestMapping(value = "srjgsrly")
	public String srjigsuly(HttpServletRequest request,
			HttpServletResponse response){
		return "modules/echarts/hubei/shouru/srjgsrly";
	}
	
	//收入结构占比---按财务科目分析
	@RequestMapping(value = "srjgcwkm")
	public String srjgcwkm(HttpServletRequest request,
			HttpServletResponse response){
		return "modules/echarts/hubei/shouru/srjgcwkm";
	}
	
	//帐前帐后调账依据分析
	@RequestMapping(value = "srtzyj")
	public String srtzyj(HttpServletRequest request,
			HttpServletResponse response){
		return "modules/echarts/hubei/shouru/srtzyj";
	}
	
	//房屋出租收入
	@RequestMapping(value = "srfwczsr")
	public String srfwczsr(HttpServletRequest request,
			HttpServletResponse response){
		return "modules/echarts/hubei/shouru/srfwczsr_1";
	}
	
	//出售商品支出占收比
	@RequestMapping(value = "srcsspzczsb")
	public String srcsspzczsb(HttpServletRequest request,
			HttpServletResponse response){
		return "modules/echarts/hubei/shouru/srcsspzczsb";
	}
	
	/***********************************成本********************************/
	//成本一级科目月度趋势分析
	@RequestMapping(value = "cbyjkmydqs")
	public String cbyjkmydqs(HttpServletRequest request,
			HttpServletResponse response){
		return "modules/echarts/hubei/chengben/cbyjkmydqs";
	}
	
	//成本一级科目结构占比分析
	@RequestMapping(value = "cbyjkmjgzbfx")
	public String cbyjkmjgzbfx(HttpServletRequest request,
			HttpServletResponse response){
		return "modules/echarts/hubei/chengben/cbyjkmjgzbfx";
	}
	
	//成本重点营业成本趋势分析
	@RequestMapping(value = "zdyycb")
	public String zdyycb(HttpServletRequest request,
			HttpServletResponse response){
		return "modules/echarts/hubei/chengben/zdyycb";
	}
	
	//成本重点销售费用趋势分析
	@RequestMapping(value = "cbzdxsfy")
	public String cbzdxsfy(HttpServletRequest request,
			HttpServletResponse response){
		return "modules/echarts/hubei/chengben/cbzdxsfy";
	}
	
	//成本重点销售费用结构及同比分析
	@RequestMapping(value = "cbzdxsfyjg")
	public String cbzdxsfyjg(HttpServletRequest request,
			HttpServletResponse response){
		return "modules/echarts/hubei/chengben/cbzdxsfyjg";
	}
	//成本 终端补贴占收比
	@RequestMapping(value = "rzdbt")
	public String rzdbt(HttpServletRequest request,
			HttpServletResponse response){
		return "modules/echarts/hubei/chengben/rzdbt";
	}
	
	
	//成本 代理代办费月度趋势
	@RequestMapping(value = "rdldbfy")
	public String rdldbfy(HttpServletRequest request,
			HttpServletResponse response){
		return "modules/echarts/hubei/chengben/rdldbfy";
	}
	
	//成本 人工成本月度趋势分析
	@RequestMapping(value = "rrgcbqs")
	public String rrgcbqs(HttpServletRequest request,
			HttpServletResponse response){
		return "modules/echarts/hubei/chengben/rrgcbqs";
	}
	
	
	//成本 手工录入佣金异常分析-地市
	@RequestMapping(value = "sglryjycfx")
	public String sglryjycfx(HttpServletRequest request,
			HttpServletResponse response){
		return "modules/echarts/hubei/chengben/sglryjycfx";
	}
	
	/***********************************SPCP********************************/

	//成本 CPSP结算收支匹配分析-地市
	@RequestMapping(value = "cpspcjsszppfx")
	public String cpspcjsszppfx(HttpServletRequest request,
			HttpServletResponse response){
		return "modules/echarts/hubei/spcp/cpspcjsszppfx";
	}
	
	//赠金抵扣SPCP模型一
		@RequestMapping(value = "zjdkspcp1")
		public String zjdkspcp1(HttpServletRequest request,
				HttpServletResponse response){
			return "modules/echarts/hubei/spcp/zjdkspcp1";
		}
		
	//赠金抵扣SPCP模型二
	@RequestMapping(value = "zjdkspcp2")
	public String zjdkspcp2(HttpServletRequest request,
			HttpServletResponse response){
		return "modules/echarts/hubei/spcp/zjdkspcp2";
	}
	
	
	/***********************************积分管理********************************/
	//积分计提分析
	@RequestMapping(value = "jfjt")
	public String jfjt(HttpServletRequest request,
			HttpServletResponse response){
		return "modules/echarts/hubei/jifen/jfjt";
	}
	
	//积分兑换分析
	@RequestMapping(value = "jfdh")
	public String jfdh(HttpServletRequest request,
			HttpServletResponse response){
		return "modules/echarts/hubei/jifen/jfdh";
	}
	
	/***********************************营收资本********************************/

	//EDW系统--余额结转
	@RequestMapping(value = "yejz")
	public String yejz(HttpServletRequest request,
			HttpServletResponse response){
		return "modules/echarts/hubei/yingshou/yejz";
	}
	

	//EDW系统--余额提取
	@RequestMapping(value = "yuetiqu")
	public String yuetiqu(HttpServletRequest request,
			HttpServletResponse response){
		return "modules/echarts/hubei/yingshou/yuetiqu";
	}
	
	//EDW系统--政企预打票
	@RequestMapping(value = "zqydp")
	public String zqydp(HttpServletRequest request,
			HttpServletResponse response){
		return "modules/echarts/hubei/yingshou/zqydp";
	}
	
	/***********************************武汉水电消耗模型********************************/
	
	@RequestMapping(value = "dian")
	public String dian(HttpServletRequest request,
			HttpServletResponse response){
		return "modules/echarts/hubei/dian";
	}
	
	@RequestMapping(value = "dian1")
	public String dian1(HttpServletRequest request,
			HttpServletResponse response){
		return "modules/echarts/hubei/dian1";
	}
	
	@RequestMapping(value = "shui")
	public String shui(HttpServletRequest request,
			HttpServletResponse response){
		return "modules/echarts/hubei/shui";
	}
	
	@RequestMapping(value = "shui1")
	public String shui1(HttpServletRequest request,
			HttpServletResponse response){
		return "modules/echarts/hubei/shui1";
	}
	/***********************************武汉水电消耗模型********************************/
	
	//vc充值--跨省充值分析
	@RequestMapping(value = "vcks")
	public String vcks(HttpServletRequest request,
			HttpServletResponse response){
		return "modules/echarts/hubei/vc/vcks";
	}
	
	//vc充值--小额充值分析
	@RequestMapping(value = "vcxe")
	public String vcxe(HttpServletRequest request,
			HttpServletResponse response){
		return "modules/echarts/hubei/vc/vcxe";
	}
	
}
