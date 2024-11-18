package com.movie.pang.mov.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.movie.pang.mov.MovService;
import com.movie.pang.mov.Mov_moviesVO;

@Service("movService")//어노테이션 객체.
public class MovServiceImpl implements MovService {
	
	@Autowired
	private MovDAOMybatis MovDAO;
//	@Autowired
//	private ReviewDAOMybatis reviewDAO;
	
	//영화 serviceimpl
	@Override
	public int insertMovie(Mov_moviesVO vo) {
		  return MovDAO.insertMovie(vo);
	}

	@Override
	public int updateMovie(Mov_moviesVO vo) {
		return MovDAO.updateMovie(vo);
	}

	@Override
	public void deleteMovie(Mov_moviesVO vo) {
		MovDAO.deleteMovie(vo);
	}
	
	@Override
	public Mov_moviesVO getMovie(String mov_Num) {
		return MovDAO.getMovie(mov_Num);
	}

	@Override
	public List<Mov_moviesVO> getMovieList(Mov_moviesVO vo) {
		return MovDAO.getMovieList(vo);
	}

	@Override
	public int getMovieCount(Mov_moviesVO vo) {
        return MovDAO.getMovieCount(vo);
	}

//	@Override
//	public List<Mov_moviesVO> getMovieListPost(Mov_moviesVO vo) {
//		return MovDAO.getMovieListPost(vo);
//	}
	
	public List<Mov_moviesVO> getMovList(Mov_moviesVO vo){
		return MovDAO.getMovList(vo);
	}

	@Override
	public List<Mov_moviesVO> getMovDetail(String mov_Num) {
		return MovDAO.getMovDetail(mov_Num);
	}
	
	@Override
	   public List<Mov_moviesVO> getMovModify(String num_Num) {
	      return MovDAO.getMovModify(num_Num);
	   }

	   public List<Mov_moviesVO> getMovList(){
		      return MovDAO.getMovList();
		   }
	   
	   @Override
	   public List<Mov_moviesVO> searchMov(String searchCondition, String searchKeyword) {
	      return MovDAO.searchMov(searchCondition, searchKeyword);
	   }

	
}
