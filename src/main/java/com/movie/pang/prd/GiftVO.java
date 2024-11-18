package com.movie.pang.prd;

public class GiftVO {
	
	private String gift_buyer; //구매자
	private String prd_num; //상품번호
	private String prd_serial; //상품 시리얼 번호
	private String prd_name; //상품 이름
	private String gift_owntel; //소유자, 받은사람 번호
	private String prd_price; //상품 가격
	private String gift_owner;//소유자, 받은사람 
	private String prd_cnt; //상품 수량
	private String gift_date;// 상품 날짜
	private String gift_buyertel; // 상품구매자 폰번호
	private String state; //상품 상태
	public String getGift_buyer() {
		return gift_buyer;
	}
	public void setGift_buyer(String gift_buyer) {
		this.gift_buyer = gift_buyer;
	}
	public String getPrd_num() {
		return prd_num;
	}
	public void setPrd_num(String prd_num) {
		this.prd_num = prd_num;
	}
	public String getPrd_serial() {
		return prd_serial;
	}
	public void setPrd_serial(String prd_serial) {
		this.prd_serial = prd_serial;
	}
	public String getPrd_name() {
		return prd_name;
	}
	public void setPrd_name(String prd_name) {
		this.prd_name = prd_name;
	}
	public String getGift_owntel() {
		return gift_owntel;
	}
	public void setGift_owntel(String gift_owntel) {
		this.gift_owntel = gift_owntel;
	}
	public String getPrd_price() {
		return prd_price;
	}
	public void setPrd_price(String prd_price) {
		this.prd_price = prd_price;
	}
	public String getGift_owner() {
		return gift_owner;
	}
	public void setGift_owner(String gift_owner) {
		this.gift_owner = gift_owner;
	}
	public String getPrd_cnt() {
		return prd_cnt;
	}
	public void setPrd_cnt(String prd_cnt) {
		this.prd_cnt = prd_cnt;
	}
	public String getGift_date() {
		return gift_date;
	}
	public void setGift_date(String gift_date) {
		this.gift_date = gift_date;
	}
	public String getGift_buyertel() {
		return gift_buyertel;
	}
	public void setGift_buyertel(String gift_buyertel) {
		this.gift_buyertel = gift_buyertel;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	@Override
	public String toString() {
		return "GiftVO [gift_buyer=" + gift_buyer + ", prd_num=" + prd_num + ", prd_serial=" + prd_serial
				+ ", prd_name=" + prd_name + ", gift_owntel=" + gift_owntel + ", prd_price=" + prd_price
				+ ", gift_owner=" + gift_owner + ", prd_cnt=" + prd_cnt + ", gift_date=" + gift_date
				+ ", gift_buyertel=" + gift_buyertel + ", state=" + state + "]";
	}
	
	
}
