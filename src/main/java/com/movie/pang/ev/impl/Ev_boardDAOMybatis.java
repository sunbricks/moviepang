package com.movie.pang.ev.impl;

import java.util.*;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.movie.pang.ev.Ev_boardVO;

@Repository
public class Ev_boardDAOMybatis {
   
   @Autowired
   private SqlSessionTemplate mybatis;
   
//   CRUD 기능의 메소드 구현
   // 글 등록
   public void insertBoard(Ev_boardVO vo) {
      mybatis.insert("evDAO.insertEv_board", vo);
   }
   
   // 글 수정
   public void updateBoard(Ev_boardVO vo) {
      mybatis.update("evDAO.updateEv_board", vo);
   }
   
   // 글 삭제
   public void deleteBoard(Ev_boardVO vo) {
      mybatis.delete("evDAO.deleteEv_board", vo);
   }
   
   // 글 상세 조회
   public Ev_boardVO getBoard(Ev_boardVO vo) {
      return mybatis.selectOne("evDAO.getEv_board", vo);
   }
   
   // 글 목록 조회
   public List<Ev_boardVO> getBoardList(Ev_boardVO vo) {
      List<Ev_boardVO> lbvo = mybatis.selectList("evDAO.getEv_BoardList", vo);
      for(Ev_boardVO lvo : lbvo) {
      }
      return lbvo;
   }

   public void updateBoard1(Ev_boardVO vo) {
      mybatis.update("evDAO.updateEv_board1", vo);
      
   }

   public int getEv_boardCount(Ev_boardVO vo) {
       return mybatis.selectOne("evDAO.getTotalListCnt", vo);
   }
// 이벤트 관리자
   public List<Ev_boardVO> getallEv_BoardList(Ev_boardVO vo) {
      return mybatis.selectList("evDAO.getallEv_BoardList", vo);
   }
   //이벤트 진행중
   public List<Ev_boardVO> getallEv_BoardListt(Ev_boardVO vo) {
      return mybatis.selectList("evDAO.getallEv_BoardListt", vo);
   }
   //이벤트 종료
   public List<Ev_boardVO> getallEv_BoardListf(Ev_boardVO vo) {
      return mybatis.selectList("evDAO.getallEv_BoardListf", vo);
   }


   public List<Ev_boardVO> getEv_BoardList2(String option, String value) {
      Map<String, Object> params = new HashMap<>();
       params.put("option", option);
       params.put("value", value);
       System.out.println( "params : "+params);
      return mybatis.selectList("evDAO.getEv_BoardList1", params);
   }

   public Ev_boardVO getBoard1(int evNum) {
      return mybatis.selectOne("evDAO.getEv_board1", evNum);
   }
   
   //메인화면 이벤트
   public List<Ev_boardVO> getRecentEvents(Ev_boardVO vo) {
      return mybatis.selectList("evDAO.getRecentEvents", vo);
   }
   
}