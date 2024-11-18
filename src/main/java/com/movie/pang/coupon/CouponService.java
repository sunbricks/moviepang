package com.movie.pang.coupon;

import java.util.List;


public interface CouponService {
	// 쿠폰 생성
	void insertCoupon(CouponVO vo);

	// 쿠폰 수정
	void updateCoupon(CouponVO vo);

	// 쿠폰 삭제
	void deleteCoupon(CouponVO vo);

	// 쿠폰 상세 조회
	CouponVO getCoupon(CouponVO vo);

	// 쿠폰 테이블 2개 조인
	CouponVO getallCoupon(CouponVO vo);
	
	// 종류가 쿠폰인 쿠폰 목록 조회
	List<CouponVO> getCouponList(CouponVO vo);
	
	// 쿠폰 검색
	List<CouponVO> searchCoupon(String option);
	
	// 유저 전체 조회
	List<CouponVO> getCouponUserList(CouponVO vo);
	
	// 다운전 전체 조회
	List<CouponVO> getPreCouponList(CouponVO vo);
	
	int getCouponCount(CouponVO vo);

	int insertCoupon1(CouponVO vo);

	public int countDownCoupon(CouponVO vo);

	CouponVO getCoupon1();

	//
	void updateCoupon1(CouponVO vo1);
	
	void updateCoupon2(CouponVO vo);
	
	List<CouponVO> getCouponList1(String mem_Id);
	
	List<CouponVO> getCouponList2(String mem_Id);

	int couponcount(String mem_Id);

	List<String> getDownloadedCoupons(String memId);




	//

}