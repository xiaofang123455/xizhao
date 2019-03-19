package com.thinkgem.jeesite.modules.sys.entity;

import java.io.Serializable;
import java.util.List;

import com.thinkgem.jeesite.common.persistence.DataEntity;

public class EbitDa  extends DataEntity<EbitDa> {
	// 单位编码
	private String dwbm;

	// 单位名称
	private String dwmc;

	// 单位级别
	private String dwjb;

	// 公司性质
	private String gsxz;

	// 年度
	private String year;

	// 月份
	private int month;

	// EBITDA
	private String ebita;

	// 经营收入
	private String income;

	// EBITDA收入比
	private float ebitdaRate;
	
	//开始年
	private String startYear;
	
	//结束年
	private String endYear;
	
	//开始月份
	private String startMonth;
	
	//结束月份
	private String endMonth;
	
	private List<String> dwbmList;

	public int getMonth() {

		return month;
	}

	public void setMonth(int month) {

		this.month = month;
	}

	public String getDwmc() {

		return dwmc;
	}

	public void setDwmc(String dwmc) {

		this.dwmc = dwmc;
	}

	public String getEbita() {

		return ebita;
	}

	public void setEbita(String ebita) {

		this.ebita = ebita;
	}

	public String getYear() {

		return year;
	}

	public void setYear(String year) {

		this.year = year;
	}

	public String getIncome() {

		return income;
	}

	public float getEbitdaRate() {

		return ebitdaRate;
	}

	public void setEbitdaRate(float ebitdaRate) {

		this.ebitdaRate = ebitdaRate;
	}

	public void setIncome(String income) {

		this.income = income;
	}

	public String getDwbm() {
	
		return dwbm;
	}

	public void setDwbm(String dwbm) {
	
		this.dwbm = dwbm;
	}

	public String getDwjb() {
	
		return dwjb;
	}

	public void setDwjb(String dwjb) {
	
		this.dwjb = dwjb;
	}

	public String getGsxz() {
	
		return gsxz;
	}

	public void setGsxz(String gsxz) {
	
		this.gsxz = gsxz;
	}

	public String getStartYear() {
	
		return startYear;
	}

	public void setStartYear(String startYear) {
	
		this.startYear = startYear;
	}

	public String getEndYear() {
	
		return endYear;
	}


	public List<String> getDwbmList() {
	
		return dwbmList;
	}

	public void setDwbmList(List<String> dwbmList) {
	
		this.dwbmList = dwbmList;
	}

	public void setEndYear(String endYear) {
	
		this.endYear = endYear;
	}

	public String getStartMonth() {
	
		return startMonth;
	}

	public void setStartMonth(String startMonth) {
	
		this.startMonth = startMonth;
	}

	public String getEndMonth() {
	
		return endMonth;
	}

	public void setEndMonth(String endMonth) {
	
		this.endMonth = endMonth;
	}


}
