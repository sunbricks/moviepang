package com.movie.pang.mov;

import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class Mov_screenVO {

	private int mov_sNum;
	private String mov_sName;
	private String mov_sMovieName;
	private String mov_sDate;
	private String mov_sTime;
	private String mov_sRegistDate;

	

	public int getMov_sNum() {
		return mov_sNum;
	}
	public void setMov_sNum(int mov_sNum) {
		this.mov_sNum = mov_sNum;
	}
	public String getMov_sName() {
		return mov_sName;
	}
	public void setMov_sName(String mov_sName) {
		this.mov_sName = mov_sName;
	}
	public String getMov_sMovieName() {
		return mov_sMovieName;
	}
	public void setMov_sMovieName(String mov_sMovieName) {
		this.mov_sMovieName = mov_sMovieName;
	}
	

	public String getMov_sDate() {
		return mov_sDate;
	}
	public void setMov_sDate(String mov_sDate) {
		this.mov_sDate = mov_sDate;
	}
	public String getMov_sTime() {
		return mov_sTime;
	}
	public void setMov_sTime(String mov_sTime) {
		this.mov_sTime = mov_sTime;
	}
	public String getMov_sRegistDate() {
		return mov_sRegistDate;
	}
	public void setMov_sRegistDate(String mov_sRegistDate) {
		this.mov_sRegistDate = mov_sRegistDate;
	}

	@Override
	public String toString() {
		return "Mov_screenVO [ mov_sName=" + mov_sName + ", mov_sMovieName=" + mov_sMovieName
				+ ", mov_sDate=" + mov_sDate + ", mov_sTime=" + mov_sTime + ", mov_sRegistDate=" + mov_sRegistDate
				+ "]";
	}
	
	
}
