package com.movie.pang.mem;

public class BmemVO {
	private String bmem_nm; 
	private String bmem_tel; 
	private String bmem_pwd;
	private String bmem_bir;
	public String getBmem_nm() {
		return bmem_nm;
	}
	public void setBmem_nm(String bmem_nm) {
		this.bmem_nm = bmem_nm;
	}
	public String getBmem_tel() {
		return bmem_tel;
	}
	public void setBmem_tel(String bmem_tel) {
		this.bmem_tel = bmem_tel;
	}
	public String getBmem_pwd() {
		return bmem_pwd;
	}
	public void setBmem_pwd(String bmem_pwd) {
		this.bmem_pwd = bmem_pwd;
	}
	public String getBmem_bir() {
		return bmem_bir;
	}
	public void setBmem_bir(String bmem_bir) {
		this.bmem_bir = bmem_bir;
	}
	@Override
	public String toString() {
		return "BmemVO [bmem_nm=" + bmem_nm + ", bmem_tel=" + bmem_tel + ", bmem_pwd=" + bmem_pwd + ", bmem_bir="
				+ bmem_bir + "]";
	}
	
	
}
