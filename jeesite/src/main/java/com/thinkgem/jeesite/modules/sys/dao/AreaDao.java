/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.thinkgem.jeesite.common.persistence.TreeDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.sys.entity.Area;

/**
 * 区域DAO接口
 * @author ThinkGem
 * @version 2014-05-16
 */
@MyBatisDao
public interface AreaDao extends TreeDao<Area> {

	List<Area> getAreaListByType(Area area);

	List<Area> getChildAreaListByParentAreaId(Area area);

	Area getAreaByCode(Area area);

	List<Area> findAreaList(Area area);

	/**
	 * @Description:
	 * 通过父区域的区域编码，获取子区域中最小的区域编码
	 *
	 */
	String getChildAreaCodeByParentAreaCode(@Param("code") String code);
	
}
