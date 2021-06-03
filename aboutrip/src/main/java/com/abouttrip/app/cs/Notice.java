package com.abouttrip.app.cs;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Notice {
	private int listNum, NOTICEnum;
	private int notice;
	private String title;
	private String content;
	private String reg_date;
	private String AdminNum;
	
	private int NfileNum;
	private String originalFilename;
	private String saveFilename;
	private int fileCount;
	
	private List<MultipartFile> upload;
	
	private long gap;

	public int getListNum() {
		return listNum;
	}

	public void setListNum(int listNum) {
		this.listNum = listNum;
	}

	public int getNOTICEnum() {
		return NOTICEnum;
	}

	public void setNOTICEnum(int nOTICEnum) {
		NOTICEnum = nOTICEnum;
	}

	public int getNotice() {
		return notice;
	}

	public void setNotice(int notice) {
		this.notice = notice;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getReg_date() {
		return reg_date;
	}

	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}

	public String getAdminNum() {
		return AdminNum;
	}

	public void setAdminNum(String adminNum) {
		AdminNum = adminNum;
	}

	public int getNfileNum() {
		return NfileNum;
	}

	public void setNfileNum(int nfileNum) {
		NfileNum = nfileNum;
	}

	public String getOriginalFilename() {
		return originalFilename;
	}

	public void setOriginalFilename(String originalFilename) {
		this.originalFilename = originalFilename;
	}

	public String getSaveFilename() {
		return saveFilename;
	}

	public void setSaveFilename(String saveFilename) {
		this.saveFilename = saveFilename;
	}

	public int getFileCount() {
		return fileCount;
	}

	public void setFileCount(int fileCount) {
		this.fileCount = fileCount;
	}

	public List<MultipartFile> getUpload() {
		return upload;
	}

	public void setUpload(List<MultipartFile> upload) {
		this.upload = upload;
	}

	public long getGap() {
		return gap;
	}

	public void setGap(long gap) {
		this.gap = gap;
	}
	
	
}
