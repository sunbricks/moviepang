package com.movie.pang.coupon.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import com.movie.pang.coupon.CouponService;
import com.movie.pang.coupon.CouponVO;

@Service("couponService")
public class CouponServiceImpl implements CouponService {

	@Autowired
	private CouponDAOMybatis dao;

	@Override
	public void insertCoupon(CouponVO vo) {
		dao.insertCoupon(vo);
	}

	@Override
	public void updateCoupon(CouponVO vo) {
		dao.updateCoupon(vo);
	}

	@Override
	public void deleteCoupon(CouponVO vo) {
		dao.deleteCoupon(vo);
	}

	@Override
	public CouponVO getCoupon(CouponVO vo) {
		return dao.getCoupon(vo);
	}
	@Override
	public CouponVO getallCoupon(CouponVO vo) {
		return dao.getallCoupon(vo);
	}
	
	@Override
	public List<CouponVO> searchCoupon(String option) {
		return dao.searchCoupon(option);
	}

	@Override
	public List<CouponVO> getCouponList(CouponVO vo) {
		return dao.getCouponList(vo);
	}
	@Override
	public List<CouponVO> getCouponUserList(CouponVO vo) {
		return dao.getCouponUserList(vo);
	}
	@Override
	public List<CouponVO> getPreCouponList(CouponVO vo) {
		return dao.getPreCouponList(vo);
	}

	@Override
	public int getCouponCount(CouponVO vo) {
		return dao.getCouponCount(vo);
	}

	@Override
	public int insertCoupon1(CouponVO vo) {
		return dao.insertCoupon1(vo);
	}

	@Override
	public int countDownCoupon(CouponVO vo) {
		return dao.countDownCoupon(vo);
	}

	@Override
	public CouponVO getCoupon1() {
		return dao.getCoupon1();
	}

//

	@Override
	public List<CouponVO> getCouponList1(String mem_Id) {
		return dao.getCouponList1(mem_Id);
	}
	
	@Override
	public List<CouponVO> getCouponList2(String mem_Id) {
		return dao.getCouponList2(mem_Id);
	}

	//쿠폰 사용처리
	@Override
	public void updateCoupon1(CouponVO vo) {
		dao.updateCoupon1(vo);
	}
	
	//쿠폰 사용처리 기간 만료
	@Override
	public void updateCoupon2(CouponVO vo) {
		dao.updateCoupon2(vo);
	}
	
	// 쿠폰 유저 개수 가져오기
	@Override
	public int couponcount(String mem_Id) {
		return dao.couponcount(mem_Id);
	}

	@Override
	public List<String> getDownloadedCoupons(String memId) {
		return dao.getDownloadedCoupons(memId);
	}

}