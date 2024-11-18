package com.movie.pang.board.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.movie.pang.board.BoardService;
import com.movie.pang.board.BoardVO;
import com.movie.pang.board.PageInfo;
import com.movie.pang.mem.MemVO;

@Service("boardService")
public class BoardServiceImpl implements BoardService {
   
//   @Autowired
//   private BoardDAODBCP dao;
   
   @Autowired
   private BoardDAOMybatis dao;
   
   @Override
   public void insertBoard(BoardVO vo) {
      dao.insertBoard(vo);
   }

   @Override
   public void updateBoard(BoardVO vo) {
      dao.updateBoard(vo);
   }

   @Override
   public void deleteBoard(BoardVO vo) {
      dao.deleteBoard(vo);
   }

   @Override
   public BoardVO getBoard(BoardVO vo) {
      return dao.getBoard(vo);
   }

   @Override
   public List<BoardVO> getBoardList(BoardVO vo) {
      return dao.getBoardList(vo);
   }

    @Override
       public int getBoardCount(BoardVO vo) {
           return dao.getBoardCount(vo);
       }

   @Override
   public List<BoardVO> getBoardList1(String option, String value) {
      return dao.getBoardList1(option, value);
   }

   @Override
   public List<BoardVO> getBoardList2(BoardVO vo) {
      return dao.getBoardList2(vo);
   }

   //화면 공지사항
   @Override
   public List<BoardVO> getRecentBoardList(BoardVO vo) {
      return dao.getRecentBoardList(vo);
   }

   @Override
   public BoardVO getannounBoard(int bnnum) {
      return dao.getannounBoard(bnnum);
      
   }



}