package com.aboutrip.app.scheduler;

import java.util.List;
import java.util.Map;

public interface SchedulerService {
	public void insertSchedule(Scheduler dto) throws Exception;
	
	public List<Scheduler> listMonth(Map<String, Object> map) throws Exception;
	
	public Scheduler readScheduler(int user_num) throws Exception;
	
	public void updateScheduler(Map<String, Object> map) throws Exception;
	
	public void deleteSchedule(Map<String, Object> map) throws Exception;
}
