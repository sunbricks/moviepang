package com.movie.pang.prd;

import java.util.List;

public interface GiftService {

	int insertGift(GiftVO vo);

	Object deleteGift(String prd_num);

	List<GiftVO> selectGift(GiftVO vo);

}
