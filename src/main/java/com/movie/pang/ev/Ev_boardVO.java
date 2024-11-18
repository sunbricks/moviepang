package com.movie.pang.ev;

import org.springframework.web.multipart.MultipartFile;

public class Ev_boardVO {

	private int ev_num;
	private String ev_title;
	private String ev_content;
	private String ev_sdate;
	private String ev_edate;
	private String ev_status;
	private String ev_img;

	// 업로드한 파일 정보를 담는 멤버필드
	private MultipartFile uploadFile;

	// 마이바티스를 사용하기 위해 필요한 멤버필드
	private String searchCondition;
	private String searchKeyword;
	
	private int start;
	private int listCount;
	private int rowno;	

	public int getEv_num() {
		return ev_num;
	}

	public void setEv_num(int ev_num) {
		this.ev_num = ev_num;
	}

	public String getEv_title() {
		return ev_title;
	}

	public void setEv_title(String ev_title) {
		this.ev_title = ev_title;
	}

	public String getEv_content() {
		return ev_content;
	}

	public void setEv_content(String ev_content) {
		this.ev_content = ev_content;
	}

	public String getEv_sdate() {
		return ev_sdate;
	}

	public void setEv_sdate(String ev_sdate) {
		this.ev_sdate = ev_sdate;
	}

	public String getEv_edate() {
		return ev_edate;
	}

	public void setEv_edate(String ev_edate) {
		this.ev_edate = ev_edate;
	}

	public String getEv_status() {
		return ev_status;
	}

	public void setEv_status(String ev_status) {
		this.ev_status = ev_status;
	}

	public String getEv_img() {
		return ev_img;
	}

	public void setEv_img(String ev_img) {
		this.ev_img = ev_img;
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
		return "Ev_boardVO [ev_num=" + ev_num + ", ev_title=" + ev_title + ", ev_content=" + ev_content + ", ev_sdate="
				+ ev_sdate + ", ev_edate=" + ev_edate + ", ev_status=" + ev_status + ", ev_img=" + ev_img
				+ ", uploadFile=" + uploadFile + ", searchCondition=" + searchCondition + ", searchKeyword="
				+ searchKeyword + ", start=" + start + ", listCount=" + listCount + ", rowno=" + rowno + "]";
	}
}
