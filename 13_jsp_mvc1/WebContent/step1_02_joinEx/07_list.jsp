<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Date"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>list</title>
<link href="../css/bootstrap.min.css" rel="stylesheet" type="text/css">
<style>
	#login_wrapper {
		position: absolute;
		top:25%;
		left:47%;
		margin-left:-150px;
	}
</style> 
</head>
<body>
	<%
		
		Connection conn 		= null;
		PreparedStatement pstmt = null;
		ResultSet rs 			= null;
		
		try {
			
			Class.forName("com.mysql.cj.jdbc.Driver");	
			
			String url      = "jdbc:mysql://localhost:3306/login_ex?serverTimezone=UTC";
			String user     = "root";
			String password = "1234";
			
			conn = DriverManager.getConnection(url , user , password);
		
			pstmt = conn.prepareStatement("SELECT * FROM MEMBER");
			rs = pstmt.executeQuery();
	%>
		<div id="login_wrapper">
			<h2 align="center">회원 리스트</h2>
			<br>
			<table class="table table-hover" >
				<colgroup>
					<col width="25%">
					<col width="25%">
					<col width="25%">
					<col width="25%">
				</colgroup>
				<tr class="table-primary" align="center">
					<th>ID</th>
					<th>PASSWORD</th>
					<th>NAME</th>
					<th>JOIN DATE</th>
				</tr>
	<% 
					
				while (rs.next()){
					
					
					String id       = rs.getString("ID");				
					String passwd   = rs.getString("PASSWD");			
					String name     = rs.getString("NAME");				
					Date joinDate   = rs.getDate("JOIN_DATE");  		
	%>
					 <tr class="table-default" align="center">
					 	<td><%=id %></td>
					 	<td><%=passwd %></td>
					 	<td><%=name %></td>
					 	<td><%=joinDate %></td>
					 </tr>
	<% 
				}
	%>
			</table>
		</div>	
	<% 		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)    try {rs.close();}    catch (Exception e) {e.printStackTrace();}
			if (pstmt != null) try {pstmt.close();} catch (Exception e) {e.printStackTrace();}
			if (conn != null)  try {conn.close();}  catch (Exception e) {e.printStackTrace();}
		}
		
	%>
</body>
</html>