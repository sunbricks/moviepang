package com.movie.pang.ticket;

import java.sql.Date;

public class TicketVO {
    private int tic_Num;
    private String tic_Id;
    private String tic_MemName;
    private String tic_MemId;
    public String getTic_MemId() {
		return tic_MemId;
	}
	public void setTic_MemId(String tic_MemId) {
		this.tic_MemId = tic_MemId;
	}
	private String tic_MovName;
    private String tic_MovRT;
    private String tic_MovRate;
    private String tic_MovGenre;
    private String tic_MovRoom;
    private String tic_WatDate;
    private String tic_WatTime;
    private int tic_WatNum;
    private String tic_RoomSeat;
    
	private String tic_SeatType;
    private int tic_Price;
    private String tic_Status;
    private String tic_CancledDate;
    
    
    public String getTic_CancledDate() {
		return tic_CancledDate;
	}
	public void setTic_CancledDate(String tic_CancledDate) {
		this.tic_CancledDate = tic_CancledDate;
	}

	public int getTic_Num() {
		return tic_Num;
	}
	public String getTic_Id() {
		return tic_Id;
	}
	public void setTic_Id(String tic_Id) {
		this.tic_Id = tic_Id;
	}
	public void setTic_Num(int tic_Num) {
		this.tic_Num = tic_Num;
	}
	
	public String getTic_MemName() {
		return tic_MemName;
	}
	public void setTic_MemName(String tic_MemName) {
		this.tic_MemName = tic_MemName;
	}
	public String getTic_MovName() {
		return tic_MovName;
	}
	public void setTic_MovName(String tic_MovName) {
		this.tic_MovName = tic_MovName;
	}
	public String getTic_MovRT() {
		return tic_MovRT;
	}
	public void setTic_MovRT(String tic_MovRT) {
		this.tic_MovRT = tic_MovRT;
	}
	public String getTic_MovRate() {
		return tic_MovRate;
	}
	public void setTic_MovRate(String tic_MovRate) {
		this.tic_MovRate = tic_MovRate;
	}
	public String getTic_MovGenre() {
		return tic_MovGenre;
	}
	public void setTic_MovGenre(String tic_MovGenre) {
		this.tic_MovGenre = tic_MovGenre;
	}
	public String getTic_MovRoom() {
		return tic_MovRoom;
	}
	public void setTic_MovRoom(String tic_MovRoom) {
		this.tic_MovRoom = tic_MovRoom;
	}
	public String getTic_WatDate() {
		return tic_WatDate;
	}
	public void setTic_WatDate(String tic_WatDate) {
		this.tic_WatDate = tic_WatDate;
	}
	public String getTic_WatTime() {
		return tic_WatTime;
	}
	public void setTic_WatTime(String tic_WatTime) {
		this.tic_WatTime = tic_WatTime;
	}
	public int getTic_WatNum() {
		return tic_WatNum;
	}
	public void setTic_WatNum(int tic_WatNum) {
		this.tic_WatNum = tic_WatNum;
	}
	public String getTic_RoomSeat() {
		return tic_RoomSeat;
	}
	public void setTic_RoomSeat(String tic_RoomSeat) {
		this.tic_RoomSeat = tic_RoomSeat;
	}
	public String getTic_SeatType() {
		return tic_SeatType;
	}
	public void setTic_SeatType(String tic_SeatType) {
		this.tic_SeatType = tic_SeatType;
	}
	public int getTic_Price() {
		return tic_Price;
	}
	public void setTic_Price(int tic_Price) {
		this.tic_Price = tic_Price;
	}
	public String getTic_Status() {
		return tic_Status;
	}
	public void setTic_Status(String tic_Status) {
		this.tic_Status = tic_Status;
	}
	@Override
	public String toString() {
		return "TicketVO [tic_Num=" + tic_Num + ", tic_Id=" + tic_Id + ", tic_MemName=" + tic_MemName + ", tic_MemId="
				+ tic_MemId + ", tic_MovName=" + tic_MovName + ", tic_MovRT=" + tic_MovRT + ", tic_MovRate="
				+ tic_MovRate + ", tic_MovGenre=" + tic_MovGenre + ", tic_MovRoom=" + tic_MovRoom + ", tic_WatDate="
				+ tic_WatDate + ", tic_WatTime=" + tic_WatTime + ", tic_WatNum=" + tic_WatNum + ", tic_RoomSeat="
				+ tic_RoomSeat + ", tic_SeatType=" + tic_SeatType + ", tic_Price=" + tic_Price + ", tic_Status="
				+ tic_Status + ", tic_CancledDate=" + tic_CancledDate + "]";
	}
	
}