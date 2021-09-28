<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardLogin</title>
</head>
<body>
<tr>
	<td>
		<table id="boardTable" border = "1">
			<tr>
			<td width="80" align="left">
			ID:
			</td>
			<td width="150">
			<input name="loginID" value="id"> 
			</td>
			</tr>
			<tr>
			<td width="40" align="left">
			PASSWORD:
			</td>
			<td width="150">
			<input name="loginPW" value="pw">
			</td>
			</tr>
		</table>
	</td>
</tr>
</body>
</html>