package com.aboutrip.app.scheduler;

public class MateReply {
	private int num; //기본키
	private int user_num; // 유저번호
	private int mate_num; // 댓글다려는 메이트넘버
	private String content; // 댓글 내용
	private String created; // 작성일
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getUser_num() {
		return user_num;
	}
	public void setUser_num(int user_num) {
		this.user_num = user_num;
	}
	public int getMate_num() {
		return mate_num;
	}
	public void setMate_num(int mate_num) {
		this.mate_num = mate_num;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCreated() {
		return created;
	}
	public void setCreated(String created) {
		this.created = created;
	}
	
	
}
