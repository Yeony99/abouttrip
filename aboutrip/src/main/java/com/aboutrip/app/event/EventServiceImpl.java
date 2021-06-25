package com.aboutrip.app.event;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aboutrip.app.common.dao.AboutDAO;

@Service("event.eventService")
public class EventServiceImpl implements EventService {
	
	@Autowired
	private AboutDAO dao;
	
	
	@Override
	public void insertEvent(Event dto) throws Exception {
		try {
			dao.insertData("event.insertEvent", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e; 
		}
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("event.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Event> listEvent(Map<String, Object> map) {
		List<Event> list = null;
		try {
			list=dao.selectList("event.listEvent", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Event readEvent(int num) {
		Event dto = null;
		
		try {
			dto=dao.selectOne("event.readEvent", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public Event preReadEvent(Map<String, Object> map) {
		Event dto=null;
		try {
			dto=dao.selectOne("event.preReadEvent", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Event nextReadEvent(Map<String, Object> map) {
		Event dto=null;
		try {
			dto=dao.selectOne("event.nextReadEvent", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateEvent(Event dto) throws Exception {
		try {
			dao.updateData("event.updateEvent", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void deleteEvent(int num, int userNum) throws Exception {
		try {
			Event dto = readEvent(num);
			if(dto==null || userNum!=1111) {
				return;
			}
			dao.deleteData("event.deleteEvent", num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void partEvent(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("event.partEvent", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public Event readPart(int num, int partNum) {
		Event dto = null;
		
		try {
			dto = dao.selectOne("event.readPart", partNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	@Override
	public List<Event> listPart(Map<String, Object> map) {
		List<Event> list = null;
		try {
			list=dao.selectList("event.listPart", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int partCount(int num) {
		int result=0;
		try {
			result=dao.selectOne("event.partCount", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void deletePart(int num, int partNum) throws Exception {
		try {
			dao.deleteData("event.deletePart", partNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void winEvent(Event dto) throws Exception {
		try {
			dao.insertData("event.winEvent", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Event> listWin(Map<String, Object> map) {
		List<Event> list = null;
		try {
			list = dao.selectList("event.listWin", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}


	
}
