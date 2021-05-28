package com.aboutrip.app.member;

import java.util.List;
import java.util.Map;

public interface MemberService {
	public Member loginMember(String userId);
	
	public void insertMember(Member dto) throws Exception;
	public void updateMember(Member dto) throws Exception;
	
	public Member readMember(int userNum);
	public Member readMember(String nickName);
	
	public void deleteMember(int userNum) throws Exception;
	public List<Member> listMember(Map<String,Object> map);
	public int dataCount(Map<String, Object> map);

	
}
