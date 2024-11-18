package com.movie.pang.chart;

public class TicketRatioVO {
	private String movName;
	private String movGenre;
	private int watNum;
	private int movScore;
	public String getMovName() {
		return movName;
	}
	public void setMovName(String movName) {
		this.movName = movName;
	}
	public String getMovGenre() {
		return movGenre;
	}
	public void setMovGenre(String movGenre) {
		this.movGenre = movGenre;
	}
	public int getWatNum() {
		return watNum;
	}
	public void setWatNum(int watNum) {
		this.watNum = watNum;
	}
	public int getMovScore() {
		return movScore;
	}
	public void setMovScore(int movScore) {
		this.movScore = movScore;
	}
	@Override
	public String toString() {
		return "TicketRatioVO [movName=" + movName + ", movGenre=" + movGenre + ", watNum=" + watNum + ", movScore="
				+ movScore + "]";
	}

}
