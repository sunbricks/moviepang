package com.movie.pang.prd.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.movie.pang.prd.CartService;
import com.movie.pang.prd.CartVO;
import com.movie.pang.prd.ProductsVO;

@Service("CartService")
public class CartServiceImpl implements CartService{
		
		@Autowired
		private CartDAOMybatis CartDAO;
		
		@Override
		public int insertCart(CartVO vo) {
			return CartDAO.insertCart(vo);
		};
		
		
		@Override
		public List<CartVO> getCartList(String mem_id){
			return CartDAO.getCartList(mem_id);
		}
		
		@Override
		public void updateCart(CartVO vo) {
			
			 CartDAO.updateCart(vo);
		}	
		
		@Override
		public void deleteCart(CartVO vo) {

			 CartDAO.deleteCart(vo);
		}	
		
		@Override
		public void deleteAllCart(String mem_id) {
			
			CartDAO.deleteAllCart(mem_id);
		}	
		
		@Override
		public CartVO getCart(CartVO vo) {
			return CartDAO.getCart(vo);
		}
		
		
}
