/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.sys.entity.FtpFile;

/**
 * ftp上传文件DAO接口
 * @author yxf
 * @version 2017-04-27
 */
@MyBatisDao
public interface FtpFileDao extends CrudDao<FtpFile> {
	
}