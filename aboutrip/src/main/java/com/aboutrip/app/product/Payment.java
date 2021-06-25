package com.aboutrip.app.product;

public class Payment {
	// 결제승인
	private int order_num;
	private String pay_date;
	private String imp_uid;
	private int paid_amount;
	private int card_ok_num;
	
	// 결제 취소
	private int repund_key;
	private String reason;
	private int cancel_request_amount;
	private String refund_date;
	private String refund_account;
	private int refund_bank;
	private int order_detail;
	public int getOrder_num() {
		return order_num;
	}
	public void setOrder_num(int order_num) {
		this.order_num = order_num;
	}
	public String getPay_date() {
		return pay_date;
	}
	public void setPay_date(String pay_date) {
		this.pay_date = pay_date;
	}
	public String getImp_uid() {
		return imp_uid;
	}
	public void setImp_uid(String imp_uid) {
		this.imp_uid = imp_uid;
	}
	public int getPaid_amount() {
		return paid_amount;
	}
	public void setPaid_amount(int paid_amount) {
		this.paid_amount = paid_amount;
	}
	public int getCard_ok_num() {
		return card_ok_num;
	}
	public void setCard_ok_num(int card_ok_num) {
		this.card_ok_num = card_ok_num;
	}
	public int getRepund_key() {
		return repund_key;
	}
	public void setRepund_key(int repund_key) {
		this.repund_key = repund_key;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public int getCancel_request_amount() {
		return cancel_request_amount;
	}
	public void setCancel_request_amount(int cancel_request_amount) {
		this.cancel_request_amount = cancel_request_amount;
	}
	public String getRefund_date() {
		return refund_date;
	}
	public void setRefund_date(String refund_date) {
		this.refund_date = refund_date;
	}
	public String getRefund_account() {
		return refund_account;
	}
	public void setRefund_account(String refund_account) {
		this.refund_account = refund_account;
	}
	public int getRefund_bank() {
		return refund_bank;
	}
	public void setRefund_bank(int refund_bank) {
		this.refund_bank = refund_bank;
	}
	public int getOrder_detail() {
		return order_detail;
	}
	public void setOrder_detail(int order_detail) {
		this.order_detail = order_detail;
	}
	
	
}
