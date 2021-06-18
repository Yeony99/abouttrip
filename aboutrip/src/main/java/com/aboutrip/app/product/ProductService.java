package com.aboutrip.app.product;

import java.util.List;
import java.util.Map;

public interface ProductService {

	public void insertReview(Order dto) throws Exception;
	public void insertQuestion(QnA dto) throws Exception;
	public void insertAnswer(QnA dto) throws Exception;
	public void insertcart(Order dto) throws Exception;
	
	public List<Product> listProducts(Map<String, Object> map) throws Exception;
	public List<Order> listOrder(int code) throws Exception;
	public List<QnA> listQna(int code) throws Exception;
	public List<Product> listEvent(int category_num) throws Exception;
	public List<Product> listOption(int code) throws Exception;
	public List<Order> listcart(int userNum) throws Exception;

	public void updateQnA(int num) throws Exception;
	
	public int countProduct(Map<String, Object> map) throws Exception;
	public int listCount(Map<String, Object> map) throws Exception;
	
	public Product readProduct(int code) throws Exception;
	public int countcart(int user_num) throws Exception;
}
