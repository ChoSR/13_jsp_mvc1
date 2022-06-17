<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insert</title>
<link href="../css/bootstrap.css" rel="stylesheet" type="text/css">
<style>
	#login_wrapper {
		position: absolute;
		top:25%;
		left:50%;
		margin-left:-150px;
	}
</style>
<script>

	function checkPasswordLength() {
		
		if (document.getElementById("passwd").value.length < 8) {
			document.getElementById("passwdMessage").innerHTML = "<span style='color:red;'>비밀번호를 8자 이상으로 입력 하세요.</span>";
			return false;
		}
		else {
			document.getElementById("passwdMessage").innerHTML = "";
			return true;
		}
	 
	}
	
	function checkConfirmPassword(){
		
		var passwd        = document.getElementById("passwd"); 
		var confirmPasswd = document.getElementById("confirmPasswd");
		
		if (passwd.value == confirmPasswd.value) {
			confirmPasswd.className = "form-control is-valid";
			return true;
		}
		else {	
			confirmPasswd.className = "form-control is-invalid";
			return false;
		}
		
	}
	
	function formValidationCheck() {
		
		var id = document.getElementById("id");
		if (id.value == "") {
			alert("아이디를 입력하세요.");
			id.focus();
			return false;
		}
		
		var passwd = document.getElementById("passwd");
		if (passwd.value == "") {
			alert("비밀번를 입력하세요.");
			passwd.focus();
			return false;
		}
		
		var confirmPasswd = document.getElementById("confirmPasswd");
		if (confirmPasswd.value == "") {
			alert("비밀번호를 확인하세요.");
			confirmPasswd.focus();
			return false;
		}
		
		var name = document.getElementById("name");
		if (name.value == "") {
			alert("이름을 입력하세요.");
			name.focus();
			return false;
		}
		
		
		if (!checkPasswordLength()) {
			alert("비밀번호를 8자 이상으로 생성하세요.");
			return false;
		}
		
		if (!checkConfirmPassword()) {
			alert("비밀번호를 확인하세요.");
			return false;
		}
	
	}
	
</script>

</head>
<body>

	<div id="login_wrapper">
		<h2 align="center">Join Form</h2>
		<br>
		<form method="post" action="02_insertPro.jsp" onsubmit="return formValidationCheck()">
			<div class="form-group">
				<label for="id">Id</label>
				<input type="text" name="id" id="id" class="form-control" size="40" autofocus>
			</div>
			<div class="form-group">
				<label for="passwd">Password</label>
				<input type="password" name="passwd" id="passwd" class="form-control" placeholder="8자 이상 입력" onblur="checkPasswordLength()">
				<div id="passwdMessage"></div>
			</div>
			<div class="form-group">
				<label for="confirmPasswd">Confirm Password</label>
				<input type="password" name="confirmPasswd" id="confirmPasswd" class="form-control" onblur="checkConfirmPassword()">
			</div>
			<div class="form-group">
				<label for="name">Name</label>
				<input type="text" name="name" id="name" class="form-control">
			</div>
			<div class="form-group" align="right">
				<input type="submit" value="Join" class="btn btn-primary">
			</div>
		</form>
	</div>

</body>
</html>