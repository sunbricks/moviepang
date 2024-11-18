package com.movie.pang.review;

import java.util.List;

import org.apache.ibatis.annotations.Param;

//import com.movie.pang.mov.Mov_moviesVO;

public interface ReviewService {
	
	int insertReview(ReviewVO vo);
	
	void updateReview(ReviewVO vo);
	
	void delReview(ReviewVO vo);
	
	int checkReview(ReviewVO vo);
	
	List<ReviewVO> getReviewList(String mov_Num);
	
}
