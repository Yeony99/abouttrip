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
	private MultipartFile upload;
	private String savePlace;
	private String created_date;
	private int hitCount;
	private int ctgNum;
	private String placeFileName;
	private int listNum;
	
	
	
	
	
	public int getListNum() {
		return listNum;
	}
	public void setListNum(int listNum) {
		this.listNum = listNum;
	}
	public String getPlaceFileName() {
		return placeFileName;
	}
	public void setPlaceFileName(String placeFileName) {
		this.placeFileName = placeFileName;
	}
	public int getCtgNum() {
		return ctgNum;
	}
	public void setCtgNum(int ctgNum) {
		this.ctgNum = ctgNum;
	}
	public String getSavePlace() {
		return savePlace;
	}
	public void setSavePlace(String savePlace) {
		this.savePlace = savePlace;
	}
	public MultipartFile getUpload() {
		return upload;
	}
	public void setUpload(MultipartFile upload) {
		this.upload = upload;
	}
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
