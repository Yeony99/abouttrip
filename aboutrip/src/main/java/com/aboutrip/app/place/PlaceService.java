package com.aboutrip.app.place;

import java.util.List;
import java.util.Map;

public interface PlaceService {
	public int dataCount(Map<String, Object> map);
	
	public List<Place> listPlace(Map<String, Object> map);
	public List<Place> currentList(Map<String, Object> map);
	
	public void insertPlace(Place dto, String pathname) throws Exception;
	
	public Place readPlace(int placeNum);
	
	public void updateHitCount(int num) throws Exception;
	public void updatePlace(Place dto, String pathname) throws Exception;
	
	public Place preReadPlace(Map<String, Object> map);
	public Place nextReadPlace(Map<String, Object> map);
	
	public void deletePlace(int PlaceNum, String pathname) throws Exception;
	
}
