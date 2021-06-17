package com.aboutrip.app.scheduler;

import java.util.List;
import java.util.Map;

public interface SchService {
	public void insertMate(Mate dto) throws Exception;
	
	public int MateCount();
	
	public List<Mate> listMate(Map<String, Object> map) throws Exception;
}
