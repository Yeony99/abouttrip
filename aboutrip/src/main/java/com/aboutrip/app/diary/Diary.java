package com.aboutrip.app.diary;

import org.springframework.web.multipart.MultipartFile;

public class Diary {
	private int listNum, diaryNum, userNum;
	private String userId;
	private String nickName;
	private String diaryTitle;
	private int diaryType;
	private String diaryContent;
	private String diaryCreated;
	private String diaryImgNum;
	private String hashNum;
	private MultipartFile upload;
	
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
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getDiaryTitle() {
		return diaryTitle;
	}
	public void setDiaryTitle(String diaryTitle) {
		this.diaryTitle = diaryTitle;
	}
	public int getDiaryType() {
		return diaryType;
	}
	public void setDiaryType(int diaryType) {
		this.diaryType = diaryType;
	}
	public String getDiaryContent() {
		return diaryContent;
	}
	public void setDiaryContent(String diaryContent) {
		this.diaryContent = diaryContent;
	}
	public String getDiaryCreated() {
		return diaryCreated;
	}
	public void setDiaryCreated(String diaryCreated) {
		this.diaryCreated = diaryCreated;
	}
	public String getDiaryImgNum() {
		return diaryImgNum;
	}
	public void setDiaryImgNum(String diaryImgNum) {
		this.diaryImgNum = diaryImgNum;
	}
	public String getHashNum() {
		return hashNum;
	}
	public void setHashNum(String hashNum) {
		this.hashNum = hashNum;
	}
	public MultipartFile getUpload() {
		return upload;
	}
	public void setUpload(MultipartFile upload) {
		this.upload = upload;
	}
	public int getDiaryNum() {
		return diaryNum;
	}
	public void setDiaryNum(int diaryNum) {
		this.diaryNum = diaryNum;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}	
}
