package com.movie.pang.mov;

public class Mov_roomVO {

	private int mov_rNum;
	private String mov_rName;
	private String mov_rSeatRow;
	private int mov_rSeatCol;
	private String mov_rSeatPrice;
	private String mov_rType;
	private int mov_rPrice;
	
	public int getMov_rNum() {
		return mov_rNum;
	}

	public void setMov_rNum(int mov_rNum) {
		this.mov_rNum = mov_rNum;
	}

	public String getMov_rName() {
		return mov_rName;
	}

	public void setMov_rName(String mov_rName) {
		this.mov_rName = mov_rName;
	}

	public String getMov_rSeatRow() {
		return mov_rSeatRow;
	}

	public void setMov_rSeatRow(String mov_rSeatRow) {
		this.mov_rSeatRow = mov_rSeatRow;
	}

	public int getMov_rSeatCol() {
		return mov_rSeatCol;
	}

	public void setMov_rSeatCol(int mov_rSeatcol) {
		this.mov_rSeatCol = mov_rSeatcol;
	}

	public String getMov_rSeatPrice() {
		return mov_rSeatPrice;
	}

	public void setMov_rSeatPrice(String mov_rSeatPrice) {
		this.mov_rSeatPrice = mov_rSeatPrice;
	}

	public String getMov_rType() {
		return mov_rType;
	}

	public void setMov_rType(String mov_rType) {
		this.mov_rType = mov_rType;
	}

	public int getMov_rPrice() {
		return mov_rPrice;
	}

	public void setMov_rPrice(int mov_rPrice) {
		this.mov_rPrice = mov_rPrice;
	}


	@Override
	public String toString() {
		return "Mov_roomVO [mov_rNum=" + mov_rNum + ", mov_rName=" + mov_rName + ", mov_rSeatRow=" + mov_rSeatRow
				+ ", mov_rSeatCol=" + mov_rSeatCol + ", mov_rSeatPrice=" + mov_rSeatPrice + ", mov_rType=" + mov_rType
				+ ", mov_rPrice=" + mov_rPrice + "]";
	}
		
	
	
}
