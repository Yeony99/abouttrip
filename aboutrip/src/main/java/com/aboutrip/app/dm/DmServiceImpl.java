package com.aboutrip.app.dm;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aboutrip.app.common.dao.AboutDAO;

@Service("dm.dmService")
public class DmServiceImpl implements DmService {
	@Autowired
	AboutDAO dao;

	@Override
	public List<Dm> listFriend(Map<String, Object> map) {
		List<Dm> list = null;
		try {
			list = dao.selectList("dm.listFriend", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void insertDm(Dm dto) throws Exception {
		try {
			for(int receiver : dto.getReceivers()) {
				dto.setReceiverNum(receiver);
				dao.insertData("dm.insertDm", dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public int dataCountReceive(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("dm.dataCountReceive", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Dm> listReceive(Map<String, Object> map) {
		List<Dm> list = null;
		
		try {
			list = dao.selectList("dm.listReceive", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCountSend(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("dm.dataCountSend", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Dm> listSend(Map<String, Object> map) {
		List<Dm> list=null;
		
		try {
			list=dao.selectList("dm.listSend", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Dm readReceive(int dmNum) {
		Dm dto=null;
		
		try{
			dto=dao.selectOne("dm.readReceive", dmNum);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public Dm preReadReceive(Map<String, Object> map) {
		Dm dto=null;
		
		try{
			dto=dao.selectOne("dm.preReadReceive", map);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public Dm nextReadReceive(Map<String, Object> map) {
		Dm dto=null;
		
		try{
			dto=dao.selectOne("dm.nextReadReceive", map);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public Dm readSend(int dmNum) {
		Dm dto=null;
		
		try{
			dto=dao.selectOne("dm.readSend", dmNum);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public Dm preReadSend(Map<String, Object> map) {
		Dm dto=null;
		
		try{
			dto=dao.selectOne("dm.preReadSend", map);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public Dm nextReadSend(Map<String, Object> map) {
		Dm dto=null;
		
		try{
			dto=dao.selectOne("dm.nextReadSend", map);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void updateIdentifyDay(int dmNum) throws Exception {
		try{
			dao.updateData("dm.updateIdentifyDay", dmNum);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteDm(Map<String, Object> map) throws Exception {
		try{
			// 삭제 상태가 아닌 경우는 삭제 상태로 수정
			dao.updateData("dm.updateDeleteState", map);
			
		    // 삭제(삭제상태로 된경우에는 글을 삭제)
			dao.deleteData("dm.deleteDm", map);
	} catch(Exception e) {
		e.printStackTrace();
		throw e;
	}
	}

	@Override
	public int newDmCount(int userNum) {
		int result=0;
		try {
			result=dao.selectOne("dm.newDmCount", userNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
}
