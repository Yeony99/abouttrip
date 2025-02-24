package com.aboutrip.app.member;

import java.util.List;
import java.util.Map;

import com.aboutrip.app.product.Order;

public interface MemberService {
	public Member loginMember(String userId);
	
	public void insertMember(Member dto,String pathname) throws Exception;
	public void insertPayment(Member dto) throws Exception;
	public void updateMember(Member dto,String pathname) throws Exception;
	public void updatePwd(Member dto) throws Exception;
	
	public Member readMember(String userId);
	public Member readMember(String userName, String tel);
	
	public void deleteMember(String userId) throws Exception;
	public List<Member> listMember(Map<String,Object> map);
	public int dataCount();
	public int payCount(Map<String,Object> map);
	public int logCount(Map<String, Object> map);
	public int followingCount(Map<String, Object> map);
	public int followerCount(Map<String, Object> map);
	public int orderCount(int user_num);
	
	public List<Member> payList(Map<String, Object> map);
	public List<Member> logList(Map<String, Object> map);
	public List<Member> followingList(Map<String, Object> map);
	public List<Member> followerList(Map<String, Object> map);
	public List<Order> orderList(Map<String, Object> map);

	public void generatePwd(Member dto) throws Exception;
	public void checkIpAddr(Member dto) throws Exception;
	
	public void deleteFollow(Map<String, Object> map) throws Exception;
	public void deletePaymentCode(Map<String, Object> map) throws Exception;
}
