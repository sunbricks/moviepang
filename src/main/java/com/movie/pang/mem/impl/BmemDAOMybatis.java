package com.movie.pang.mem.impl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.movie.pang.mem.BmemVO;

@Repository
public class BmemDAOMybatis {

	@Autowired
	SqlSessionTemplate mybatis;
	public int insertBmem(BmemVO vo) {
		
		return mybatis.insert("BmemDAO.insertBmem",vo);
	}

}
