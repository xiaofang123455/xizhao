/**
 * Copyright &copy; 2012-2016 <a
 * href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.web;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.OfficeService;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 首页MainController
 * 
 * @author zxy
 * @version 2016-8-18
 */
@Controller
@RequestMapping(value = "${adminPath}/main")
public class MainController extends BaseController
{
	
	@Autowired
	private SystemService systemService;

	
	@Autowired
	private OfficeService officeService;
	
	
	String year = "";
	String month = "";
	

	@ModelAttribute
	public User get()
	{
		User currentUser=UserUtils.getUser();
		return currentUser;
	}
	
	@RequestMapping(value = "index")
	public String index(HttpServletRequest request,
			HttpServletResponse response, Model model){
		return "modules/sys/main";
	}
	
	
}
