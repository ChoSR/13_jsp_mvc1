<%@page import="step4_00_boardEx.BoardAdvanceDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>09_bDeletePro</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
	%>
		<jsp:useBean id="boardAdvanceDto" class="step4_00_boardEx.BoardAdvanceDto">
			<jsp:setProperty name="boardAdvanceDto" property="*"/>
		</jsp:useBean>
	<%
		boolean isDelete = BoardAdvanceDao.getInstance().deleteBoard(boardAdvanceDto);

		if (isDelete) {
	%>
			<script>
				alert("삭제되었습니다.");
				location.href = "04_bList.jsp";
			</script>
	<%				
		}
		else {
	%>
			<script>
				alert("패스워드가 틀립니다.");
				history.go(-1);
			</script>
	<%				
		}
	%>	
</body>
</html>