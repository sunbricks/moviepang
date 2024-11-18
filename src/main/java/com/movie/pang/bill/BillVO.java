package com.movie.pang.bill;

public class BillVO {
	private String bill_num;
	private String bill_id;
	private String bill_prd_num; 
	private String bill_prd_name;
	private String bill_cst_name; 
	private String bill_cst_tel; 
	private String bill_method; 
	private String bill_date; 
	private String bill_price; 
	private String bill_status;
	
	public String getBill_num() {
		return bill_num;
	}
	public void setBill_num(String bill_num) {
		this.bill_num = bill_num;
	}
	public String getBill_id() {
		return bill_id;
	}
	public void setBill_id(String bill_id) {
		this.bill_id = bill_id;
	}
	public String getBill_prd_num() {
		return bill_prd_num;
	}
	public void setBill_prd_num(String bill_prd_num) {
		this.bill_prd_num = bill_prd_num;
	}
	public String getBill_prd_name() {
		return bill_prd_name;
	}
	public void setBill_prd_name(String bill_prd_name) {
		this.bill_prd_name = bill_prd_name;
	}
	public String getBill_cst_name() {
		return bill_cst_name;
	}
	public void setBill_cst_name(String bill_cst_name) {
		this.bill_cst_name = bill_cst_name;
	}
	public String getBill_cst_tel() {
		return bill_cst_tel;
	}
	public void setBill_cst_tel(String bill_cst_tel) {
		this.bill_cst_tel = bill_cst_tel;
	}
	public String getBill_method() {
		return bill_method;
	}
	public void setBill_method(String bill_method) {
		this.bill_method = bill_method;
	}
	public String getBill_date() {
		return bill_date;
	}
	public void setBill_date(String bill_date) {
		this.bill_date = bill_date;
	}
	public String getBill_price() {
		return bill_price;
	}
	public void setBill_price(String bill_price) {
		this.bill_price = bill_price;
	}
	public String getBill_status() {
		return bill_status;
	}
	public void setBill_status(String bill_status) {
		this.bill_status = bill_status;
	}
	@Override
	public String toString() {
		return "BillVO [bill_num=" + bill_num + ", bill_id=" + bill_id + ", bill_prd_num=" + bill_prd_num
				+ ", bill_prd_name=" + bill_prd_name + ", bill_cst_name=" + bill_cst_name + ", bill_cst_tel="
				+ bill_cst_tel + ", bill_method=" + bill_method + ", bill_date=" + bill_date + ", bill_price="
				+ bill_price + ", bill_status=" + bill_status + "]";
	}
	
	
	
	
}
