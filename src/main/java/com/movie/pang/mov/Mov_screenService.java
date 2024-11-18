package com.movie.pang.mov;

import java.util.List;
import java.util.Map;

import com.movie.pang.chart.NowScreenedVO;
import com.movie.pang.ticket.TicketVO;

public interface Mov_screenService {
	
	//CRUD 기능의 메소드 구현
		//상영 정보 등록
		int insertMovScreen(Mov_screenVO vo);

		//상영 정보 수정
		void updateMovScreen(Mov_screenVO vo);

		//상영 정보 삭제
		void deleteMovScreen(Mov_screenVO vo);

		//상영 정보 상세 조회
		Mov_screenVO selectMovScreen(Mov_screenVO vo);

		//상영 정보 조회
		List<Mov_screenVO> selectMovScreenList();
		
		// 상영 영화 날짜 정보 조회
		List<String> findMovScreenDate(Mov_screenVO vo);
		
		// 상영 영화 시간 정보 보회
		List<Mov_screenVO> findMovScreenTime(Mov_screenVO vo);
		
		// 영화 정보 반환
		Mov_moviesVO getMovInfo(Mov_screenVO vo);
		
		// 영화관 정보 반환
		String getRoomInfo(Mov_screenVO vo);
		
		// 조건 있는 상영 정보 반환
		List<Mov_screenVO> findMovScreenList(String condition, String value);
		
		// 영화 제목 반환 
		List<Mov_moviesVO> getMovNameList();
		
		// 해당 시간 사용 중인 좌석 수 
		List<Map<String, Object>> getRoomCnt(Mov_screenVO vo);

		// 영화좌석 정보 가져오기
		List<String> alearedySelectedSeats(TicketVO vo);
		
		// 영화 상영 가져오기
		List<NowScreenedVO> nowScreened();
		
		// 상영 예정작 가져오기
		List<Mov_moviesVO> willScreened();
		
		//추천 영화 리스트 반환 
		List<NowScreenedVO> recommendedMov();
		
}
