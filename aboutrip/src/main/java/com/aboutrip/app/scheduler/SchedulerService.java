package com.aboutrip.app.scheduler;

import java.util.List;
import java.util.Map;

public interface SchedulerService {
	public void insertSchedule(Scheduler dto) throws Exception;
	
	public List<Scheduler> listMonth(Map<String, Object> map) throws Exception;
	
	public Scheduler readScheduler(int user_num) throws Exception;
	
	public void updateScheduler(Map<String, Object> map) throws Exception;
	
	public void deleteSchedule(Map<String, Object> map) throws Exception;
	
	public void insertMate(Mate dto) throws Exception;
	
	public int MateCount();
	
	public List<Mate> listMate(Map<String, Object> map) throws Exception;
	
	public List<Mate> readMate(int userNum) throws Exception;
}
