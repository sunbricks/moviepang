package com.movie.pang.board;

public class PageInfo {

	private int currentPage; // 현재 페이지
	private int maxPage; //총 버튼 갯수 페이지
	private int startPage; // 한 번에 보여질 페이지 버튼에서 처음 버튼 수
	private int endPage; // 한 번에 보여질 페이지 버튼에서 마지막 버튼 수
	private int listCount; //한 번에 보여질 목록 갯수
	private int pageSize; //한 번에 보여질 페이지버튼 갯수
	private int startList; //한 번에 보여질 목록에서 처음 목록 번호
	private int listTotalCount;
	
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getMaxPage() {
		return maxPage;
	}
	public void setMaxPage(int maxPage) {
		this.maxPage = maxPage;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public int getListCount() {
		return listCount;
	}
	public void setListCount(int listCount) {
		this.listCount = listCount;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getStartList() {
		return startList;
	}
	public void setStartList(int startList) {
		this.startList = startList;
	}
	
	public int getListTotalCount() {
		return listTotalCount;
	}
	public void setListTotalCount(int listTotalCount) {
		this.listTotalCount = listTotalCount;
		//총 페이지 수 설정
		int maxPage = listTotalCount % listCount==0 ? (int) listTotalCount/listCount : (int) listTotalCount/listCount+1;
		setMaxPage(maxPage);
		
		//건너띄는 번호 지정하기
		int startList = (currentPage-1) * listCount ;
		setStartList(startList);
	}
	
	
	@Override
	public String toString() {
		return "PageInfo [현재페이지 번호=" + currentPage + ", 총 페이지 갯수=" + maxPage + ", 시작페이지번호=" + startPage
				+ ", 끝페이지 번호=" + endPage + ", 한페이지에 보여질 목록 갯수=" + listCount + ", 한번에 보여질 버튼 갯수=" + pageSize 
				+ ", 한 페이지에서 시작되는 처음 목록번호=" + startList + ", 총 목록 갯수=" + listTotalCount + "]";
	}

}