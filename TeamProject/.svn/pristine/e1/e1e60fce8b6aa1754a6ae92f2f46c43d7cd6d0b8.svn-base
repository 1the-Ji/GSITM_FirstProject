<%--
	author  : 지승훈
	since   : 2017. 5. 2.
	version : 1.0
	subject : 로그인 화면
	description : 로그인을 하기위한 폼
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta charset="UTF-8">
<script src="${pageContext.servletContext.contextPath}/resources/js/jquery.min.js"></script>
<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/css/common.css">
<style>
body {
	background-image:url(https://scontent-icn1-1.xx.fbcdn.net/v/t31.0-8/12113328_972673629458703_3952166403536460003_o.jpg?oh=32fb7fe7ebe26d2493e2c0cd8f8dd406&oe=594F8B2B);
	height: 100%;
   margin: 0;
   background-position: center;
   background-repeat: no-repeat;
   background-size: cover;
}

html {
	font-size: 62.5%;
}

.cb41w1 h2 {
	text-align: center;
	font-weight: normal;
	margin: 0 0 30px 0;
	font-size: 4rem;
}

.cb41w1 ul {
	padding-left:15px;
}

.cb41w1 li {
	list-style-type: none;
}
.cb41w4 input[type="submit"]{
	display:block;
	margin: 0 auto;
}
@keyframes cb41FadeIn {
	0%{
		transform: translateY(2.5em);
		opacity: 0
	}
	35%{
		transform:translateY(2.5em);
		opacity:0
	}
	100%{
		transform:translateY(0);
		opacity:1
	}
}
.cb41w1 {
	width: 400px;
	height: 300px;
	padding: 30px;
	position: absolute;
	top: 50%;
	left: 50%;
	margin-left:-200px;
	margin-top:-150px;
	background: rgba(255, 255, 255, 0.85);
	animation: cb41FadeIn 1.2s 0s 1 cubic-bezier(0, 0, 0.2, 1) forwards;
}
.cb41w1 label {
	display: block;
	text-align: center;
	color: #405f73;
	width: 100%;
	position: absolute;
	font-size: 1.8rem;
	bottom: 22%;
}
.cb41w1 input[type="text"], .cb41w1 input[type="password"] {
	text-align: center;
	background: none;
	color: #001d26;
	width: 80%;
	border: none;
	height: 1.8em;
	position: absolute;
	left: 50%;
	margin-left: -40%;
	font-size: 1.8rem;
	top: 36%;
	z-index: 3
}
.cb41w2, .cb41w3 {
	border-bottom: 1px solid #b7cdd9;
	position: relative;
	padding: 2.4rem 0 1rem 0;
	height: 3.4rem;
	text-align: center
}

.cb41w2:before, .cb41w3:before {
	content: "";
	background-position: 0 0;
	background-size: 360%;
	width: 3.4rem;
	height: 3.4rem;
	position: absolute;
	left: 0
}
.cb41w3:before {
	background-position: 0 36%
}
.cb41w4 {
	margin-top: 6px
}
input[type="submit"] {
	width: 100%;
	background: #1f4f82;
	padding: 16px;
	margin: 0;
	border: none;
	text-align: center;
	font-weight: bold;
	font-size: 2.2rem;
	color: #FFF;
	cursor: pointer;
}
input[type="submit"]:hover{
	background: #007cba;
	outline: 1px solid #FFF
}
.cb41w2:before, .cb41w3:before
	{
	background-image:
		url("data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNjUuOCIgaGVpZ2h0PSIxNzMuMyIgdmlld0JveD0iMCAwIDE2NS44IDE3My4zIj48cGF0aCBmaWxsPSIjOEFBREJFIiBkPSJNMzguOCAzM2MtLjMtMi4xLTEuNi0zLjktMy41LTQuOGwtOS44LTQuNmMwIC4xLTEgNC4zLTUuNyA2LjgtNC44LTIuNS01LjctNi43LTUuNy02LjhsLTkuOCA0LjZDMi40IDI5LjIgMS4xIDMxIC44IDMzTDAgNDEuNmgzOS4zbC0uNS04LjZ6TTEyLjQgMTIuOGwuMyAyLjJjLjEuNy43IDEuMyAxLjQgMS4zLjggNS41IDQuOSA1LjcgNS42IDUuNy42IDAgNC44LS4yIDUuNi01LjcuNyAwIDEuNC0uNSAxLjUtMS4zbC4zLTIuMmMuMS0uNi0uMi0xLjItLjctMS41LjItLjkuNS0yLjcuNS00LjIgMC0yLjctMi40LTUuNC01LjYtNS43bC0xLTEuNGMtNy43LjQtNy43IDYuNy03LjcgNi43di44YzAgMS40LjMgMyAuNSAzLjktLjUuMi0uOC44LS43IDEuNHptMjEgNzcuN1Y2Ny44aC01LjJ2LTYuM0MyOC4yIDU1LjEgMjMgNTAgMTYuNyA1MFM1LjIgNTUuMiA1LjIgNjEuNXY2LjNIMHYyMi43bTE4LjYtMTAuOXY0LjJjMCAxLS44IDEuOS0xLjkgMS45cy0xLjktLjgtMS45LTEuOXYtNC4yYy0xLjEtLjYtMS45LTEuOC0xLjktMy4yIDAtMi4xIDEuNy0zLjcgMy43LTMuN3MzLjcgMS43IDMuNyAzLjdjLjEgMS4zLS42IDIuNS0xLjcgMy4yek0yMyA2Ny44SDEwLjR2LTYuM2MwLTMuNSAyLjgtNi4zIDYuMy02LjNTMjMgNTggMjMgNjEuNXY2LjN6Ii8+PHBhdGggZmlsbD0iIzMyNEI1QyIgZD0iTTg4LjggMzNjLS4zLTIuMS0xLjYtMy45LTMuNS00LjhsLTkuOC00LjZjMCAuMS0xIDQuMy01LjcgNi44LTQuOC0yLjUtNS43LTYuNy01LjctNi44bC05LjggNC42Yy0xLjkuOS0zLjIgMi43LTMuNSA0LjhsLS44IDguNmgzOS4zbC0uNS04LjZ6TTYyLjQgMTIuOGwuMyAyLjJjLjEuNy43IDEuMyAxLjQgMS4zLjggNS41IDQuOSA1LjcgNS42IDUuNy42IDAgNC44LS4yIDUuNi01LjcuNyAwIDEuNC0uNSAxLjUtMS4zbC4zLTIuMmMuMS0uNi0uMi0xLjItLjctMS41LjItLjkuNS0yLjcuNS00LjIgMC0yLjctMi40LTUuNC01LjYtNS43bC0xLTEuNGMtNy43LjQtNy43IDYuNy03LjcgNi43di44YzAgMS40LjMgMyAuNSAzLjktLjUuMi0uOC44LS43IDEuNHptMjEgNzcuN1Y2Ny44aC01LjJ2LTYuM0M3OC4yIDU1LjEgNzMgNTAgNjYuNyA1MHMtMTEuNSA1LjItMTEuNSAxMS41djYuM0g1MHYyMi43bTE4LjYtMTAuOXY0LjJjMCAxLS44IDEuOS0xLjkgMS45cy0xLjktLjgtMS45LTEuOXYtNC4yYy0xLjEtLjYtMS45LTEuOC0xLjktMy4yIDAtMi4xIDEuNy0zLjcgMy43LTMuN3MzLjcgMS43IDMuNyAzLjdjLjEgMS4zLS42IDIuNS0xLjcgMy4yek03MyA2Ny44SDYwLjR2LTYuM2MwLTMuNSAyLjgtNi4zIDYuMy02LjNTNzMgNTggNzMgNjEuNXY2LjN6TTY4LjggMTAwYy0xMC40IDAtMTguOCA4LjQtMTguOCAxOC44czguNCAxOC44IDE4LjggMTguOCAxOC44LTguNCAxOC44LTE4LjhTNzkuMiAxMDAgNjguOCAxMDB6bTIuMSAzMGgtNC4ydi0xNGg0LjJ2MTR6bTAtMTYuOGgtNC4yVjEwOWg0LjJ2NC4yeiIvPjxwYXRoIGZpbGw9IiM0NzVDNkMiIGQ9Ik0xNi43IDEzMGg0LjJ2LTE0aC00LjJ2MTR6bTAtMjF2NC4yaDQuMlYxMDloLTQuMnoiLz48cGF0aCBmaWxsPSIjNDc1QzZDIiBkPSJNMTguOCAxMDBDOC40IDEwMCAwIDEwOC40IDAgMTE4LjhzOC40IDE4LjggMTguOCAxOC44IDE4LjgtOC40IDE4LjgtMTguOFMyOS4yIDEwMCAxOC44IDEwMHptMCAzNS42Yy05LjMgMC0xNi44LTcuNS0xNi44LTE2LjhTOS42IDEwMiAxOC44IDEwMnMxNi44IDcuNSAxNi44IDE2LjgtNy41IDE2LjgtMTYuOCAxNi44eiIvPjxwYXRoIGZpbGw9Im5vbmUiIGQ9Ik0uMSAxNTBoMTgwLjR2NDEuMUguMVYxNTB6Ii8+PGc+PHBhdGggZmlsbD0iI0ZGRiIgZD0iTTY5IDE2My41aDEwLjZsLTUuNi05LTEwLjIgMTYuM2gtNC43bDEyLjUtMTkuNWMuNS0uOCAxLjQtMS4zIDIuNC0xLjNzMS45LjUgMi40IDEuMmwxMi41IDE5LjZoLTQuN2wtMi4yLTMuNkg3MS40bC0yLjQtMy43em00OC41IDMuN3YtMTdoLTR2MTguNmMwIC41LjIgMSAuNiAxLjRzLjkuNiAxLjUuNmgxOC4xbDIuMy0zLjZoLTE4LjV6TTUyIDE2NC4xYzMuOCAwIDctMy4xIDctNyAwLTMuOC0zLjEtNy03LTdIMzQuN3YyMC42aDR2LTE3aDEzLjFjMS44IDAgMy4zIDEuNSAzLjMgMy4zcy0xLjUgMy4zLTMuMyAzLjNINDAuNmwxMS44IDEwLjNoNS44bC04LTYuNyAxLjguMnptLTQxLjcgNi43Yy01LjcgMC0xMC4zLTQuNi0xMC4zLTEwLjNzNC42LTEwLjMgMTAuMy0xMC4zaDEyYzUuNyAwIDEwLjMgNC42IDEwLjMgMTAuM3MtNC42IDEwLjMtMTAuMyAxMC4zaC0xMnptMTEuNy0zLjZjMy43IDAgNi43LTMgNi43LTYuN3MtMy02LjctNi43LTYuN0gxMC42Yy0zLjcgMC02LjcgMy02LjcgNi43czMgNi43IDYuNyA2LjdIMjJ6bTc1LjIgMy42Yy01LjcgMC0xMC4zLTQuNi0xMC4zLTEwLjNzNC42LTEwLjMgMTAuMy0xMC4zaDE0LjJsLTIuMyAzLjZIOTcuNWMtMy43IDAtNi43IDMtNi43IDYuN3MzIDYuNyA2LjcgNi43aDE0LjNsLTIuMyAzLjZIOTcuMnptNDguNC0zLjZjLTMgMC01LjYtMi02LjQtNC44aDE2LjlsMi4zLTMuNmgtMTkuM2MuOC0yLjggMy40LTQuOSA2LjQtNC45aDExLjZsMi4zLTMuNmgtMTQuMmMtNS43IDAtMTAuMyA0LjYtMTAuMyAxMC4zczQuNiAxMC4zIDEwLjMgMTAuM2gxMi4ybDIuMy0zLjYtMTQuMS0uMXptMTYuMS0xNC44YzAtMSAuOC0xLjggMS44LTEuOHMxLjguOCAxLjggMS44LS44IDEuOC0xLjggMS44LTEuOC0uOC0xLjgtMS44em0xLjggMi4zYzEuMyAwIDIuMy0xIDIuMy0yLjNzLTEtMi4zLTIuMy0yLjMtMi4zIDEtMi4zIDIuMyAxLjEgMi4zIDIuMyAyLjN6bS0uMi0zLjdjLjQgMCAuNSAwIC43LjEuNS4yLjUuNi41Ljd2LjJjMCAuMS0uMS4zLS4zLjRsLS4xLjEuNiAxLjFoLS43bC0uNS0xaC0uNHYxaC0uNVYxNTFoLjd6bS4yIDEuMmMuMiAwIC4zIDAgLjQtLjIgMC0uMS4xLS4xLjEtLjJzLS4xLS4zLS4yLS4zaC0uNnYuN2guM3oiLz48L2c+PGc+PGNpcmNsZSBmaWxsPSIjRDgwMDAwIiBjeD0iMTE4LjgiIGN5PSIxOS44IiByPSIxOC44Ii8+PHBhdGggZmlsbD0ibm9uZSIgZD0iTTExMy41IDMuOWgxMC40djM4LjZoLTEwLjRWMy45eiIvPjx0ZXh0IHRyYW5zZm9ybT0idHJhbnNsYXRlKDExMy40OCAzMC43MjYpIiBmaWxsPSIjRkZGIiBmb250LWZhbWlseT0iJ0FyaWFsLUJvbGRNVCciIGZvbnQtc2l6ZT0iMzEuMjc2Ij4hPC90ZXh0PjwvZz48L3N2Zz4=")
}
</style>
<script>
	$(document).ready(function(){
		$('#userId').focus();
	});
	function loginCheck(){
		if(document.loginForm.userId.value.length==0){
			alert("아이디를 입력하여주세요");
			loginForm.userId.focus();
			return false;
		}
		if(document.loginForm.userPwd.value.length==0){
			alert("비밀번호를 입력하여주세요");
			loginForm.userPwd.focus();
			return false;
		}
	}
</script>
<title>로그인</title>
</head>
<body>
	<div class="cb41w1">
		<h2>로그인</h2>
		<form method="post" name="loginForm" action="login">
			<ul>
				<li>
					<div class="cb41w2">
						<input type="text"  id="userId" name="userId" value="IT0907" maxlength="10"/>
					</div>
				</li>
				<li>
					<div class="cb41w3">
						<input type="password" name="userPwd" value="1234" maxlength="12" style="font-family: Verdana, sans-serif;"/>
					</div>
				</li>
			</ul>
			<div class="cb41w4">
				<span>${message}</span>
				<input type="submit" onclick="return loginCheck()" value="로그인"/>
			</div>
		</form>
	</div>
</body>
</html>