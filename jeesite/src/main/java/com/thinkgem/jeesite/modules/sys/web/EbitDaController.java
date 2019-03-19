package com.thinkgem.jeesite.modules.sys.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.Area;
import com.thinkgem.jeesite.modules.sys.entity.EbitDa;
import com.thinkgem.jeesite.modules.sys.service.AreaService;
import com.thinkgem.jeesite.modules.sys.service.EbitDaService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * @File: EbitDaController.java
 * @Description: ebitDa处理类
 * @author yxf
 * @date 2016年8月31日 上午9:55:34
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/ebitDa")
public class EbitDaController extends BaseController {

	@Autowired
	private EbitDaService ebitDaService;
	
	@Autowired
	private AreaService areaService;

	/**
	 * @Description:
	 * 	1、默认方式和通过表格链接最新的四个月用户所在省份的数据。
	 * 	2、通过查询显示的是限定年月数据，选择机构选择多个，则默认第一个。
	 *
	 * @date:2016年10月9日 下午3:51:00
	 *
	 * @date:2016年10月9日     @author:yxf     create
	 */
	@ResponseBody
	@RequestMapping(value = "queryByDwbm")
	public List<EbitDa> queryByDwbm(HttpServletRequest request,
			HttpServletResponse response,EbitDa ebitDa) {
		List<EbitDa> ebitDas = new ArrayList<EbitDa>();
		List<Area> bigAreaCodeList = new ArrayList<Area>();
		List<String> provinceCodeList = new ArrayList<String>();
		if (StringUtils.isBlank(ebitDa.getDwbm())) {
			ebitDa.setDwbm(UserUtils.getUser().getCompany().getArea().getCode());
		}else {
			//处理传过来的单位编码
			//当单位编码传过来有华东，华北等地区，或者传过来的省份数量大于一，显示用户所属dwbm
			//当单位编码有且只有一个省份，显示这个省份
			String[] dwbmArr  = ebitDa.getDwbm().split(",");
			if (StringUtils.isBlank(dwbmArr[0])) {
				ebitDa.setDwbm(UserUtils.getUser().getCompany().getArea().getCode());
			}else {
				Area area = new Area();
				area.setType("2");
				List<Area>  areaList = areaService.getAreaListByType(area);
				for(int i = 0;i<dwbmArr.length;i++){
					for(int j = 0;j<areaList.size();j++){
						if(dwbmArr[i] == areaList.get(j).getCode()){
							bigAreaCodeList.add(areaList.get(j));
							continue;
						}
						if(j == (areaList.size()-1)){
							provinceCodeList.add(dwbmArr[i]);
						}
					}}
				}
		if(bigAreaCodeList.size()>0||provinceCodeList.size() > 1){
			ebitDa.setDwbm(UserUtils.getUser().getCompany().getArea().getCode());
		}
		if (bigAreaCodeList.size() == 0&&provinceCodeList.size() == 1) {
			ebitDa.setDwbm(provinceCodeList.get(0));
		}
		
		}
		ebitDas = ebitDaService.queryEbitdaByDwbm(ebitDa);
		if (ebitDas.size() > 0) {
			if (StringUtils.isNotBlank(ebitDa.getGsxz())) {
				if(ebitDa.getGsxz().equals("A")){
					ebitDas.get(0).setGsxz("股份");
				}
				if(ebitDa.getGsxz().equals("B")){
					ebitDas.get(0).setGsxz("网资");
				}
				if(ebitDa.getGsxz().equals("C")){
					ebitDas.get(0).setGsxz("存续");
				}
			}
			
		}
		return ebitDas;
	}

	@ResponseBody
	@RequestMapping(value = "queryEbitDaByYear")
	public List<EbitDa> queryEbitDaByYear(HttpServletRequest request,
			HttpServletResponse response,EbitDa ebitDa) {
		List<EbitDa> ebitDas = new ArrayList<EbitDa>();
		if (StringUtils.isBlank(ebitDa.getEndYear())) {
			String latestYear = ebitDaService.getLatestYear();
			ebitDa.setEndYear(latestYear);
			}
		ebitDas = ebitDaService.queryEbitDaByYear(ebitDa);
		List<EbitDa> ebitDasList = new ArrayList<EbitDa>();
		if (ebitDas.size() > 0) {
			for (int i = 0; i < 3; i++) {
				ebitDasList.add(ebitDas.get(i));
			}
			ebitDasList.add(ebitDas.get(5));
			ebitDasList.add(ebitDas.get(4));
			ebitDasList.add(ebitDas.get(3));
			ebitDasList.get(0).setEndYear(ebitDa.getEndYear());
			if (!StringUtils.isBlank(ebitDa.getGsxz())) {
				if(ebitDa.getGsxz().equals("A")){
					ebitDasList.get(0).setGsxz("股份");
				}
				if(ebitDa.getGsxz().equals("B")){
					ebitDasList.get(0).setGsxz("网资");
				}
				if(ebitDa.getGsxz().equals("C")){
					ebitDasList.get(0).setGsxz("存续");
					}
			}
		}
		return ebitDasList;
	}

	@RequestMapping(value = "list")
	public String list(HttpServletRequest request,HttpServletResponse response, Model model,EbitDa ebitDa) {
		List<Area> bigAreaCodeList = new ArrayList<Area>();
		List<String> provinceCodeList = new ArrayList<String>();
		if (!StringUtils.isBlank(ebitDa.getDwbm())){
			String[] dwbmArr  = ebitDa.getDwbm().split(",");
			if (StringUtils.isBlank(dwbmArr[0])) {
				ebitDa.setDwbmList(null);
			}else {
				Area area = new Area();
				area.setType("2");
				List<Area>  areaList = areaService.getAreaListByType(area);
				for(int i = 0;i<dwbmArr.length;i++)
					for(int j = 0;j<areaList.size();j++){
						if(dwbmArr[i].equals(areaList.get(j).getCode())){
							bigAreaCodeList.add(areaList.get(j));
							break;
						}
						if(j == areaList.size()-1){
							provinceCodeList.add(dwbmArr[i]);
						}
					}
				for(int i=0;i < bigAreaCodeList.size();i++){
					List<Area>  childAreaList = areaService.getChildAreaListByParentAreaId(bigAreaCodeList.get(i));
					for(int j = 0;j < childAreaList.size();j++ ){
						provinceCodeList.add(childAreaList.get(j).getCode());
					}
				}
				ebitDa.setDwbmList(provinceCodeList);
			}
			
		}
		Page<EbitDa> page = ebitDaService.findEbitdaList(new Page<EbitDa>(request, response), ebitDa);
		model.addAttribute("page", page);
		model.addAttribute("ebitDa", ebitDa);
		return "modules/charts/ebitdaTable";
	}
	
	@ResponseBody
	@RequestMapping(value = "queryEbitDa")
	public List<EbitDa> queryEbitDa(HttpServletRequest request,
			HttpServletResponse response, EbitDa ebitDa) {
		List<EbitDa> ebitDaList = ebitDaService.queryEbitDa(ebitDa);
		return ebitDaList;
	}
	
	
	@ResponseBody
	@RequestMapping(value = "testPie")
	public List<EbitDa> testPie(HttpServletRequest request,
			HttpServletResponse response, EbitDa ebitDa) {
		
		List<EbitDa> ebitDaList = ebitDaService.queryEbitDa(ebitDa);
		return ebitDaList;
	}
	
	@RequestMapping(value = "showPolarChart")
	public String showPolarChart(HttpServletRequest request,
			HttpServletResponse response,ModelAndView modelAndView){
		
		return "modules/charts/polar-area";
	}

	@RequestMapping(value = "showLineChart")
	public String showLineChart(HttpServletRequest request,
			HttpServletResponse response){
		return "modules/charts/line";
	}
	
	@RequestMapping(value = "showBarChart")
	public String showBarChart(HttpServletRequest request,
			HttpServletResponse response){
		return "modules/charts/bar";
	}
	
	@RequestMapping(value = "showBarStacked")
	public String showBarStacked(HttpServletRequest request,
			HttpServletResponse response){
		return "modules/charts/bar-stacked";
	}
	
	
	@RequestMapping(value = "showEbitda")
	public String showEbitda(HttpServletRequest request,
			HttpServletResponse response){
		return "modules/charts/ebitda";
	}
	
	
	@RequestMapping(value = "showPieChart")
	public String showPieChart(HttpServletRequest request,
			HttpServletResponse response){
		List<EbitDa> ebitDaList = ebitDaService.queryEbitDa(new EbitDa());
		StringBuilder stringBuilder  = new StringBuilder();
		for(int i = 0;i < 4;i++){
			stringBuilder.append(""+ebitDaList.get(i).getEbitdaRate()+"");
			stringBuilder.append(",");
		}
		stringBuilder.append(ebitDaList.get(4).getEbitdaRate());
		request.setAttribute("piedata", stringBuilder.toString());
		return "modules/charts/pie";
	}
	
	/**
	 * 
	 * @Description:
	 * 			
	 * @date:2016年10月20日     @author:yxf     create
	 */
	@RequestMapping(value = "jumpToYearDataChart")
	public String jumpToYearDataChart(EbitDa ebitDa,Model model){
		/*model.addAttribute("ebitDa",ebitDa);*/
		model.addAttribute("year",ebitDa.getYear());
		model.addAttribute("dwbm", ebitDa.getDwbm());
		model.addAttribute("dwmc", ebitDa.getDwmc());
		return "modules/charts/yearDataChart";
	}
	
	@ResponseBody
	@RequestMapping(value = "showYearDataChart")
	public List<EbitDa> showYearDataChart(EbitDa ebitDa){
		List<EbitDa> ebitDas = ebitDaService.showYearDataChart(ebitDa);
		return ebitDas;
	}
	
	@ResponseBody
	@RequestMapping(value = "showSpecificDataChart")
	public Map<String, String> showSpecificDataChart(EbitDa ebitDa){
		String key = "";
		List<EbitDa> ebitDas = ebitDaService.showSpecificDataChart(ebitDa);
		Map<String, String> map = new HashMap<String, String>();
		for(EbitDa oneEbitDa :ebitDas){
			key = oneEbitDa.getGsxz().toUpperCase()+"_"+oneEbitDa.getYear()+"_"+oneEbitDa.getMonth();
			map.put(key+"_ebitda",oneEbitDa.getEbita());
			map.put(key+"_income",oneEbitDa.getIncome());
		}
	
		return map;
	}
	
}
