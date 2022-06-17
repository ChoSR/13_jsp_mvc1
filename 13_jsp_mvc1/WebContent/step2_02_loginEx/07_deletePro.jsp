<%@page import="step2_00_loginEx.MemberDto"%>
<%@page import="step2_00_loginEx.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deletePro</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		
		MemberDto memberDto = new MemberDto();
		memberDto.setId(request.getParameter("id"));
		memberDto.setPasswd(request.getParameter("passwd"));
		
		boolean isDeleteMember = MemberDao.getInstance().deleteMember(memberDto);
			
		if (isDeleteMember) {
			session.invalidate();
	%>
			<script>
				alert("Your account has been deleted successfully.");
				location.href = "00_main.jsp";
			</script>
	<% 
		}
		else {
	%>	
			<script>
				alert("Check your Id or Password");
				history.go(-1);
			</script>
	<% 		
		}
	%>

</body>
</html>