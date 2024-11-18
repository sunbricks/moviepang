package com.movie.pang.mov.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.movie.pang.chart.NowScreenedVO;
import com.movie.pang.mov.Mov_moviesVO;
import com.movie.pang.mov.Mov_screenVO;
import com.movie.pang.ticket.TicketVO;


@Repository
public class Mov_screenDAOMybatis {
	
	@Autowired
	private SqlSessionTemplate msMybatis;
	
	//CRUD 기능의 메소드 구현(select, insert, update, delete)
		//상영 정보 등록
		public int insertMovScreen(Mov_screenVO vo) {
			return msMybatis.insert("movScreenDAO.insertMovScreen",vo);
		};
		
		// 상영 정보 상세 조회
		public Mov_screenVO selectMovScreen(Mov_screenVO vo) {
			return msMybatis.selectOne("movScreenDAO.selectMovScreen", vo);
		}
		
		//영화의 상영날짜 반한
		public List<String> findMovScreenDate(Mov_screenVO vo){
			return	msMybatis.selectList("movScreenDAO.findMovScreenDate",vo);
				};
		
		// 영화 상영날짜의 상영시간 반환
		public List<Mov_screenVO> findMovScreenTime(Mov_screenVO vo){
			return	msMybatis.selectList("movScreenDAO.findMovScreenTime",vo);
				};
		
		//상영 정보 수정
		public void updateMovScreen(Mov_screenVO vo) {
			msMybatis.update("movScreenDAO.updateMovScreen", vo);
		};

		//상영 정보 삭제
		public void deleteMovScreen(Mov_screenVO vo) {
			msMybatis.delete("movScreenDAO.deleteMovScreeen",vo);
			
		};


		//상영 정보 조회
		public List<Mov_screenVO> selectMovScreenList(){
			return msMybatis.selectList("movScreenDAO.selectMovScreenList");
		};
		
		// 영화 정보 반환
		public Mov_moviesVO getMovInfo(Mov_screenVO vo) {
			return msMybatis.selectOne("movScreenDAO.getMovInfo",vo);
		}
		
		// 추천 영화 정보 반환
		public List<NowScreenedVO> recommendedMov() {
			return msMybatis.selectList("movScreenDAO.recommendedMov");
		}
		
		// 영화관 정보 반환
		public String getRoomInfo(Mov_screenVO vo) {
			return msMybatis.selectOne("movScreenDAO.getRoomInfo",vo);
		}
		
		// 조건 있는 상영 정보 리스트 반환
		public List<Mov_screenVO> findMovScreenList(String condition, String value) {
			Map<String, Object> params = new HashMap<>();
		       params.put("condition", condition);
		       params.put("value", value);
			return msMybatis.selectList("movScreenDAO.findMovScreenList", params);
		};
		
		// 영화 이름 연령 정보 가져옴
		public List<Mov_moviesVO> getMovNameList() {
			
			return msMybatis.selectList("movScreenDAO.getMovNameList");
		};
		
		public List<Map<String, Object>> getRoomCnt(Mov_screenVO vo) {
			return msMybatis.selectList("movScreenDAO.getRoomCnt",vo);
		};
		
		// 이미 선택된 좌석 정보 가져오기
		public List<String> alearedySelectedSeats(TicketVO vo) {
			return msMybatis.selectList("movScreenDAO.alearedySelectedSeats",vo);
		}
		
		public List<NowScreenedVO> nowScreened() {
			return  msMybatis.selectList("movScreenDAO.nowScreened");
		}
		public List<Mov_moviesVO> willScreened() {
			return  msMybatis.selectList("movScreenDAO.willScreened");
		}
		
}