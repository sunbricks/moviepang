package com.movie.pang.prd.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.movie.pang.prd.GiftService;
import com.movie.pang.prd.GiftVO;

@Service
public class GiftServiceImpl implements GiftService {

	@Autowired
	private GiftDAOMybatis giftDAO;
	
	@Override
	public int insertGift(GiftVO vo) {
		return giftDAO.insertGift(vo);
	}

	@Override
	public Object deleteGift(String prd_num) {
		return giftDAO.deleteGift(prd_num);
		
	}

	@Override
	public List<GiftVO> selectGift(GiftVO vo) {
		
		return giftDAO.selectGift(vo);
	}


}
