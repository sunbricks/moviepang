package com.movie.pang.mem.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.movie.pang.mem.BmemService;
import com.movie.pang.mem.BmemVO;

@Service
public class BmemServiceImpl implements BmemService {
	
	@Autowired
	BmemDAOMybatis bmemDAO;
	
	@Override
	public int insertBmem(BmemVO vo) {
		return bmemDAO.insertBmem(vo);
	}

}
