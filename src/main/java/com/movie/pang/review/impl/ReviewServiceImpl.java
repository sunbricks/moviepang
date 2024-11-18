package com.movie.pang.review.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.movie.pang.review.ReviewService;
import com.movie.pang.review.ReviewVO;

@Service("reviewService")
public class ReviewServiceImpl implements ReviewService{
	
	@Autowired
	ReviewDAOMybatis reviewDAO;
	
	public int insertReview(ReviewVO vo) {
		return reviewDAO.insertReview(vo);
	}
	public void updateReview(ReviewVO vo) {
		reviewDAO.updateReview(vo);
	}
	public void delReview(ReviewVO vo) {
		reviewDAO.delReview(vo);
	}

    public List<ReviewVO> getReviewList(String mov_Num) {
    	System.out.println("mov_Num - "+ mov_Num);
        return reviewDAO.getReviewList(mov_Num);
    }
	
    public int checkReview(ReviewVO vo) {
    	int result = reviewDAO.checkReview(vo);
		
		if(result > 0) {
			return 1;
		} else {
			return 0;
		}
    }
}
