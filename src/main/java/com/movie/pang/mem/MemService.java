package com.movie.pang.mem;

import java.util.List;
import java.util.Map;

public interface MemService {
//	대시보드 관련 서비스 시작
	
	public int getMemAllCnt();
	public int getMemWeekCnt();
	public int getMemMonthCnt();
	public int getMemYearCnt();

//	대시보드 관련 서비스 끝
	public int insertMem(MemVO vo);

	public MemVO getUser(MemVO vo);

	public void updatePoint(MemVO vo);

	public int idCheck(String id);

	List<MemVO> getMemberList();

	List<MemVO> getMemberInfo(String id);

	List<MemVO> searchMember(String option, String value);

	public void leaveUser(String id);

	public String findId(String memNm, String memBir, String memTel);

	public boolean isValidTel(String memId, String memNm, String memTel);

	List<MemVO> findPwd(String memId, String memNm, String memTel);

	public int updatePwd(MemVO vo);

	public void updateTel(String id, String tel);

	public void updateEmail(String id, String em);

	public String getPrdState(String prd_serial);

	public String getPrdName(String prd_serial);

	public String getPrdPrice(String prd_serial);

	public int chargePoints(MemVO vo);

	public void updatePrdState(String prd_serial);
	
	public int changePwd(Map<String, Object> paramMap);
	
	
	

}