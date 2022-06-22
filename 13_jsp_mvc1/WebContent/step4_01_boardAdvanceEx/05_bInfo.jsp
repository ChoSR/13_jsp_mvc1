<%@page import="step4_00_boardEx.BoardAdvanceDao"%>
<%@page import="step4_00_boardEx.BoardAdvanceDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>05_bInfo</title>
</head>
</head>
<body>

	<%
		int num = Integer.parseInt(request.getParameter("num"));
		BoardAdvanceDto boardAdvanceDto = BoardAdvanceDao.getInstance().getOneBoard(num);
	%>
	
	<div align="center" style="padding-top: 100px">
		<h1>게시글 보기</h1>
		<br>
		<table style="width: 700px; text-align: center" border="1">
			<colgroup>
				<col width="20%">
				<col width="80%">
			</colgroup>
			<tr>
				<td>글번호</td>
				<td><%=boardAdvanceDto.getNum()%></td>
			</tr>
			<tr>
				<td>조회수</td>
				<td><%=boardAdvanceDto.getReadCount()%></td>
			</tr>
			<tr>
				<td>작성자</td>
				<td><%=boardAdvanceDto.getWriter()%></td>
			</tr>
			<tr>
				<td>작성일</td>
				<td><%=boardAdvanceDto.getRegDate()%></td>
			</tr>
			<tr>
				<td>이메일</td>
				<td><%=boardAdvanceDto.getEmail()%></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><%=boardAdvanceDto.getSubject()%></td>
			</tr>
			<tr class="table-default">
				<td>글 내용</td>
				<td><%=boardAdvanceDto.getContent()%></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="button" value="답글쓰기"  onclick="location.href='10_bRe.jsp?num=<%=boardAdvanceDto.getNum()%>'"> 
					<input type="button" value="수정하기"  onclick="location.href='06_bUpdate.jsp?num=<%=boardAdvanceDto.getNum()%>'">
					<input type="button" value="삭제하기"  onclick="location.href='08_bDelete.jsp?num=<%=boardAdvanceDto.getNum()%>'">
					<input type="button" value="목록보기"  onclick="location.href='04_bList.jsp'">
				</td>
			</tr>
		</table>
	</div>
</body>
</html>