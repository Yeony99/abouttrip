package com.aboutrip.app.scheduler;

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

}
