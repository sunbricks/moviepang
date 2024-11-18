package com.movie.pang.mov.impl;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.movie.pang.mov.Mov_screenVO;



public class Mov_screenRowMapper  implements RowMapper<Mov_screenVO>{

	@Override
	public Mov_screenVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		Mov_screenVO movScreen = new Mov_screenVO();
		movScreen.setMov_sName(rs.getString("Mov_sName")); // 2
		movScreen.setMov_sMovieName(rs.getString("Mov_sMovieName")); // 3
		movScreen.setMov_sDate(rs.getString("Mov_sDate")); // 4
		movScreen.setMov_sTime(rs.getString("Mov_sTime")); // 5
		movScreen.setMov_sRegistDate(rs.getString("Mov_sRegistDate")); // 6
		
		return movScreen;
	}


}