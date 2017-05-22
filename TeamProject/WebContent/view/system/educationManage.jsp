<%--
	author  : 지승훈
	since   : 2017. 5. 5.
	version : 1.0
	subject : 교육실 관리 하기위한 화면
	description : 시스템 관리자가 교육실을 관리하기위한 폼
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script src="${pageContext.servletContext.contextPath}/resources/js/jquery.min.js"></script>
		<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/css/common.css">
		<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/css/system-manage.css">
		<title>교육실 관리</title>
		<style>
		.table-btn{
			height:30px !important;
		}
		</style>
	</head>
	<body>
		<jsp:include page="/view/common/header.jsp"></jsp:include>
		<h2>교육실 관리</h2>
		<hr/>
		<table class="checkName">
			<tr>
				<td colspan=2>
					<select name="buildName" id="buildName">
						<option value="default">전체건물</option>
						<c:forEach var ="roomNameEduList" items="${roomNameEduList}">
							<option value="${roomNameEduList}">${roomNameEduList}</option>
						</c:forEach>
					</select>
					<input id="search" type="button" onclick="selectBuildName()" value="조회" class="btn-bold"/>
				</td>
				<td style="padding-right: 0px;">
					<input type="button" onclick="moveRegisterForm()" value="+ 교육실 추가" class="btn" />
				</td>
			</tr>
		</table>
		<table>
			<tr>
				<th>건물명</th>
				<th>교육실명</th>
				<th style="width: 28%;">교육실 정보 수정</th>
			</tr>
			<c:forEach var="Room" items="${Room}">
				<tr>
					<td>${Room.buildName}</td>
					<td>${Room.roomName}</td>
					<td>
						<input type="button" onclick="updateRoom('${Room.roomId}')" value="수정" class="btn-bold table-btn"/>
						<input type="button" onclick="deleteRoom('${Room.roomId}')" value="삭제" class="btn-red table-btn"/>
					</td>
				</tr>
			</c:forEach>
		</table>
			<div class="paging">
				<a href="${pageContext.servletContext.contextPath}/education/manageaction?pageNo=1">[처음]</a>
				<c:if test="${groupNo>1}">
					<a href="${pageContext.servletContext.contextPath}/education/manageaction?pageNo=${startPageNo-1}">[이전]</a>
				</c:if>

				<c:forEach var="i" begin="${startPageNo}" end="${endPageNo}">
				 	<a href="${pageContext.servletContext.contextPath}/education/manageaction?pageNo=${i}" <c:if test="${pageNo==i}">style="color:red"</c:if> > ${i} </a>
				</c:forEach>

				<c:if test="${groupNo<totalGroupNo}">
				 	<a href="${pageContext.servletContext.contextPath}/education/manageaction?pageNo=${endPageNo+1}">[다음]</a>
				</c:if>
				 <a href="${pageContext.servletContext.contextPath}/education/manageaction?pageNo=${totalPageNo}">[맨끝]</a><%-- 제일 끝의 그룹 번호 --%>
			</div>

			<!-- 교육실 삭제 modal -->
			<div id="myModal" class="modal">
			<form method="post" action="../education/deleteaction">
			  <div class="modal-content">
			  	 <div class="delete-title"><b>교육실 삭제 확인</b></div>
			  	 <hr/>
			  	 <div class="delete-content">
			  		 <p><img id="warning"src="${pageContext.servletContext.contextPath}/resources/image/warning.png"> 정말 교육실을 삭제 하시겠습니까?</p>
			   	 비밀번호 입력 : <input id="modal-pwd" type="password" name="deletePwd"/>
			  	 </div>
			  	 <hr/>
			  	 <div class="delete-footer">
				    <input type="submit" id="delete" name="delete" value="삭제" class="btn-red"/>
				    <input type="button" id="close" value="취소" class="btn-gray"/>
			    </div>
			  </div>
			 </form>
			</div>
		<jsp:include page="/view/common/footer.jsp"></jsp:include>
	</body>
	<script>
		$(document).ready(function(){
			$("#delete").on('click',function(){
				if(confirm("교육실을 삭제하시겠습니까?")!=0){
		            return true;
				}else
		         return false;
			});
			
			if('${param.buildName}' == '' && '${param.pageNo}' == '')
				$('#search').click();
		});
		var modal = document.getElementById('myModal');
		$('#close').click(function () {
			modal.style.display = "none";
		});
		window.onclick = function(event) {
		    if (event.target == modal) {
		        modal.style.display = "none";
		    }
		}
		function moveRegisterForm(){
			//location.href="../education/registeraction";
			javascript:window.open('../education/registeraction','', 'width=910px, height=670px, left= '+(screen.availWidth/2 - 450)+', top=20');
			
		}
		function updateRoom(RoomId){
			//location.href="../education/updateaction?roomId=" + RoomId;
			javascript:window.open('../education/updateaction?roomId=' + RoomId,'', 'width=910px, height=690px, left= '+(screen.availWidth/2 - 450)+', top=20');
		}
		function deleteRoom(RoomId){
			modal.style.display = "block";
			var tag = "<input type='hidden' name='roomId' value='"+RoomId+"'/>";
			$('.delete-title').append(tag);
		}
		function selectBuildName(){
			var buildName = document.getElementById('buildName');
			var optionValue = buildName.options[buildName.selectedIndex].text;
			location.href = "../education/manageaction?buildName="+optionValue;
			console.log(optionValue);
		}
		$(document).ready(function () {
			var vname = decodeURIComponent('${param.buildName}');
			$('#buildName').val(vname).prop("selected", true);
		});
	</script>
</html>