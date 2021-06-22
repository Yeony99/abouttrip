package com.aboutrip.app.sug;

import java.util.List;
import java.util.Map;

public interface SugService {
	public void insertSug(Sug dto, String pathname) throws Exception;
	
	public List<Sug> listSug(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	
	public Sug readSug(int num);
	public Sug preReadSug(Map<String, Object> map);
	public Sug nextReadSug(Map<String, Object> map);
	
	public void updateSug(Sug dto, String pathname) throws Exception;
	public void deleteSug(int num, String pathname, int userNum) throws Exception;
		
	public void insertSugLike(Map<String, Object> map) throws Exception;
	public int sugLikeCount(int num);
	
}
