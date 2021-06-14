package com.aboutrip.app.admin.memManage;

import java.util.List;
import java.util.Map;

public interface MemberMService {
	public int dataCount(Map<String, Object> map);
	public List<Member> listMember(Map<String, Object> map);
	
	public Member readMember(String userId);
	
	public List<Analysis> listAgeSection();

	public void updateEnable(Map<String, Object> map) throws Exception;
	public List<Member> listEnable(String userId);
	public Member readEnable(String userId);
}
