package com.movie.pang.prd;

import java.util.List;

public interface ProductsService {
	
	public int insertPrd(ProductsVO vo);

	public List<ProductsVO> getPrdList(ProductsVO vo);

	public ProductsVO getPrd(ProductsVO vo);
	
	//관리자 상품 리스트
		public List<ProductsVO> getPrdList();

		public void deletePrd(ProductsVO vo);

		public void updatePrd(ProductsVO vo);

		public List<ProductsVO> searchPrd(String option, String value);
}
