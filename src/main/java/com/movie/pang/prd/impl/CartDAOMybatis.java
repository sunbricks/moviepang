package com.movie.pang.prd.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.movie.pang.board.BoardVO;
import com.movie.pang.prd.CartVO;
import com.movie.pang.prd.ProductsVO;

@Repository
public class CartDAOMybatis {
	@Autowired
	private SqlSessionTemplate mybatis;

	public int insertCart(CartVO vo) {
		return mybatis.insert("CartDAO.insertCart", vo);
	}

	// 장바구니 목록 조회
	public List<CartVO> getCartList(String mem_id){
		return mybatis.selectList("CartDAO.getCartList", mem_id);
					
	}
	
	// 장바구니 수정
	public void updateCart(CartVO vo) {
		mybatis.update("CartDAO.updateCart", vo);
	}
	
	// 장바구니 삭제
	public void deleteCart(CartVO vo) {
		mybatis.delete("CartDAO.deleteCart", vo);
	}
	
	// 장바구니 전체 삭제
	public void deleteAllCart(String mem_id) {
		mybatis.delete("CartDAO.deleteAllCart", mem_id);
	}
	
	// 장바구니 중복 조회
	public CartVO getCart(CartVO vo) {
		return mybatis.selectOne("CartDAO.getCart", vo);
	}
	
}
