package com.movie.pang.mov;

import java.util.List;

import com.movie.pang.ticket.TicketVO;

public interface Mov_roomService {
	
	//영화관 정보
	List<Mov_roomVO> selectSeat(TicketVO vo);
}
