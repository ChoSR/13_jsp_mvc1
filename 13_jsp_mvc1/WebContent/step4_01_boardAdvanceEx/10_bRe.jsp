<%@page import="step4_00_boardEx.BoardAdvanceDto"%>
<%@page import="step4_00_boardEx.BoardAdvanceDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>10_bRe</title>
</head>
<body>

	<%
		int num = Integer.parseInt(request.getParameter("num"));
		BoardAdvanceDto boardAdvanceDto = BoardAdvanceDao .getInstance().getOneBoard(num);
	%>
	
	<div align="center" style="padding-top: 100px">
		<form action="11_bRePro.jsp" method="post" >
			<h2>답변글 입력하기</h2>
			<br>
			<table style="width: 700px;" border="1">
				<colgroup>
					<col width="20%">
					<col width="80%">
				</colgroup>
				<tr>
					<td align="center"><span style="color: red">*</span> 작성자</td>
					<td><input type="text" id="writer" name="writer" /></td>
				</tr>
				<tr>
					<td align="center"><span style="color: red">*</span> 제목</td>
					<td><input type="text" id="subject" name="subject" /></td>
				</tr>
				<tr>
					<td align="center"><span style="color: red">*</span> 이메일</td>
					<td><input type="email" id="email" name="email" /></td>
				</tr>
				<tr>
					<td align="center"><span style="color: red">*</span> 비밀번호</td>
					<td><input type="password"  id="password" name="password" /></td>
				</tr>
				<tr>
					<td align="center">글내용</td>
					<td><textarea rows="10" cols="50" id="content" name="content"></textarea></td>
				</tr>
				<tr align="center">
					<td colspan="2">
						<input type="hidden" name="ref"     value="<%=boardAdvanceDto.getRef() %>">
						<input type="hidden" name="reStep"  value="<%=boardAdvanceDto.getReStep() %>">
						<input type="hidden" name="reLevel" value="<%=boardAdvanceDto.getReLevel() %>">
						<input type="submit" value="답글쓰기">
						<input type="reset"  value="다시작성">
						<input type="button" value="전체게시글보기" onclick="location.href='04_bList.jsp'">
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>