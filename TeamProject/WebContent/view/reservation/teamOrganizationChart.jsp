<%--
author  : 김준호
since   : 2017. 5. 12.
version : 1.0
subject :
description :
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
	/* 최상위 div */
	.center {
		width: 260px;
		margin: 0 auto;
	}
	/* 조직도 선택창 */
	#sidetree {
		width: 210px;
	    height: 300px;
	    float: left;
	    border: 1px solid #ccc;
	    padding: 10px;
	    margin: 15px;
	    overflow: auto;
	}
	/* 확인 및 취소 버튼 div  */
	#buttonContainer{
		/* float: right; */
		/* margin-right: 30px; */
		text-align: center;
	}
	/* 확인 및 취소 버튼 */
	#ok, #cancel {
		width: 80px;
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
		$('#ok').click(function () {
			var depId = new Array();
			var depName = new Array();

			if(opener != null){
				//조직도에서 선택한 부서의 아이디값과 이름을 팀선택창으로 가져옴
				$('input[type=checkbox]:checked').each(function(index){
					depId = $(this).val();
					depName = $(this).parent().text();
					opener.setUseTeam(depId, depName);
				});
				window.close();
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
			<!--  -->
				<li>
					<strong>CFO 조직</strong>
					<ul>
						<li><input type="checkbox" value="14AA20"/>CFO 조직</li>
						<li><input type="checkbox" value="14AA22"/>재무관리팀</li>
					</ul>
				</li>
				<li>
					<strong>기획실</strong>
					<ul>
						<li><input type="checkbox" value="14GA00"/>기획실</li>
						<li><input type="checkbox" value="14GA02"/>기획팀</li>
						<li><input type="checkbox" value="14GA07"/>QA팀</li>
						<li><input type="checkbox" value="14GA08"/>보안파트</li>
						<li><input type="checkbox" value="14GA09"/>최적화파트</li>
					</ul>
				</li>
				<li>
					<strong>인사지원실</strong>
					<ul>
						<li><input type="checkbox" value="14GA10"/>인사지원실</li>
						<li><input type="checkbox" value="14GA11"/>인사파트</li>
						<li><input type="checkbox" value="A00023"/>태양광TF</li>
					</ul>
				</li>
				<li>
					<strong>기술연구소</strong>
					<ul>
						<li><input type="checkbox" value="14HA00"/>기술연구소</li>
					</ul>
				</li>
				<li>
					<strong>영업총괄센터</strong>
					<ul>
						<li><input type="checkbox" value="14KA00"/>영업총괄센터</li>
						<li><input type="checkbox" value="14KA02"/>SI영업팀</li>
						<li><input type="checkbox" value="14KA03"/>ICT팀</li>
					</ul>
				</li>
				<li>
					<strong>SI사업부</strong>
					<ul>
						<li><input type="checkbox" value="14LA00"/>SI사업부</li>
						<li><input type="checkbox" value="14LA02"/>Account Lead</li>
						<li><input type="checkbox" value="14LA03"/>기획파트</li>
						<li><input type="checkbox" value="14LA06"/>플랜트/ICT사업팀</li>
						<li><input type="checkbox" value="14LA10"/>SI사업팀</li>
						<li><input type="checkbox" value="14LA12"/>솔루션파트</li>
						<li><input type="checkbox" value="14LA13"/>ERP사업팀</li>
					</ul>
				</li>
				<li>
					<strong>SM사업부</strong>
					<ul>
						<li>인프라총괄센터
							<ul>
								<li><input type="checkbox" value="14MA02"/>인프라총괄센터</li>
							</ul>
							<ul>
								<li><input type="checkbox" value="14MA03"/>데이터센터추진 TFT</li>
							</ul>
							<ul>
								<li><input type="checkbox" value="14MA04"/>인프라기술지원파트</li>
							</ul>
							<ul>
								<li><input type="checkbox" value="14MA05"/>TA지원파트</li>
							</ul>
						</li>
						<li>GSC SM센터
							<ul>
								<li><input type="checkbox" value="14MA08"/>GSC SM센터</li>
							</ul>
							<ul>
								<li><input type="checkbox" value="14MA09"/>경영관리파트</li>
							</ul>
							<ul>
								<li><input type="checkbox" value="14MA10"/>재무파트</li>
							</ul>
							<ul>
								<li><input type="checkbox" value="14MA11"/>영업물류파트</li>
							</ul>
							<ul>
								<li><input type="checkbox" value="14MA12"/>모바일파트</li>
							</ul>
							<ul>
								<li><input type="checkbox" value="14MA13"/>인프라파트</li>
							</ul>
							<ul>
								<li><input type="checkbox" value="14MA14"/>로열티파트</li>
							</ul>
							<ul>
								<li><input type="checkbox" value="14MA15"/>플랜트운영파트</li>
							</ul>
						</li>
						<li>Shared Service센터
							<ul>
								<li><input type="checkbox" value="14MA26"/>Shared Service센터</li>
							</ul>
							<ul>
								<li><input type="checkbox" value="14MA16"/>GSM운영파트</li>
							</ul>
						</li>
						<li>홈쇼핑 SM센터
							<ul>
								<li><input type="checkbox" value="14MA27"/>홈쇼핑 SM센터</li>
							</ul>
							<ul>
								<li><input type="checkbox" value="14MA25"/>기간계개발지원파트</li>
							</ul>
							<ul>
								<li><input type="checkbox" value="14MA32"/>PD파트</li>
							</ul>
							<ul>
								<li><input type="checkbox" value="14MA33"/>MC개발지원파트</li>
							</ul>
							<ul>
								<li><input type="checkbox" value="14MA34"/>인프라운영지원파트</li>
							</ul>
						</li>
						<li>리테일 SM센터
							<ul>
								<li><input type="checkbox" value="14MA29"/>리테일 SM센터</li>
							</ul>
							<ul>
								<li><input type="checkbox" value="14MA19"/>GS리테일팀</li>
							</ul>
						</li>
					</ul>
				<li>
					<strong>CFO직속</strong>
				</li>
				<li>
					<strong>외부고객</strong>
					<ul>
						<li><input type="checkbox" value="ETC000"/>외부고객</li>
					</ul>
				</li>
			</ul>
		</div>

		<div id="buttonContainer">
			<button id='cancel' onclick="javascript:window.close();" class="btn-gray">취소</button>
			<button id='ok' class="btn-bold">확인</button>
		</div>
	</div>
</body>
</html>