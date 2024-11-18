package com.movie.pang.mov;

import java.util.List;
public interface MovService {
	
	//CRUD기능의 메소드 구현

	//글등록
	int insertMovie(Mov_moviesVO vo);
	//글수정
	int updateMovie(Mov_moviesVO vo) ;
	//글삭제
	void deleteMovie(Mov_moviesVO vo);
	//글상세 조회
	public Mov_moviesVO getMovie(String mov_Num);
	//글 목록 조회
	List<Mov_moviesVO> getMovieList(Mov_moviesVO vo);
	
	int getMovieCount(Mov_moviesVO vo);
	
	List<Mov_moviesVO> getMovList(Mov_moviesVO vo);
	
	
	List<Mov_moviesVO> getMovDetail(String num_Num);
	   List<Mov_moviesVO> getMovModify(String mov_Num);
	   List<Mov_moviesVO> getMovList();
	   List<Mov_moviesVO> searchMov(String searchCondition, String searchKeyword);
}
