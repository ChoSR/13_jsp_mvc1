<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>update</title>
</head>
<body>

	<% 
		String id = (String)session.getAttribute("id");
	%>
	
	<form action="09_updatePro.jsp" method="post">
		<fieldset>
			<legend>Update Member'<%=id %>'</legend>
			<p>Id : <input type="text" name="id" value="<%=id %>" readonly></p>		
			<p>Password : <input type="password" name="passwd"></p>		
			<p>Name : <input type="text" name="name"></p>		
			<p><input type="submit" value="update"></p>
		</fieldset>	
	</form>
	
</body>
</html>