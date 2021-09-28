<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

/* 	$j(document).on("click", '#update', function() {
		if(confirm("정말 수정하시겠습니까?") == true) {
			$j("#boardView").submit();
			const boardTitle = $('boardTitle').val().trim();
			const boardContent = $('boardComment').val().trim(); 
	
			var formData = new FormData(); 
			formData.append('boardNum', boardNum);
			formData.append('boardTitle', boardTitle); 
			formData.append('boardComment', boardComment);  
		}
		else {
			System.out.println("edit didn't work"); 
			return ; 
		}
	});   */ 
/*  	$j(document).on("click", '#delete', function()) {
		if(confirm('정말 삭제하시겠습니까?') == true) {
			$j("#boardView").attr("action", "boardDelete.do");
			$j("#boardView").submit();
		}
		else{
			system.out.println("delete didn't work"); 
			return;
		}	
	});    */ 
	
	
	$j(document).ready(function(){ 

	$j("#btn_delete").on("click",function(){
		var $frm = $j('.boardView :input');
		var param = $frm.serialize(); 
		var Number = document.boardView; 
		alert(param); 
		$j.ajax({
			// (Yi's code)
			// to send send-file form-data to ajax, we need to set enctype, processData, ContentType
	 		// enctype : 'multipart/form-data',
			// processData : false,
			// contentType : false,
			// cache : false,   
			//
		    url : "/board/boardDelete.do",
		    dataType: "json",
		    type: "POST",
		    data : param,
		    success: function(data, textStatus, jqXHR)
	  	 	{ 	
	 		   	var msg="정말 삭제하시겠습니까?";
				var flag = confirm(msg);
				if (flag==true) {
					$j("#boardView").attr("action", "boardDelete.do");
					$j("#boardView").submit(); 
					alert("삭제완료");
					alert("메세지:"+data.success);
					location.href = "/board/boardList.do";  
				}	
	    	},
	    	error: function (jqXHR, textStatus, errorThrown)
	    	{
	    		alert("실패");
	    		
	   	 	} 
		});
	}); 


// 지금 작업중 20210907 
$j(document).ready(function(){  
	$j("#btn_update").on("click",function(){
		var $frm = $j('.boardView :input');
		var param = $frm.serialize(); 
		/* var Number = document.boardView;  */
		alert(param); 
		$j.ajax({
			// (Yi's code)
			// to send send-file form-data to ajax, we need to set enctype, processData, ContentType
		 	// enctype : 'multipart/form-data',
			// processData : false,
		// contentType : false,
		// cache : false,   
		//
	    	url : "/board/boardUpdate.do",
	    	dataType: "json",
	 	   	type: "POST",
		    data : param,
		   	success: function(data, textStatus, jqXHR)
		    {	 
		    	var msg="정말 수정하시겠습니까?";
				var flag = confirm(msg);
				if (flag==true) {
					$j("#boardView").submit(); 
					alert("수정완료");
					alert("메세지:"+data.success);
					location.href = "/board/boardList.do";  
				}	
	 	   },
		    error: function (jqXHR, textStatus, errorThrown)
		    {
		    	alert("실패");
		    } 
		});
	});
});


/* $j(".check").on('click', function() {
			let chekObj = document.getElementsByClassName("check);
		    let length = chekObj.length;
	  		let checked = 0;
		 	let checkboxTest;

			  for (i = 0; i < length; i++) {
			    if (chekObj[i].checked === true) {
			      checked += 1;
			      checkboxTest = chekObj[i].getAttribute("id");
			      console.log(checkboxTest);
			    }
			  }

			  if (checked >= 2){
			    alert("체크 해제 후 한 가지만 선택해 주세요");
			    return false;
			  } */
		/* 	var kind = $j('input:checkbox[name="item"]').val(); 
			alert(kind);  */
			
			/* $j.ajax({
				url : "/board/boardRead.do",
				type : "post", 
				data : {"kind" : kind}, 
				success : function(data) {
					console.log(data);
					
					$j('body').html(data); 
				},
				error : function(data) {
					alert('error'); 
				}//error
			})//ajax 
		});//click 
	}); //ready */


    /* $j(document).on("click", "input[name='item']", function(){
    	var param = $frm.serialize(); 
		alert(param); 
		console.log(('#result'));
    	$j('#result').children().text("");
    	$j('#result').children('전체').text("");
    	$j('input:checkbox').each(function() {   [name="item"]
    		if(this.checked)
    			$('#result').append('<p>'+this.value);
    	}); 
    });  */
	<tr>
<td align="right">
<button id="btn_update" type="button" class="btn_update">수정</button>
<button id="btn_delete" type="button" class="btn_delete">삭제</button>
</td>

<input name="Number" value="${board.boardNum}">
<tr>
</body>
</html>