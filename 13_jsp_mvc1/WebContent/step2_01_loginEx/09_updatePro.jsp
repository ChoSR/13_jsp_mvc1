<%@page import="step2_00_loginEx.MemberDto"%>
<%@page import="step2_00_loginEx.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updatePro</title>
</head>
<body>

	<%
		request.setCharacterEncoding("utf-8");
			
		MemberDto memberDto = new MemberDto();
		memberDto.setId(request.getParameter("id"));
		memberDto.setPasswd(request.getParameter("passwd"));
		memberDto.setName(request.getParameter("name"));
			
		boolean isUpdateMember = MemberDao.getInstance().updateMember(memberDto);
		
		if (isUpdateMember) {
	%>
			<script>
				alert("Information has changed");
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




