package com.movie.pang.mov;

import org.springframework.web.multipart.MultipartFile;

public class Mov_moviesVO {
	private String mov_Num;
	private String mov_Nm;
	private String mov_Con1;
	private String mov_Con2;
	private String mov_Con3;
	private String mov_Detail;
	private String mov_Date;
	private String mov_Pd;
	private String mov_Act;
	private String mov_Post;
	private String mov_Rt;
	private String mov_Lang;
	private String mov_Sub;
	private String mov_Nation;
	private String mov_Rate;
	private String mov_EndDate;
	

	private MultipartFile uploadFile;

	// 마이바티스를 사용하기 위해 필요한 멤버필드
	private String searchCondition;
	private String searchKeyword;

	private int start;
	private int listCount;
	private int rowno;

	public String getMov_Num() {
		return mov_Num;
	}

	public void setMov_Num(String mov_Num) {
		this.mov_Num = mov_Num;
	}

	public String getMov_Nm() {
		return mov_Nm;
	}

	public void setMov_Nm(String mov_Nm) {
		this.mov_Nm = mov_Nm;
	}

	public String getMov_Con1() {
		return mov_Con1;
	}

	public void setMov_Con1(String mov_Con1) {
		this.mov_Con1 = mov_Con1;
	}

	public String getMov_Con2() {
		return mov_Con2;
	}

	public void setMov_Con2(String mov_Con2) {
		this.mov_Con2 = mov_Con2;
	}

	public String getMov_Con3() {
		return mov_Con3;
	}

	public void setMov_Con3(String mov_Con3) {
		this.mov_Con3 = mov_Con3;
	}

	public String getMov_Detail() {
		return mov_Detail;
	}

	public void setMov_Detail(String mov_Detail) {
		this.mov_Detail = mov_Detail;
	}

	public String getMov_Date() {
		return mov_Date;
	}

	public void setMov_Date(String mov_Date) {
		this.mov_Date = mov_Date;
	}

	public String getMov_Pd() {
		return mov_Pd;
	}

	public void setMov_Pd(String mov_Pd) {
		this.mov_Pd = mov_Pd;
	}

	public String getMov_Act() {
		return mov_Act;
	}

	public void setMov_Act(String mov_Act) {
		this.mov_Act = mov_Act;
	}

	public String getMov_Post() {
		return mov_Post;
	}

	public void setMov_Post(String mov_Post) {
		this.mov_Post = mov_Post;
	}

	public String getMov_Rt() {
		return mov_Rt;
	}

	public void setMov_Rt(String mov_Rt) {
		this.mov_Rt = mov_Rt;
	}
	public String getMov_Rate() {
		return mov_Rate;
	}
	
	public void setMov_Rate(String mov_Rate) {
		this.mov_Rate = mov_Rate;
	}

	public String getMov_Lang() {
		return mov_Lang;
	}

	public void setMov_Lang(String mov_Lang) {
		this.mov_Lang = mov_Lang;
	}

	public String getMov_Sub() {
		return mov_Sub;
	}

	public void setMov_Sub(String mov_Sub) {
		this.mov_Sub = mov_Sub;
	}

	public String getMov_Nation() {
		return mov_Nation;
	}

	public void setMov_Nation(String mov_Nation) {
		this.mov_Nation = mov_Nation;
	}

	public String getMov_EndDate() {
		return mov_EndDate;
	}
	
	public void setMov_EndDate(String mov_EndDate) {
		this.mov_EndDate = mov_EndDate;
	}
	
	public MultipartFile getUploadFile() {
		return uploadFile;
	}
	
	public void setUploadFile(MultipartFile uploadFile) {
		this.uploadFile = uploadFile;
	}

	public String getSearchCondition() {
		return searchCondition;
	}
	
	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}
	public String getSearchKeyword() {
		return searchKeyword;
	}
	
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	
	public int getStart() {
		return start;
	}
	
	public void setStart(int start) {
		this.start = start;
	}
	
	public int getListCount() {
		return listCount;
	}
	
	public void setListCount(int listCount) {
		this.listCount = listCount;
	}
	
	public int getRowno() {
		return rowno;
	}
	
	public void setRowno(int rowno) {
		this.rowno = rowno;
	}

	@Override
	public String toString() {
		return "Mov_moviesVO [mov_Num=" + mov_Num + ", mov_Nm=" + mov_Nm + ", mov_Con1=" + mov_Con1 + ", mov_Con2="
				+ mov_Con2 + ", mov_Con3=" + mov_Con3 + ", mov_Detail=" + mov_Detail + ", mov_Date=" + mov_Date
				+ ", mov_Pd=" + mov_Pd + ", mov_Act=" + mov_Act + ", mov_Post=" + mov_Post + ", mov_Rt=" + mov_Rt
				+ ", mov_Lang=" + mov_Lang + ", mov_Sub=" + mov_Sub + ", mov_Nation=" + mov_Nation + ", mov_Rate="
				+ mov_Rate + ", mov_EndDate=" + mov_EndDate + ", uploadFile=" + uploadFile + ", searchCondition="
				+ searchCondition + ", searchKeyword=" + searchKeyword + ", start=" + start + ", listCount=" + listCount
				+ ", rowno=" + rowno + "]";
	}
}