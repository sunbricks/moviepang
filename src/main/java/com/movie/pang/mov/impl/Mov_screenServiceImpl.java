package com.movie.pang.mov.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.movie.pang.chart.NowScreenedVO;
import com.movie.pang.mov.Mov_moviesVO;
import com.movie.pang.mov.Mov_screenService;
import com.movie.pang.mov.Mov_screenVO;
import com.movie.pang.ticket.TicketVO;

@Service("mov_screenService")
public class Mov_screenServiceImpl implements Mov_screenService{
	
	@Autowired
	private Mov_screenDAOMybatis movScreenDAO;
	
	//CRUD 기능의 메소드 구현
	//상영 정보 등록
	@Override
	public int insertMovScreen(Mov_screenVO vo) {
		return movScreenDAO.insertMovScreen(vo);
	};

	//상영 정보 수정
	@Override
	public void updateMovScreen(Mov_screenVO vo) {
		movScreenDAO.updateMovScreen(vo);
	};

	//상영 정보 삭제
	@Override
	public void deleteMovScreen(Mov_screenVO vo) {
		movScreenDAO.deleteMovScreen(vo);
	};

	//상영 정보 상세 조회
//	@Override
//	public Mov_screenVO getMovScreen(Mov_screenVO vo);

	//상영 정보 조회
	@Override
	public List<Mov_screenVO> selectMovScreenList(){
		return movScreenDAO.selectMovScreenList();
	}
	
	//상영 정보 상세 조회
	@Override
	public Mov_screenVO selectMovScreen(Mov_screenVO vo) {
		return movScreenDAO.selectMovScreen(vo);
	}

	@Override
	public List<String> findMovScreenDate(Mov_screenVO vo) {
		// TODO Auto-generated method stub
		return movScreenDAO.findMovScreenDate(vo);
	}

	@Override
	public List<Mov_screenVO> findMovScreenTime(Mov_screenVO vo) {
		// TODO Auto-generated method stub
		return movScreenDAO.findMovScreenTime(vo);
	}

	@Override
	public Mov_moviesVO getMovInfo(Mov_screenVO vo) {
		
		return movScreenDAO.getMovInfo(vo);
	}

	// 상영관 정보 가져오기
	@Override
	public String getRoomInfo(Mov_screenVO vo) {
		return movScreenDAO.getRoomInfo(vo);
	}

	@Override
	public List<Mov_screenVO> findMovScreenList(String condition, String value) {
		
		return movScreenDAO.findMovScreenList(condition, value);
	}

	@Override
	public List<Mov_moviesVO> getMovNameList() {
		return movScreenDAO.getMovNameList();
	}
	
	// 예매된 좌석 수 계산용
	@Override
	public List<Map<String, Object>> getRoomCnt(Mov_screenVO vo) {
		return movScreenDAO.getRoomCnt(vo);
	};

	@Override
	public List<String> alearedySelectedSeats(TicketVO vo) {
		return movScreenDAO.alearedySelectedSeats(vo);
	}

	@Override
	public List<NowScreenedVO> nowScreened() {
		return movScreenDAO.nowScreened();
	}
	
	@Override
	public List<Mov_moviesVO> willScreened() {
		return movScreenDAO.willScreened();
	}
	// 상영 정보 리스트 반환
	@Override
	public List<NowScreenedVO> recommendedMov() {
		return movScreenDAO.recommendedMov();
	}

}
