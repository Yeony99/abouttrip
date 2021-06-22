package com.aboutrip.app.dm;

import java.util.List;

public class Dm {
	private int dmNum;
	private int senderNum, receiverNum;
	private String senderNickName, receiverNickName;
	private String content;
	private String sendDay, identifyDay;
	private String sendDelete, receiveDelete;
	
	private List<Integer> receivers;
	private int userNum;
	private String nickName;
	
	public int getDmNum() {
		return dmNum;
	}
	public void setDmNum(int dmNum) {
		this.dmNum = dmNum;
	}
	public int getSenderNum() {
		return senderNum;
	}
	public void setSenderNum(int senderNum) {
		this.senderNum = senderNum;
	}
	public int getReceiverNum() {
		return receiverNum;
	}
	public void setReceiverNum(int receiverNum) {
		this.receiverNum = receiverNum;
	}
	public String getSenderNickName() {
		return senderNickName;
	}
	public void setSenderNickName(String senderNickName) {
		this.senderNickName = senderNickName;
	}
	public String getReceiverNickName() {
		return receiverNickName;
	}
	public void setReceiverNickName(String receiverNickName) {
		this.receiverNickName = receiverNickName;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getSendDay() {
		return sendDay;
	}
	public void setSendDay(String sendDay) {
		this.sendDay = sendDay;
	}
	public String getIdentifyDay() {
		return identifyDay;
	}
	public void setIdentifyDay(String identifyDay) {
		this.identifyDay = identifyDay;
	}
	public String getSendDelete() {
		return sendDelete;
	}
	public void setSendDelete(String sendDelete) {
		this.sendDelete = sendDelete;
	}
	public String getReceiveDelete() {
		return receiveDelete;
	}
	public void setReceiveDelete(String receiveDelete) {
		this.receiveDelete = receiveDelete;
	}
	public List<Integer> getReceivers() {
		return receivers;
	}
	public void setReceivers(List<Integer> receivers) {
		this.receivers = receivers;
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
}
