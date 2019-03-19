/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.web;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.Dict;
import com.thinkgem.jeesite.modules.sys.service.DictService;

/**
 * 字典Controller
 * 
 * @author ThinkGem
 * @version 2014-05-16
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/dict")
public class DictController extends BaseController {

	@Autowired
	private DictService dictService;

	@ModelAttribute
	public Dict get(@RequestParam(required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			return dictService.get(id);
		} else {
			return new Dict();
		}
	}

	@RequestMapping(value = "deleteAll")
	public String deleteAll(RedirectAttributes redirectAttributes,String ids) {
		String[] idsArray = ids.split(",");
		List<String> idsList = Arrays.asList(idsArray);
		if (Global.isDemoMode()) {
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/sys/dict/?repage";
		}
		try {
			int rows = dictService.deleteAll(idsList);
			addMessage(redirectAttributes, "成功删除"+rows+"个字典");
		} catch (Exception e) {
			addMessage(redirectAttributes, "删除失败");
		}
		return "redirect:" + adminPath + "/sys/dict/list";
	}

	
	/*
	 * @RequiresPermissions("sys:dict:view")
	 * 
	 * @RequestMapping(value = {"list", ""}) public String list(Dict dict,
	 * HttpServletRequest request, HttpServletResponse response, Model model) {
	 * List<String> typeList = dictService.findTypeList();
	 * model.addAttribute("typeList", typeList); Page<Dict> page =
	 * dictService.findPage(new Page<Dict>(request, response), dict);
	 * model.addAttribute("page", page); return "modules/sys/dictList"; }
	 */

	@RequiresPermissions("sys:dict:view")
	@RequestMapping(value = { "list", "" })
	public String list(Dict dict, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		List<String> typeList = dictService.findTypeList();
		model.addAttribute("typeList", typeList);
		Page<Dict> page = dictService.findPage(
				new Page<Dict>(request, response), dict);
		model.addAttribute("page", page);
		model.addAttribute("dict", dict);
		return "modules/sys/dictList";
	}
	
	@RequiresPermissions("sys:dict:view")
	@RequestMapping(value = "form")
	public String form(Dict dict, Model model) {	
		model.addAttribute("dict", dict);
		return "modules/sys/dictForm";
	}

	/**
	 * 验证该标签在该类型下是否有重复
	 * 
	 * @return
	 */
	@ResponseBody
	@RequiresPermissions("sys:dict:edit")
	@RequestMapping(value = "checkLabelByType")
	public String checkLabelByType(String label,String oldLabel,String type )
	{
		Dict dict = new Dict();
		dict.setLabel(label);
		dict.setType(type);
		if (label != null && label.equals(oldLabel))
		{
			return "true";
		}
		else if (label != null && dictService.getDict(dict).size() == 0) { return "true"; }
		return "false";
	}
	
	
	

	/**
	 * 验证该标签在该类型下是否有重复
	 * 
	 * @return
	 */
	@ResponseBody
	@RequiresPermissions("sys:dict:edit")
	@RequestMapping(value = "checkValueByType")
	public String checkValueByType(String oldValue,String type,String value )
	{
		Dict dict = new Dict();
		dict.setValue(value);
		dict.setType(type);
		if (value != null && value.equals(oldValue))
		{
			return "true";
		}
		else if (type != null &&  dictService.getDict(dict).size() == 0) { return "true"; }
		return "false";
	}
	
	
	@RequiresPermissions("sys:dict:edit")
	@RequestMapping(value = "save")
	public String save(Dict dict, Model model,
			RedirectAttributes redirectAttributes) {
		if (Global.isDemoMode()) {
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/sys/dict/?repage&type="
					+ dict.getType();
		}
		if (!beanValidator(model, dict)) {
			return form(dict, model);
		}
		dictService.save(dict);
		addMessage(redirectAttributes, "保存字典'" + dict.getLabel() + "'成功");
		return "redirect:" + adminPath + "/sys/dict/?repage&type="
				+ dict.getType();
	}

	@RequiresPermissions("sys:dict:edit")
	@RequestMapping(value = "delete")
	public String delete(Dict dict, RedirectAttributes redirectAttributes) {
		if (Global.isDemoMode()) {
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/sys/dict/?repage";
		}
		dictService.delete(dict);
		addMessage(redirectAttributes, "删除字典成功");
		return "redirect:" + adminPath + "/sys/dict/?repage&type="
				+ dict.getType();
	}

	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(
			@RequestParam(required = false) String type,
			HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		Dict dict = new Dict();
		dict.setType(type);
		List<Dict> list = dictService.findList(dict);
		for (int i = 0; i < list.size(); i++) {
			Dict e = list.get(i);
			Map<String, Object> map = Maps.newHashMap();
			map.put("id", e.getId());
			map.put("pId", e.getParentId());
			map.put("name", StringUtils.replace(e.getLabel(), " ", ""));
			mapList.add(map);
		}
		return mapList;
	}

	@ResponseBody
	@RequestMapping(value = "listData")
	public List<Dict> listData(@RequestParam(required = false) String type) {
		Dict dict = new Dict();
		dict.setType(type);
		return dictService.findList(dict);
	}

}
