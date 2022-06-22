<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>02_bWrite</title>
</head>
<body>
	<div align="center" style="padding-top: 100px">
		<form action="03_bWritePro.jsp" method="post">
			<h2>게시글 쓰기</h2>
			<br>
			<table style="width: 700px;" border="1">
				<colgroup>
					<col width="20%">
					<col width="80%">
				</colgroup>
				<tr>
					<td align="center"><span style="color: red">*</span> 작성자</td>
					<td><input type="text"  id="writer" name="writer" /></td>
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
					<td><input type="password" id="password" name="password" /></td>
				</tr>
				<tr>
					<td align="center">글내용</td>
					<td><textarea rows="10" cols="50" id="content" name="content"></textarea></td>
				</tr>
				<tr align="center">
					<td colspan="2">
						<input type="submit" value="글쓰기" />
						<input type="reset"  value="다시작성" />
						<input type="button" value="전체게시글보기" onclick="location.href='04_bList.jsp'">
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>