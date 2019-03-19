/**
、 * Copyright &copy; 2012-2016 <a
 * href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.web;

import java.util.List;
import java.util.Map;

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
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.Area;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.AreaService;
import com.thinkgem.jeesite.modules.sys.service.OfficeService;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 机构Controller
 * 
 * @author ThinkGem
 * @version 2013-5-15
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/office")
public class OfficeController extends BaseController
{

	@Autowired
	private OfficeService officeService;
	
	@Autowired
	private AreaService areaService;


	@ModelAttribute("office")
	public Office get(@RequestParam(required = false) String id)
	{
		if (StringUtils.isNotBlank(id))
		{
			return officeService.get(id);
		}
		else
		{
			return new Office();
		}
	}

	@RequiresPermissions("sys:office:view")
	@RequestMapping(value =
	{ "" })
	public String index(Office office, Model model)
	{
		// model.addAttribute("list", officeService.findAll());
		return "modules/sys/officeIndex";
	}

	@RequiresPermissions("sys:office:view")
	@RequestMapping(value =
	{ "list" })
	public String list(Office office, Model model)
	{
		model.addAttribute("list", officeService.findList(office));
		model.addAttribute("dictList", DictUtils.getDictList("sys_office_type"));
		return "modules/sys/officeList";
	}

	@RequiresPermissions("sys:office:view")
	@RequestMapping(value = "form")
	public String form(Office office, Model model)
	{
		User user = UserUtils.getUser();
		
		if (office.getArea() == null)
		{
			if(office.getParent()!=null && office.getParent().getId() != null){
				Office parentOffice = officeService.get(office.getParent().getId());
				Area area = new Area();
				if (parentOffice != null) {
					area.setId(parentOffice.getArea().getId());
					office.setArea(areaService.get(area));
				}
			}else {
				office.setArea(user.getOffice().getArea());
			}
			
		}

		if (office.getParent() == null || office.getParent().getId() == null)
		{
			office.setParent(user.getOffice());
		}
		office.setParent(officeService.get(office.getParent().getId()));
		
		
		if (office.getArea() == null && office.getParent() != null )
		{
			if (office.getParent().getId() == null){
				office.setArea(user.getOffice().getArea());
			}else {
				Office parentOffice = officeService.get(office.getParent().getId());
				Area area = new Area();
				area.setId(parentOffice.getArea().getId());
				office.setArea(areaService.get(area));
			}
		}
		// 自动获取排序号
		if (StringUtils.isBlank(office.getId()) && office.getParent() != null)
		{
			int size = 0;
			List<Office> list = officeService.findAll();
			for (int i = 0; i < list.size(); i++)
			{
				Office e = list.get(i);
				if (e.getParent() != null && e.getParent().getId() != null
						&& e.getParent().getId().equals(office.getParent().getId()))
				{
					size++;
				}
			}
			if (office.getParent().getCode() == null||"null".equals(office.getParent().getCode())) {
				office.setCode(StringUtils.leftPad(String.valueOf(size > 0 ? size + 1 : 1), 3, "0"));
			}else {
				office.setCode(office.getParent().getCode()
						+ StringUtils.leftPad(String.valueOf(size > 0 ? size + 1 : 1), 3, "0"));
			}
		}
		model.addAttribute("office", office);
		return "modules/sys/officeForm";
	}

	@RequiresPermissions("sys:office:edit")
	@RequestMapping(value = "save")
	public String save(Office office, Model model, RedirectAttributes redirectAttributes)
	{
		if (Global.isDemoMode())
		{
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/sys/office/";
		}
		if (!beanValidator(model, office)) { return form(office, model); }
		officeService.save(office);

		if (office.getChildDeptList() != null)
		{
			Office childOffice = null;
			for (String id : office.getChildDeptList())
			{
				childOffice = new Office();
				childOffice.setName(DictUtils.getDictLabel(id, "sys_office_common", "未知"));
				childOffice.setParent(office);
				childOffice.setArea(office.getArea());
				childOffice.setType("2");
				childOffice.setGrade(String.valueOf(Integer.valueOf(office.getGrade()) + 1));
				childOffice.setUseable(Global.YES);
				officeService.save(childOffice);
			}
		}

		addMessage(redirectAttributes, "保存机构'" + office.getName() + "'成功");
		String id = "0".equals(office.getParentId()) ? "" : office.getParentId();
/*		return "redirect:" + adminPath + "/sys/office/list?id=" + id + "&parentIds=" + office.getParentIds();
*/

		return "redirect:" + adminPath + "/sys/office/list";	
	}

	@RequiresPermissions("sys:office:edit")
	@RequestMapping(value = "delete")
	public String delete(Office office, RedirectAttributes redirectAttributes)
	{
		if (Global.isDemoMode())
		{
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/sys/office/list";
		}
		// if (Office.isRoot(id)){
		// addMessage(redirectAttributes, "删除机构失败, 不允许删除顶级机构或编号空");
		// }else{
		officeService.delete(office);
		addMessage(redirectAttributes, "删除机构成功");
		// }
		// String id = "0".equals(office.getParentId()) ? "" :
		// office.getParentId();
		/*return "redirect:" + adminPath + "/sys/office/list?id=" + office.getParentId() + "&parentIds="
				+ office.getParentIds();*/
		return "redirect:" + adminPath + "/sys/office/list";

	}

	/**
	 * 获取机构JSON数据。
	 * 
	 * @param extId
	 *            排除的ID
	 * @param type
	 *            类型（1：公司；2：部门/小组/其它：3：用户）
	 * @param grade
	 *            显示级别
	 * @param response
	 * @return
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required = false) String extId,
			@RequestParam(required = false) String type, @RequestParam(required = false) Long grade,
			@RequestParam(required = false) Boolean isAll, HttpServletResponse response)
	{
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<Office> list = officeService.findList(isAll);
		for (int i = 0; i < list.size(); i++)
		{
			Office e = list.get(i);
			if ((StringUtils.isBlank(extId) || (extId != null && !extId.equals(e.getId()) && e.getParentIds().indexOf(
					"," + extId + ",") == -1))
					&& (type == null || (type != null && (type.equals("1") ? type.equals(e.getType()) : true)))
					&& (grade == null || (grade != null && Integer.parseInt(e.getGrade()) <= grade.intValue()))
					&& Global.YES.equals(e.getUseable()))
			{
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getId());
				map.put("pId", e.getParentId());
				map.put("pIds", e.getParentIds());
				map.put("name", e.getName());
				if (type != null && "3".equals(type))
				{
					map.put("isParent", true);
				}
				mapList.add(map);
			}
		}
		return mapList;
	}
	
	
	/**
	 * 验证登录名是否有效
	 * 
	 * @param oldLoginName
	 * @param loginName
	 * @return
	 */
	@ResponseBody
	@RequiresPermissions("sys:office:edit")
	@RequestMapping(value = "checkZipCode")
	public String checkZipCode(String oldZipCode, String zipCode)
	{
	
		if (zipCode != null && zipCode.equals(oldZipCode))
		{
			return "true";
		}
		else if (zipCode != null && officeService.getOfficeByZipCode(zipCode) == null) { return "true"; }
		return "false";
	}

	
	
}
