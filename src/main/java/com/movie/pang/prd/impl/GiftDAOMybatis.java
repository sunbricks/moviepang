package com.movie.pang.prd.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.movie.pang.prd.GiftVO;

@Repository
public class GiftDAOMybatis {

	@Autowired
	private SqlSessionTemplate mybatis;

	public int insertGift(GiftVO vo) {

		return mybatis.insert("GiftDAO.insertGift", vo);
	}

	public Object deleteGift(String prd_num) {
		
		return mybatis.delete("GiftDAO.deleteGift", prd_num);
	}

	public List<GiftVO> selectGift(GiftVO vo) {
	
		return mybatis.selectList("GiftDAO.selectGift", vo);
	}

}
