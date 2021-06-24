package com.aboutrip.app.event;

import java.util.List;
import java.util.Map;

public interface EventService {
	public void insertEvent(Event dto) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	public List<Event> listEvent(Map<String, Object> map);
	
	public Event readEvent(int num);
	public Event preReadEvent(Map<String, Object> map);
	public Event nextReadEvent(Map<String, Object> map);
	
	public void updateEvent(Event dto) throws Exception;
	public void deleteEvent(int num, int userNum) throws Exception;
	
	public void partEvent(Map<String, Object> map) throws Exception;
	public Event readPart(int num, int partNum);
	public List<Event> listPart(Map<String, Object> map);
	public int partCount(int num);
	public void deletePart(Map<String, Object> map) throws Exception;
	
	public void winEvent(Event dto) throws Exception;
	public List<Event> listWin(Map<String, Object> map);
	
}
