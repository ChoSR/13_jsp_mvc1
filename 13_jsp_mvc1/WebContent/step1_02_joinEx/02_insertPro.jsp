<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertPro</title>
</head>
<body>
	
	<% 
	
		request.setCharacterEncoding("utf-8");
	
		String id     = request.getParameter("id");
		String passwd = request.getParameter("passwd");
		String name   = request.getParameter("name");
		
		Connection conn         = null;
		PreparedStatement pstmt = null;
		
		try {
			
			Class.forName("com.mysql.cj.jdbc.Driver");	
			
			String url       = "jdbc:mysql://localhost:3306/login_ex?serverTimezone=UTC";
			String user      = "root";
			String password  = "1234";
			
			conn = DriverManager.getConnection(url , user , password);
			pstmt = conn.prepareStatement("INSERT INTO MEMBER VALUES(?,?,?,NOW())");	
			pstmt.setString(1, id);				
			pstmt.setString(2, passwd);			
			pstmt.setString(3, name);			
			pstmt.executeUpdate();	
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) try {pstmt.close();} catch (Exception e) {e.printStackTrace();}
			if (conn != null)  try {conn.close();}  catch (Exception e) {e.printStackTrace();}
		}
		
	%>

	<script>
		alert("회원가입 되었습니다.");
		location.href = "00_main.jsp"; 	
	</script>

</body>
</html>