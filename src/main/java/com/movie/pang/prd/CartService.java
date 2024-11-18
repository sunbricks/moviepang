package com.movie.pang.prd;

import java.util.List;

public interface CartService {
	
	int insertCart(CartVO vo);

	List<CartVO> getCartList(String mem_id);
	
	/* 카트 수량 수정 */
    void updateCart(CartVO vo);		
	
	/* 카트 삭제 */
	void deleteCart(CartVO vo);	

	/* 카트 전체 삭제 */
	void deleteAllCart(String mem_id);	
	
	/* 카트 중복 조회 */
	CartVO getCart(CartVO vo);



	




}
