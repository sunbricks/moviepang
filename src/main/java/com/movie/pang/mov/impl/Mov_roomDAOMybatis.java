package com.movie.pang.mov.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.movie.pang.mov.Mov_roomVO;
import com.movie.pang.ticket.TicketVO;

@Repository
public class Mov_roomDAOMybatis {
	
	@Autowired
	private SqlSessionTemplate mrMybatis;
	
	public List<Mov_roomVO> selectSeat(TicketVO vo) {
		return mrMybatis.selectList("ticketDAO.selectSeat", vo);
	}

}
