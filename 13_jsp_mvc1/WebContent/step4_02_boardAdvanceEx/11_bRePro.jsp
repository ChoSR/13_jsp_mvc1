<%@page import="step4_00_boardEx.BoardAdvanceDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>11_bRePro</title>
</head>
<body>

	<%
		request.setCharacterEncoding("UTF-8");
	%>
		<jsp:useBean id="boardAdvanceDto" class="step4_00_boardEx.BoardAdvanceDto">
			<jsp:setProperty name="boardAdvanceDto" property="*" />
		</jsp:useBean>
	<%
		BoardAdvanceDao.getInstance().reWriteBoard(boardAdvanceDto);
		response.sendRedirect("04_bList.jsp");
	%>

</body>
</html>