package com.movie.pang.review.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.movie.pang.review.ReviewVO;

@Repository
public class ReviewDAOMybatis {

    private final SqlSession sqlSession;

    @Autowired
    public ReviewDAOMybatis(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    public int insertReview(ReviewVO vo) {
        return sqlSession.insert("ReviewDAO.insertReview", vo);
    }

    public void updateReview(ReviewVO vo) {
        sqlSession.update("ReviewDAO.updateReview", vo);
    }

    public void delReview(ReviewVO vo) {
        sqlSession.delete("ReviewDAO.delReview", vo);
    }
    
    public int checkReview(ReviewVO vo) {
        int result = sqlSession.selectOne("ReviewDAO.checkReview", vo);
        System.out.println("review_id - " + vo.getReview_id());
        System.out.println("review_name - " + vo.getReview_name());
        System.out.println("result " + result);
        if (result > 0) {
             return 1;
        } else {
            return 0;
        }
    }

    public List<ReviewVO> getReviewList(String mov_Num) {
        return sqlSession.selectList("ReviewDAO.getReviewList", mov_Num);
    }
}
