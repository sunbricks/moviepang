package com.movie.pang.prd;

public class CartVO {
	
	private String mem_id;
	private int prd_num;
	private int cart_id;
	private int cart_count;
	
	
	//product
	private String prd_name; 
	private String prd_type;
	private String prd_img;
	private int prd_price;
	private int prd_discount;
	
	//추가
    private int salePrice;
    private int totalPrice;
    private int count;

	
	
    
    
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	
	
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	
	public int getPrd_num() {
		return prd_num;
	}
	public void setPrd_num(int prd_num) {
		this.prd_num = prd_num;
	}
	public int getCart_id() {
		return cart_id;
	}
	public void setCart_id(int cart_id) {
		this.cart_id = cart_id;
	}
	public int getCart_count() {
		return cart_count;
	}
	public void setCart_count(int cart_count) {
		this.cart_count = cart_count;
	}
	
	public String getPrd_name() {
		return prd_name;
	}
	public void setPrd_name(String prd_name) {
		this.prd_name = prd_name;
	}
	public String getPrd_type() {
		return prd_type;
	}
	public void setPrd_type(String prd_type) {
		this.prd_type = prd_type;
	}
	public String getPrd_img() {
		return prd_img;
	}
	public void setPrd_img(String prd_img) {
		this.prd_img = prd_img;
	}
	public int getPrd_price() {
		return prd_price;
	}
	public void setPrd_price(int prd_price) {
		this.prd_price = prd_price;
	}
	
	public int getSalePrice() {
		return salePrice;
	}

	public int getTotalPrice() {
		return totalPrice;
	}
	
	public void initSaleTotal() {
		this.salePrice = (int) (this.prd_price * (1-this.prd_discount));
		this.totalPrice = this.salePrice*this.cart_count;
	}
	
	@Override
	public String toString() {
		return "CartVO [mem_id=" + mem_id + ", prd_num=" + prd_num + ", cart_id=" + cart_id + ", cart_count="
				+ cart_count + "]";
	}
	

	
	
	
	
	
	
	
	
	

}
