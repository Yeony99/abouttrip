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
	public Member readMember(int userNum) {
		Member dto = null;
		
		try {
			dto = dao.selectOne("memManage.readMember", userNum);
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
	public void updateEnable(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("memManage.updateEnable", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<Member> listEnable(int userNum) {
		List<Member> list=null;
		try {
			list=dao.selectList("memManage.listEnable", userNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Member readEnable(int userNum) {
		Member dto=null;
		
		try {
			dto=dao.selectOne("memManage.readEnable", userNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
}
