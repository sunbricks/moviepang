package com.movie.pang.coupon;

public class CouponVO {

	private String cup_num;
    private String cup_sdate;
    private String cup_edate;
    private String cup_fdate;


	private String cup_contents;
    private String cup_dc;
    private String cup_type;
    private String cup_user;
    private String cup_tf;
    
    
    private int start;
	private int listCount;
	private int rowno;
	
//	private String searchCondition;
//	private String searchKeyword;
    
	
	
	
	public String getCup_fdate() {
		return cup_fdate;
	}
	public void setCup_fdate(String cup_fdate) {
		this.cup_fdate = cup_fdate;
	}
	
	public int getStart() {
		return start;
	}
	public String getCup_num() {
		return cup_num;
	}
	public void setCup_num(String cup_num) {
		this.cup_num = cup_num;
	}
	public String getCup_sdate() {
		return cup_sdate;
	}
	public void setCup_sdate(String cup_sdate) {
		this.cup_sdate = cup_sdate;
	}
	public String getCup_edate() {
		return cup_edate;
	}
	public void setCup_edate(String cup_edate) {
		this.cup_edate = cup_edate;
	}

	public String getCup_dc() {
		return cup_dc;
	}
	public void setCup_dc(String cup_dc) {
		this.cup_dc = cup_dc;
	}
	public String getCup_type() {
		return cup_type;
	}
	public void setCup_type(String cup_type) {
		this.cup_type = cup_type;
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
	
	
	
	public String getCup_contents() {
		return cup_contents;
	}
	public void setCup_contents(String cup_contents) {
		this.cup_contents = cup_contents;
	}
	public String getCup_user() {
		return cup_user;
	}
	public void setCup_user(String cup_user) {
		this.cup_user = cup_user;
	}
	public String getCup_tf() {
		return cup_tf;
	}
	public void setCup_tf(String cup_tf) {
		this.cup_tf = cup_tf;
	}
	
	
@Override
public String toString() {
	return "CouponVO [cup_num=" + cup_num + ", cup_sdate=" + cup_sdate + ", cup_edate=" + cup_edate + ", cup_fdate="
			+ cup_fdate + ", cup_contents=" + cup_contents + ", cup_dc=" + cup_dc + ", cup_type=" + cup_type
			+ ", cup_user=" + cup_user + ", cup_tf=" + cup_tf + ", start=" + start + ", listCount=" + listCount
			+ ", rowno=" + rowno + "]";
}
    
}
