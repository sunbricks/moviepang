package com.movie.pang.ev;

import java.util.List;



public interface Ev_boardService {
   // 이벤트 등록
   void insertEv_board(Ev_boardVO vo);
   
   // 이벤트 수정
   void updateEv_board(Ev_boardVO vo);

   void updateEv_board1(Ev_boardVO vo);
   
   // 이벤트 삭제
   void deleteEv_board(Ev_boardVO vo);
   
   // 이벤트 상세 조회
   Ev_boardVO getEv_board(Ev_boardVO vo);
   
   // 이벤트 목록 조회
   List<Ev_boardVO> getEv_boardList(Ev_boardVO vo);
   
   int getEv_boardCount(Ev_boardVO vo);

   
   List<Ev_boardVO> getallEv_BoardList(Ev_boardVO vo);
   
   // 이벤트 진행중
   List<Ev_boardVO> getallEv_BoardListt(Ev_boardVO vo);
   
   //이벤트 종료
   List<Ev_boardVO> getallEv_BoardListf(Ev_boardVO vo);


   List<Ev_boardVO> getBoardList1(String option, String value);

   Ev_boardVO getEv_board1(int evNum);

   // 사용자 이벤트 상세보기
   Ev_boardVO getEvBoard(int evNum);
   
   //메인화면 이벤트
   List<Ev_boardVO> getRecentEvents(Ev_boardVO vo);

}