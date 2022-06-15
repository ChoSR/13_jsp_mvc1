<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updatePro</title>
</head>
<body>

	<%
	
		request.setCharacterEncoding("utf-8");
		
		Connection conn 		= null;
		PreparedStatement pstmt = null;
		ResultSet rs 			= null;
		
		String id     = request.getParameter("id");
		String passwd = request.getParameter("passwd");
		String name   = request.getParameter("name");
		
		try {
			
			Class.forName("com.mysql.cj.jdbc.Driver");	
			
			String url      = "jdbc:mysql://localhost:3306/login_ex?serverTimezone=UTC";
			String user     = "root";
			String password = "1234";
			
			conn = DriverManager.getConnection(url , user , password);
			
			pstmt = conn.prepareStatement("SELECT * FROM MEMBER WHERE ID = ? AND PASSWD = ?");
			pstmt.setString(1 , id);
			pstmt.setString(2 , passwd);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				
				pstmt = conn.prepareStatement("UPDATE MEMBER SET NAME = ? WHERE ID = ?");	
				pstmt.setString(1 , name);
				pstmt.setString(2 , id);
				pstmt.executeUpdate();
	%>
				<script>
					alert("수정 되었습니다.");
					location.href = "00_main.jsp";
				</script>
	<% 
			}
			else {
	%>
				<script>
					alert("아이디와 패스워드를 확인하세요.");
					history.go(-1);
				</script>
	<% 			
			}
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