package com.spring.board.vo;

public class PageVo {
	
	private int pageNo = 0; // original value was 0. 

	private String [] codeId;  
	
	
	//  20210928 @ https://po9357.github.io/spring/2019-05-28-Board_Paging/
	private int startPage, endPage, total, cntPerPage, lastPage; // nowPage = pageNo
	private int cntPage = 10; 
	
	public PageVo() {
	}

//	public PageVo(int total, int nowPage, int cntPerPage) {
//		setPageNo(pageNo); 
//		setCntPerPage(cntPerPage); 
//		setTotalCnt(total); 
//		calcLastPage(getTotal(), getCntPerPage()); 
//		calcStartEndPage(getPageNo(), cntPage()); 
//		calcStartEnd( getPageNo(), getCntPerPage()); 
//	}
//	// last page calculation
//	public void calcLastPage(int total, int cntPerPage) {
//		setLastPage(int)Math.ceil((double)pageNo / (double)cntPerPage)); 
//	}
//	
//	public void calcStartEndPage(int pageNo, int cntPerPage) {
//		setEndPage((int)Math.ceil((double)nowPage / (double)cntPerPage)) * cntPerPage);  )
//
//	}
	public int getPageNo() {
		return pageNo;
	}
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	public String[] getCodeId() {
		return codeId;
	}
	public void setCodeId(String[] codeId) {
		this.codeId = codeId;
	}
	
	
	

	
}
