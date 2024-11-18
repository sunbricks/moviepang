package com.movie.pang.mem.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.movie.pang.mem.MemVO;

@Repository
public class MemDAOMybatis {

	@Autowired
	SqlSessionTemplate mybatis;

	public int getMemAllCnt() {
	      return mybatis.selectOne("MemDAO.getMemAllCnt");
	}

	public int getMemWeekCnt() {
	      return mybatis.selectOne("MemDAO.getMemWeekCnt");
	}

	public int getMemMonthCnt() {
	      return mybatis.selectOne("MemDAO.getMemMonthCnt");
	}

	public int getMemYearCnt() {
	      return mybatis.selectOne("MemDAO.getMemYearCnt");
	}

	public int insertMem(MemVO vo) {
		return mybatis.insert("MemDAO.insertMem", vo);
	}

	public MemVO getUser(MemVO vo) {
		return mybatis.selectOne("MemDAO.getUser", vo);
	}

	public void updatePoint(MemVO vo) {
		mybatis.update("MemDAO.updatePoint", vo);
	}

	public int checkId(String id) {
		return mybatis.selectOne("MemDAO.checkId", id);
	}

	public List<MemVO> getMemberList() {
		return mybatis.selectList("MemDAO.getMemberList");
	}

	public List<MemVO> getMemberInfo(String id) {
		return mybatis.selectList("MemDAO.getMemberInfo", id);
	}

	public List<MemVO> searchMember(String option, String value) {
		Map<String, Object> params = new HashMap<>();
		params.put("option", option);
		params.put("value", value);
		return mybatis.selectList("MemDAO.searchMember", params);
	}

	public String findId(String memNm, String memBir, String memTel) {
		Map<String, Object> params = new HashMap<>();
		params.put("memNm", memNm);
		params.put("memBir", memBir);
		params.put("memTel", memTel);
		return mybatis.selectOne("MemDAO.findId", params);
	}

	public boolean isValidTel(String memId, String memNm, String memTel) {
		Map<String, Object> params = new HashMap<>();
		params.put("memId", memId);
		params.put("memNm", memNm);
		params.put("memTel", memTel);

		return mybatis.selectOne("MemDAO.isValidTel", params);

	}

	public List<MemVO> findPwd(String memId, String memNm, String memTel) {
		Map<String, Object> params = new HashMap<>();
		params.put("memId", memId);
		params.put("memNm", memNm);
		params.put("memTel", memTel);
		return mybatis.selectList("MemDAO.findPwd", params);
	}

	public int updatePwd(MemVO vo) {
		return mybatis.update("MemDAO.updatePwd", vo);
	}

	public void leaveMem(String id) {
		mybatis.update("MemDAO.leaveMem", id);

	}

	public void updateTel(String id, String tel) {
		Map<String, Object> params = new HashMap<>();
		params.put("mem_id", id);
		params.put("mem_tel", tel);
		mybatis.update("MemDAO.updateTel", params);

	}

	public void updateEmail(String id, String em) {
		Map<String, Object> params = new HashMap<>();
		params.put("mem_id", id);
		params.put("mem_em", em);
		mybatis.update("MemDAO.updateEmail", params);

	}

	public String getPrdState(String prd_serial) {
		return mybatis.selectOne("MemDAO.getPrdState", prd_serial);
	}

	public String getPrdName(String prd_serial) {
		return mybatis.selectOne("MemDAO.getPrdName", prd_serial);
	}

	public String getPrdPrice(String prd_serial) {
		return mybatis.selectOne("MemDAO.getPrdPrice", prd_serial);
	}

	public int chargePoints(MemVO vo) {
		return mybatis.update("MemDAO.chargePoints", vo);
	}

	public void updatePrdState(String prd_serial) {
		mybatis.update("MemDAO.updatePrdState", prd_serial);
	}
	
	public int changePwd(Map<String, Object> paramMap) {
		
		return mybatis.update("MemDAO.changePwd", paramMap);
	}

	public String selectEncPw(Object object) {
		
		return mybatis.selectOne("MemDAO.selectEncPw", object);
	}
}
