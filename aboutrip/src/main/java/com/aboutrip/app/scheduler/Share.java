package com.aboutrip.app.scheduler;

import org.springframework.web.multipart.MultipartFile;

public class Share {
	private int num;
	private String subject;
	private String content;
	private String search;
	private int userNum;
	private int listNum;
	private int hitCount;
	private String nickName;
	private String scheduler_subject;
	private String scheduler_created;
	private String check_in;
	private String check_out;
	private String memo;
	private String imageFileName;
	private String created;
	private MultipartFile upload;
	
	public String getImageFileName() {
		return imageFileName;
	}
	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}
	public String getCreated() {
		return created;
	}
	public void setCreated(String created) {
		this.created = created;
	}
	public MultipartFile getUpload() {
		return upload;
	}
	public void setUpload(MultipartFile upload) {
		this.upload = upload;
	}
	private int ctgNum;
	
	public int getCtgNum() {
		return ctgNum;
	}
	public void setCtgNum(int ctgNum) {
		this.ctgNum = ctgNum;
	}
	public int getHitCount() {
		return hitCount;
	}
	public void setHitCount(int hitCount) {
		this.hitCount = hitCount;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getScheduler_subject() {
		return scheduler_subject;
	}
	public void setScheduler_subject(String scheduler_subject) {
		this.scheduler_subject = scheduler_subject;
	}
	public String getScheduler_created() {
		return scheduler_created;
	}
	public void setScheduler_created(String scheduler_created) {
		this.scheduler_created = scheduler_created;
	}
	public String getCheck_in() {
		return check_in;
	}
	public void setCheck_in(String check_in) {
		this.check_in = check_in;
	}
	public String getCheck_out() {
		return check_out;
	}
	public void setCheck_out(String check_out) {
		this.check_out = check_out;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public int getListNum() {
		return listNum;
	}
	public void setListNum(int listNum) {
		this.listNum = listNum;
	}
	public int getUserNum() {
		return userNum;
	}
	public void setUserNum(int userNum) {
		this.userNum = userNum;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getSearch() {
		return search;
	}
	public void setSearch(String search) {
		this.search = search;
	}
	
}
