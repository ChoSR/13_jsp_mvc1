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
	
	<%-- 
	
		# 데이터 베이스 연동 방법 
		
		1) mysql_connector.jar파일을 WEB-INF안 폴더의 lib에 넣는다. ( 처음셋팅할때 1번만 )
		2) Class.forName("com.mysql.cj.jdbc.Driver"); 을 작성한다. ( 외울필요 없고 인터넷에서 복사 붙여넣기 해서 사용합니다. )
		3) DriverManager의 getConnection(db연결정보,연결id,연결password) 메소드를 통하여서 Connection 객체를 생성한다.
		4) 쿼리문을 작성하여 선처리문 객체를 생성한다.
		5) 선처리문 객체를 사용하여 sql 쿼리문을 jps에서 실행한다.

		
		# 쉽게 요약한 연동 방법
		
		1) mysql_connector.jar 파일을 lib폴더에 넣는다.
		2) Class.forName("com.mysql.cj.jdbc.Driver"); 입력
		3) Connection 객체를 생성
		4) Connection 객체로 PrepareStatement 객체를 생성한 후 쿼리문을 실행
	
	--%>
	
	<%
		request.setCharacterEncoding("utf-8");
		
		String id	  = request.getParameter("id");
		String passwd = request.getParameter("passwd");
		String name   = request.getParameter("name");
		
		// 데이터 베이스를 연결하기 위한 객체
		Connection conn = null;
		
		// 쿼리문을 실행하기 위한 객체
		PreparedStatement pstmt = null;
		
		try{
			// forName 생성
			Class.forName("com.mysql.cj.jdbc.Driver");	
						
			// DB 연결 정보 >   "jdbc:mysql://DB서버주소:프로토콜번호/DB명?시간동기화"
			String url = "jdbc:mysql://localhost:3306/login_ex?serverTimezone=UTC";
			// DB 연결 계정
			String user = "root";
			// DB 연결 비밀번호
			String password = "1234";
					
			// 데이터 베이스 연동
			conn = DriverManager.getConnection(url , user , password);
			
			/*
				# prepareStatement
	
				- 원래는 statement이었으나 SQL Injection 공격에 대응하는 보안 기법으로 prepareStatement를 사용한다.
				- 먼저 ?로 쿼리문의 형식을 만들고 setter 메서드로 데이터를 대입하여 쿼리문을 완성한다.
				- 인덱스는 1부터 시작한다.
				- pstmt.set자료형(인덱스, 값);
		
				Ex)
				pstmt.setInt(index , value);     // 정수 타입 데이터 적용 메서드
				pstmt.setString(index , value);  // 문자열 타입 데이터 적용 메서드
				pstmt.setDate(index , value);  	 // 날짜 타입 데이터 적용 메서드

			*/
			
			// 선처리문 쿼리 작성
			pstmt = conn.prepareStatement("INSERT INTO MEMBER VALUES(?,?,?,NOW())"); // "INSERT INTO MEMBER VALUES(?,?,?,NOW())"
			
			// 선처리문 쿼리 완성
			pstmt.setString(1, id);												 // "INSERT INTO MEMBER VALUES(id,?,?,NOW())"								
			pstmt.setString(2, passwd);                                          // "INSERT INTO MEMBER VALUES(id,passwd,?,NOW())"
			pstmt.setString(3, name);											 // "INSERT INTO MEMBER VALUES(id,passwd,name,NOW())"
			
			// 쿼리문 실행
			pstmt.executeUpdate();
			
			// executeUpdate() : insert, update, delete 쿼리문 실행 메서드
			// executeQuery()  : select 쿼리문 실행 메서드
			
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			
			// 데이터베이스 연동 종료
			pstmt.close();
			conn.close();
			
		}
		
	%>
	
	<script>
		alert("회원가입이 되었습니다.");
		location.href = "00_main.jsp"; 	// location.href = "url" 은 해당 url로 이동한다.
	</script>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
</body>
</html>