<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="java.lang.String.*"%>  <!-- Yi: added import="java.lang.String.*" -->
<%@include file="/WEB-INF/views/common/common.jsp"%>    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardWrite</title>
</head>
<script type="text/javascript">

	$j(document).ready(function(){
		
		// 작성 버튼 
		$j("#submit").on("click", function(){
			var $frm = $j('.boardWrite :input');
			var param = $frm.serialize();
			/* var arr = param.split(","); */        // Yi: attempted split function 20211007
			
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
	
			$j.ajax({
			    url : "/board/boardWriteAction.do",
			    dataType: "json",
			    type: "POST",
			    data : param,
			    success: function(data, textStatus, jqXHR)
			    {
			    	alert(param); 
					alert("작성완료");
					alert("메세지:"+data.success);
					<!-- Yi: after success, the web browser will show this page --> 
					location.href = "/board/boardList.do?pageNo="+data.pageNo;  // Yi's code: pageNo= --> pageNo=1 --> +data.pageNo 20210928 and then adjusted boardWriteAction controller
			    }, 
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("실패");
			    }
			});  // ajax
		}); // click 
	
		// 행추가 버튼 
		$j('#add').click(function() {
			let addRowContent = 
				 '<tr><td width="120" align="center">Type</td><td width="400"><select name="boardType" id="boardType" value="${boardType}">'
				+'<c:forEach items="${selectKindList}" var="comCode" varStatus="status">'
				+'<option type="checkbox" class="check" name="codeId" id="codeId" value="${comCode.codeId}">${comCode.codeName}</c:forEach></select></td></tr>'
				+'<tr><td width="120" align="center">Title</td><td width="400"><input name="boardTitle" id="boardTitle" type="text" size="50" value="${board.boardTitle}"> </td></tr>'
				+'<tr><td height="300" align="center">Comment</br><input type="button" value="삭제" ;"></td><td valign="top"><textarea name="boardComment" id="boardComment" rows="20" cols="55">${board.boardComment}</textarea></td></tr>';
 			$j('#DynamicTable').append(addRowContent); 
 		}); 
	
		$j('body').on('click','input[type="button"]', function(e) {
			/* alert('delete btn clicked'); */
			$j(this).closest('tr').prev().prev().remove(); 
			$j(this).closest('tr').prev().remove(); 
			$j(this).closest('tr').remove();   
			
		}); 
		
	});
	
	

</script>
<body id="addForm"> <!-- <body onload="addForm();"> -->
<form class="boardWrite" id="form1">   
	<table align="center" id="table" >
		<tr>
			<td align="right">
			<input id="submit" type="button" value="작성">
			<button type= "button" id="add" class="btn_btn_add">행추가</button>
 			<input id="pageNo" type="hidden" value="${pageNo}"> 
			</td>
		</tr>
		<tr>
			<td>
				<table border ="1" id="writeTable"> 
			<tbody id="DynamicTable">
					<tr>
						<td width="120" align="center">
						Type
						</td>
						<td width="400">
						<select name="boardType" id="boardType" value="${boardType}" >
							<c:forEach items="${selectKindList}" var="comCode" varStatus="status">
								<option type="checkbox" class="check" name="codeId" id="codeId" value="${comCode.codeId}">${comCode.codeName}
							</c:forEach>
						</select> 
						</td>
					</tr>
				
			
				
					<tr>
						<td width="120" align="center">
						Title
						</td>
						<td width="400">
						<input name="boardTitle" id="boardTitle" type="text" size="50" value="${board.boardTitle}"> 
						</td>
					</tr>
					<tr>
						<td height="300" align="center">
						Comment
						</td>
						<td valign="top">
						<textarea name="boardComment" id="boardComment" rows="20" cols="55">${board.boardComment}</textarea>
						</td>
					</tr>
			</tbody>	
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
	<div id="addedFormDiv"></div><br>
</form>	
</body>
</html>