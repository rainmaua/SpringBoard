package com.spring.board.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;


import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.board.HomeController;
import com.spring.board.service.boardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.UserInfoVo;
import com.spring.common.CommonUtil;

@Controller
public class BoardController {
	
	@Autowired 
	boardService boardService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	// 목록 페이지 이동 
	@RequestMapping(value = "/board/boardList.do" , method = RequestMethod.GET )  // Yi: removed (  )
	public String boardList(Locale locale, Model model, PageVo pageVo, 
				BoardVo boardVo, HttpServletRequest request) throws Exception{
		
		String [] codeId = request.getParameterValues("codeId"); 
	
		List<BoardVo> boardList = new ArrayList<BoardVo>(); 
		List<ComCodeVo> selectKindList = new ArrayList<ComCodeVo>();
		
		int page = 1;
		int totalCnt = 0; 

		if(pageVo.getPageNo() == 0){
			pageVo.setPageNo(page);
		}
		
		pageVo.setCodeId(codeId); 
		boardList = boardService.SelectBoardList(pageVo);
		totalCnt = boardService.selectBoardCnt();
		selectKindList = boardService.selectKindList(); 
	
		model.addAttribute("pageNo", page); 
		model.addAttribute("boardList", boardList); 
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("selectKindList", selectKindList);
		
		return "board/boardList";
	}
	
	
	// 게시판 - 상세보기 
	
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardView.do", method = RequestMethod.GET)
	public String boardView(Locale locale, Model model
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum) throws Exception{
		
		BoardVo boardVo = new BoardVo();
		
		boardVo = boardService.selectBoard(boardType,boardNum);
		
		model.addAttribute("boardType", boardType);
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("board", boardVo);
		
		return "board/boardView";
	}
	
	// 글 작성 클릭시 글 작성 페이지로 이동 
	@RequestMapping(value = "/board/boardWrite.do", method = RequestMethod.GET)
	public String boardWrite(Locale locale, Model model, HttpServletRequest request, BoardVo boardVo, ComCodeVo comCodeVo) throws Exception{
		String [] codeId= request.getParameterValues("codeId");

		List<ComCodeVo> selectKindList= new ArrayList<ComCodeVo>();
		
		selectKindList= boardService.selectKindList(); 
		
		model.addAttribute("selectKindList", selectKindList); 
		
		return "board/boardWrite";
	}
	// 게시판 - 글 작성 처리 
	@RequestMapping(value = "/board/boardWriteAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardWriteAction(Locale locale, BoardVo boardVo, PageVo pageVo,
			HttpServletRequest request) throws Exception{
		// Yi: 체크박스는 한가지 variable을 배열로 만들어 여러가지 값을 넣어주는 거였고, 
		// 행추가는 여러 variable들을 배열로 만들어 여러가지 값을 넣어준다,
		// 배열 덕분에 split을 쓰지 않고도, 여러가지 값을 하나의 variable에 저장할 수 있다.

		String [] boardType = request.getParameterValues("boardType"); 
		String [] boardTitle = request.getParameterValues("boardTitle");
		String [] boardComment = request.getParameterValues("boardComment"); 
		
		List<BoardVo> boardList = new ArrayList<BoardVo>(); 
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		CommonUtil commonUtil = new CommonUtil();
		
		
		for (int i=0; i < boardTitle.length; i++) {
			boardVo.setBoardType(boardType[i]); 
			boardVo.setBoardTitle(boardTitle[i]);
			boardVo.setBoardComment(boardComment[i]); 
			
			System.out.println("Hey! boardTitle: " + boardTitle[i]);
			// 전체 게시글 개수를 얻어와 resultCnt에 저장 
			int resultCnt = boardService.boardInsert(boardVo);
			
			// page 변수 추가 
			int page = 1; 
			if(pageVo.getPageNo() == 0){
				pageVo.setPageNo(page);;
			}
			String pageNo = Integer.toString(pageVo.getPageNo()); 
			result.put("pageNo", pageNo); 
			
			result.put("boardType", boardType); 
			result.put("boardTitle", boardTitle); 
			result.put("boardComment", boardComment); 
			result.put("boardList", boardList); 
			result.put("success", (resultCnt > 0)?"Y":"N");
		
		}
		// send all data from boardWrite.jsp as a callbackMsg 
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		System.out.println("callbackMsg::"+callbackMsg);
		return callbackMsg;
	}
	
	// 게시판 - 회원가입 
		@RequestMapping(value = "/board/boardRegisterAction.do", method = RequestMethod.POST)
		@ResponseBody
		public String boardRegisterAction(Locale locale, BoardVo boardVo, UserInfoVo userInfoVo) throws Exception{
			
			HashMap<String, String> result = new HashMap<String, String>();
			CommonUtil commonUtil = new CommonUtil();
			
			int resultCnt = boardService.boardRegister(userInfoVo);  // ?? 
			
			result.put("Temporary", "hello"); 
			result.put("success", (resultCnt > 0)?"Y":"N");
			String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
			
			System.out.println("callbackMsg::"+callbackMsg);
			
			return callbackMsg;
		}
	
	// 게시판 - 삭제 처리 
	@RequestMapping(value="/board/boardDelete.do", method = RequestMethod.POST)
	@ResponseBody // you should add this when you're returning callbackMsg/json data 
	public String boardDelete(Model model, BoardVo boardVo) throws Exception {

		HashMap<String, String> result = new HashMap<String, String>(); 
		CommonUtil commonUtil = new CommonUtil(); 
			
		int resultCnt = boardService.boardDelete(boardVo);
			
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString("", result); 
		System.out.println("callbackMsg::"+callbackMsg);
			
		boardService.boardDelete(boardVo);
		return callbackMsg; // this is not used to return url location. Instead, it's used for returning json data. 
	}
		
	// 게시판 - 수정 처리 
	@RequestMapping(value = "/board/boardUpdateAction.do", method = RequestMethod.POST) // Yi: not sure, post or get
	@ResponseBody
	public String boardUpdateAction(Locale locale, BoardVo boardVo) throws Exception {

		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();

		int resultCnt = boardService.boardUpdate(boardVo);

		result.put("success", (resultCnt > 0) ? "Y" : "N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ", result);
		System.out.println("callbackMsg::" + callbackMsg);

		//boardService.boardUpdate(boardVo);
		return callbackMsg; // 다른 방법 'return "redirect:/board/boardList"' doesn't work because it's not for returning url location;
	}
	
	// 게시판 - 수정 뷰 페이지 이동
	@RequestMapping(value="/board/{boardType}/{boardNum}/boardUpdate.do", method = RequestMethod.GET)
	public String boardUpdate(Locale locale, Model model
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum") int boardNum) throws Exception{
	
		BoardVo boardVo = new BoardVo();
		
		boardVo = boardService.selectBoard(boardType, boardNum);
		
		model.addAttribute("boardType", boardType);
		model.addAttribute("boardNum", boardNum); 
		model.addAttribute("board", boardVo);
		
		System.out.println("The troublesome boardUpdate - controller is finally working"); 
		
		return "board/boardUpdate"; 
	}
	
	// 게시판 - 로그인 페이지 이동 
	@RequestMapping(value = "/board/boardLogin.do", method = RequestMethod.GET)
	public String boardLogin(Locale locale, Model model) throws Exception{
		return "board/boardLogin";
	}
	
	// 게시판 - 회원가입 이미지 이동 
	@RequestMapping(value = "/board/boardRegister.do", method = RequestMethod.GET)
	public String boardRegister(Locale locale, Model model) throws Exception{
		return "board/boardRegister";
	}

	@RequestMapping(value = "/board/boardRead.do", method = RequestMethod.GET)
	public String boardRead(Locale locale, Model model) throws Exception{
		return "board/boardReadr";
	}
}
