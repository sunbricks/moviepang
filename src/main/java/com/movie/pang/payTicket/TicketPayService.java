package com.movie.pang.payTicket;

import java.util.List;
import java.util.Map;

import com.movie.pang.chart.ChartAgeVO;
import com.movie.pang.chart.TicketRatioVO;
import com.movie.pang.chart.canceledTicketVO;
import com.movie.pang.mem.MemVO;
import com.movie.pang.ticket.TicketVO;

public interface TicketPayService {

	void ticketPay(TicketPayVO vo);

	// 예매 결제의 마지막 번호 가져오기
	int getPayNum();

	// 영화 번호 가져오기
	int getMovNum(TicketPayVO vo);

	// 쿠폰 사용
	void updateToUsedCoupon(String cup_num);

	List<ChartAgeVO> getTicketPaymentsAll(String sunDay, String saturDay);

	String findImp_Uid(TicketVO vo);

	void changePay_Status(TicketVO vo);

	void changeTic_Status(TicketVO vo);

	List<canceledTicketVO> getCancledData(TicketVO vo);

	List<TicketRatioVO> getTicketRatio(String sunday, String saturDay);

	// 리뷰 체크 가져오기
	int checkMovTicket(TicketPayVO vo);

	TicketPayVO getPaymentsInfo(TicketVO vo);

	void payPoint(MemVO memvo);

	void cancledPoint(MemVO memvo);
	
	Map<String, String> getPopularMovie();
	int getYearTicketSales();
	int getWeeklyTicketSales();
	int getMonthlyTicketSales();

}
