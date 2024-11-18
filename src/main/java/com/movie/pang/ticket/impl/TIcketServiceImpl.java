package com.movie.pang.ticket.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.movie.pang.chart.AlreadyTicketVO;
import com.movie.pang.chart.PaymentDateVO;
import com.movie.pang.coupon.CouponVO;
import com.movie.pang.mem.MemVO;
import com.movie.pang.mov.Mov_moviesVO;
import com.movie.pang.ticket.TicketService;
import com.movie.pang.ticket.TicketVO;

@Service("ticketService")
public class TIcketServiceImpl implements TicketService {
	
	@Autowired
	private TicketDAOMybatis ticketDAO;

	@Override
	   public int getUseMemWeekCnt() {
	     return ticketDAO.getUseMemWeekCnt();
	}

	@Override
	   public int getUseMemMonthCnt() {
	     return ticketDAO.getUseMemMonthCnt();
	}

	@Override
	   public int getUseMemYearCnt() {
	     return ticketDAO.getUseMemYearCnt();
	}
	@Override
	public void insertTicket(TicketVO vo) {
		ticketDAO.insertTicket(vo);
		
	}

	@Override
	public void updateTicket(TicketVO vo) {
		
	}

	@Override
	public void deleteTicket(TicketVO vo) {
		
	}

	@Override
	public TicketVO getTicket(TicketVO vo) {
		return null;
	}

	@Override
	public TicketVO getDetailTicket(TicketVO vo) {
		return null;
	}

	@Override
	public List<TicketVO> getTicketList(TicketVO vo) {
		return null;
	}
	
	// 번호가져오기
	@Override
	public int getTicNum() {
		return ticketDAO.getTicNum();
	}
	// 영화 번호 가져오기
	@Override
	public int getMovNum(TicketVO vo) {
		return ticketDAO.getMovNum(vo);
	}
	// 마이포인트 정보 가져오기
	@Override
	public int findMyPoint(MemVO vo) {
		return ticketDAO.findMyPoint(vo);
	}

	@Override
	public List<CouponVO> findCoupon(MemVO vo) {
		// TODO Auto-generated method stub
		return ticketDAO.findCoupon(vo);
	}

	@Override
	public List<PaymentDateVO> findTicketDays(String startWeek, String endWeek) {
		return ticketDAO.findTicketDays(startWeek,endWeek);
	}

	public List<AlreadyTicketVO> getTicketMypage(TicketVO vo){
		return ticketDAO.getTicketMypage(vo);

	}

	@Override
	public List<AlreadyTicketVO> getPastTicket(TicketVO vo) {
		return ticketDAO.getPastTicket(vo);
	}


	

}
