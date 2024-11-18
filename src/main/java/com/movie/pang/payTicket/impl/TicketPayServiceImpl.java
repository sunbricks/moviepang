package com.movie.pang.payTicket.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.movie.pang.chart.ChartAgeVO;
import com.movie.pang.chart.TicketRatioVO;
import com.movie.pang.chart.canceledTicketVO;
import com.movie.pang.mem.MemVO;
import com.movie.pang.payTicket.TicketPayService;
import com.movie.pang.payTicket.TicketPayVO;
import com.movie.pang.ticket.TicketVO;

@Service("ticketPayService")
public class TicketPayServiceImpl implements TicketPayService{

	@Autowired
	private TicketPayDAOMybatis ticketPayDAO;
	
	public void ticketPay(TicketPayVO vo) {
		ticketPayDAO.ticketPay(vo);
	}
	
	@Override
	public Map<String, String> getPopularMovie() {
	     return ticketPayDAO.getPopularMovie();
	}
	// 예매 결제 마지막 번호 가져오기 
	@Override
	public int getPayNum() {
		return ticketPayDAO.getPayNum();
	}
	// 예매 결제 영화번호 가져오기

	@Override
	public int getMovNum(TicketPayVO vo) {
		return ticketPayDAO.getMovNum(vo);
	}

	@Override
	public void updateToUsedCoupon(String cup_num) {
		ticketPayDAO.updateToUsedCoupon(cup_num);
		
	}
	
	// 영화데이터 정보 가져오기
	@Override
	public List<ChartAgeVO> getTicketPaymentsAll(String sunDay,String saturDay) {
		return ticketPayDAO.getTicketPaymentsAll(sunDay, saturDay);
	};
	
	

	@Override
	public String findImp_Uid(TicketVO vo) {
		return ticketPayDAO.findImp_Uid(vo);
	}

	@Override
	public void changePay_Status(TicketVO vo) {
		ticketPayDAO.changePay_Status(vo);
		
	}

	@Override
	public void changeTic_Status(TicketVO vo) {
		ticketPayDAO.changeTic_Status(vo);
	};
	
	@Override
	public List<canceledTicketVO> getCancledData(TicketVO vo) {
		return ticketPayDAO.getCancledData(vo);
	}

	@Override
	public List<TicketRatioVO> getTicketRatio(String sunday, String saturDay) {
		return ticketPayDAO.getTicketRatio(sunday, saturDay);
	}

	@Override
	public int checkMovTicket(TicketPayVO vo) {
		return ticketPayDAO.checkMovTicket(vo);
	}

	@Override
	public TicketPayVO getPaymentsInfo(TicketVO vo) {
		return ticketPayDAO.getPaymentsInfo(vo);
	}

	@Override
	public void payPoint(MemVO memvo) {
		ticketPayDAO.payPoint(memvo);
	}

	@Override
	public void cancledPoint(MemVO memvo) {
		ticketPayDAO.cancledPoint(memvo);
	}

	@Override
	public int getYearTicketSales() {
		// TODO Auto-generated method stub
		return ticketPayDAO.getYearTicketSales();
	}

	@Override
	public int getWeeklyTicketSales() {
		// TODO Auto-generated method stub
		return ticketPayDAO.getWeeklyTicketSales();
	}

	@Override
	public int getMonthlyTicketSales() {
		// TODO Auto-generated method stub
		return ticketPayDAO.getMonthlyTicketSales();
	}
	
}
