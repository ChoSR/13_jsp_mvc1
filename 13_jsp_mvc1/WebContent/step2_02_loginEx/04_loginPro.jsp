<%@page import="step2_00_loginEx.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<%
		request.setCharacterEncoding("utf-8");
			
		String id     = request.getParameter("id");
		String passwd = request.getParameter("passwd");
	
		boolean isValidMember = MemberDao.getInstance().login(id , passwd);
		
		if (isValidMember) {
			session.setAttribute("id", id);
			session.setMaxInactiveInterval(60 * 10);
	%>
			<script>
				alert("Logged in");
				location.href = "00_main.jsp";
			</script>
	<% 
			}
		else {
	%>
			<script>
				alert("check your Id and Password");
				history.go(-1);
			</script>
	<% 	
		}
		
	%>


</body>
</html>