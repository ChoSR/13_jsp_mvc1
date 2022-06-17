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
			<p><a href="01_insert.jsp">Join!</a></p>
			<p><a href="03_login.jsp">Login!</a></p>
	<%		
		}
		else {
	%>
			<h1>Welcome!! <%=id %></h1>
			<p><a href="05_logout.jsp">Logout!</a></p>	
			<p><a href="06_delete.jsp">Delete!</a></p>
			<p><a href="08_update.jsp">Update!</a></p>
			
	<%
		}
	
	%>
	
</body>
</html>