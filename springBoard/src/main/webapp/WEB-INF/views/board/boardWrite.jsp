<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardWrite</title>
</head>
<script type="text/javascript">

	$j(document).ready(function(){
		
		$j("#submit").on("click", function(){
			var $frm = $j('.boardWrite :input');
			var param = $frm.serialize();
			
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
				// (Yi's code)
				// to send send-file form-data to ajax, we need to set enctype, processData, ContentType
				/* enctype : 'multipart/form-data',
				processData : false,
				contentType : false,
				cache : false,  */
				//
			    url : "/board/boardWriteAction.do",
			    dataType: "json",
			    type: "POST",
			    data : param,
			    success: function(data, textStatus, jqXHR)
			    {
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
		
	});			
	$j(function() {
		$j("#btn_add").on("click", function(){
 			$j(".boardWrite").append(
 			'<form class="boardWrite" id="form1" ><table align="center"><tr><td>	<table border ="1">	  <tr><td width="120" align="center"> Type </td> <td width="400"> <select name="boardType" id="boardType" value="${boardType}"> <option value="a01">일반</option> <option value="a02">Q&A</option>  <option value="a03">익명</option> <option value="a04">자유</option> </select> </td>  </tr>   <tr>	  <td width="120" align="center">	  Title	    </td>	 <td width="400">   <input name="boardTitle" type="text" size="50" value="${board.boardTitle}">	    </td>	  </tr>	    <tr >	  <td height="300" align="center">	   Comment	    </td>	   <td valign="top">	 <textarea name="boardComment"  rows="20" cols="55">${board.boardComment}</textarea></td></tr> </table></td></tr> </br></br></br>	</table>	</form>'	    				
 			);	        
 		});	    
	});	
	
	
	
	

</script>
<body id="addForm"> <!-- <body onload="addForm();"> -->
<form class="boardWrite" id="form1">  
	<table align="center" class="table">
		<tr>
			<td align="right">
			<input id="submit" type="button" value="작성">
			<input id="btn_add" type="button" value="행추가">
			<input id="pageNo" type="hidden" value="${pageNo}"> 
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
							<option value="a02">Q&A</option>  <!--  add an extra space to match 4byte at DB -->
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