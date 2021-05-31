package com.aboutrip.app.member;

// 세션에 저장할 정보(아이디, 이름, 권한, 회원번호)
public class SessionInfo {
	private int userNum;
	private String nickName;
	private int enable;
	
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
	public int getEnable() {
		return enable;
	}
	public void setEnable(int enable) {
		this.enable = enable;
	}
	
	
	
	
}
