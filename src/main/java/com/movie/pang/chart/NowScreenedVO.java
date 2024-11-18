package com.movie.pang.chart;

// com.movie.pang.chart.NowScreenedVO
public class NowScreenedVO {
	
	private String mov_Post;
	private String mov_Nm;
	private String mov_Con1;
	private int total;
	private String mov_Num;
	private int avg_rating;
	
	
	public String getMov_Num() {
        return mov_Num;
    }
    public void setMov_Num(String mov_Num) {
        this.mov_Num = mov_Num;
    }

	
	public String getMov_Post() {
		return mov_Post;
	}
	public void setMov_Post(String mov_Post) {
		this.mov_Post = mov_Post;
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
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public int getAvg_rating() {
		return avg_rating;
	}
	public void setAvg_rating(int avg_rating) {
		this.avg_rating = avg_rating;
	}
	@Override
	public String toString() {
		return "NowScreenedVO [mov_Post=" + mov_Post + ", mov_Nm=" + mov_Nm + ", mov_Con1=" + mov_Con1 + ", total="
				+ total + ", mov_Num=" + mov_Num + ", avg_rating=" + avg_rating + "]";
	}

}
