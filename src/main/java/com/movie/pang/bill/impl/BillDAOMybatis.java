package com.movie.pang.bill.impl;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.movie.pang.bill.BillVO;

@Repository
public class BillDAOMybatis {

	@Autowired
	SqlSessionTemplate mybatis;

	public int insertBill(BillVO vo) {
		return mybatis.insert("BillDAO.insertBill", vo);
	}
	
	public int updateBill(BillVO vo) {
		return mybatis.update("BillDAO.updateBill", vo);
	}
	
	// 결제 목록 조회
		public List<BillVO> getBillList(BillVO vo) {
			return mybatis.selectList("BillDAO.getBillList", vo);
		}
		
	// 취소할때 목록 조회
		public List<BillVO> getBill(BillVO vo) {
			return mybatis.selectList("BillDAO.getBill", vo);
		}
		public Map<String, String> bestPrdName() {
	        return mybatis.selectOne("BillDAO.bestPrdName");
	    }

	
}
