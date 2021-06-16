package com.aboutrip.app.scheduler;

public class Mate {
	private int num; //기본키
	private int user_num; // 유저넘버
	private String subject; // 제목
	private String content; //내용
	private int location; // 지역코드
	private String created; // 생성일
	private int mate_num; // 같이가는 인원
	private int currnt_num; // 현재 인원
	private String start_date; // 시작일
	private String end_date; // 종료일
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
	public int getLocation() {
		return location;
	}
	public void setLocation(int location) {
		this.location = location;
	}
	public String getCreated() {
		return created;
	}
	public void setCreated(String created) {
		this.created = created;
	}
	public int getMate_num() {
		return mate_num;
	}
	public void setMate_num(int mate_num) {
		this.mate_num = mate_num;
	}
	public int getCurrnt_num() {
		return currnt_num;
	}
	public void setCurrnt_num(int currnt_num) {
		this.currnt_num = currnt_num;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	
	
}
