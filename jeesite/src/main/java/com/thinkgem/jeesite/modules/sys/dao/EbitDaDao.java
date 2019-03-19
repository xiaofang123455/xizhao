package com.thinkgem.jeesite.modules.sys.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.sys.entity.EbitDa;

/**
 * @Description: ebitDa接口
 * @author yxf 
 * @date 2016年8月31日 上午9:59:54
 */
@MyBatisDao
public interface EbitDaDao {

	List<EbitDa> queryEbitDa(EbitDa ebitDa);

	List<EbitDa> queryEbitDaByYear(EbitDa ebitDa);

	/**
	 * 
	 * @Function: com.thinkgem.jeesite.modules.sys.dao.EbitDaDao.queryEbitDaToRightChartInfo
	 * @Description:
	 *			通过选择的时间，单位名称，公司性质来查询对应的数据
	 * @param ebitDa
	 *
	 * @Modification History:
	 * @date:2016年8月31日     @author:yxf     create
	 */
	List<EbitDa> queryEbitdaByDwbm(EbitDa ebitDa);

	/**
	 * 
	 * @Description:
	 *	返回有数据的最新年份
	 *
	 * @date:2016年9月30日 下午2:15:59
	 *
	 * @date:2016年9月30日     @author:yxf     create
	 */
	String getLatestYear();

	List<EbitDa> showYearDataChart(EbitDa ebitDa);
	
	/**
	 * 
	 * @Description:
	 *	返回按月,公司性质分组的数据
	 *
	 * @date:2016年9月30日 下午2:15:59
	 *
	 * @date:2016年9月30日     @author:yxf     create
	 */
	List<EbitDa> showSpecificDataChart(EbitDa ebitDa);

}
