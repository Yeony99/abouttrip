package com.aboutrip.app.booking;

import java.util.List;
import java.util.Map;

public interface BookingService {
	public int countEvent(Map<String, Object> map);
	public List<Booking> listEvent(Map<String, Object> map) throws Exception;
}
