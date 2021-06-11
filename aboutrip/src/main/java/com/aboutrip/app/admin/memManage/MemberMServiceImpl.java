package com.aboutrip.app.admin.memManage;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aboutrip.app.common.dao.AboutDAO;

@Service("admin.memManage.memberMService")
public class MemberMServiceImpl implements MemberMService {
	@Autowired
	private AboutDAO dao;
	
	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("memManage.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@Override
	public List<Member> listMember(Map<String, Object> map) {
		List<Member> list=null;
		try {
			list=dao.selectList("memManage.listMember", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public Member readMember(String userId) {
		Member dto = null;
		
		try {
			dto = dao.selectOne("memManage.readMember", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	public List<Analysis> listAgeSection() {
		List<Analysis> list = null;
		try {
			list = dao.selectList("memManage.listAgeSection");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void failCntReset(String userId) throws Exception {
		try {
			dao.updateData("memManage.FailCntReset", userId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updateEnable(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("memManage.updateEnable", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public void insertEnable(Member dto) throws Exception {
		try {
			dao.updateData("memManage.insertEnable", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Member> listEnable(String userId) {
		List<Member> list=null;
		try {
			list=dao.selectList("memManage.listEnable", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Member readEnable(String userId) {
		Member dto=null;
		
		try {
			dto=dao.selectOne("memManage.readEnable", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
}
