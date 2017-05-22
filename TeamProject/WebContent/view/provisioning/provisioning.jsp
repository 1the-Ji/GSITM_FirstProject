<%--
author  : 김준호
since   : 2017. 5. 10.
version : 1.0
subject : 담당자 권한 관리
description : 회의실 및 교육실 담당자 권한 관리 화면
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>담당자 권한 관리</title>
<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/css/jquery-ui.css">
<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/css/common.css">
<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/css/jquery.treeview.css">
<script src="${pageContext.servletContext.contextPath}/resources/js/jquery.min.js"></script>
<script src="${pageContext.servletContext.contextPath}/resources/js/jquery-ui.min.js"></script>
<script src="${pageContext.servletContext.contextPath}/resources/js/jquery.treeview.js"></script>
<script src="${pageContext.servletContext.contextPath}/resources/js/jquery.cookie.js"></script>
<style type="text/css">
	#div0 {
		width: 100%;
		position: relative;
	}
	#div1 {
		width: 100%;
		height: 50px;
		position: relative;
	}
	#div2 {
		margin: auto;
		width: 1000px;
		height: 220px;
		position: relative;
		display: table;
	}
	#div2_content {
		background-color: #e9e9e9;
		vertical-align: middle;
		display: table-cell;
	}
	#div2_content p {
		margin-left: 30px;
	}
	#div3 {
		margin: auto;
		top: 10px;
		width: 1000px;
		height: 130px;
		position: relative;
		background-color: #e9e9e9;
		text-align: center;
		display: table-cell;
		vertical-align: middle;
	}
	#div4 {
		width: 100%;
		height: 20px;
		margin: 20px;
		text-align: center;
	}
	/* 관리자 권한 관리 테이블 스타일 */
	#selectAdminTable {
		margin: 0 auto;
	}
	#selectAdminTable td {
		width: 150px;
	}
	/* 직원리스트 테이블 위치 */
	#showDepEmployees {
		float: left;
	}
	/* 조직도 위치 */
	#tree {
		float: left;
	}
	#buttonContainer {
		margin: 0 auto;
		width: 1000px;
		text-align: center;
		margin-top: 30px;
	}
	/* 선택 및 삭제버튼 스타일 */
	input[type="button"] {
		width: 154px;
		height: 25px;
		font-size: 10pt;
	}
	input[type="submit"] {
		width: 200px;
		height: 30px;
		font-size: 11pt;
	}
	input[type="text"] {
		margin: 1px 10px;
		width: 150px;
		height: 24px;
		text-align: center;
		font-size: 12pt;
		font-weight: bold;
	}
	#div_font {
		margin: 0 auto;
	}
	#contents_wrapper {
		width: 1000px;
    	margin: 0 auto;
	}
</style>
<script type="text/javascript">
	/* 조직도 트리 */
	$(function() {
		$("#tree").treeview({
			collapsed: true,
			animated: "medium",
			control:"#sidetreecontrol",
			persist: "location"
		});
		//회의실 관리자를 삭제했을 경우
		$('#conEmpRemove').click(function () {
			$('#confManagerList').val("");
		});
		//교육실 관리자를 삭제했을 경우
		$('#eduEmpRemove').click(function () {
			$('#eduManagerList').val("");
		});
	})
	//조직도 팝업창
	function open_orgChart(url){
		window.open(url, "", 'left='+(screen.availWidth-560)/2+',top='+(screen.availHeight-480)/2+', width=560px, height=430px');
	}
	//회의실 관리자 선택창
	function setConfManager(empName, empId) {
		//회의실 관리자의 값을 지움
		$('#confManagerList').val(empName + ' (' + empId + ')');
		$("#newConfAdminEmpId").val(empId);
	}
	//교육실 관리자 선택창
	function setEduManager(empName, empId) {
		$('#eduManagerList').val(empName + ' (' + empId + ')');
		$('#newEduAdminEmpId').val(empId);
	}
	//관리자 선택 유효성 체크
	function isSelextBoxEmpty() {
	  	if($('#confManagerList').val() == ''){
			alert('회의실 관리자를 선택해주세요');
			return false;
	  	}
	  	else if($('#eduManagerList').val() == ''){
	  		alert('교육실 관리자를 선택해주세요');
			return false;
	  	}
	  	else {
			return true;
	  	}
	}
</script>
</head>
<body>
<jsp:include page="/view/common/header.jsp"></jsp:include>
<div id="div0">
	<div id="div1">
		<h2>권한 관리</h2>
		<hr>
	</div>
	<div id="contents_wrapper">
		<div id="div_font">
			<h3>※ 회의실 담당자 선택시 주의사항</h3>
		</div>

		<div id="div2">
			<div id="div2_content">
				<p>● 회의실 및 교육실 관리자는 반드시 지정해주어야 합니다.</p>
				<p>● 회의실 및 교육실 관리자는 같은 직원으로 설정할 수 없습니다.</p>
				<p>● 회의실 관리자는 회의실 및 대회의실 예약에 대한 승인권한이 있습니다.</p>
				<p>● 교육실 관리자는 교육실 예약에 대한 승인권한이 있습니다.</p>
				<p>● 시스템 관리자는 회의실 및 교육실 </p>
			</div>
		</div><br>
		<h3>※ 관리자 권한 관리</h3>
		<form action="provisioning" method="post">
		<div id="div3">
			<div id="selectAdminTableDiv">
				<table id="selectAdminTable">
					<tr>
						<td>회의실 관리자</td>
						<td>교육실 관리자</td>
					</tr>
					<tr>
						<td>
							<!-- 기존의 회의실 관리자를 출력 -->
							<c:if test="${oldConfAdmin != null}">
								<input type="text" id="confManagerList" name="curConfAdminEmpId" value="${oldConfAdmin.empName} (${oldConfAdmin.empId})" readonly="readonly">
								<!-- 기존의 회의실 관리자 아이디 전달 -->
								<input type="hidden" id="newConfAdminEmpId" name="newConfAdminEmpId" value="${oldConfAdmin.empId}"/>
								<input type="hidden" id="oldConfAdminEmpId" name="oldConfAdminEmpId" value="${oldConfAdmin.empId}"/>
							</c:if>
						</td>
						<td>
							<!-- 기존의 교육실 관리자를 출력 -->
							<c:if test="${oldEduAdmin != null}">
								<input type="text" id="eduManagerList" name="curEduAdminEmpId" value="${oldEduAdmin.empName} (${oldEduAdmin.empId})" readonly="readonly">
								<!-- 기존의 교육실 관리자 아이디 전달 -->
								<input type="hidden" id="newEduAdminEmpId" name="newEduAdminEmpId" value="${oldEduAdmin.empId}"/>
								<input type="hidden" id="oldEduAdminEmpId" name="oldEduAdminEmpId" value="${oldEduAdmin.empId}"/>
							</c:if>
						</td>
					</tr>
					<tr>
						<td>
							<input type="button" id="selectBtn1" class="btn-gray" value="선택" onclick="open_orgChart('./organizationchart?mode=conf')" />
						</td>
						<td>
							<input type="button" id="selectBtn2" class="btn-gray" value="선택" onclick="open_orgChart('./organizationchart?mode=edu')" />
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div id="buttonContainer">
			<input type="submit" class="btn-bold" value="저장" onclick="return isSelextBoxEmpty()"/>
		</div>
		</form>
	</div>
</div>
</body>
</html>