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
	public List<Booking> listEvent(int category_num) throws Exception {
		List<Booking> event = null;
		try {
			event = dao.selectList("booking.event_list", category_num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}	
		return event;
	}

	@Override
	public int countEvent(int category_num) {
		int result = 0;
		try {
			result = dao.selectOne("booking.event_count", category_num);
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

	@Override
	public List<Order> listReview(Map<String, Object> map) throws Exception {
		List<Order> Review = null;
		try {
			Review = dao.selectList("booking.review_list", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}	
		return Review;
	}

	@Override
	public List<QnA> listQna(Map<String, Object> map) throws Exception {
		List<QnA> Qna = null;
		try {
			Qna = dao.selectList("booking.qna_list", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}	
		return Qna;
	}

	@Override
	public int countProduct(Map<String, Object> map) throws Exception {
		int result = 0;
		try {
			result = dao.selectOne("booking.product_count", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@Override
	public int countReview(int code) throws Exception {
		int result = 0;
		try {
			result = dao.selectOne("booking.review_count",code);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return result;
	}

}
