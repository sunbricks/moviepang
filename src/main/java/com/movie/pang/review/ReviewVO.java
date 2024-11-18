package com.movie.pang.review;

public class ReviewVO {
	
	String review_num;
	String review_name;
	String review_review;
	String review_nick;
	String review_date;
	String review_paycheck;
	String review_rerate;
	String review_id;
	
	public String getReview_id() {
		return review_id;
	}
	public void setReview_id(String review_id) {
		this.review_id = review_id;
	}
	public String getReview_num() {
		return review_num;
	}
	public void setReview_num(String review_num) {
		this.review_num = review_num;
	}
	public String getReview_name() {
		return review_name;
	}
	public void setReview_name(String review_name) {
		this.review_name = review_name;
	}
	
	public String getReview_review() {
		return review_review;
	}
	public void setReview_review(String review_review) {
		this.review_review = review_review;
	}
	public String getReview_nick() {
		return review_nick;
	}
	public void setReview_nick(String review_nick) {
		this.review_nick = review_nick;
	}
	public String getReview_date() {
		return review_date;
	}
	public void setReview_date(String review_date) {
		this.review_date = review_date;
	}
	public String getReview_paycheck() {
		return review_paycheck;
	}
	public void setReview_paycheck(String review_paycheck) {
		this.review_paycheck = review_paycheck;
	}
	public String getReview_rerate() {
		return review_rerate;
	}
	public void setReview_rerate(String review_rerate) {
		this.review_rerate = review_rerate;
	}
	@Override
	public String toString() {
		return "ReviewVO [review_num=" + review_num + ", review_name=" + review_name + ", review_review="
				+ review_review + ", review_nick=" + review_nick + ", review_date=" + review_date + ", review_paycheck="
				+ review_paycheck + ", review_rerate=" + review_rerate + ", review_id=" + review_id + "]";
	}
	
	
	
}
