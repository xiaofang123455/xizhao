/**
 * Copyright &copy; 2012-2016 <a
 * href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.web;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.UnauthorizedException;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.web.util.WebUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.security.shiro.session.SessionDAO;
import com.thinkgem.jeesite.common.servlet.ValidateCodeServlet;
import com.thinkgem.jeesite.common.utils.CacheUtils;
import com.thinkgem.jeesite.common.utils.CookieUtils;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.security.FormAuthenticationFilter;
import com.thinkgem.jeesite.modules.sys.security.SystemAuthorizingRealm.Principal;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 登录Controller
 * 
 * @author ThinkGem
 * @version 2013-5-31
 */
@Controller
public class LoginController extends BaseController
{

	@Autowired
	private SessionDAO sessionDAO;
	
	@Autowired
	private SystemService systemService;
	
	/**
	 * 管理登录
	 */
	@RequestMapping(value = "${adminPath}/login", method = RequestMethod.GET)
	public String login(HttpServletRequest request, HttpServletResponse response, Model model)
	{
		Principal principal = UserUtils.getPrincipal();

		// // 默认页签模式
		// String tabmode = CookieUtils.getCookie(request, "tabmode");
		// if (tabmode == null){
		// CookieUtils.setCookie(response, "tabmode", "1");
		// }

		if (logger.isDebugEnabled())
		{
			logger.debug("login, active session size: {}", sessionDAO.getActiveSessions(false).size());
		}

		// 如果已登录，再次访问主页，则退出原账号。
		if (Global.TRUE.equals(Global.getConfig("notAllowRefreshIndex")))
		{
			CookieUtils.setCookie(response, "LOGINED", "false");
		}

		// 如果已经登录，则跳转到管理首页
		if (principal != null && !principal.isMobileLogin()) { return "redirect:" + adminPath; }
		// String view;
		// view = "/WEB-INF/views/modules/sys/sysLogin.jsp";
		// view = "classpath:";
		// view +=
		// "jar:file:/D:/GitHub/jeesite/src/main/webapp/WEB-INF/lib/jeesite.jar!";
		// view += "/"+getClass().getName().replaceAll("\\.",
		// "/").replace(getClass().getSimpleName(), "")+"view/sysLogin";
		// view += ".jsp";
		return "modules/sys/sysLogin";
	}

	/**
	 * 登录失败，真正登录的POST请求由Filter完成
	 */
	@RequestMapping(value = "${adminPath}/login", method = RequestMethod.POST)
	public String loginFail(HttpServletRequest request, HttpServletResponse response, Model model)
	{
		Principal principal = UserUtils.getPrincipal();

		// 如果已经登录，则跳转到管理首页
		if (principal != null) { return "redirect:" + adminPath; }
		
		// 如果已经登录，则跳转到管理首页
		if (principal != null) { 
			return "redirect:" + adminPath; 
		}

		String username = WebUtils.getCleanParam(request, FormAuthenticationFilter.DEFAULT_USERNAME_PARAM);
		boolean rememberMe = WebUtils.isTrue(request, FormAuthenticationFilter.DEFAULT_REMEMBER_ME_PARAM);
		boolean mobile = WebUtils.isTrue(request, FormAuthenticationFilter.DEFAULT_MOBILE_PARAM);
		String exception = (String) request.getAttribute(FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME);
		String message = (String) request.getAttribute(FormAuthenticationFilter.DEFAULT_MESSAGE_PARAM);

		if (StringUtils.isBlank(message) || StringUtils.equals(message, "null"))
		{
			message = "用户或密码错误, 请重试.";
		}

		model.addAttribute(FormAuthenticationFilter.DEFAULT_USERNAME_PARAM, username);
		model.addAttribute(FormAuthenticationFilter.DEFAULT_REMEMBER_ME_PARAM, rememberMe);
		model.addAttribute(FormAuthenticationFilter.DEFAULT_MOBILE_PARAM, mobile);
		model.addAttribute(FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME, exception);
		model.addAttribute(FormAuthenticationFilter.DEFAULT_MESSAGE_PARAM, message);

		if (logger.isDebugEnabled())
		{
			logger.debug("login fail, active session size: {}, message: {}, exception: {}", sessionDAO
					.getActiveSessions(false).size(), message, exception);
		}

		// 非授权异常，登录失败，验证码加1。
		if (!UnauthorizedException.class.getName().equals(exception))
		{
			model.addAttribute("isValidateCodeLogin", isValidateCodeLogin(username, true, false));
		}

		// 验证失败清空验证码
		request.getSession().setAttribute(ValidateCodeServlet.VALIDATE_CODE, IdGen.uuid());

		// 如果是手机登录，则返回JSON字符串
		if (mobile) { return renderString(response, model); }

		return "modules/sys/exception";
	}


	/**
	 * 登录成功，进入管理首页
	 */
	@RequestMapping(value = "${adminPath}/ssoLogin")
	public String ssoLogin(HttpServletRequest request, HttpServletResponse response, Model model)
	{
		
		User user = new User();
		String encryptedNo=request.getParameter("encryptedNo").trim();
		 model.addAttribute("encryptedNo",encryptedNo);
		Principal principal = UserUtils.getPrincipal();
		//得到参数encryptedNo和pricipal同时不为空，且不相等，相当于没有退出，要进行二次登录，则将原账号退出
		if(encryptedNo!=null && principal != null && encryptedNo!=principal.getId()){
			UserUtils.getSubject().logout();
			principal=null;
		}
		//用来模拟用户名和密码的页面
		String returnPage="modules/sys/tsysLogin";
		// 如果已经登录，则跳转到管理首页
		if (principal != null && !principal.isMobileLogin()) {
			if(encryptedNo!=null){
				returnPage="redirect:" + adminPath; 
			}
		}else{
			user.setEncryptedNo(encryptedNo);
			user = systemService.getUserByEncryptedNo(user);
			String message = "";
			String userName="";
			if(user!=null){
				 userName=user.getLoginName();
				 model.addAttribute("userName",userName);
			}else{
				message = "用户不存在，请切换用户再做尝试.";
				 model.addAttribute("message",message);
				returnPage= "modules/sys/exception";
			}
		}
		return returnPage;
	}
	
	
	/**
	 * 登录成功，进入管理首页
	 */
	@RequiresPermissions("user")
	@RequestMapping(value = "${adminPath}")
	public String index(HttpServletRequest request, HttpServletResponse response)
	{
		Principal principal = UserUtils.getPrincipal();

		// 登录成功后，验证码计算器清零
		isValidateCodeLogin(principal.getLoginName(), false, true);

		if (logger.isDebugEnabled())
		{
			logger.debug("show index, active session size: {}", sessionDAO.getActiveSessions(false).size());
		}

		// 如果已登录，再次访问主页，则退出原账号。
		if (Global.TRUE.equals(Global.getConfig("notAllowRefreshIndex")))
		{
			String logined = CookieUtils.getCookie(request, "LOGINED");
			if (StringUtils.isBlank(logined) || "false".equals(logined))
			{
				CookieUtils.setCookie(response, "LOGINED", "true");
			}
			else if (StringUtils.equals(logined, "true"))
			{
				UserUtils.getSubject().logout();
				return "redirect:" + adminPath + "/login";
			}
		}
		request.getSession().setAttribute("userCompanyName","湖北公司");
		request.getSession().setAttribute("user",UserUtils.getUser());
		// 如果是手机登录，则返回JSON字符串
		if (principal.isMobileLogin())
		{
			if (request.getParameter("login") != null) { return renderString(response, principal); }
			if (request.getParameter("index") != null) { return "modules/sys/sysIndex"; }
			return "redirect:" + adminPath + "/login";
		}

		// // 登录成功后，获取上次登录的当前站点ID
		// UserUtils.putCache("siteId",
		// StringUtils.toLong(CookieUtils.getCookie(request, "siteId")));

		// System.out.println("==========================a");
		// try {
		// byte[] bytes =
		// com.thinkgem.jeesite.common.utils.FileUtils.readFileToByteArray(
		// com.thinkgem.jeesite.common.utils.FileUtils.getFile("c:\\sxt.dmp"));
		// UserUtils.getSession().setAttribute("kkk", bytes);
		// UserUtils.getSession().setAttribute("kkk2", bytes);
		// } catch (Exception e) {
		// e.printStackTrace();
		// }
		// // for (int i=0; i<1000000; i++){
		// // //UserUtils.getSession().setAttribute("a", "a");
		// // request.getSession().setAttribute("aaa", "aa");
		// // }
		// System.out.println("==========================b");
		
		
		//生成水印，判断该用户名下的文件夹下，是否有所需的水印图片，没有，删掉里面其他的，创造一个
		
		if (!StringUtils.isBlank(principal.getEncryptedNo())) {
			return "modules/sys/ssoSysIndex";
		}
		return "modules/sys/sysIndex";
	}

	/**
	 * 获取主题方案
	 */
	@RequestMapping(value = "/theme/{theme}")
	public String getThemeInCookie(@PathVariable String theme, HttpServletRequest request, HttpServletResponse response)
	{
		if (StringUtils.isNotBlank(theme))
		{
			CookieUtils.setCookie(response, "theme", theme);
		}
		else
		{
			theme = CookieUtils.getCookie(request, "theme");
		}
		return "redirect:" + request.getParameter("url");
	}

	/**
	 * 是否是验证码登录
	 * 
	 * @param useruame
	 *            用户名
	 * @param isFail
	 *            计数加1
	 * @param clean
	 *            计数清零
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static boolean isValidateCodeLogin(String useruame, boolean isFail, boolean clean)
	{
		Map<String, Integer> loginFailMap = (Map<String, Integer>) CacheUtils.get("loginFailMap");
		if (loginFailMap == null)
		{
			loginFailMap = Maps.newHashMap();
			CacheUtils.put("loginFailMap", loginFailMap);
		}
		Integer loginFailNum = loginFailMap.get(useruame);
		if (loginFailNum == null)
		{
			loginFailNum = 0;
		}
		if (isFail)
		{
			loginFailNum++;
			loginFailMap.put(useruame, loginFailNum);
		}
		if (clean)
		{
			loginFailMap.remove(useruame);
		}
		return loginFailNum >= 3;
	}
}
