package com.aboutrip.app.diary;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Diary {
	private int listNum, diaryNum, userNum;
	private String userId;
	private String nickName;
	private String diaryTitle;
	private int diaryType;
	private String diaryContent;
	private String diaryCreated;
	
	private int diaryImgNum;
	private String originalFilename;
	private String saveFilename;
	private String hashNum;
	private String hashName;
	private int categoryNum;
	private String categoryName;
	private int hitCount;
	private int diaryLikeCount;
	
	private List<MultipartFile> upload;
	private List<String> savePathname = new ArrayList<>();
	
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
	public int getDiaryImgNum() {
		return diaryImgNum;
	}
	public void setDiaryImgNum(int diaryImgNum) {
		this.diaryImgNum = diaryImgNum;
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
	public String getHashNum() {
		return hashNum;
	}
	public void setHashNum(String hashNum) {
		this.hashNum = hashNum;
	}
	public String getHashName() {
		return hashName;
	}
	public void setHashName(String hashName) {
		this.hashName = hashName;
	}
	public int getCategoryNum() {
		return categoryNum;
	}
	public void setCategoryNum(int categoryNum) {
		this.categoryNum = categoryNum;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public int getHitCount() {
		return hitCount;
	}
	public void setHitCount(int hitCount) {
		this.hitCount = hitCount;
	}
	public int getDiaryLikeCount() {
		return diaryLikeCount;
	}
	public void setDiaryLikeCount(int diaryLikeCount) {
		this.diaryLikeCount = diaryLikeCount;
	}
	public List<MultipartFile> getUpload() {
		return upload;
	}
	public void setUpload(List<MultipartFile> upload) {
		this.upload = upload;
	}
	public List<String> getSavePathname() {
		return savePathname;
	}
	public void setSavePathname(List<String> savePathname) {
		this.savePathname = savePathname;
	}
}
