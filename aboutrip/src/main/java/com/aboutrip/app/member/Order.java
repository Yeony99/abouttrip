package com.aboutrip.app.member;

public class Order {
	private int order_num;
	private int user_num;
	private String order_date;
	private int isUsed;
	private int final_price;
	private String option_name;
	private String product_name;
	private int listNum;
	private String articleUrl;
	
	
	
	public String getArticleUrl() {
		return articleUrl;
	}
	public void setArticleUrl(String articleUrl) {
		this.articleUrl = articleUrl;
	}
	public int getListNum() {
		return listNum;
	}
	public void setListNum(int listNum) {
		this.listNum = listNum;
	}
	public int getOrder_num() {
		return order_num;
	}
	public void setOrder_num(int order_num) {
		this.order_num = order_num;
	}
	public int getUser_num() {
		return user_num;
	}
	public void setUser_num(int user_num) {
		this.user_num = user_num;
	}
	public String getOrder_date() {
		return order_date;
	}
	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}
	public int getIsUsed() {
		return isUsed;
	}
	public void setIsUsed(int isUsed) {
		this.isUsed = isUsed;
	}
	public int getFinal_price() {
		return final_price;
	}
	public void setFinal_price(int final_price) {
		this.final_price = final_price;
	}
	public String getOption_name() {
		return option_name;
	}
	public void setOption_name(String option_name) {
		this.option_name = option_name;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	
	
}
