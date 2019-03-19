package com.thinkgem.jeesite.common.db;
 
import org.springframework.jdbc.datasource.lookup.AbstractRoutingDataSource;
 
/**
 * oracle 多数据源切换
 *
 * @author zxy
 * @Description:
 * @date 2017/4/19
 */
public class DynamicDataSource extends AbstractRoutingDataSource {
    private static final ThreadLocal<String> contextHolder = new ThreadLocal<String>();  
       
    /** 
     *  
     * @author zxy 
     * @date 2017-4-19 
     * @return the currentLookupKey 
     */  
    public static String getCurrentLookupKey() {  
        return (String) contextHolder.get();  
    }  
   
    /** 
     *  
     * @author zxy 
     * @date 2017-4-19 
     * @param currentLookupKey 
     *            the currentLookupKey to set 
     */  
    public static void setCurrentLookupKey(String currentLookupKey) {  
        contextHolder.set(currentLookupKey);  
    }  
   
    /* 
     * (non-Javadoc) 
     *  
     * @see 
     * org.springframework.jdbc.datasource.lookup.AbstractRoutingDataSource# 
     * determineCurrentLookupKey() 
     */  
    @Override  
    protected Object determineCurrentLookupKey() {  
        return getCurrentLookupKey();  
    }  
}