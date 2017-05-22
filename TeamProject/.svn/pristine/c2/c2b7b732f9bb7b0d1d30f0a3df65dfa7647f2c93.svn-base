<%--
	author  : 지승훈
	since   : 2017. 5. 2.
	version : 1.0
	subject : 로그인한 회원의 정보 조회 화면
	description : GSITM 임직원들의 회원 정보 및 로그인한 회원은 예약 현황 조회 및 관리를 하기위한 폼
--%>
<%@page import="com.gsitm.common.ConstString"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/css/common.css">
		<script src="${pageContext.servletContext.contextPath}/resources/js/jquery.min.js"></script>
		<title>My Page</title>
		<style>
			.userInfo{
				background-color: #e9e9e9;
				width: 1000px;
				margin: 0 auto;
				padding: 20px 0px;
			}
			#userPhoto{
				border-radius:40px;
			}
			.userInfo table{
				width: 1000px;
				/* margin-left: 50px; */
			}
			.userInfo table tr:nth-child(1) td:nth-child(1){
				text-align:center;

			}
			.userInfo table tr:nth-child(2) td{
				text-align: center;
			}
			.userInfo ul li {
				height: 30px;
			}
			.reservation input[type=button] {
				width: 80px;
				height: 30px;
			}
			.reservation table, .reservation th,.reservation td{
				border-collapse:collapse;
				border:1px solid #B1B1B1;
				padding: 5px;
			}
			#reservationLsit{
				text-align: center;
				width: 1000px;
				margin: 0 auto;
			}
			#reservationLsit table{
				margin: 0 auto;
				width: 1000px;
			}
			#div_font{
				width:1000px;
				margin: 0 auto;
			}
		</style>
		<script>
			$(document).ready(function () {
				$('#filterSelect').val('${param.filter}').prop("selected", true);
			});
		

			function moveCancelReg(regInId, startDate){
				if(confirm("예약을 취소하시겠습니까?") == true){
					location.href="./reservedelete?regInId=" + regInId + "&startDate=" + startDate;
				}else{
					return;
				}
			}
			function moveUpdateReg(regInId){
				var url ="./reserveupdate?resId=" + regInId;
				window.open(url,'', 'width=910px, height=710px, left= '+(screen.availWidth/2 - 450)+', top=20');
			}
			function moveDetailView(regInId) {
				var url ="./mailformgen?type=mypage&regId=" + regInId;
				window.open(url,'', 'width=910px, height=710px, left= '+(screen.availWidth/2 - 450)+', top=20');
			}
 		</script>
	</head>
	<body>
		<jsp:include page="/view/common/header.jsp"></jsp:include>
		<h2>My Page</h2>
		<hr/>
		<div id="div_font">
			<h3>※ 내 프로필</h3>
		</div>
		<section class="userInfo">
			<table>
				<tr>
					<td>
						<img id="userPhoto" src="${Employee.empPhoto}">
					</td>
					<td>
						<ul>
		 					<li>이름 : ${Employee.empName}</li>
			 				<li>사번 : ${Employee.empId}</li>
			 				<li>조직 : ${Employee.depName}</li>
			 				<li>이메일 : ${Employee.email}</li>
			 			</ul>
					</td>
				</tr>
				<tr>
					<!-- <td>프로필</td> -->
					<td></td>
					<td></td>
				</tr>
			</table>
		</section>
		<div id="div_font">
			<h3>※ 예약내역</h3>
		</div>
		<section class="reservation">
			<div id="reservationLsit">
				<div class="head" style="height: 40px; text-align: left; margin: 10px 0px;">
					<form method="GET">
					<select id="filterSelect" name=filter style="height:25px; width: 120px; margin: 7px 10px;">
						<option value="all">전체내역</option>
						<option value="req">신청내역</option>
						<option value="sign">결재완료</option>
						<option value="appro">승인완료</option>
						<option value="finish">사용완료</option>
						<option value="cencel">취소내역</option>
						<option value="reject">반려내역</option>
					</select>
					<button class="btn-bold" style="width: 100px; height: 24px; margin-left: -10px;">조회</button>
					</form>
				</div>
				<table>
					<tr>
						<th width="10%">회의실</th>

						<th width="20%">사용목적</th>
						<th width="22%">이용시간</th>
						<th>신청일자</th>
						<th>예약상태</th>
						<th style="width: 200px;">예약사항</th>
					</tr>
					<c:forEach var="res" items="${reservationList}" varStatus="status">
					<tr>
						<td>${rooms[status.index].roomName}</td>
						<td>${res.usePurpose}</td>
						<c:if test="${res.regTerm eq 'day'}">
							<td>
								<span style="color: #999;">단기예약</span>
								<fmt:formatDate pattern = "yyyy-MM-dd HH:mm" value = "${res.startDate}"/>~
     							<fmt:formatDate pattern = "HH:mm" value = "${res.finishDate}"/>
        					</td>
						</c:if>
						<c:if test="${res.regTerm eq 'period'}">
							<td>
								<span style="color: #999;">기간예약</span>
								${res.startDate}<br>~${res.finishDate}</td>
						</c:if>
						<%-- <td>${teamsList[status.index]}</td> --%>
						<%-- <td><fmt:formatNumber value="${res.fee}" type="number"/>원</td> --%>
						<td>${res.regDate}</td>
						<td>${res.regState}</td>
						<td style="width: 160px;">
							<c:if test="${modAbleList[status.index] eq 'true'}">
								<input type="button" id="updateBtn" class="btn-bold" onclick="moveUpdateReg('${res.regInId}');" value="예약변경">&nbsp;
								<input type="button" id="cancelBtn" class="btn-red" onclick="moveCancelReg('${res.regInId}', '<fmt:formatDate pattern = "yyyy-MM-dd HH:mm" value = "${res.startDate}"/>')" value="예약취소">
							</c:if>
							<c:if test="${modAbleList[status.index] eq 'false'}">
								<input type="button" class="btn-gray" style="width: 168px;" onclick="moveDetailView('${res.regInId}')" value="상세보기">
							</c:if>
						</td>
					</tr>
					</c:forEach>
				</table>
			</div>
		</section>
	<jsp:include page="/view/common/footer.jsp"></jsp:include>
	</body>
</html>