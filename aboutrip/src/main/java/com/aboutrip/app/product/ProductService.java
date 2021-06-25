package com.aboutrip.app.product;

import java.util.List;
import java.util.Map;

public interface ProductService {

	public void insertReview(Order dto) throws Exception;
	public void insertQuestion(QnA dto) throws Exception;
	public void insertAnswer(QnA dto) throws Exception;
	public void insertcart(Order dto) throws Exception;
	public void repundPayment(Payment dto) throws Exception;
	
	public List<Product> listProducts(Map<String, Object> map) throws Exception;
	public List<Order> listOrder(int code) throws Exception;
	public List<QnA> listQna(Map<String,Object> map) throws Exception;
	public List<Product> listEvent(int category_num) throws Exception;
	public List<Product> listOption(int code) throws Exception;
	public List<Order> listcart(int userNum) throws Exception;
	public List<Order> listPayment(Map<String, Object> map) throws Exception;
	public List<Order> listCard(int user_num) throws Exception;
	public List<Order> listReview(Map<String, Object> map) throws Exception;
	
	public void updateQnA(int num) throws Exception;
	
	public int countProduct(Map<String, Object> map) throws Exception;
	public int countcart(int user_num) throws Exception;
	public int listCount(Map<String, Object> map) throws Exception;
	public int countQna(int code) throws Exception;
	public int countReview(int code) throws Exception;
	
	public Product readProduct(int code) throws Exception;
	public Order readMember(int user_num) throws Exception;
	public Order readOrder(int order_detail) throws Exception;

	public void deletecart(int cart_num) throws Exception;
	public void deletecart(Map<String, Object> map) throws Exception;
	public void completePayment(Order dto, List<Order> list, Payment pay) throws Exception;
}
