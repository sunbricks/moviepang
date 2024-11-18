package com.movie.pang.chart;

public class PaymentDateVO {
	 private String pay_PaymentDate;
	 private int cnt;
	 
	public String getPay_PaymentDate() {
		return pay_PaymentDate;
	}
	public void setPay_PaymentDate(String pay_PaymentDate) {
		this.pay_PaymentDate = pay_PaymentDate;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	
	@Override
	public String toString() {
		return "PaymentDateVO [payPaymentDate=" + pay_PaymentDate + ", cnt=" + cnt + "]";
	}



}
