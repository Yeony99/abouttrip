package com.aboutrip.app.member;

import org.springframework.web.multipart.MultipartFile;

public class Member {
	private int userNum;
	private String userId, email1, email2;
	private String userPwd;
	private String nickName;
	private String zip;
	private int enable;
	private int FailCnt;
	private String profile_pic;
	private MultipartFile selectFile;
	private String address1;
	private String address2;
	private String tel;
	private String birth;
	private String gender;
	private int paymentNum;
	private String userName;
	private String created_date;
	private String ipaddr;
	private int logNum;
	private int cardNum;
	private String cardName;
	private String paymentCode;
	private String logDate;
	private int followingNum;
	private String following_date;
	private String followingNickname;
	private String followerNickname;
	private int followingUserNum;
	private int followerUserNum;
	
	public int getFollowingUserNum() {
		return followingUserNum;
	}
	public void setFollowingUserNum(int followingUserNum) {
		this.followingUserNum = followingUserNum;
	}
	public int getFollowerUserNum() {
		return followerUserNum;
	}
	public void setFollowerUserNum(int followerUserNum) {
		this.followerUserNum = followerUserNum;
	}
	public String getFollowingNickname() {
		return followingNickname;
	}
	public void setFollowingNickname(String followingNickname) {
		this.followingNickname = followingNickname;
	}
	public String getFollowerNickname() {
		return followerNickname;
	}
	public void setFollowerNickname(String followerNickname) {
		this.followerNickname = followerNickname;
	}
	public int getFollowingNum() {
		return followingNum;
	}
	public void setFollowingNum(int followingNum) {
		this.followingNum = followingNum;
	}
	public String getFollowing_date() {
		return following_date;
	}
	public void setFollowing_date(String following_date) {
		this.following_date = following_date;
	}
	public String getLogDate() {
		return logDate;
	}
	public void setLogDate(String logDate) {
		this.logDate = logDate;
	}
	public int getCardNum() {
		return cardNum;
	}
	public void setCardNum(int cardNum) {
		this.cardNum = cardNum;
	}
	public String getCardName() {
		return cardName;
	}
	public void setCardName(String cardName) {
		this.cardName = cardName;
	}
	public String getPaymentCode() {
		return paymentCode;
	}
	public void setPaymentCode(String paymentCode) {
		this.paymentCode = paymentCode;
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
	public String getEmail1() {
		return email1;
	}
	public void setEmail1(String email1) {
		this.email1 = email1;
	}
	public String getEmail2() {
		return email2;
	}
	public void setEmail2(String email2) {
		this.email2 = email2;
	}
	public String getUserPwd() {
		return userPwd;
	}
	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getZip() {
		return zip;
	}
	public void setZip(String zip) {
		this.zip = zip;
	}
	public int getEnable() {
		return enable;
	}
	public void setEnable(int enable) {
		this.enable = enable;
	}
	public int getFailCnt() {
		return FailCnt;
	}
	public void setFailCnt(int failCnt) {
		FailCnt = failCnt;
	}
	public String getProfile_pic() {
		return profile_pic;
	}
	public void setProfile_pic(String profile_pic) {
		this.profile_pic = profile_pic;
	}
	public MultipartFile getSelectFile() {
		return selectFile;
	}
	public void setSelectFile(MultipartFile selectFile) {
		this.selectFile = selectFile;
	}
	public String getAddress1() {
		return address1;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public int getPaymentNum() {
		return paymentNum;
	}
	public void setPaymentNum(int paymentNum) {
		this.paymentNum = paymentNum;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getCreated_date() {
		return created_date;
	}
	public void setCreated_date(String created_date) {
		this.created_date = created_date;
	}
	public String getIpaddr() {
		return ipaddr;
	}
	public void setIpaddr(String ipaddr) {
		this.ipaddr = ipaddr;
	}
	public int getLogNum() {
		return logNum;
	}
	public void setLogNum(int logNum) {
		this.logNum = logNum;
	}
	
}
