package com.aboutrip.app.member;

import java.util.List;
import java.util.Map;

public interface MemberService {
	public Member loginMember(String userId);
	
	public void insertMember(Member dto,String pathname) throws Exception;
	public void updateMember(Member dto,String pathname) throws Exception;
	public void updatePwd(Member dto) throws Exception;
	
	public Member readMember(String userId);
	public Member readMember(String userName, String tel);
	
	public void deleteMember(String userId) throws Exception;
	public List<Member> listMember(Map<String,Object> map);
	public int dataCount();
	public int payCount(Map<String,Object> map);
	
	public List<Member> payList(Map<String, Object> map);

	public void generatePwd(Member dto) throws Exception;
	public void checkIpAddr(Member dto) throws Exception;
	public void insertPayment(Member dto) throws Exception;
}
