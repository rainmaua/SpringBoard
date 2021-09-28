<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardUpdate</title>
</head>
<script type="text/javascript">
$j(document).ready(function(){ 
	
	$j("#btn_update").on("click",function(){
		
		if ($j("#boardTitle").val()=="") {
			alert("제목을 입력하세요"); 
			$("#boardTitle").focus();
			return false; 
		}
		
		if ($j("#boardComment").val()==""){
			alert("내용을 입력하세요"); 
			$("#boardComment").focus();
			return false; 
		}
		
		var $frm = $j('.boardUpdate :input');
		var param = $frm.serialize(); 
		alert(param); 
		
		$j.ajax({
		    url : "/board/boardUpdateAction.do",
		    dataType: "json",
		    type: "POST",
		    data : param,
		    success: function(data, textStatus, jqXHR)
	  	 	{ 	
				alert("수정완료");
				alert("메세지:"+data.success);
				location.href = "/board/boardList.do";  
	    	},
	    	error: function (jqXHR, textStatus, errorThrown)
	    	{
	    		alert("실패");
	    		
	   	 	} 
		});
	}); 
});
</script>
<body>
<form class="boardUpdate" id="boardUpdate" name="boardUpdate" action="board/boardUpdate.do">  
	<table align="center">
		<tr>
			<td align="right">
			<input id="btn_update" type="button" class="btn_update" value="수정한 내용 저장">
			<input type= "hidden" name="boardNum" value="${board.boardNum}">	
			</td>
		</tr>
		<tr>
			<td>
				<table border ="1"> 
					<tr>
						<td width="120" align="center">
						Type
						</td>
						<td width="400">
					
						<select name="boardType" id="boardType" value="${boardType}">
							<option value="a01">일반</option>
							<option value="a02">Q&A</option>
							<option value="a03">익명</option>
							<option value="a04">자유</option>
						</select>
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						Title
						</td>
						<td width="400">
						<input name="boardTitle" type="text" size="50" value="${board.boardTitle}"> 
						</td>
					</tr>
					<tr>
						<td height="300" align="center">
						Comment
						</td>
						<td valign="top">
						<textarea name="boardComment"  rows="20" cols="55">${board.boardComment}</textarea>
						</td>
					</tr>
					<tr>
						<td align="center">
						Writer
						</td>
						<td>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="right">
				<a href="/board/boardList.do">List</a>
			</td>
		</tr>
	</table>
</form>	
</body>
</html>