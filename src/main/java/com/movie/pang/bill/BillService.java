package com.movie.pang.bill;

import java.util.List;
import java.util.Map;

public interface BillService {
	
	int insertBill(BillVO vo);
	int updateBill(BillVO vo);
	List<BillVO> getBillList(BillVO vo);
	List<BillVO> getBill(BillVO vo);
	Map<String, String> bestPrdName();
}
