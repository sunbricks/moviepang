package com.movie.pang.mov.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.movie.pang.mov.Mov_roomService;
import com.movie.pang.mov.Mov_roomVO;
import com.movie.pang.ticket.TicketVO;

@Service("mov_roomService")
public class Mov_roomServiceImpl implements Mov_roomService{
	@Autowired
	private Mov_roomDAOMybatis mov_roomDAOMybatis;
	
	@Override
	public List<Mov_roomVO> selectSeat(TicketVO vo) {
		return mov_roomDAOMybatis.selectSeat(vo);
	}

}
