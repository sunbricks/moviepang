package com.movie.pang.prd.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.movie.pang.prd.ProductsService;
import com.movie.pang.prd.ProductsVO;

@Service
public class ProductsServiceImpl implements ProductsService {

	@Autowired
	private PrdDAOMybatis prdDAO;
	
	@Override
	public int insertPrd(ProductsVO vo) {
			return prdDAO.insertPrd(vo);
		}

	@Override
	public List<ProductsVO> getPrdList(ProductsVO vo) {
	
		return prdDAO.getPrdList(vo);
	}

	@Override
	public ProductsVO getPrd(ProductsVO vo) {
		return prdDAO.getPrd(vo);
	}
	
	@Override
	public List<ProductsVO> getPrdList() {
		return prdDAO.getPrdList();
	}

	@Override
	public void deletePrd(ProductsVO vo) {
		prdDAO.deletePrd(vo);
	}

	@Override
	public void updatePrd(ProductsVO vo) {
		prdDAO.updatePrd(vo);
		
	}

	@Override
	public List<ProductsVO> searchPrd(String option, String value) {
		return prdDAO.searchPrd(option, value);
	}


	}


