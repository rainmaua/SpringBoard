package com.spring.board.service;

import java.util.List;
import java.util.Map;

import com.spring.board.vo.BoardVo;
import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.PageVo;

public interface boardService {

	public String selectTest() throws Exception;
	
	// 게시글 목록 조회
	public List<BoardVo> SelectBoardList(PageVo pageVo) throws Exception;
	
	// 게시글 카테고리별 목록 조회 
	public List<ComCodeVo> selectKindList() throws Exception;
	
	// 게시글 카테고리별 갯수 
	public int getKindCount(Map map) throws Exception; 
	
	// 게시글 조회
	public BoardVo selectBoard(String boardType, int boardNum) throws Exception;
	
	// 게시글 갯수 
	public int selectBoardCnt() throws Exception;

	// 게시글 작성 
	public int boardInsert(BoardVo boardVo) throws Exception;
	
	// Yi's code
	// 게시글 수정 
	public int boardUpdate(BoardVo boardVo) throws Exception; 
	
	//게시글 삭제 
	public int boardDelete(BoardVo boardVo) throws Exception; 
	
	

}
