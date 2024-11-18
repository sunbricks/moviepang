package com.movie.pang.ticket;

import java.util.List;

import com.movie.pang.chart.AlreadyTicketVO;
import com.movie.pang.chart.PaymentDateVO;
import com.movie.pang.coupon.CouponVO;
import com.movie.pang.mem.MemVO;
import com.movie.pang.mov.Mov_moviesVO;

public interface TicketService {
	
	List<CouponVO> findCoupon(MemVO vo);
	
	// 마이포인트 정보 가져오기
	int findMyPoint(MemVO vo);
	
	// 끝번호 가져오기
	int getTicNum();
	
	// 영화 번호 가져오기
	int getMovNum(TicketVO vo);
	
	// 예매 등록
	void insertTicket(TicketVO vo);
	
	// 예매 수정
	void updateTicket(TicketVO vo);
	
	// 예매 삭제
	void deleteTicket(TicketVO vo);
	
	// 예매 조회(소비자)
	TicketVO getTicket(TicketVO vo);
	
	// 예매 상세 조회(관리자)
	TicketVO getDetailTicket(TicketVO vo);
	
	// 예매 목록 조회(관리자)
	List<TicketVO> getTicketList(TicketVO vo);
	
	// 날짜 요일 가져오기
	List<PaymentDateVO> findTicketDays(String startWeek, String endWeek);
	
	// 마이페이지에 티켓 정보 가져오기
	List<AlreadyTicketVO> getTicketMypage(TicketVO vo);
	
	// 과거 이용 정보 가져오기
	List<AlreadyTicketVO> getPastTicket(TicketVO vo);
	


	// 이용 관객수 카운트
	// 주간 이용관객수
	int getUseMemWeekCnt();
		
	// 월간 이용관객수
	int getUseMemMonthCnt();
		
	// 연간 이용관객수
	int getUseMemYearCnt();

	
	
	
	
}

