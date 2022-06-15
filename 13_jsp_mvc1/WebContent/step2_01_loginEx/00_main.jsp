<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main</title>
</head>
<body>
	
	<%
		
		String id = (String)session.getAttribute("id");
		
		if (id == null){
	%>
			<h1>JUST DO IT</h1>
			<p>Join!</p>
			<p><a href="03_login.jsp">Login!</a></p>
	<%		
		}
		else {
	%>
			<h1>Welcome!! <%=id %></h1>
			<p>Logout!</p>
			<p>Delete!</p>
			<p>Update!</p>
			
	<%
		}
	
	%>
	
</body>
</html>