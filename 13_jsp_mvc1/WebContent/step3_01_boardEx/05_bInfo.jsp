<%@page import="step3_00_boardEx.BoardDto"%>
<%@page import="step3_00_boardEx.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bInfo</title>
</head>
<body>
	
	<%
		int num = Integer.parseInt(request.getParameter("num"));
		BoardDto boardDto = BoardDao.getInstance().getOneBoard(num);
		
	%>
	
	<h2>게시글 보기</h2>
	<br>
	<table border="1">
		<tr>
			<td>글번호</td>
			<td><%=boardDto.getNum() %></td>
		</tr>
		<tr>
			<td>조회수</td>
			<td><%=boardDto.getReadCount() %></td>
		</tr>
		<tr>
			<td>작성자</td>
			<td><%=boardDto.getWriter() %></td>
		</tr>
		<tr>
			<td>작성일</td>
			<td><%=boardDto.getRegDate() %></td>
		</tr>
		<tr>
			<td>이메일</td>
			<td><%=boardDto.getEmail() %></td>
		</tr>
		<tr>
			<td>제목</td>
			<td><%=boardDto.getSubject() %></td>
		</tr>
		<tr>
			<td>글내용</td>
			<td><%=boardDto.getContent() %></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="button" value="수정하기" onclick="location.href='06_bUpdate.jsp?num=<%=boardDto.getNum() %>'">
				<input type="button" value="삭제하기" onclick="location.href='08_bDelete.jsp?num=<%=boardDto.getNum() %>'">
				<input type="button" value="목록보기" onclick="location.href='04_bList.jsp'">
			</td>
		</tr>
	</table>
	
</body>
</html>