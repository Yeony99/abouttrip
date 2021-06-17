package com.aboutrip.app.scheduler;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aboutrip.app.common.dao.AboutDAO;

@Service("scheduler.schedulerService")
public class SchedulerServiceImpl implements SchedulerService{
	
	@Autowired
	private AboutDAO dao;
	@Override
	public void insertSchedule(Scheduler dto) throws Exception {
		try {
			//dto.setNum(dao.selectOne("scheduler.scheduler_seq"));
			dao.insertData("scheduler.insertScheduler", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public List<Scheduler> listMonth(Map<String, Object> map) throws Exception {
		List<Scheduler> list = null;
		try {
			list = dao.selectList("scheduler.listMonth",map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return list;
	}

	@Override
	public Scheduler readScheduler(int user_num) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateScheduler(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("scheduler.updateScheduler", map);
		} catch (Exception e) {
			throw e;
		}
		
	}

	@Override
	public void deleteSchedule(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("scheduler.deleteScheduler", map);
		} catch (Exception e) {
			throw e;
		}
		
	}
	
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

	@Override
	public List<Mate> readMate(int userNum) throws Exception {
		List<Mate> list = null;
		try {
			list = dao.selectList("scheduler.readMate",userNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
}
