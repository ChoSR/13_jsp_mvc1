<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>01_main</title>
</head>
<%--

	[ 계층형 댓글 처리 관련 정보 ]
	
	
	num     : 게시글의 고유번호  ( 원본글과 댓글은 모두 num이 다르다. )
	ref     : 게시글의 그룹번호  ( 한 원본글과 그 아래 있는 댓글들은 모두 ref가 같다. )
	reLevel : 게시글의 계층 	 (주로 depth로 표현)
			
			원본글 : 1
			원본글의 댓글 : 2
			원본글의 댓글의 댓글 : 3
			원본글의 댓글의 댓글의 댓글 : 4
			
	reStep : 한 게시글 그룹의 게시글 순서
	
			 쿼리문에서 order by로 정렬하여 화면에 표기한다.
							ref desc [내림차순]
							re_step  [오름차순] 
			 
			 - 마지막글 추가이면 re_step = restep + 1을 해주면 된다.
			 - (헷갈림)중간글 추가(가운데 있는 댓글의 댓글)이면 
			 	내가 추가하는 게시글의 re_step보다 re_step = re_step+1로 들어가고
			   추가되는 위치보다 뒤에 있는 re_step은 전부다 +1씩 늘려준다.
							
	
	예시 (위에서 아래로 순서대로 작성했다는 가정)
	
	원본글1								: num = 1 / ref = 1 / level = 1 / step = 1 
		> 댓글1-1						: num = 2 / ref = 1 / level = 2 / step = 2
			> 댓글 1-1-1				: num = 3 / ref = 1 / level = 3 / step = 3
		> 댓글1-2						: num = 4 / ref = 1 / level = 2 / step = 4
			> 댓글 1-2-1				: num = 5 / ref = 1 / level = 3 / step = 5
			> 댓글 1-2-2				: num = 6 / ref = 1 / level = 3 / step = 6
		> 댓글1-3						: num = 7 / ref = 1 / level = 2 / step = 7
		
	원본글2								: num =  8 / ref = 2 / level = 1 / step = 1 
		> 댓글2-1						: num =  9 / ref = 2 / level = 2 / step = 2 
			> 댓글 2-1-1				: num = 10 / ref = 2 / level = 3 / step = 3
		> 댓글2-2						: num = 11 / ref = 2 / level = 2 / step = 4

--%>

<body>	
		<img src="../img/jsp.PNG" alt="jsp심볼" width="800px" height="500px"><br><br><br><br>
		<input type="button" value="게시판 보기" onclick="location.href='04_bList.jsp'">
</body>
</html>