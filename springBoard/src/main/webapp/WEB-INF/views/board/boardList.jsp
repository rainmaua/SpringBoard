<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>list</title>
</head>
<script type="text/javascript">
	
 $j(document).ready(function() {
 	$j("#allCheck").click(function() {
 		/*alert("allCheck clicked!"); */
 		if($j(".check").prop("checked")){
 			$j(".check").prop("checked", true);
 		}
 		else{
 			$j(".check").prop("checked",false);
 		}
 		
 	});
 	
 	var codeIdCount = ${fn:length(selectKindList)}; 
 	
	$j(".check").click(function(){
		 if($j("input[name='codeId']:checked").length == codeIdCount) {
			 $j("#allCheck").prop("checked", true); 
		 } 
		 else{
			 $j("#allCheck").prop("checked", false); 
		 }
	 }); 
 	
 	$j("#btn_read").click(function() {
 		$j("#selectKind").submit(); 
 		
 		/* var $frm = $j('.selectKind :input');
		var param = $frm.serialize();
		alert(param); 
 		$j.ajax({
		    url : "/board/boarList.do",
		    dataType: "json",
		    type: "GET",
		    data : param,
		    success: function(data, textStatus, jqXHR)
		    {
				alert("successfully submitted category");
				
				location.href = "/board/boardList.do?codeId="+param;  // Yi's code: pageNo= --> pageNo=1 --> +data.pageNo 20210928 and then adjusted boardWriteAction controller
		    }, 
		    error: function (jqXHR, textStatus, errorThrown)
		    {
		    	alert("실패");
		    }
		});  // ajax */
 		
	}); 
 	
 	
 });
 
</script>
<body>
<!-- <form class="boardList" id="boardList" name="boardList" action="board/boardList.do">   -->

<table  align="center">
	<tr>
		<td align="left">
			<a href ="/board/boardLogin.do">login</a>
			<a href ="/board/boardRegister.do">join</a>
		</td>
		
		<td align="right">
			total : ${totalCnt}
		</td>
	</tr>
	<tr>
		<td>
			<table id="boardTable" border = "1">
				<tr>
					<td width="80" align="center">
						Type
					</td>
					<td width="40" align="center">
						No
					</td>
					<td width="300" align="center">
						Title
					</td>
				</tr>
				<c:forEach items="${boardList}" var="list">
					<tr>
						<td align="center">
							${list.codeName} <!-- original: ${list.boardType} -->
						</td>
						<td>
							${list.boardNum}
						</td>
						<td>
							<a href = "/board/${list.boardType}/${list.boardNum}/boardView.do?pageNo=${pageNo}">${list.boardTitle}</a>
						</td>
					</tr>	
				</c:forEach>
				
			</table>
		</td>
	</tr>
		<td align="right">
			<a href ="/board/boardWrite.do">글쓰기</a>
		</td>
	<tr>
		
		<td align="left">
			<br/> 
			<form id="selectKind" class="selectKind" method="get" action="/board/boardList.do">
				<input type="checkbox" class="check"  id="allCheck" name="allCheck">전체
				<input type="hidden" value="${codeId}"> 
				<c:forEach items="${selectKindList}" var="comCode" varStatus="status">
					<input type="checkbox" class="check" name="codeId" id="codeId" value="${comCode.codeId}">${comCode.codeName}
				</c:forEach>
			
				<input type="button" id="btn_read" class="btn_read" name="btn_read" value="조회">
			</form> 
		</td>

	</tr> 
	<tr>
	<td align="right">
		${pageNo}
	</td>
	</tr>	
</table>	
<!-- </form> -->
</body>

</html>