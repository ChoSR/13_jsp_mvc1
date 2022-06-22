<%@page import="step3_00_boardEx.BoardDao"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>03_bWritePro</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
	%>
		<jsp:useBean id="boardDto" class="step3_00_boardEx.BoardDto">
			<jsp:setProperty name="boardDto" property="*"/>
		</jsp:useBean>
	
	<%
		BoardDao.getInstance().insertBoard(boardDto);
	%>
	<script>
		alert("등록되었습니다.");
		location.href = "04_bList.jsp"
	</script>
	
</body>
</html>