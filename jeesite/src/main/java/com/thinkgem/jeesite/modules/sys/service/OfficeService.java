/**
 * Copyright &copy; 2012-2016 <a
 * href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.service.TreeService;
import com.thinkgem.jeesite.modules.sys.dao.OfficeDao;
import com.thinkgem.jeesite.modules.sys.dao.UserDao;
import com.thinkgem.jeesite.modules.sys.entity.Area;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 机构Service
 * 
 * @author ThinkGem
 * @version 2014-05-16
 */
@Service
@Transactional(readOnly = true)
public class OfficeService extends TreeService<OfficeDao, Office>
{
	@Autowired
	OfficeDao officeDao; 
	
	@Autowired
	UserDao userDao; 
	
	public List<Office> findAll()
	{
		return UserUtils.getOfficeList();
	}

	public List<Office> findList(Boolean isAll)
	{
		if (isAll != null && isAll)
		{
			return UserUtils.getOfficeAllList();
		}
		else
		{
			return UserUtils.getOfficeList();
		}
	}

	@Transactional(readOnly = true)
	public List<Office> findList(Office office)
	{
		if (office != null)
		{
			if (office.getParentIds() == null || office.getParentIds().equals("null"))
			{
				office.setParentIds("%");
			}
			else
			{
				office.setParentIds(office.getParentIds() + "%");
			}

			return dao.findByParentIdsLike(office);
		}
		return new ArrayList<Office>();
	}

	@Transactional(readOnly = false)
	public void save(Office office)
	{
		super.save(office);
		//删除当前用户的缓存
		User user = UserUtils.getUser();
		UserUtils.clearCache(user);
		UserUtils.getSession().removeAttribute(UserUtils.CACHE_OFFICE_LIST);
		//UserUtils.removeCache(UserUtils.CACHE_OFFICE_LIST);
	}

	@Transactional(readOnly = false)
	public void delete(Office office)
	{
		super.delete(office);
		UserUtils.removeCache(UserUtils.CACHE_OFFICE_LIST);
	}

	public Office getOfficeByZipCode(String zipCode) {
		
				return officeDao.getOfficeByZipCode(zipCode) ;
			
	}

	public void insertOfficeList(List<Office> offices) {
		
		officeDao.deleteSysOffice();
		
		List<List<Office>> officesTypeArr = Lists.newArrayList();
		for (int i = 0; i < 4; i++) {
			List<Office> officeList = Lists.newArrayList();
			officesTypeArr.add(officeList);
		}
			
		User user =userDao.get("1");
		for (int i = 0; i < offices.size(); i++) {
			
			Area area = new Area(); 
			area.setId("1");
			offices.get(i).setArea(area);
			offices.get(i).setIsNewRecord(false);
			offices.get(i).preInsert();
			offices.get(i).setUpdateBy(user);
			offices.get(i).setCreateBy(user);
			offices.get(i).setUseable("1");
			offices.get(i).setCreateDate(new Date());
			offices.get(i).setUpdateDate(new Date());
			offices.get(i).setSort(30);
			offices.get(i).setCode("30");
			if (offices.get(i).getType().equals("1")) {
				Office office = new Office();
				office.setId("0");
				offices.get(i).setParent(office);
				offices.get(i).setParentIds("0,");
			}
			
			//type从1—4
			for (int j = 1; j <=4 ; j++) {
				if (offices.get(i).getType().equals(j+"")) {
					officesTypeArr.get(j-1).add(offices.get(i));
				}
			}
		}
		
		for (int i = 0; i < officesTypeArr.get(0).size(); i++) {
			officeDao.insert(officesTypeArr.get(0).get(i));
		}
		
		for (int j = 1; j < 4 ; j++) {
			for (int i = 0; i < officesTypeArr.get(j).size(); i++) {
				String parentName = officesTypeArr.get(j).get(i).getParentName();
				Office parentOffice = new Office();
				//获取父节点
				for (int k = 0; k < officesTypeArr.get(j-1).size(); k++) {
					if (officesTypeArr.get(j-1).get(k).getName().equals(parentName)) {
						parentOffice = officesTypeArr.get(j-1).get(k);
						break;
					}
				}
				if (!(parentOffice != null && parentOffice.getId() != "" && parentOffice.getId() != null)) {
					parentOffice.setId("1");
					parentOffice.setParentIds("1,");
				}
				officesTypeArr.get(j).get(i).setParent(parentOffice);
				officesTypeArr.get(j).get(i).setParentIds(parentOffice.getParentIds()+parentOffice.getId()+",");
				officeDao.insert(officesTypeArr.get(j).get(i));
			}
		}
		
	}

}
