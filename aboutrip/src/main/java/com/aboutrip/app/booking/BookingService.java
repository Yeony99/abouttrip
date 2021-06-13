package com.aboutrip.app.booking;

import java.util.List;
import java.util.Map;

public interface BookingService {
	public int countEvent(int category_num);
	public int countProduct(Map<String, Object> map) throws Exception ;
	public int countReview(int code) throws Exception ;
	public List<Booking> listEvent(int category_num) throws Exception;
	public Booking readBooking(int code);
	

	public List<Order> listReview(Map<String, Object> map) throws Exception;
	public List<QnA> listQna(Map<String, Object> map) throws Exception;
}
