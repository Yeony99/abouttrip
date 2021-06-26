package com.aboutrip.app.admin.diaryManage;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class DiaryManage {
	private int listNum, diaryNum, userNum;
	private String userId;
	private String nickName;
	private String diaryTitle;
	private int diaryType;
	private String diaryContent;
	private String diaryCreated;
	private int diaryLikeCount;
	
	private int diaryImgNum;
	private String saveImgName;
	private List<MultipartFile> upload;
	
	public int getListNum() {
		return listNum;
	}
	public void setListNum(int listNum) {
		this.listNum = listNum;
	}
	public int getDiaryNum() {
		return diaryNum;
	}
	public void setDiaryNum(int diaryNum) {
		this.diaryNum = diaryNum;
	}
	public int getUserNum() {
		return userNum;
	}
	public void setUserNum(int userNum) {
		this.userNum = userNum;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
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
	public int getDiaryLikeCount() {
		return diaryLikeCount;
	}
	public void setDiaryLikeCount(int diaryLikeCount) {
		this.diaryLikeCount = diaryLikeCount;
	}
	public int getDiaryImgNum() {
		return diaryImgNum;
	}
	public void setDiaryImgNum(int diaryImgNum) {
		this.diaryImgNum = diaryImgNum;
	}
	public String getSaveImgName() {
		return saveImgName;
	}
	public void setSaveImgName(String saveImgName) {
		this.saveImgName = saveImgName;
	}
	public List<MultipartFile> getUpload() {
		return upload;
	}
	public void setUpload(List<MultipartFile> upload) {
		this.upload = upload;
	}
}
