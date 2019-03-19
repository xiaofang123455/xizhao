/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.web;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.FtpFile;
import com.thinkgem.jeesite.modules.sys.service.FtpFileService;
import com.thinkgem.jeesite.modules.sys.utils.FtpUtil;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * ftp上传文件Controller
 * @author yxf
 * @version 2017-04-27
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/ftpFile")
public class FtpFileController extends BaseController {

	@Autowired
	private FtpFileService ftpFileService;
	
	@ModelAttribute
	public FtpFile get(@RequestParam(required=false) String id) {
		FtpFile entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = ftpFileService.get(id);
		}
		if (entity == null){
			entity = new FtpFile();
		}
		return entity;
	}
	
	@RequiresPermissions("sys:ftpFile:view")
	@RequestMapping(value = {"list", ""})
	public String list(FtpFile ftpFile, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<FtpFile> page = ftpFileService.findPage(new Page<FtpFile>(request, response), ftpFile); 
		model.addAttribute("page", page);
		return "modules/sys/ftpFileList";
	}

	@RequiresPermissions("sys:ftpFile:view")
	@RequestMapping(value = "form")
	public String form(FtpFile ftpFile, Model model) {
		model.addAttribute("ftpFile", ftpFile);
		return "modules/sys/fileInput";
	}

	@RequiresPermissions("sys:ftpFile:edit")
	@RequestMapping(value = "save")
	public String save(FtpFile ftpFile, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, ftpFile)){
			return form(ftpFile, model);
		}
		ftpFileService.save(ftpFile);
		addMessage(redirectAttributes, "保存ftp上传文件成功");
		return "redirect:"+Global.getAdminPath()+"/sys/ftpFile/?repage";
	}
	
	@RequestMapping(value = "jumpToFileInput")
	public String jumpToFileInput(HttpServletRequest request,HttpServletResponse response){
		return "modules/sys/fileInput";
	}
	
	
   /* 如果只是上传一个文件，则只需要MultipartFile类型接收文件即可，而且无需显式指定@RequestParam注解   
           如果想上传多个文件，那么这里就要用MultipartFile[]类型来接收文件，并且还要指定@RequestParam注解   
           并且上传多个文件时，前台表单中的所有<input type="file"/>的name都应该是myfiles，否则参数里的myfiles无法获取到所有上传的文件   */
	@ResponseBody
	@RequestMapping(value = "upload")
	public Map upload(@RequestParam MultipartFile[] myfiles,HttpServletRequest request,HttpServletResponse response,Model model) throws IOException{
		
		 HashMap<String,String> map = new HashMap<String,String>();
		 boolean isFileUpload = false;
			
        for(MultipartFile myfile : myfiles){   
        	
        	FtpFile ftpFile = new FtpFile();
            if(myfile.isEmpty()){
                System.out.println("文件未上传");   
            }else{   
                System.out.println("文件长度: " + myfile.getSize());   
                System.out.println("文件类型: " + myfile.getContentType());   
                System.out.println("文件名称: " + myfile.getName());   
                System.out.println("文件原名: " + myfile.getOriginalFilename());   
                System.out.println("========================================"); 
                
              //获取文件后缀名
              String prefix=myfile.getOriginalFilename().substring(myfile.getOriginalFilename().lastIndexOf(".")+1);
              //获取文件新的名字
              String no = FtpUtil.getNo();
              String  newname =  no+"."+prefix;
              
              //获取配置信息
              String host=  Global.getConfig("host");
              int port=  Integer.parseInt(Global.getConfig("port"));
              String username=  Global.getConfig("username");
              String password=  Global.getConfig("password");
              String basePath=  Global.getConfig("basePath");
              String filePath=  Global.getConfig("filePath");
              
              //上传文件
              isFileUpload = FtpUtil.uploadFile(host,port,username,password,basePath,filePath,newname, myfile.getInputStream());
              
              //上传成功保存文件信息
              if (isFileUpload == true) {
				map.put("state", "1");
				//设置数据
				ftpFile.setFileName(newname);
				ftpFile.setFilePath(basePath+filePath);
				ftpFile.setFileRealName(myfile.getOriginalFilename());
				ftpFile.setFileType(prefix);
				ftpFile.setUploader(UserUtils.getUser().getId());
				ftpFile.setUploadDatetime(new Date());
				ftpFile.setFileSize(String.valueOf(myfile.getSize()));
				//保存信息
				ftpFileService.save(ftpFile);
              }else {
            	  map.put("state", "0");
              }
            }   
        }   
        return map;  
    }  
	
	
	@RequestMapping(value = "download")
	public String download(FtpFile ftpFile,RedirectAttributes redirectAttributes) {
			boolean isDownload = false;
			
			//获取配置文件
		   String host=  Global.getConfig("host");
           int port=  Integer.parseInt(Global.getConfig("port"));
           String username=  Global.getConfig("username");
           String password=  Global.getConfig("password");
           String uploadPath=  Global.getConfig("uploadPath");
           String downLoadPath=  Global.getConfig("downLoadPath");
           
           List<String> names = new ArrayList<String>();
           names.add(ftpFile.getFileName());

           try {
        	   //下载上传文件
               isDownload =  FtpUtil.downloadFile(host,port,username,password,uploadPath,names,downLoadPath);
               if (isDownload) {
            	   addMessage(redirectAttributes, "ftp文件下载成功,请到指定目录查看");
               }else {
            	   addMessage(redirectAttributes, "ftp文件下载失败");
    	        }
			} catch (Exception e) {
				 e.printStackTrace();
				 addMessage(redirectAttributes, "ftp文件下载失败");
			}
          
           return "redirect:"+Global.getAdminPath()+"/sys/ftpFile/?repage";
    }  
	
	@RequestMapping(value = "downloadAll")
	public String downloadAll(String names,RedirectAttributes redirectAttributes){
			boolean isDownload = false;
			
			//获取配置文件
		   String host=  Global.getConfig("host");
           int port=  Integer.parseInt(Global.getConfig("port"));
           String username=  Global.getConfig("username");
           String password=  Global.getConfig("password");
           String uploadPath=  Global.getConfig("uploadPath");
           String downLoadPath=  Global.getConfig("downLoadPath");
           
	       	String[] namesArray = names.split(",");
			List<String> namesList = Arrays.asList(namesArray);
           
           try {
        	 //下载上传文件
               isDownload =  FtpUtil.downloadFile(host,port,username,password,uploadPath,namesList,downLoadPath);
               if (isDownload) {
            	   addMessage(redirectAttributes, "ftp文件下载成功,请到指定目录查看");
               }else {
            	   addMessage(redirectAttributes, "ftp文件下载失败");
    	        }
	   		} catch (Exception e) {
	   			addMessage(redirectAttributes, "ftp文件下载失败");
	   			e.printStackTrace();
	   		}
           
           return "redirect:"+Global.getAdminPath()+"/sys/ftpFile/?repage";
    }  
	
	@RequiresPermissions("sys:ftpFile:edit")
	@RequestMapping(value = "delete")
	public String delete(FtpFile ftpFile, RedirectAttributes redirectAttributes)  {
		boolean isDelete = false;
		
		//获取配置文件
		String host=  Global.getConfig("host");
        int port=  Integer.parseInt(Global.getConfig("port"));
        String username=  Global.getConfig("username");
        String password=  Global.getConfig("password");
        String uploadPath=  Global.getConfig("uploadPath");
        
        List<String> names = new ArrayList<String>();
        names.add(ftpFile.getFileName());
        
        try {
            //下载上传文件
            isDelete =  FtpUtil.deleteFile(host,port,username,password,uploadPath,names);
            ftpFileService.delete(ftpFile);
            if (isDelete) {
         	   addMessage(redirectAttributes, "删除文件成功");
            }else {
         	   addMessage(redirectAttributes, "删除文件失败");
    	     }
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "删除失败");
		}
        
    
		return "redirect:"+Global.getAdminPath()+"/sys/ftpFile/?repage";
	}
	
	@RequiresPermissions("sys:ftpFile:edit")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(FtpFile ftpFile, RedirectAttributes redirectAttributes,String ids,String names) {
		
		//获取配置文件
		String host=  Global.getConfig("host");
        int port=  Integer.parseInt(Global.getConfig("port"));
        String username=  Global.getConfig("username");
        String password=  Global.getConfig("password");
        String uploadPath=  Global.getConfig("uploadPath");
        
		String[] idsArray = ids.split(",");
		List<String> idsList = Arrays.asList(idsArray);
		String[] namesArray = names.split(",");
		List<String> namesList = Arrays.asList(namesArray);
		try {
			 FtpUtil.deleteFile(host,port,username,password,uploadPath,namesList);
			int rows = ftpFileService.deleteAll(idsList);
			addMessage(redirectAttributes, "成功删除"+rows+"个文件");
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "删除失败");
		}
		return "redirect:"+Global.getAdminPath()+"/sys/ftpFile/?repage";
	}
}