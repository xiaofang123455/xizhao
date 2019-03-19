/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.sys.entity.FtpFile;
import com.thinkgem.jeesite.modules.sys.dao.FtpFileDao;

/**
 * ftp上传文件Service
 * @author yxf
 * @version 2017-04-27
 */
@Service
@Transactional(readOnly = true)
public class FtpFileService extends CrudService<FtpFileDao, FtpFile> {

	public FtpFile get(String id) {
		return super.get(id);
	}
	
	public List<FtpFile> findList(FtpFile ftpFile) {
		return super.findList(ftpFile);
	}
	
	public Page<FtpFile> findPage(Page<FtpFile> page, FtpFile ftpFile) {
		return super.findPage(page, ftpFile);
	}
	
	@Transactional(readOnly = false)
	public void save(FtpFile ftpFile) {
		super.save(ftpFile);
	}
	
	@Transactional(readOnly = false)
	public void delete(FtpFile ftpFile) {
		super.delete(ftpFile);
	}
	
	@Transactional(readOnly = false)
	public int deleteAll(List<String> idsList) {
		int num = dao.deleteAll(idsList);
		return num;
	}
	
}