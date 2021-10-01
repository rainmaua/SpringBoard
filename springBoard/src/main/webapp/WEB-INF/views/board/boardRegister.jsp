<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardRegister</title>
</head>
<body>
<form class="boardRegister">
	<table>
	회원가입
	<tr>
	<td>
	<a href="/board/boardList.do">List</a>
	</td>
	</tr>
	<table id="boardRegister" border="1">
		<tr>
			<td width="80" align="center">
				id
			</td>
			<td width="300">
				<input name="userId" id="userId" value="${userId}">
			</td>
		</tr>
		<tr>
			<td width="80" align="center">
				pw
			</td>
			<td width="300">
				<input name="userPw" id="userPw" value="${userPw}" size="0">
			</td>
		</tr>
		<tr>
			<td width="80" align="center">
				pw check
			</td>
			<td width="300">
				<input name="pwCheck" id="pwCheck" value="${userPw}">
			</td>
		</tr>
		<tr>
			<td width="80" align="center">
				name
			</td>
			<td width="300">
				<input name="userName" id="userName" value="${userName}">
			</td>
		</tr>
		<tr>
			<td width="80" align="center">
				phone
			</td>
			
			<td>
				<input name="userPhone1" id="userPhone1" size="4" value="${userPhone1}">-
				<input name="userPhone2" id="userPhone2" size="4" value="${userPhone2}">-
				<input name="userPhone3" id="userPhone3" size="4" value="${userPhone3}">
			</td>
		</tr>
		<tr>
			<td width="80" align="center">
				postNo
			</td>
			<td width="300">
				<input name="userAddr1" id="userAddr1" value="${userAddr1}">
			</td>
		</tr>
		<tr>
			<td width="80" align="center">
				address
			</td>
			<td width="300">
				<input name="userAddr2" id="userAddr2" value="${userAddr2}">
			</td>
		</tr>
		<tr>
			<td width="80" align="center">
				company
			</td>
			<td width="300">
				<input name="userCompany" id="userCompany" value="${userCompany}">
			</td>
		</tr>
		
	</table>
	</br>
	<tr aligh="right">
		<td align="right">
			<input name="btn_register" id="btn_register" value="join" type="submit"> 
		</td>
	</tr>
	</table>
</form>

</body>
</html>