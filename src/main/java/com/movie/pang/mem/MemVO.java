package com.movie.pang.mem;

import java.util.Date;

public class MemVO {
	private String mem_id;
	private String mem_pwd;
	private String mem_nm;
	private String mem_em;
	private String mem_tel;
	private String mem_jd;
	private String mem_st;
	private int mem_mp;
	private String mem_gen;
	private String mem_bir;
	private String mem_lea;
	private String mem_chpwd;
	private String mem_chpwdchk;
	
	
	public String getMem_chpwd() {
		return mem_chpwd;
	}
	public void setMem_chpwd(String mem_chpwd) {
		this.mem_chpwd = mem_chpwd;
	}
	public String getMem_chpwdchk() {
		return mem_chpwdchk;
	}
	public void setMem_chpwdchk(String mem_chpwdchk) {
		this.mem_chpwdchk = mem_chpwdchk;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getMem_pwd() {
		return mem_pwd;
	}
	public void setMem_pwd(String mem_pwd) {
		this.mem_pwd = mem_pwd;
	}
	public String getMem_nm() {
		return mem_nm;
	}
	public void setMem_nm(String mem_nm) {
		this.mem_nm = mem_nm;
	}
	public String getMem_em() {
		return mem_em;
	}
	public void setMem_em(String mem_em) {
		this.mem_em = mem_em;
	}
	public String getMem_tel() {
		return mem_tel;
	}
	public void setMem_tel(String mem_tel) {
		this.mem_tel = mem_tel;
	}
	public String getMem_jd() {
		return mem_jd;
	}
	public void setMem_jd(String mem_jd) {
		this.mem_jd = mem_jd;
	}
	public String getMem_st() {
		return mem_st;
	}
	public void setMem_st(String mem_st) {
		this.mem_st = mem_st;
	}
	public int getMem_mp() {
		return mem_mp;
	}
	public void setMem_mp(int mem_mp) {
		this.mem_mp = mem_mp;
	}
	public String getMem_gen() {
		return mem_gen;
	}
	public void setMem_gen(String mem_gen) {
		this.mem_gen = mem_gen;
	}
	public String getMem_bir() {
		return mem_bir;
	}
	public void setMem_bir(String mem_bir) {
		this.mem_bir = mem_bir;
	}
	public String getMem_lea() {
		return mem_lea;
	}
	public void setMem_lea(String mem_lea) {
		this.mem_lea = mem_lea;
	}
	@Override
	public String toString() {
		return "MemVO [mem_id=" + mem_id + ", mem_pwd=" + mem_pwd + ", mem_nm=" + mem_nm + ", mem_em=" + mem_em
				+ ", mem_tel=" + mem_tel + ", mem_jd=" + mem_jd + ", mem_st=" + mem_st + ", mem_mp=" + mem_mp
				+ ", mem_gen=" + mem_gen + ", mem_bir=" + mem_bir + ", mem_lea=" + mem_lea + ", mem_chpwd=" + mem_chpwd
				+ ", mem_chpwdchk=" + mem_chpwdchk + "]";
	}


}
