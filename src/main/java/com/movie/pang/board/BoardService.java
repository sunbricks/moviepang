package com.movie.pang.board;

import java.util.*;

import com.movie.pang.mem.MemVO;

public interface BoardService {
   // 글 등록
   void insertBoard(BoardVO vo);
   
   // 글 수정
   void updateBoard(BoardVO vo);
   
   // 글 삭제
   void deleteBoard(BoardVO vo);
   
   // 글 상세 조회
   BoardVO getBoard(BoardVO vo);
   
   // 글 목록 조회
   List<BoardVO> getBoardList(BoardVO vo);
   
   List<BoardVO> getBoardList2(BoardVO vo);

   List<BoardVO> getBoardList1(String option, String value); 

    int getBoardCount(BoardVO vo);

    //공지사항 상세보기
    BoardVO getannounBoard(int bnnum);
    
    // 화면 공지사항
   List<BoardVO> getRecentBoardList(BoardVO vo);
   






}