package com.movie.pang.bill.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.movie.pang.bill.BillService;
import com.movie.pang.bill.BillVO;

@Service
public class BillServiceImpl implements BillService {
	
	@Autowired
	BillDAOMybatis billDAO;
	
	@Override
	public int insertBill(BillVO vo) {
		return billDAO.insertBill(vo);
	}
	
	@Override
	public int updateBill(BillVO vo) {
		 return billDAO.updateBill(vo);
	}
	
	@Override
	public List<BillVO> getBillList(BillVO vo) {
		return billDAO.getBillList(vo);
	}
	@Override
	public List<BillVO> getBill(BillVO vo) {
		return billDAO.getBill(vo);
	}
	
	@Override
    public Map<String, String> bestPrdName() {
        return billDAO.bestPrdName();
    }



}
