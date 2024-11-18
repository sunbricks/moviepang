package com.movie.pang.chart;

public class ChartAgeVO {
	
	private String cha_memId;
	private String cha_memNm;
	private String cha_memTel;
	private String cha_memBir;
	private int cha_memAge;
	private String cha_payPaymentsDate;
	
	public String getCha_payPaymentsDate() {
		return cha_payPaymentsDate;
	}

	public void setCha_payPaymentsDate(String cha_payPaymentsDate) {
		this.cha_payPaymentsDate = cha_payPaymentsDate;
	}

	public String getCha_memId() {
		return cha_memId;
	}
	
	public void setCha_memId(String cha_memId) {
		this.cha_memId = cha_memId;
	}
	
	public String getCha_memNm() {
		return cha_memNm;
	}
	
	public void setCha_memNm(String cha_memNm) {
		this.cha_memNm = cha_memNm;
	}
	
	public String getCha_memTel() {
		return cha_memTel;
	}
	
	public void setCha_memTel(String cha_memTel) {
		this.cha_memTel = cha_memTel;
	}
	
	public String getCha_memBir() {
		return cha_memBir;
	}
	public void setCha_memBir(String cha_memBir) {
		this.cha_memBir = cha_memBir;
	}
	public int getCha_memAge() {
		return cha_memAge;
	}
	public void setCha_memAge(int cha_memAge) {
		this.cha_memAge = cha_memAge;
	}

	@Override
	public String toString() {
		return "ChartAgeVO [cha_memId=" + cha_memId + ", cha_memNm=" + cha_memNm + ", cha_memTel=" + cha_memTel
				+ ", cha_memBir=" + cha_memBir + ", cha_memAge=" + cha_memAge + ", cha_payPaymentsDate="
				+ cha_payPaymentsDate + "]";
	}
	
	
	
}
