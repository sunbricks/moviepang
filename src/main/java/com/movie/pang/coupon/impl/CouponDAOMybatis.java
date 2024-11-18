package com.movie.pang.coupon.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.movie.pang.board.BoardVO;
import com.movie.pang.coupon.CouponVO;

@Repository
public class CouponDAOMybatis {
    
    @Autowired
    private SqlSessionTemplate mybatis;
    
    // 쿠폰 생성
    public void insertCoupon(CouponVO vo) {
        mybatis.insert("CouponDAO.insertCoupon", vo);
    }

    // 쿠폰 수정
    public void updateCoupon(CouponVO vo) {
		mybatis.update("CouponDAO.updateCoupon", vo);
    }
    
    // 쿠폰 삭제
    public void deleteCoupon(CouponVO vo) {
    	mybatis.delete("CouponDAO.deleteCoupon", vo);
    }
    
    // 쿠폰 상세 조회
    public CouponVO getCoupon(CouponVO vo) {
    	System.out.println(vo);
        return mybatis.selectOne("CouponDAO.getCoupon", vo);
    }

    // 상세보기  쿠폰 조회
    public CouponVO getallCoupon(CouponVO vo) {
    	return mybatis.selectOne("CouponDAO.getallCoupon", vo);
    }
    
    // 종류가 쿠폰인 쿠폰 조회
    public List<CouponVO> getCouponList(CouponVO vo) {
        return mybatis.selectList("CouponDAO.getCouponList");
    }
    
    // 유저 전체 조회
    public List<CouponVO> getCouponUserList(CouponVO vo) {
    	return mybatis.selectList("CouponDAO.getCouponUserList");
    }
    // 다운 전 쿠폰 조회
    public List<CouponVO> getPreCouponList(CouponVO vo) {
    	return mybatis.selectList("CouponDAO.getPreCouponList");
    }
    
    // 쿠폰 검색
    public List<CouponVO> searchCoupon(String option) {
    	 Map<String, Object> params = new HashMap<>();
	       params.put("option", option);
    	return mybatis.selectList("CouponDAO.searchCoupon", params);
    }
    // 게시글 총 개수 조회
    public int getCouponCount(CouponVO vo) {
        return mybatis.selectOne("CouponDAO.getTotalListCnt", vo);
    }
    
    // 게시글 총 개수 조회
    public int countDownCoupon(CouponVO vo) {
    	return mybatis.selectOne("CouponDAO.countDownCoupon", vo);
    }


    public int insertCoupon1(CouponVO vo) {
        return mybatis.insert("CouponDAO.insertCoupon1", vo);
    }
    
	public CouponVO getCoupon1() {
		return mybatis.selectOne("CouponDAO.getCoupon1");
	}

	//
	public CouponVO getCoupon2(CouponVO vo) {
		return mybatis.selectOne("CouponDAO.getCoupon2", vo);
	}

	public List<CouponVO> getCouponList1(String mem_Id) {
		return mybatis.selectList("CouponDAO.getCouponList1", mem_Id);
	}
	
	public List<CouponVO> getCouponList2(String mem_Id) {
		return mybatis.selectList("CouponDAO.getCouponList2", mem_Id);
	}

	//
	// 쿠폰 자동 처리
    public void updateCoupon1(CouponVO vo1) {
		mybatis.update("CouponDAO.updateCoupon1", vo1);
    }
    
    // 쿠폰 자동 처리 기간만료
    public void updateCoupon2(CouponVO vo1) {
    	System.out.println("vo888" +vo1);
    	mybatis.update("CouponDAO.updateCoupon2", vo1);
    }

	public int couponcount(String mem_Id) {
		return mybatis.selectOne("CouponDAO.couponcount", mem_Id);
	}

	public List<String> getDownloadedCoupons(String memId) {
		return mybatis.selectList("CouponDAO.getDownloadedCoupons", memId);
	}




}