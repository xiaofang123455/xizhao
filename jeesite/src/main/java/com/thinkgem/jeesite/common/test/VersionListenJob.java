package com.thinkgem.jeesite.common.test;

import java.io.IOException;
/*@Service
@Lazy(value=false)*/
public class VersionListenJob {
	/*@Scheduled(cron="0/5 * *  * * ? ")*/ 
	public void execute() throws IOException{
		System.out.println("ihao ");
	}
}
