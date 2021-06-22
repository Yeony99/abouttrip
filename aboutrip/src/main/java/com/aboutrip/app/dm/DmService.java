package com.aboutrip.app.dm;

import java.util.List;
import java.util.Map;

public interface DmService {
	public List<Dm> listFriend(Map<String, Object> map);
	public void insertDm(Dm dto) throws Exception;
	public int dataCountReceive(Map<String, Object> map);
	public List<Dm> listReceive(Map<String, Object> map);
	
	public int dataCountSend(Map<String, Object> map);
	public List<Dm> listSend(Map<String, Object> map);
	
	public Dm readReceive(int dmNum);
	public Dm preReadReceive(Map<String, Object> map);
	public Dm nextReadReceive(Map<String, Object> map);
	
	public Dm readSend(int dmNum);
	public Dm preReadSend(Map<String, Object> map);
	public Dm nextReadSend(Map<String, Object> map);
	
	public void updateIdentifyDay(int dmNum) throws Exception;
	public void deleteDm(Map<String, Object> map) throws Exception;
	public int newDmCount(String userNum);
}
