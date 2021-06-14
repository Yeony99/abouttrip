package com.aboutrip.app.inquiry;

import java.util.List;
import java.util.Map;


public interface InquiryService {
	public void insertInquiry(Inquiry dto) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	public List<Inquiry> listInquiry(Map<String, Object> map);
	
	public Inquiry readInquiry(int num);
	
	public void answerInquiry(Inquiry dto) throws Exception;
	public void deleteAnswer(int num) throws Exception;
	public void deleteInquiry(int num) throws Exception;
}
