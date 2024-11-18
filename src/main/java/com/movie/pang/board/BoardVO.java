package com.movie.pang.board;

import java.sql.Date;

public class BoardVO {
	private int bn_num;
	private String bn_type;
	private String bn_title;
	private String bn_content;
	private String bn_date;
	
	//마이바티스를 사용하기 위해 필요한 멤버필드
	private String searchCondition;
	private String searchKeyword;
	
	private int start;
	private int listCount;
	private int rowno;	
	
	public int getBn_num() {
		return bn_num;
	}
	public void setBn_num(int bn_num) {
		this.bn_num = bn_num;
	}
	public String getBn_type() {
		return bn_type;
	}
	public void setBn_type(String bn_type) {
		this.bn_type = bn_type;
	}
	public String getBn_title() {
		return bn_title;
	}
	public void setBn_title(String bn_title) {
		this.bn_title = bn_title;
	}
	public String getBn_content() {
		return bn_content;
	}
	public void setBn_content(String bn_content) {
		this.bn_content = bn_content;
	}
	public String getBn_date() {
		return bn_date;
	}
	public void setBn_date(String bn_date) {
		this.bn_date = bn_date;
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
	public void setListCoun(int listCount) {
		this.listCount = listCount;
	}
	
	public int getRowno() {
		return rowno;
	}
	public void setRowno(int rowno) {
		this.rowno = rowno;
	}
	public void setListCount(int listCount) {
		this.listCount = listCount;
	}
	
	@Override
	public String toString() {
		return "BoardVO [bn_num=" + bn_num + ", bn_type=" + bn_type + ", bn_title=" + bn_title + ", bn_content="
				+ bn_content + ", bn_date=" + bn_date + ", searchCondition=" + searchCondition + ", searchKeyword="
				+ searchKeyword + ", start=" + start + ", listCount=" + listCount + ", rowno=" + rowno + "]";
	}
	
}
