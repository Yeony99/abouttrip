package com.aboutrip.app.scheduler;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aboutrip.app.common.dao.AboutDAO;

@Service("scheduler.schService")
public class SchServiceImpl implements SchService{

	@Autowired
	private AboutDAO dao;
	
	@Override
	public void insertMate(Mate dto) throws Exception {
		try {
			dao.insertData("scheduler.insertMate", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public int MateCount() {
		int result = 0;
		
		try {
			result = dao.selectOne("scheduler.mateCount");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<Mate> listMate(Map<String, Object> map) throws Exception {
		List<Mate> list = null;
		try {
			list = dao.selectList("scheduler.listMate",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

}
