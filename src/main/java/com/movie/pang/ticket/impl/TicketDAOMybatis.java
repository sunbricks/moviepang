package com.movie.pang.ticket.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.movie.pang.chart.AlreadyTicketVO;
import com.movie.pang.chart.PaymentDateVO;
import com.movie.pang.coupon.CouponVO;
import com.movie.pang.mem.MemVO;
import com.movie.pang.ticket.TicketVO;

@Repository
public class TicketDAOMybatis {
	
	@Autowired
	private SqlSessionTemplate mybatis;

	public int getUseMemWeekCnt() {
	      return mybatis.selectOne("ticketDAO.getUseMemWeekCnt");
	}

	public int getUseMemMonthCnt() {
	      return mybatis.selectOne("ticketDAO.getUseMemMonthCnt");
	}

	public int getUseMemYearCnt() {
	      return mybatis.selectOne("ticketDAO.getUseMemYearCnt");
	}

	// 쿠폰 정보 가져오기
	public List<CouponVO> findCoupon(MemVO vo){
		return mybatis.selectList("ticketDAO.findCoupon",vo);
	};
	
	// 마이포인트 정보 받아오기
	public int findMyPoint(MemVO vo) {
		return mybatis.selectOne("ticketDAO.findMyPoint",vo);
	}
	// 번호 받아오기
	public int getTicNum() {
		return mybatis.selectOne("ticketDAO.getTicNum");
	}
//	// 예매 등록
	public void insertTicket(TicketVO vo) {
		mybatis.insert("ticketDAO.insertTicket",vo);
	};
	
	// 영화 번호 가져오기
	public int getMovNum(TicketVO vo) {
		return mybatis.selectOne("ticketDAO.getMovNum",vo);
	}
	
	public List<PaymentDateVO> findTicketDays(String startWeek, String endWeek){
		Map<String, Object> params = new HashMap<>();
		params.put("startWeek", startWeek);
		params.put("endWeek", endWeek);
		return mybatis.selectList("ticketDAO.findTicketDays", params);
	}
	
	public List<AlreadyTicketVO> getTicketMypage(TicketVO vo){
		return mybatis.selectList("ticketDAO.getTicketMypage",vo);
	}
	
	
	public List<AlreadyTicketVO> getPastTicket(TicketVO vo) {
		return mybatis.selectList("ticketDAO.getPastTicket",vo);
	}

	
	
	

	
}
