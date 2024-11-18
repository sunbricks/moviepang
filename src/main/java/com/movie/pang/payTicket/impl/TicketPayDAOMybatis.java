package com.movie.pang.payTicket.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.movie.pang.chart.ChartAgeVO;
import com.movie.pang.chart.TicketRatioVO;
import com.movie.pang.chart.canceledTicketVO;
import com.movie.pang.mem.MemVO;
import com.movie.pang.payTicket.TicketPayVO;
import com.movie.pang.ticket.TicketVO;

@Repository
public class TicketPayDAOMybatis {

	@Autowired
	SqlSessionTemplate mybatis;

	public Map<String, String> getPopularMovie() {
	     return mybatis.selectOne("ticketPayDAO.popularMovie");
	}

	public void ticketPay(TicketPayVO vo) {
		mybatis.insert("ticketPayDAO.ticketPay", vo);
	};
	
	public int getPayNum() {
		int num = mybatis.selectOne("ticketPayDAO.getPayNum");
		return num;
	};
	
	public int getMovNum(TicketPayVO vo) {
		return mybatis.selectOne("ticketPayDAO.getMovNum", vo);
	};
	
	public void updateToUsedCoupon(String cup_num) {
		Map<String, Object> params = new HashMap<>();
		params.put("cup_num", cup_num);
		mybatis.update("ticketPayDAO.updateToUsedCoupon",cup_num);
		
	};
	public int getYearTicketSales() {
	      return mybatis.selectOne("ticketPayDAO.getYearTicketSales");
	}
	
	public int getWeeklyTicketSales() {
	      return mybatis.selectOne("ticketPayDAO.selectWeeklyTicketSales");
	}
	
	public int getMonthlyTicketSales() {
	      return mybatis.selectOne("ticketPayDAO.selectMonthlyTicketSales");
	}

	
	public void updateToPoint(TicketPayVO vo,String Point) {
		Map<String, Object> params = new HashMap<>();
		int usePoint = Integer.parseInt(Point);
		params.put("usePoint", usePoint);
		params.put("pay_MemName", vo.getPay_MemName());
		params.put("pay_MemPhoneNumber", vo.getPay_MemPhoneNumber());
		mybatis.update("ticketPayDAO.updateToPoint",params);
	}
	
	public List<ChartAgeVO> getTicketPaymentsAll(String sunDay, String saturDay){
		Map<String, Object> params = new HashMap<>();
		params.put("sunDay", sunDay);
		params.put("saturDay", saturDay);
		System.out.println(params);
		return mybatis.selectList("ticketPayDAO.getTicketPaymentsAll",params);
	}
	
	public String findImp_Uid(TicketVO vo){
		return mybatis.selectOne("ticketPayDAO.findImp_Uid",vo);
	}
	
	public void changePay_Status(TicketVO vo) {
		mybatis.update("ticketPayDAO.changePay_Status",vo);
	}
	
	public void changeTic_Status(TicketVO vo) {
		mybatis.update("ticketPayDAO.changeTic_Status",vo);
	}
	
	public List<canceledTicketVO> getCancledData(TicketVO vo){
		return mybatis.selectList("ticketPayDAO.getCancledData",vo);
	}
	
//	영화 평점과 예매율
	public List<TicketRatioVO> getTicketRatio(String sunDay, String saturDay) {
		Map<String, Object> params = new HashMap<>();
		params.put("sunDay", sunDay);
		params.put("saturDay", saturDay);
		return mybatis.selectList("ticketPayDAO.getTicketRatio", params);
	}

	
	// 리뷰 체크 가져오기
	public int checkMovTicket(TicketPayVO vo) {
			return mybatis.selectOne("ticketPayDAO.checkMovTicket", vo);
		};
		
	public TicketPayVO getPaymentsInfo(TicketVO vo) {
		return mybatis.selectOne("ticketPayDAO.getPaymentsInfo",vo);
	}
	
	
	public void payPoint(MemVO memvo) {
		mybatis.update("ticketPayDAO.payPoint", memvo);
	}

	public void cancledPoint(MemVO memvo) {
		mybatis.update("ticketPayDAO.cancledPoint", memvo);
	}

}
