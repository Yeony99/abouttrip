package com.aboutrip.app.product;

public class Order {
	// 유저정보
	private String nickName;
	
	// 리뷰 정보
	private String reviewContent;
	private int rate;
	
	// 장바구니
	private int user_num;
	private int cart_num;
	private int quentity;
	
	// 선택상품
	private int option_num;
	private String option_name;
	private String option_value;
	private int price;
	private int parent_num;
	
	// 주문
	private int order_num;
	private int order_price;
	private int order_state;
	private String order_date;
	private int isUsed;
	
	// 결제
	private int payment;
	private String pat_date;
	private String card_name;
	private int card_num;
	private int card_ok_num;
	
	// 주문 상세
	private int order_detail;
	private int quantity;
	private int ori_price;
	private int discount;
	private int final_price;
	private int detail_num;
	
	// 결제취소
	private int cKey;
	private String whyCancel;
	private int cPrice;
	private String cDate;
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getReviewContent() {
		return reviewContent;
	}
	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}
	public int getRate() {
		return rate;
	}
	public void setRate(int rate) {
		this.rate = rate;
	}
	public int getUser_num() {
		return user_num;
	}
	public void setUser_num(int user_num) {
		this.user_num = user_num;
	}
	public int getCart_num() {
		return cart_num;
	}
	public void setCart_num(int cart_num) {
		this.cart_num = cart_num;
	}
	public int getQuentity() {
		return quentity;
	}
	public void setQuentity(int quentity) {
		this.quentity = quentity;
	}
	public int getOption_num() {
		return option_num;
	}
	public void setOption_num(int option_num) {
		this.option_num = option_num;
	}
	public String getOption_name() {
		return option_name;
	}
	public void setOption_name(String option_name) {
		this.option_name = option_name;
	}
	public String getOption_value() {
		return option_value;
	}
	public void setOption_value(String option_value) {
		this.option_value = option_value;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getParent_num() {
		return parent_num;
	}
	public void setParent_num(int parent_num) {
		this.parent_num = parent_num;
	}
	public int getOrder_num() {
		return order_num;
	}
	public void setOrder_num(int order_num) {
		this.order_num = order_num;
	}
	public int getOrder_price() {
		return order_price;
	}
	public void setOrder_price(int order_price) {
		this.order_price = order_price;
	}
	public int getOrder_state() {
		return order_state;
	}
	public void setOrder_state(int order_state) {
		this.order_state = order_state;
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
	public int getPayment() {
		return payment;
	}
	public void setPayment(int payment) {
		this.payment = payment;
	}
	public String getPat_date() {
		return pat_date;
	}
	public void setPat_date(String pat_date) {
		this.pat_date = pat_date;
	}
	public String getCard_name() {
		return card_name;
	}
	public void setCard_name(String card_name) {
		this.card_name = card_name;
	}
	public int getCard_num() {
		return card_num;
	}
	public void setCard_num(int card_num) {
		this.card_num = card_num;
	}
	public int getCard_ok_num() {
		return card_ok_num;
	}
	public void setCard_ok_num(int card_ok_num) {
		this.card_ok_num = card_ok_num;
	}
	public int getOrder_detail() {
		return order_detail;
	}
	public void setOrder_detail(int order_detail) {
		this.order_detail = order_detail;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public int getOri_price() {
		return ori_price;
	}
	public void setOri_price(int ori_price) {
		this.ori_price = ori_price;
	}
	public int getDiscount() {
		return discount;
	}
	public void setDiscount(int discount) {
		this.discount = discount;
	}
	public int getFinal_price() {
		return final_price;
	}
	public void setFinal_price(int final_price) {
		this.final_price = final_price;
	}
	public int getDetail_num() {
		return detail_num;
	}
	public void setDetail_num(int detail_num) {
		this.detail_num = detail_num;
	}
	public int getcKey() {
		return cKey;
	}
	public void setcKey(int cKey) {
		this.cKey = cKey;
	}
	public String getWhyCancel() {
		return whyCancel;
	}
	public void setWhyCancel(String whyCancel) {
		this.whyCancel = whyCancel;
	}
	public int getcPrice() {
		return cPrice;
	}
	public void setcPrice(int cPrice) {
		this.cPrice = cPrice;
	}
	public String getcDate() {
		return cDate;
	}
	public void setcDate(String cDate) {
		this.cDate = cDate;
	}	
}
