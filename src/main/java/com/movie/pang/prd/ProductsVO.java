package com.movie.pang.prd;

import org.springframework.web.multipart.MultipartFile;

public class ProductsVO {
	
private	String prd_num;
private String prd_name; 
private String prd_type;
private String prd_desc;
private String prd_price;
private String prd_status; 
private int prd_count;
private String prd_img;
private MultipartFile uploadFile;

public String getPrd_img() {
	return prd_img;
}
public void setPrd_img(String prd_img) {
	this.prd_img = prd_img;
}
public MultipartFile getUploadFile() {
	return uploadFile;
}
public void setUploadFile(MultipartFile uploadFile) {
	this.uploadFile = uploadFile;
}
public String getPrd_num() {
	return prd_num;
}
public void setPrd_num(String prd_num) {
	this.prd_num = prd_num;
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
public String getPrd_desc() {
	return prd_desc;
}
public void setPrd_desc(String prd_desc) {
	this.prd_desc = prd_desc;
}
public String getPrd_price() {
	return prd_price;
}
public void setPrd_price(String prd_price) {
	this.prd_price = prd_price;
}
public String getPrd_status() {
	return prd_status;
}
public void setPrd_status(String prd_status) {
	this.prd_status = prd_status;
}
public int getPrd_count() {
	return prd_count;
}
public void setPrd_count(int prd_count) {
	this.prd_count = prd_count;
}
@Override
public String toString() {
	return "ProductsVO [prd_num=" + prd_num + ", prd_name=" + prd_name + ", prd_type=" + prd_type + ", prd_desc="
			+ prd_desc + ", prd_price=" + prd_price + ", prd_status=" + prd_status + ", prd_count=" + prd_count
			+ ", prd_img=" + prd_img + ", uploadFile=" + uploadFile + "]";
}



}
