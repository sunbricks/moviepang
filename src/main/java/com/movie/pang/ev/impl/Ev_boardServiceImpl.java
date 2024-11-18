package com.movie.pang.ev.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.movie.pang.board.BoardVO;
import com.movie.pang.ev.Ev_boardService;
import com.movie.pang.ev.Ev_boardVO;

@Service("ev_boardService")
public class Ev_boardServiceImpl implements Ev_boardService {
   
//   @Autowired
//   private BoardDAODBCP dao;
   
   @Autowired
   private Ev_boardDAOMybatis evDAO;
   
   @Override
   public void insertEv_board(Ev_boardVO vo) {
      evDAO.insertBoard(vo);
   }

   @Override
   public void updateEv_board(Ev_boardVO vo) {
      evDAO.updateBoard(vo);
   }

   @Override
   public void deleteEv_board(Ev_boardVO vo) {
      evDAO.deleteBoard(vo);
   }

   @Override
   public Ev_boardVO getEv_board(Ev_boardVO vo) {
      System.out.println("vo1"+vo);
      return evDAO.getBoard(vo);
   }

   @Override
   public List<Ev_boardVO> getEv_boardList(Ev_boardVO vo) {
      List<Ev_boardVO> lbvo = evDAO.getBoardList(vo);
      return lbvo;
   }

   @Override
   public void updateEv_board1(Ev_boardVO vo) {
      evDAO.updateBoard1(vo);
      
   }


    @Override
       public int getEv_boardCount(Ev_boardVO vo) {
           return evDAO.getEv_boardCount(vo);
       }
    //이벤트 관리자
   @Override
   public List<Ev_boardVO> getallEv_BoardList(Ev_boardVO vo) {
      return evDAO.getallEv_BoardList(vo);
   }
   //이벤트 진행중
   @Override
   public List<Ev_boardVO> getallEv_BoardListt(Ev_boardVO vo) {
      return evDAO.getallEv_BoardList(vo);
   }
   //이벤트 종료
   @Override
   public List<Ev_boardVO> getallEv_BoardListf(Ev_boardVO vo) {
      return evDAO.getallEv_BoardList(vo);
   }

   @Override
   public List<Ev_boardVO> getBoardList1(String option, String value) {
      return evDAO.getEv_BoardList2(option, value);
   }

   
   @Override
   public Ev_boardVO getEv_board1(int evNum) {
      return evDAO.getBoard1(evNum);
   }

//   이벤트 상세보기 사용자
   @Override
   public Ev_boardVO getEvBoard(int evNum) {
      return evDAO.getBoard1(evNum);
   }
   
   //메인화면 이벤트
   @Override
   public List<Ev_boardVO> getRecentEvents(Ev_boardVO vo) {
      return evDAO.getRecentEvents(vo);
   }

}