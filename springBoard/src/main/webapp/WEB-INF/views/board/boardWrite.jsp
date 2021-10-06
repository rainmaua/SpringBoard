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
	/* function addRow() {
		var tableData = document.getElementById('table'); 
		var row = tableData.insertRow(tableData.rows.length); 
		
		var cell1 = row.insertCell(0);
		var cell2 = row.insertCell(1); 
		
		table.getElementsByTagName("tbody")[0].appendChild(tr); 
		
		$j("#table").append(
				"<tr><td><input name = 'text'></td></tr>");  
	} */
	
	/* var tbodyRef = document.getElementById('table').getElementsById('tbody')[0];
	var newRow = tbodyRef.insertRow(); 
	var newCell = newRow.insertCell(); 
	var newText = document.createTextNode('new row'); 
	newCell.appendChild(newText);  */
	
	$j(document).ready(function(){
		$j("#btn_add").on("click", function(){
 			/* $j("").append(
 		    '<form class="boardWrite" id="form1" ><table align="center"><tr><td><table border ="1">	  <tr><td width="120" align="center"> Type </td> <td width="400"> <select name="boardType" id="boardType" value="${boardType}"> <option value="a01">일반</option> <option value="a02">Q&A</option>  <option value="a03">익명</option> <option value="a04">자유</option> </select> </td>  </tr>   <tr>	  <td width="120" align="center">	  Title	    </td>	 <td width="400">   <input name="boardTitle" type="text" size="50" value="${board.boardTitle}">	    </td>	  </tr>	    <tr >	  <td height="300" align="center">	   Comment	    </td>	   <td valign="top">	 <textarea name="boardComment"  rows="20" cols="55">${board.boardComment}</textarea></td></tr> </table></td></tr> </br></br></br>	</table>	</form>'	    				
 			);	        
 		}); */	    
 			$j.ajax({
		    	url : "/board/boardWrite.do",
		    	dataType: "json",
		    	type: "GET",
		    	data : {"testCd":$(this).attr("value")},
		    	success: function(result) {	
					var resultHtml = ""; 
					for(var i=0; i < result.length; i++) {
						resultHtml += "<tr>";
						resultHtml += "<td>The table</td>";
						resultHtml += "<td>is finally working!</td>";
						resultHtml += "</tr>"; 
					}
		    	
					$j("#DynamicTable").append(resultHtml);	
		   		}, 
		    
		    	error: function (jqXHR, textStatus, errorThrown)
		    	{
		    		alert("실패");
		   	 	}
			});  // ajax
   		}); // click
	});	 // last
	
	/* var writeMore = $j('#tbodyWrite'); 
	var i = $j('#tbodyWrite tr').size() + 1;
	
	$j(document).ready(function(){
		$j('#btn_add').click(function() {
			writeMore.append('<tr><td>Hello!<tr><td>');
			i++ 
			return false;
		});
	});  */
	var i = 1; 
	$j(document).ready(function(){
		$j('#add').click(function() {
			$j('#DynamicTable').append('<tr id="row'+i+'"><td width="120" align="center">Type</td><td width="400"><select name="boardType" id="boardType" value="${boardType}"><c:forEach items="${selectKindList}" var="comCode" varStatus="status"><option type="checkbox" class="check" name="codeId" id="codeId" value="${comCode.codeId}">${comCode.codeName}</c:forEach></select></td></tr><tr><td width="120" align="center">Title</td><td width="400"><input name="boardTitle" id="boardTitle" type="text" size="50" value="${board.boardTitle}"> </td></tr><tr><td height="300" align="center">Comment</td><td valign="top"><textarea name="boardComment" id="boardComment" rows="20" cols="55">${board.boardComment}</textarea></td></tr><tr><td></td><td align="right"><button type="button" id="'+i+'" class="btn btn_danger remove_row">삭제</button></td></tr>');
		}); 
	});
	$j(document).ready(function(){
		$j(document).on('click','remove_row', function() {
			alert('delete btn clicked');
			var row_id = $j(this).attr("id"); 
			$j("#row"+row_id+'').remove(); 
		}); 
	});
	
	

</script>
<body id="addForm"> <!-- <body onload="addForm();"> -->
<form class="boardWrite" id="form1">   
	<table align="center" >
		<tr>
			<td align="right">
			<input id="submit" type="button" value="작성">
			<input id="btn_add" type="button" value="행추가"> 
			<button type= "button" id="add" class="btn_btn_add">행추가2</button>
			<!-- <input type="button" value="행추가" onClick="addRow(this.parentNode.parentNode)" /> -->  			<!-- <a href="#" id="btn_add">행추가</a>  -->
 			<input id="pageNo" type="hidden" value="${pageNo}"> 
			</td>
		</tr>
		<tr>
			<td>
				<table border ="1" id="writeTable"> 
				<thread>
					<tr>
						<td width="120" align="center">
						Type
						</td>
						<td width="400">
						<select name="boardType" id="boardType" value="${boardType}">
							<c:forEach items="${selectKindList}" var="comCode" varStatus="status">
								<option type="checkbox" class="check" name="codeId" id="codeId" value="${comCode.codeId}">${comCode.codeName}
							</c:forEach>
						</select> 
						</td>
					</tr>
				</thread>
			<tbody id="DynamicTable">
				
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