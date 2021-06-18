package com.aboutrip.app.scheduler;

import java.util.List;
import java.util.Map;

public interface SchedulerService {
	public void insertSchedule(Scheduler dto) throws Exception;
	public void insertMate(Mate dto) throws Exception;
	public void insertReply(MateReply dto) throws Exception;
	
	public List<Scheduler> listMonth(Map<String, Object> map) throws Exception;
	public List<Mate> listMate(Map<String, Object> map) throws Exception;
	public List<Mate> readMate(int userNum) throws Exception;
	public List<MateReply> listReply(int answer) throws Exception;
		
	public void updateScheduler(Map<String, Object> map) throws Exception;
	
	public void deleteSchedule(Map<String, Object> map) throws Exception;
	public void deleteMate(Map<String,Object> map)throws Exception;
	public void deleteReply(Map<String, Object> map) throws Exception;
	
	public int MateCount();
	public int replyAnswerCount(int answer);
}
