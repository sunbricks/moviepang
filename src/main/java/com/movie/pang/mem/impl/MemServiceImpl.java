package com.movie.pang.mem.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import com.movie.pang.mem.MemService;
import com.movie.pang.mem.MemVO;

@Service
public class MemServiceImpl implements MemService {

	@Autowired
	MemDAOMybatis memDAO;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;

	@Override
	   public int getMemAllCnt() {
	      return memDAO.getMemAllCnt();
	}

	@Override
	   public int getMemWeekCnt() {
	     return memDAO.getMemWeekCnt();
	}

	@Override
	   public int getMemMonthCnt() {
	     return memDAO.getMemMonthCnt();
	}

	@Override
	   public int getMemYearCnt() {
	     return memDAO.getMemYearCnt();
	}
	public int insertMem(MemVO vo) {
		return memDAO.insertMem(vo);
	}

	public MemVO getUser(MemVO vo) {
//		System.out.println(userDAO.getUser(vo));
		return memDAO.getUser(vo);
	}

	@Override
	public void updatePoint(MemVO vo) {
//		System.out.println(userDAO.getUser(vo));
		memDAO.updatePoint(vo);
	}

	@Override
	public int idCheck(String id) {
		System.out.println("타냐?123");
		int result = 0;

		result = memDAO.checkId(id);
		System.out.println(result);
		return result;
	}

	@Override
	public List<MemVO> getMemberList() {
		return memDAO.getMemberList();
	}

	@Override
	public List<MemVO> getMemberInfo(String id) {
		return memDAO.getMemberInfo(id);
	}

	@Override
	public List<MemVO> searchMember(String option, String value) {
		return memDAO.searchMember(option, value);
	}

	@Override
	public String findId(String memNm, String memBir, String memTel) {
		return memDAO.findId(memNm, memBir, memTel);
	}

	@Override
	public boolean isValidTel(String memId, String memNm, String memTel) {
		return memDAO.isValidTel(memId, memNm, memTel);
	}

	@Override
	public List<MemVO> findPwd(String memId, String memNm, String memTel) {
		return memDAO.findPwd(memId, memNm, memTel);
	}

	@Override
	public int updatePwd(MemVO vo) {
		System.out.println("vo2" + vo);
		return memDAO.updatePwd(vo);
	}

	@Override
	public void leaveUser(String id) {
		memDAO.leaveMem(id);

	}

	@Override
	public void updateTel(String id, String tel) {
		memDAO.updateTel(id, tel);

	}

	@Override
	public void updateEmail(String id, String em) {
		memDAO.updateEmail(id, em);

	}

	@Override
	public String getPrdState(String prd_serial) {
		return memDAO.getPrdState(prd_serial);
	}

	@Override
	public String getPrdName(String prd_serial) {
		return memDAO.getPrdName(prd_serial);
	}

	@Override
	public String getPrdPrice(String prd_serial) {
		return memDAO.getPrdPrice(prd_serial);
	}

	@Override
	public int chargePoints(MemVO vo) {
		System.out.println("vo :" + vo);
		return memDAO.chargePoints(vo);
	}

	@Override
	public void updatePrdState(String prd_serial) {
		memDAO.updatePrdState(prd_serial);
	}
	
	@Override
    public int changePwd(Map<String, Object> paramMap) {
        String memId = (String) paramMap.get("mem_id");
        String currentPassword = (String) paramMap.get("mem_pwd");
        String newPassword = (String) paramMap.get("mem_chpwd");

        // 현재 비밀번호와 데이터베이스에 저장된 비밀번호 비교
        String encPw = memDAO.selectEncPw(memId);

        if (bcryptPasswordEncoder.matches(currentPassword, encPw)) {
            // 새 비밀번호를 암호화하여 저장
            paramMap.put("mem_chpwd", bcryptPasswordEncoder.encode(newPassword));
            return memDAO.changePwd(paramMap);
        }
        return 0; // 현재 비밀번호가 일치하지 않음
    }
}