/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.sys.entity.Dict;

/**
 * 字典DAO接口
 * @author ThinkGem
 * @version 2014-05-16
 */
@MyBatisDao
public interface DictDao extends CrudDao<Dict> {

	public List<String> findTypeList(Dict dict);

	/**
	 * @Description:
	 *		批量删除字典
	 * @param idsList
	 *
	 * @date:2016年9月2日     @author:yxf     create
	 */
	public int deleteAll(@Param("list") List<String> idsList);

	/**
	 * 
	 * @Description:
	 *			根据label，value，type查询字典
	 *
	 * @date:2016年10月13日 下午4:54:12
	 *
	 * @date:2016年10月13日     @author:yxf     create
	 */
	public List<Dict> getDict(Dict dict);
	
	
}
