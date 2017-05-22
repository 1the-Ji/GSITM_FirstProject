<%--
author  : 김준호
since   : 2017. 4. 20.
version : 1.0
subject : 예약 안내 화면
description : 회의실 및 교육실 예약 안내 화면
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<script src="${pageContext.servletContext.contextPath}/resources/js/jquery.min.js"></script>
<style>
	#container {
		margin-top: 30px;
	}
	/* 내용 스타일 */
	#content {
		background: #e9e9e9;
		width: 1000px;
		/* height: 345px; */
		margin: auto;
		padding: 20px;
	}
	/* 특수문자 강조 스타일 */
	.specialCharacter {
		color: #336699;
	}
	p{
		font-size:20px;
	}
</style>
</head>
<body>
<jsp:include page="/view/common/header.jsp"></jsp:include>
	<h2>예약안내</h2>
	<hr>
	<div id="container">
		<div id ="content">
	    	<p><strong><span class="specialCharacter">></span> 예약안내</strong></p>
		    <p>·회의실 및 교육실은 최대 3일까지 예약 가능합니다.
		    <p>·회의실을 여러 일자 예약할 경우, 상위결제자의 승인을 받은 후 회의실 담당자의 승인을 받아야 합니다.</p>
		    <p>·교육실을 여러 일자 예약할 경우, 상위결제자의 승인을 받은 후 교육실 담당자의 승인을 받아야 합니다.</p>
		    <p><strong><span class="specialCharacter">></span> 예약취소</strong></p>
		    <p>·회의실은 예약 후, 사용시간 2시간 전부터는 취소가 불가능합니다.
		    <p>·회의실 및 교육실 담당자의 예약승인이 이루어지면 예약취소가 불가능합니다.
		    <p><strong><span class="specialCharacter">></span> 회의실 비용</strong></p>
		    <p>·회의실을 다수의 팀이 함께 사용하는 경우, 회의실 사용요금은 [1/팀 수]
		</div>
	</div>
	<jsp:include page="/view/common/footer.jsp"></jsp:include>
</body>
</html>
