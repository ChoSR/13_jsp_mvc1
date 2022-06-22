<%@page import="step3_00_boardEx.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bUpdatePro</title>
</head>
<body>
	
	<%request.setCharacterEncoding("utf-8");%>
	
	<jsp:useBean id="boardDto" class="step3_00_boardEx.BoardDto">
		<jsp:setProperty property="*" name="boardDto"/>
	</jsp:useBean>
	
	<%
		boolean isUpdate = BoardDao.getInstance().updateBoard(boardDto);
		
		if (isUpdate) {
	%>
		<script>
			alert("수정되었습니다.");
			location.href="04_bList.jsp";
		</script>	
	<%
		}
		else {
	%>
		<script>
			alert("비밀번호가 일치하지 않습니다.");
			history.go(-1);
		</script>
	<% 
		}
	%>
	
</body>
</html>