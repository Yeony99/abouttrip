package com.aboutrip.app.place;

import org.springframework.web.multipart.MultipartFile;

public class Place {
	private int placeNum;
	private String placeName;
	private String placeContent;
	private int mdPick;
	private String placeCtg;
	private int placeImgNum;
	private String placeImgName;
	private MultipartFile selectFile;
	private String created_date;
	private int hitCount;
	
	
	
	public int getHitCount() {
		return hitCount;
	}
	public void setHitCount(int hitCount) {
		this.hitCount = hitCount;
	}
	public String getCreated_date() {
		return created_date;
	}
	public void setCreated_date(String created_date) {
		this.created_date = created_date;
	}
	public MultipartFile getSelectFile() {
		return selectFile;
	}
	public void setSelectFile(MultipartFile selectFile) {
		this.selectFile = selectFile;
	}
	public int getPlaceNum() {
		return placeNum;
	}
	public void setPlaceNum(int placeNum) {
		this.placeNum = placeNum;
	}
	public int getPlaceImgNum() {
		return placeImgNum;
	}
	public void setPlaceImgNum(int placeImgNum) {
		this.placeImgNum = placeImgNum;
	}
	public String getPlaceName() {
		return placeName;
	}
	public void setPlaceName(String placeName) {
		this.placeName = placeName;
	}
	public String getPlaceContent() {
		return placeContent;
	}
	public void setPlaceContent(String placeContent) {
		this.placeContent = placeContent;
	}
	public int getMdPick() {
		return mdPick;
	}
	public void setMdPick(int mdPick) {
		this.mdPick = mdPick;
	}
	public String getPlaceCtg() {
		return placeCtg;
	}
	public void setPlaceCtg(String placeCtg) {
		this.placeCtg = placeCtg;
	}
	public String getPlaceImgName() {
		return placeImgName;
	}
	public void setPlaceImgName(String placeImgName) {
		this.placeImgName = placeImgName;
	}

	
}
