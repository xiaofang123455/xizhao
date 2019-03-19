/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import javax.validation.constraints.NotNull;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * ftp上传文件Entity
 * @author yxf
 * @version 2017-04-27
 */
public class FtpFile extends DataEntity<FtpFile> {
	
	private static final long serialVersionUID = 1L;
	private String id;		// file_id
	private String filePath;		// file_path
	private String fileRealName;		// file_real_name
	private String fileName;		// file_name
	private String uploader;		// uploader
	private Date uploadDatetime;		// upload_datetime
	private String fileType;		// file_type
	private String fileSize;		// file_type
	
	public FtpFile() {
		super();
	}

	public FtpFile(String id){
		super(id);
	}

	@Length(min=1, max=64, message="file_path长度必须介于 1 和 64 之间")
	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	
	@Length(min=1, max=64, message="file_real_name长度必须介于 1 和 64 之间")
	public String getFileRealName() {
		return fileRealName;
	}

	public void setFileRealName(String fileRealName) {
		this.fileRealName = fileRealName;
	}
	
	@Length(min=1, max=64, message="file_name长度必须介于 1 和 64 之间")
	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	@Length(min=1, max=64, message="uploader长度必须介于 1 和 64 之间")
	public String getUploader() {
		return uploader;
	}

	public void setUploader(String uploader) {
		this.uploader = uploader;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="upload_datetime不能为空")
	public Date getUploadDatetime() {
		return uploadDatetime;
	}

	public void setUploadDatetime(Date uploadDatetime) {
		this.uploadDatetime = uploadDatetime;
	}
	
	@Length(min=1, max=64, message="file_type长度必须介于 1 和 64 之间")
	public String getFileType() {
		return fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}

	public String getId() {
	
		return id;
	}

	public void setId(String id) {
	
		this.id = id;
	}

	public String getFileSize() {
	
		return fileSize;
	}

	public void setFileSize(String fileSize) {
	
		this.fileSize = fileSize;
	}
}