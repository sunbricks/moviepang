package com.movie.pang.mov.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.movie.pang.mov.Mov_moviesVO;
@Repository
public class MovDAOMybatis {
	
	@Autowired
	SqlSessionTemplate mybatis;
	
	//CRUD 기능의 메소드 구현(select, insert, update, delete)
		//글 등록
		public int insertMovie(Mov_moviesVO vo) {
			return mybatis.insert("MovDAO.insertMovie", vo);
		}
		
		//글수정
		public int updateMovie(Mov_moviesVO vo) {
			return mybatis.update("MovDAO.updateMovie", vo);
		}
		
		//글삭제
		public void deleteMovie(Mov_moviesVO vo) {
			mybatis.delete("MovDAO.deleteMovie", vo);
		}
		
		//글상세 조회
		public Mov_moviesVO getMovie(String mov_Num){
			return mybatis.selectOne("MovDAO.getMovie", mov_Num);
		}
		
		//글 목록 조회
		public List<Mov_moviesVO> getMovieList(Mov_moviesVO vo){
			return mybatis.selectList("MovDAO.getMovieList", vo);
		}
		
		public int getMovieCount(Mov_moviesVO vo) {
		    return mybatis.selectOne("MovDAO.getTotalListCnt", vo);
		}
		
		public List<Mov_moviesVO> getMovList(Mov_moviesVO vo) {
			
			return mybatis.selectList("MovDAO.getMovList", vo);
		}
		
		public List<Mov_moviesVO> getMovDetail(String mov_Num) {
			return mybatis.selectList("MovDAO.getMovDetail", mov_Num);
		}
		
		public List<Mov_moviesVO> getMovModify(String num_Num) {
	         return mybatis.selectList("MovDAO.getMovModify", num_Num);
	      }
		public List<Mov_moviesVO> getMovList() {
	         return mybatis.selectList("MovDAO.getMovList");
	      }
		
		public List<Mov_moviesVO> searchMov(String searchCondition, String searchKeyword) {
	          Map<String, Object> params = new HashMap<>();
			  params.put("searchCondition", searchCondition);
	          params.put("searchKeyword", searchKeyword);
	         return mybatis.selectList("MovDAO.searchMov", params);
		}
}






















