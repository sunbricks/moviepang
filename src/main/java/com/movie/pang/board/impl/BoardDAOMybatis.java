package com.movie.pang.board.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.movie.pang.board.BoardVO;
import com.movie.pang.mem.MemVO;

@Repository
public class BoardDAOMybatis {
   
   @Autowired
   private SqlSessionTemplate mybatis;
   
//   CRUD 기능의 메소드 구현
   // 글 등록
   public void insertBoard(BoardVO vo) {
      mybatis.insert("BoardDAO.insertBoard", vo);
   }
   
   // 글 수정
   public void updateBoard(BoardVO vo) {
      mybatis.update("BoardDAO.updateBoard", vo);
   }
   
   // 글 삭제
   public void deleteBoard(BoardVO vo) {
      mybatis.delete("BoardDAO.deleteBoard", vo);
   }
   
   // 글 상세 조회
   public BoardVO getBoard(BoardVO vo) {
      return mybatis.selectOne("BoardDAO.getBoard", vo);
   }
   
   // 글 목록 조회
   public List<BoardVO> getBoardList(BoardVO vo) {
      System.out.println(vo);
      return mybatis.selectList("BoardDAO.getBoardList", vo);
   }

    // 게시글 총 개수 조회
    public int getBoardCount(BoardVO vo) {
        return mybatis.selectOne("BoardDAO.getTotalListCnt", vo);
    }




   public List<BoardVO> getBoardList1(String option, String value) {
          Map<String, Object> params = new HashMap<>();
          params.put("option", option);
          params.put("value", value);
      System.out.println("dddddddddd"+ params);
          return mybatis.selectList("BoardDAO.getBoardList1", params);
      }

   public List<BoardVO> getBoardList2(BoardVO vo) {
      return mybatis.selectList("BoardDAO.getBoardList2", vo);
   }
   
   //화면 공지사항
   public List<BoardVO> getRecentBoardList(BoardVO vo) {
      return mybatis.selectList("BoardDAO.getRecentBoardList", vo);
   }

   // 공지사항 상세보기
   public BoardVO getannounBoard(int bnnum) {
      return mybatis.selectOne("BoardDAO.getannounBoard", bnnum);
   }
   

   
}