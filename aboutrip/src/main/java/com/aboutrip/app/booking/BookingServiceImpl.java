package com.aboutrip.app.booking;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aboutrip.app.common.dao.AboutDAO;

@Service("booking.bookingService")
public class BookingServiceImpl implements BookingService{

	@Autowired
	AboutDAO dao;
	
	@Override
	public List<Booking> listEvent(Map<String, Object> map) throws Exception {
		List<Booking> event = null;
		try {
			event = dao.selectList("booking.event_list",map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}	
		return event;
	}

	@Override
	public int countEvent(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("booking.event_count", map);
		} catch (Exception e) {
			e.printStackTrace();
		}	
		return result;
	}

	@Override
	public Booking readBooking(int code) {
		Booking dto = null;
		try {
			dto = dao.selectOne("booking.booking_read", code);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

}
