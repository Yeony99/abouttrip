package com.aboutrip.app.scheduler;

public class MateReply {
	private int reply_num; //기본키
	private int user_num; // 유저번호
	private int mate_num; // 댓글다려는 메이트넘버
	private String content; // 댓글 내용
	private String created; // 작성일
	private int reply_answer;// 댓글의 댓글
	private String nickName;
	
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public int getReply_answer() {
		return reply_answer;
	}
	public void setReply_answer(int reply_answer) {
		this.reply_answer = reply_answer;
	}
	private int answer; // mate join후 가져와야할 컬럼
	
	public int getAnswer() {
		return answer;
	}
	public void setAnswer(int answer) {
		this.answer = answer;
	}
	public int getReply_num() {
		return reply_num;
	}
	public void setReply_num(int reply_num) {
		this.reply_num = reply_num;
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
