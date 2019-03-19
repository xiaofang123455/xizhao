/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.CacheUtils;
import com.thinkgem.jeesite.modules.sys.dao.DictDao;
import com.thinkgem.jeesite.modules.sys.entity.Dict;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;

/**
 * 字典Service
 * @author ThinkGem
 * @version 2014-05-16
 */
@Service
@Transactional(readOnly = true)
public class DictService extends CrudService<DictDao, Dict> {
	
	@Autowired DictDao dictDao;
	/**
	 * 查询字段类型列表
	 * @return
	 */
	public List<String> findTypeList(){
		return dao.findTypeList(new Dict());
	}

	@Transactional(readOnly = false)
	public void save(Dict dict) {
		super.save(dict);
		CacheUtils.remove(DictUtils.CACHE_DICT_MAP);
	}

	@Transactional(readOnly = false)
	public void delete(Dict dict) {
		super.delete(dict);
		CacheUtils.remove(DictUtils.CACHE_DICT_MAP);
	}


	/**
	 * @Description:
	 *		批量删除字典
	 * @param idsList
	 *
	 * @date:2016年9月2日     @author:yxf     create
	 */
	public int deleteAll(List<String> idsList) {
		int num = dao.deleteAll(idsList);
		CacheUtils.remove(DictUtils.CACHE_DICT_MAP);
		return num;
			
	}

	/**
	 * @Description:
	 *		通过标签和类型查询字典
	 * @param label
	 * @param type
	 *
	 * @date:2016年9月2日 下午2:15:08
	 */
	public List<Dict> getDict(Dict dict) {
		
		return dictDao.getDict(dict);
			
	}
	

}
