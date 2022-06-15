<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>update</title>
<link href="../css/bootstrap.min.css" rel="stylesheet" type="text/css">
<style>
	#login_wrapper {
		position: absolute;
		top:25%;
		left:47%;
		margin-left:-150px;
	}
</style>
<script>
	
	function formValidationCheck() {
	
		var id = document.getElementById("id");
		if (id.value == "") {
			alert("아이디를 입력하세요.");
			id.focus();
			return false;
		}
		
		var passwd = document.getElementById("passwd");
		if (passwd.value == "") {
			alert("패스워드를 입력하세요.");
			passwd.focus();
			return false;
		}
		
		var name = document.getElementById("name");
		if (name.value == "") {
			alert("이름을 입력하세요.");
			name.focus();
			return false;
		}
		
	}

</script> 
</head>
<body>
	<div id="login_wrapper">
		<h3 align="center">회원 수정</h3>
		<br>
		<form method="post" action="06_updatePro.jsp" onsubmit="return formValidationCheck()">
			<div class="form-group">
				<label for="id">아이디</label>
				<input type="text" name="id" id="id" class="form-control" size="40" autofocus>
			</div>
			<div class="form-group">
				<label for="passwd">패스워드</label>
				<input type="password" name="passwd" id="passwd" class="form-control" >
			</div>
			<div class="form-group">
				<label for="name">이름</label>
				<input type="text" name="name" id="name" class="form-control">
			</div>
			<div class="form-group" align="right">
				<input type="submit" value="수정" class="btn btn-primary">
			</div>
		</form>	
	</div>
</body>
</html>