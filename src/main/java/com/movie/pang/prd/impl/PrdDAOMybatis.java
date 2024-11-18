package com.movie.pang.prd.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.movie.pang.prd.ProductsVO;

@Repository
public class PrdDAOMybatis {

	@Autowired
	SqlSessionTemplate mybatis;

	public int insertPrd(ProductsVO vo) {
		return mybatis.insert("PrdDAO.insertPrd", vo);
	}

	public List<ProductsVO> getPrdList(ProductsVO vo) {
		return mybatis.selectList("PrdDAO.getPrdList", vo);
	}

	public ProductsVO getPrd(ProductsVO vo) {
		return mybatis.selectOne("PrdDAO.getPrd", vo);
	}
	
	public List<ProductsVO> getPrdList() {
		return mybatis.selectList("PrdDAO.getPrdList");
	}

	public void deletePrd(ProductsVO vo) {
		mybatis.delete("PrdDAO.deletePrd", vo);
	}

	public void updatePrd(ProductsVO vo) {
		mybatis.update("PrdDAO.updatePrd", vo);
		
	}

	public List<ProductsVO> searchPrd(String option, String value) {
		 Map<String, Object> params = new HashMap<>();
	       params.put("option", option);
	       params.put("value", value);
	       System.out.println(params);
	       return mybatis.selectList("PrdDAO.searchPrd", params);
	}

}
