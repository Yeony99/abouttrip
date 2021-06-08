package com.aboutrip.app.place;

import java.util.List;
import java.util.Map;

public interface PlaceService {
	public int dataCount(Map<String, Object> map);
	
	public List<Place> listPlace(Map<String, Object> map);
	
	public void insertPlace(Place dto, String pathname) throws Exception;
	
}
