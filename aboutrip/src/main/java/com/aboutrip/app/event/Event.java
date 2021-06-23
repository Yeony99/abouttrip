package com.aboutrip.app.event;

public class Event {
	//이벤트
	private int num, listNum;

	private String title;
	private String content;
	private String eventStart;
	private String eventEnd;
	private String winDate;
	private int winCount;
	private String present;
	private int adminNum;
	
	//참가자
	private int partNum;
	private int eventNum;
	private int userNum;
	private String nickName;
	private String partDate;
	private int partCount;
	
	//당첨자 번호
	private int winNum; 

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}
	
	public int getListNum() {
		return listNum;
	}
	
	public void setListNum(int listNum) {
		this.listNum = listNum;
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

	public String getEventStart() {
		return eventStart;
	}

	public void setEventStart(String eventStart) {
		this.eventStart = eventStart;
	}

	public String getEventEnd() {
		return eventEnd;
	}

	public void setEventEnd(String eventEnd) {
		this.eventEnd = eventEnd;
	}

	public String getWinDate() {
		return winDate;
	}

	public void setWinDate(String winDate) {
		this.winDate = winDate;
	}
	
	public int getWinCount() {
		return winCount;
	}
	
	public void setWinCount(int winCount) {
		this.winCount = winCount;
	}
	

	public String getPresent() {
		return present;
	}

	public void setPresent(String present) {
		this.present = present;
	}

	public int getAdminNum() {
		return adminNum;
	}

	public void setAdminNum(int adminNum) {
		this.adminNum = adminNum;
	}

	public int getPartNum() {
		return partNum;
	}

	public void setPartNum(int partNum) {
		this.partNum = partNum;
	}

	public int getEventNum() {
		return eventNum;
	}

	public void setEventNum(int eventNum) {
		this.eventNum = eventNum;
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

	public String getPartDate() {
		return partDate;
	}

	public void setPartDate(String partDate) {
		this.partDate = partDate;
	}

	public int getPartCount() {
		return partCount;
	}

	public void setPartCount(int partCount) {
		this.partCount = partCount;
	}
	
	public int getWinNum() {
		return winNum;
	}

	public void setWinNum(int winNum) {
		this.winNum = winNum;
	}

	
}
