<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main</title>
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
	<div id="login_wrapper">
		<div align="center">
			<img src="../img/member.PNG" alt="회원아이콘" height="300px" width="300px">
		</div>
		<a href="01_insert.jsp">회원가입</a> &emsp;
		<a href="03_delete.jsp">회원삭제</a> &emsp;
		<a href="05_update.jsp">회원수정</a> &emsp;
		<a href="07_list.jsp">회원정보 확인</a>
	</div>
</body>
</html>