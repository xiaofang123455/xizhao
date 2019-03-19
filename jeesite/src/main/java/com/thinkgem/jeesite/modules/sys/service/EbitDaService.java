package com.thinkgem.jeesite.modules.sys.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.modules.sys.dao.EbitDaDao;
import com.thinkgem.jeesite.modules.sys.entity.EbitDa;

@Service
@Transactional(readOnly = true)
public class EbitDaService {

	@Autowired
	private EbitDaDao ebitDao;

	public List<EbitDa> queryEbitDa(EbitDa ebitDa) {
		return ebitDao.queryEbitDa(ebitDa);
	}

	public List<EbitDa> queryEbitDaByYear(EbitDa ebitDa) {
		return ebitDao.queryEbitDaByYear(ebitDa);
	}

	public List<EbitDa> queryEbitdaByDwbm(EbitDa ebitDa) {
		return ebitDao.queryEbitdaByDwbm(ebitDa);
	}

	public String getLatestYear() {
	 	   return ebitDao.getLatestYear();
			
	}


	public Page<EbitDa> findEbitdaList(Page<EbitDa> page, EbitDa ebitDa) {
		// 设置分页参数
		ebitDa.setPage(page);
		// 执行分页查询
		page.setList(ebitDao.queryEbitDa(ebitDa));
		return page;
			
	}

	public List<EbitDa> showYearDataChart(EbitDa ebitDa) {
		return ebitDao.showYearDataChart(ebitDa);
			
	}

	public List<EbitDa> showSpecificDataChart(EbitDa ebitDa) {
		return ebitDao.showSpecificDataChart(ebitDa);
			
	}

}
