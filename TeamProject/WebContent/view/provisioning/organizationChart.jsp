<%--
author  : 김준호
since   : 2017. 5. 10.
version : 1.0
subject : 조직도
description : 조직도 팝업 화면
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>조직도</title>
<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/css/jquery-ui.css">
<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/css/common.css">
<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/css/jquery.treeview.css">
<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/css/screen.css">
<script src="${pageContext.servletContext.contextPath}/resources/js/jquery.min.js"></script>
<script src="${pageContext.servletContext.contextPath}/resources/js/jquery-ui.min.js"></script>
<script src="${pageContext.servletContext.contextPath}/resources/js/jquery.treeview.js"></script>
<script src="${pageContext.servletContext.contextPath}/resources/js/jquery.cookie.js"></script>
<style>
	/* 조직도 선택창 */
	#sidetree {
		width: 200px;
	    height: 300px;
	    float: left;
	    border: 1px solid #ccc;
	    padding: 10px;
	    margin: 20px;
	    overflow: auto;
	}
	/* 직원리스트 선택창 */
	#showDepEmployees {
		width: 200px;
	    height: 300px;
	    float: left;
	    border: 1px solid #ccc;
	    padding: 10px;
	    margin: 20px;
	    margin-left: -10px;
	    overflow: auto;
		float: left;
	}
	/* 직원리스트 테이블 스타일*/
	#showDepEmployeesTable {
		margin: auto;
		text-align: center;
		border-collapse: collapse;
		border-color: #A6A6A6;
		width: 180px;
	}
	/* 직원리스트 테이블 */
	#table {
		border: solid 1px #DDEEEE;
		border-collapse: collapse;
		border-spacing: 0;
	}
	#table th {
		height: 20px;
		border: solid 1px #DDEEEE;
		background-color: #79a6d3;
	}
	#table td {
		height: 20px;
		text-align: center;
		border: solid 1px #DDEEEE;
	}
	#table tbody tr:nth-child(odd) {
		background-color: #EEF7EE;
	}
	#table tbody tr:nth-child(even) {
		background-color: #fff;
	}
	/* 확인 및 취소 버튼 */
	#ok, #cancel {
		width: 80px;
	}
	/* 확인 및 취소 버튼 div  */
	#buttonContainer{
		float: right;
		margin-right: 30px;
	}
	/* 최상위 div */
	.center {
		width: 500px;
		margin: 0 auto;
	}
	/* 조직도 컨트롤 박스 */
	#sidetreecontrol {
		width: 190px;
		height: 13px;
		padding: 3px;
		border: 1px solid #ccc;
		background-color: #79a6d3;
	}
	#sidetreecontrol a {
		text-decoration: none;
		color: black;
	}
	#tree > li > ul > li > a {
		text-decoration: none;
		color: black;
	}
	#tree > li > ul > li > a:visited {
		text-decoration: none;
		color: black;
	}
	#tree > li > ul > li > ul > li > a {
		text-decoration: none;
		color: black;
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

		//조직도 창에서 선택한 직원의 정보를 회의실 관리자 선택창으로 전달
		$('#ok').click(function () {
			var empName = ""; //이름
			var empId = "";   //사번
			if(opener != null){
				//조직도에서 선택한 이름의 텍스트값을 회의실관리자 선택창으로 가져옴
				$("#table input[type=radio]:checked").parent().parent().children().each(function( index ){
					//체크한 행의 이름
					if(index == 1)
						empName = $(this).text();

					//체크한 행의 사번
					if(index == 2)
						empId = $(this).text();
				});

				if(empName == "" || empId == ""){
					alert("부서 및 이름을 선택하세요.");
					return;
				}
				else {

					if('conf' == '${param.mode}')
						opener.setConfManager(empName, empId);

					if('edu' == '${param.mode}')
						opener.setEduManager(empName, empId);

					window.close();
				}
			}
		});
	})
</script>
</head>
<body>
	<div class="center">
		<div id="sidetree">
			<div class="treeheader">&nbsp;</div>

			<div id="sidetreecontrol">
				<a href="?#">전체 닫기</a> | <a href="?#">전체 열기</a>
			</div>

			<ul id="tree">
				<li>
					<strong>CFO 조직</strong>
					<ul>
						<li><a href="organizationchart?mode=${param.mode}&dep_id=14AA20">CFO 조직</a></li>
						<li><a href="organizationchart?mode=${param.mode}&dep_id=14AA22">재무관리팀</a></li>
					</ul>
				</li>
				<li>
					<strong>기획실</strong>
					<ul>
						<li><a href="organizationchart?mode=${param.mode}&dep_id=14GA00">기획실</a></li>
						<li><a href="organizationchart?mode=${param.mode}&dep_id=14GA02">기획팀</a></li>
						<li><a href="organizationchart?mode=${param.mode}&dep_id=14GA07">QA팀</a></li>
						<li><a href="organizationchart?mode=${param.mode}&dep_id=14GA08">보안파트</a></li>
						<li><a href="organizationchart?mode=${param.mode}&dep_id=14GA09">최적화파트</a></li>
					</ul>
				</li>
				<li>
					<strong>인사지원실</strong>
					<ul>
						<li><a href="organizationchart?mode=${param.mode}&dep_id=14GA10">인사지원실</a></li>
						<li><a href="organizationchart?mode=${param.mode}&dep_id=14GA11">인사파트</a></li>
						<li><a href="organizationchart?mode=${param.mode}&dep_id=A00023">태양광TFT</a></li>
					</ul>
				</li>
				<li>
					<strong>기술연구소</strong>
					<ul>
						<li><a href="organizationchart?mode=${param.mode}&dep_id=14HA00">기술연구소</a></li>
					</ul>
				</li>
				<li>
					<strong>영업총괄센터</strong>
					<ul>
						<li><a href="organizationchart?mode=${param.mode}&dep_id=14KA00">영업총괄센터</a></li>
						<li><a href="organizationchart?mode=${param.mode}&dep_id=14KA02">SI영업팀</a></li>
						<li><a href="organizationchart?mode=${param.mode}&dep_id=14KA03">ICT팀</a></li>
					</ul>
				</li>
				<li>
					<strong>SI사업부</strong>
					<ul>
						<li><a href="organizationchart?mode=${param.mode}&dep_id=14LA00">SI사업부</a></li>
						<li><a href="organizationchart?mode=${param.mode}&dep_id=14LA02">Account Lead</a></li>
						<li><a href="organizationchart?mode=${param.mode}&dep_id=14LA03">기획파트</a></li>
						<li><a href="organizationchart?mode=${param.mode}&dep_id=14LA06">플랜트/ICT사업팀</a></li>
						<li><a href="organizationchart?mode=${param.mode}&dep_id=14LA10">SI사업팀</a></li>
						<li><a href="organizationchart?mode=${param.mode}&dep_id=14LA12">솔루션파트</a></li>
						<li><a href="organizationchart?mode=${param.mode}&dep_id=14LA13">ERP사업팀</a></li>
					</ul>
				</li>
				<li>
					<strong>SM사업부</strong>
					<ul>
						<li><a href="#">인프라총괄센터</a>
							<ul>
								<li><a href="organizationchart?mode=${param.mode}&dep_id=14MA02">인프라총괄센터</a></li>
							</ul>
							<ul>
								<li><a href="organizationchart?mode=${param.mode}&dep_id=14MA03">데이터센터추진 TFT</a></li>
							</ul>
							<ul>
								<li><a href="organizationchart?mode=${param.mode}&dep_id=14MA04">인프라기술지원파트</a></li>
							</ul>
							<ul>
								<li><a href="organizationchart?mode=${param.mode}&dep_id=14MA05">TA지원파트</a></li>
							</ul>
						</li>
						<li><a href="#">GSC SM센터</a>
							<ul>
								<li><a href="organizationchart?mode=${param.mode}&dep_id=14MA08">GSC SM센터</a></li>
							</ul>
							<ul>
								<li><a href="organizationchart?mode=${param.mode}&dep_id=14MA09">경영관리파트</a></li>
							</ul>
							<ul>
								<li><a href="organizationchart?mode=${param.mode}&dep_id=14MA10">재무파트</a></li>
							</ul>
							<ul>
								<li><a href="organizationchart?mode=${param.mode}&dep_id=14MA11">영업물류파트</a></li>
							</ul>
							<ul>
								<li><a href="organizationchart?mode=${param.mode}&dep_id=14MA12">모바일파트</a></li>
							</ul>
							<ul>
								<li><a href="organizationchart?mode=${param.mode}&dep_id=14MA13">인프라파트</a></li>
							</ul>
							<ul>
								<li><a href="organizationchart?mode=${param.mode}&dep_id=14MA14">로열티파트</a></li>
							</ul>
							<ul>
								<li><a href="organizationchart?mode=${param.mode}&dep_id=14MA15">플랜트운영파트</a></li>
							</ul>
						</li>
						<li><a href="#">Shared Service센터</a>
							<ul>
								<li><a href="organizationchart?mode=${param.mode}&dep_id=14MA26">Shared Service센터</a></li>
							</ul>
							<ul>
								<li><a href="organizationchart?mode=${param.mode}&dep_id=14MA16">GSM운영파트</a></li>
							</ul>
						</li>
						<li><a href="#">홈쇼핑 SM센터</a>
							<ul>
								<li><a href="organizationchart?mode=${param.mode}&dep_id=14MA27">홈쇼핑 SM센터</a></li>
							</ul>
							<ul>
								<li><a href="organizationchart?mode=${param.mode}&dep_id=14MA25">기간계개발지원파트</a></li>
							</ul>
							<ul>
								<li><a href="organizationchart?mode=${param.mode}&dep_id=14MA32">PD파트</a></li>
							</ul>
							<ul>
								<li><a href="organizationchart?mode=${param.mode}&dep_id=14MA33">MC개발지원파트</a></li>
							</ul>
							<ul>
								<li><a href="organizationchart?mode=${param.mode}&dep_id=14MA34">인프라운영지원파트</a></li>
							</ul>
						</li>
						<li><a href="#">리테일 SM센터</a>
							<ul>
								<li><a href="organizationchart?mode=${param.mode}&dep_id=14MA29">리테일 SM센터</a></li>
							</ul>
							<ul>
								<li><a href="organizationchart?mode=${param.mode}&dep_id=14MA19">GS리테일팀</a></li>
							</ul>
						</li>
					</ul>
				</li>
				<li>
					<strong>CFO직속</strong>
				</li>
			</ul>
		</div>

		<div id="showDepEmployees"><br>
		<c:if test="${employeesList != null}">
			<table id="table" border="1" width="200">
				<tr>
					<th width=50 >선택</th>
					<th width=50 >이름</th>
					<th width=50 >사번</th>
					<th width=50 >직위</th>
				</tr>
			<c:forEach var="employeesList" items="${employeesList}" varStatus="status">
				<tr>
					<!-- 체크박스 -->
					<td><input type="radio" name="selectedEmployee"/></td>
					<!-- 직원 이름 -->
					<td><input type="hidden" id="empName" name="empName" value="${employeesList.empName}">${employeesList.empName}</td>
					<!-- 직원 아이디 -->
					<td><input type="hidden" id="empId" name="empId" value="${employeesList.empId}">${employeesList.empId}</td>
					<!-- 직원 직위 -->
					<td><input type="hidden" id="positionName" name="positionName" value="${employeesList.positionName}">${employeesList.positionName}</td>
				</tr>
			</c:forEach>
			</table>
		</c:if>
		</div>
		<div id="buttonContainer">
			<button id='cancel' onclick="javascript:window.close();" class="btn-gray">취소</button>
			<button id='ok' class="btn-bold">확인</button>
		</div>
	</div>
</body>
</html>