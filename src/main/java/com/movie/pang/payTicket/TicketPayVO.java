package com.movie.pang.payTicket;

public class TicketPayVO {
	
	private int pay_Num; //설정 완
	private String pay_ID; // 설정 완
	private String pay_TicID; //1
	private String pay_MemName; //2
	private String pay_MemPhoneNumber;//3
	private String pay_MovName; //4
	private String pay_PaymentDate; // 설정완
	private int pay_DisPrice; // 5
	private int pay_PayPrice; // 6
	private String pay_Status; // 설정 완
	private String pay_cancledDate; // 설정 완
	private String imp_uid;
	private String pay_method;
	
	
	public String getPay_method() {
		return pay_method;
	}
	public String getPay_cancledDate() {
		return pay_cancledDate;
	}
	public void setPay_cancledDate(String pay_cancledDate) {
		this.pay_cancledDate = pay_cancledDate;
	}
	public void setPay_method(String pay_method) {
		this.pay_method = pay_method;
	}

	public String getImp_uid() {
		return imp_uid;
	}
	public void setImp_uid(String imp_uid) {
		this.imp_uid = imp_uid;
	}
	public int getPay_Num() {
		return pay_Num;
	}
	public void setPay_Num(int pay_Num) {
		this.pay_Num = pay_Num;
	}
	public String getPay_ID() {
		return pay_ID;
	}
	public void setPay_ID(String pay_ID) {
		this.pay_ID = pay_ID;
	}
	public String getPay_TicID() {
		return pay_TicID;
	}
	public void setPay_TicID(String pay_TicID) {
		this.pay_TicID = pay_TicID;
	}
	public String getPay_MemName() {
		return pay_MemName;
	}
	public void setPay_MemName(String pay_MemName) {
		this.pay_MemName = pay_MemName;
	}
	public String getPay_MemPhoneNumber() {
		return pay_MemPhoneNumber;
	}
	public void setPay_MemPhoneNumber(String pay_MemPhoneNumber) {
		this.pay_MemPhoneNumber = pay_MemPhoneNumber;
	}
	public String getPay_MovName() {
		return pay_MovName;
	}
	public void setPay_MovName(String pay_MovName) {
		this.pay_MovName = pay_MovName;
	}
	public String getPay_PaymentDate() {
		return pay_PaymentDate;
	}
	public void setPay_PaymentDate(String pay_PaymentDate) {
		this.pay_PaymentDate = pay_PaymentDate;
	}
	public int getPay_DisPrice() {
		return pay_DisPrice;
	}
	public void setPay_DisPrice(int pay_DisPrice) {
		this.pay_DisPrice = pay_DisPrice;
	}
	public int getPay_PayPrice() {
		return pay_PayPrice;
	}
	public void setPay_PayPrice(int pay_PayPrice) {
		this.pay_PayPrice = pay_PayPrice;
	}
	public String getPay_Status() {
		return pay_Status;
	}
	public void setPay_Status(String pay_Status) {
		this.pay_Status = pay_Status;
	}
	@Override
	public String toString() {
		return "TicketPayVO [pay_Num=" + pay_Num + ", pay_ID=" + pay_ID + ", pay_TicID=" + pay_TicID + ", pay_MemName="
				+ pay_MemName + ", pay_MemPhoneNumber=" + pay_MemPhoneNumber + ", pay_MovName=" + pay_MovName
				+ ", pay_PaymentDate=" + pay_PaymentDate + ", pay_DisPrice=" + pay_DisPrice + ", pay_PayPrice="
				+ pay_PayPrice + ", pay_Status=" + pay_Status + ", pay_cancledDate=" + pay_cancledDate + ", imp_uid="
				+ imp_uid + ", pay_method=" + pay_method + "]";
	}

	
}
