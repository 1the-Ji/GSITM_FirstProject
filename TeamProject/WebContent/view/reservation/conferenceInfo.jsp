<!--
	author  : 김준호
	since   : 2017. 4. 19.
	version : 1.0
	subject : 회의실 조회 화면
	description : 회의실 및 교육실 조회 폼
-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
	<head>
		<title>${roomType} 예약</title>
		<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/css/jquery-ui.css">
		<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/css/common.css">
		<script src="${pageContext.servletContext.contextPath}/resources/js/jquery.min.js"></script>
		<script src="${pageContext.servletContext.contextPath}/resources/js/jquery-ui.min.js"></script>
		<script type="text/javascript">
			//이용시간
			var timeList = ['09:00', '09:30', '10:00', '10:30', '11:00', '11:30', '12:00',
							'13:00', '13:30', '14:00', '14:30', '15:00', '15:30', '16:00',
							'16:30', '17:00', '17:30', '18:00'];

			$(document).ready(function(){
				
				//datepicker 기본 형식 설정
				$.datepicker.setDefaults({
			        dateFormat: 'yy-mm-dd',
			        prevText: '이전 달',
			        nextText: '다음 달',
			        monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			        dayNames: ['일', '월', '화', '수', '목', '금', '토'],
			        dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
			        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			        showMonthAfterYear: true,
			        yearSuffix: '년',
			        showMonthAfterYear : true,
			        currentText: '오늘' , // 오늘 날짜로 이동하는 버튼 패널
			        closeText: '닫기',  // 닫기 버튼 패널
			        minDate: 0, // 오늘 이전 날짜 선택 불가
			        beforeShowDay: noWeekendsOrHolidays, //주말 선택불가
			        
			        onSelect: function(dateText) {
			        	$('#searchBtn').click(); //조회버튼 자동 클릭
			        }
			    });

				//주말 제외
				function noWeekendsOrHolidays(date) {
				    var noWeekend = jQuery.datepicker.noWeekends(date);
				    return noWeekend[0] ? [true] : noWeekend;
				}

				//startHour값 채우기
				for(var i=0; i < timeList.length-1; i++){
					if(timeList[i] == '12:00')
						continue;
					$('#startHour').append('<option value="' + timeList[i] + ':00">' + timeList[i] + '</option>');
				}

				/* //finishHour값 채우기
				$('#finishHour').append('<option value="'+ timeList[1] + ':00">' + timeList[1] + '</option>'); */
				//
				for(var i=1; i<timeList.length-11; i++){
					$('#finishHour').append('<option value="'+ timeList[i] + ':00">' + timeList[i] + '</option>');
				}
				//

				//startHour선택 시 선택시간 이후의 finishHour값 채우기
				$('#startHour').change(function() {
					////////////////////////////////


					////////////////////////////////
					$('#finishHour option').remove();
					var selectedIdx = $('#startHour option').index($('#startHour option:selected'));
					var destIdx = timeList.length;

					//선택한 startHour가 첫 번째(09:00)인 경우
					if(selectedIdx == 0){
						/* $('#finishHour').append('<option value="'+ timeList[1] + ':00">' + timeList[1] + '</option>'); */
						for(var i=1; i<timeList.length-11; i++){
							$('#finishHour').append('<option value="'+ timeList[i] + ':00">' + timeList[i] + '</option>');
						}
						return;
					}

					//선택한 startHour가 12시 이후인 경우
					if(selectedIdx <= 5){
						destIdx = 7;
						selectedIdx--;  //[선택] 인덱스 빼기
					}
					//finishHour값을 startHour값의 + 30분 시키기
					for(var s = selectedIdx + 2; s < destIdx; s++){
						$('#finishHour').append('<option value="' + timeList[s] + ':00">' + timeList[s] + '</option>');
					}
				});

				//선택 날짜
				var selectedDate = '<c:out value="${selectedDate}"/>';

				//오늘 날짜
				today = new Date();

				//조회 후 날짜
				if((selectedDate != "") && (selectedDate != null)){
					$("#selectedDate").val(selectedDate);
				//조회 전 날짜
				}else{
					$("#selectedDate").val($.datepicker.formatDate('yy-mm-dd', today));
				}
				$("#selectedDate").datepicker();

				//이전 버튼을 클릭 했을 경우 날짜 하루 빼기
				$("#prevDayBtn").click(function(){
					var date = $('#selectedDate').datepicker('getDate');

				    if (date.getDay() == 1) { //현재 요일이 월요일인 경우
						date.setTime(date.getTime() - (1000*60*60*24*3))
					} else {
						//날짜를 하루 빼주고 텍스트 박스에 출력
						date.setTime(date.getTime() - (1000*60*60*24))
					}
				    $('#selectedDate').datepicker("setDate", date);
				    $('#searchBtn').click(); //조회버튼 자동 클릭
				})

				//다음 버튼을 클릭 했을 경우 날짜 하루 더하기
				$('#nextDayBtn').click(function(){
					var date = $('#selectedDate').datepicker('getDate');

					if (date.getDay() == 5) { //현재 요일이 금요일인 경우
						date.setTime(date.getTime() + (1000*60*60*24*3))
					} else {
						//날짜를 하루 더해서 텍스트 박스에 출력
						date.setTime(date.getTime() + (1000*60*60*24))
					}
				    $('#selectedDate').datepicker('setDate', date);
				    $('#searchBtn').click(); //조회버튼 자동 클릭
				})

				//회의실 수만큼 타임테이블 동적 채우기
				$('#timeTable').append("${timeTableHtml}");
				//선택한 건물명을 검색 후에도 계속 유지시키기
				$("#selectedBuilding > option[value='${param.selectedBuilding}']").attr("selected","selected");
				//사용 시작시간 유지시키기
				$("#startHour > option[value='${startHour}']").attr("selected","selected");
				//선택한 사용시작 시간 이후부터 종료시간까지 출력
				if('${startHour}' != "") $('#startHour').change();
				//사용 종료시간 유지시키기
				$("#finishHour > option[value='${finishHour}']").attr("selected","selected");
				
				if('${startHour}' == '')
					$('#searchBtn').click();

			});
			//회의실 선택시 유효성 체크
			function check_select(){
				form = document.conferenceReservationFrm;
				if(form.selectedBuilding.value == ""){
					alert("건물명을 선택해주세요");
					return false;
				} else if(form.startHour.value == "") {
					alert("사용시작 시간을 선택해주세요");
					return false;
				} else if(form.finishHour.value == "") {
					alert("사용종료 시간을 선택해주세요");
					return false;
				} else {
					return true;
				}
			}
		</script>
		<style>
			body table {
				width: 1000px;
			}
			table th, td {
				padding: 5px;
				border-color: #ccc;
			}
			/* 예약된 시간의 타임테이블 막대그래프 색상 */
			.reserved {
				background-color: #6699CC;
			}
			/* '날짜 이동' 버튼 스타일*/
			.calBtn {
				width: 25px;
			    height: 25px;
			    font-size: 15px;
			    color: white;
			    text-align: center;
			    background: black;
			    border: solid 1px black;
			    border-radius: 20px;
			}
			#div1 {
				margin: 0 auto;
				margin: 20px 20px 20px 20px;
				text-align: center;
			}
			#div2 {
				margin: 0 auto;
				margin: 20px 20px 20px 20px;
				text-align: center;
			}
			#div3 {
				margin: 0 auto;
				margin: 20px 20px 20px 20px;
				text-align: center;
			}
			/* 날짜 출력 텍스트 박스 스타일*/
			#selectedDate {
				background: black;
				color: white;
				text-align: center;
				border: solid 1px black;
				height: 24px;
				font-size: 11pt;
				font-weight: bold;
			}
			/* '조회' 버튼 스타일 */
			#searchBtn {
				height: 25px;
				width: 100px;
				font-size: 10pt;
			}
			/* 해당 건물의 각 회의실에 대해 예약시간을 확인할 수 있는 타임테이블 */
			#timeTable {
				margin: auto;
				text-align: center;
				border-collapse: collapse;
				/* border-color: #A6A6A6; */
				border-style: none;
			}
			/* 해당 건물의 각 회의실에 대해 예약가능 여부를 확인할 수 있는 테이블 */
			#conferenceInfoTable {
				margin: auto;
				text-align: center;
				border-collapse: collapse;
				/* border-color: #A6A6A6; */
				border-style: none;
			}
			/* 셀렉트 박스 선택 테이블 스타일 */
			#selectTable {
				border-collapse: collapse;
				margin: 0 auto;
				height: 50px;
			}
			#selectTable select {
				height: 25px;
			}
			/* 셀렉트 박스 선택 테이블 td 스타일 */
			#selectTable td {
				text-align: right;
			}
			/* 건물명 셀렉트 박스 스타일 */
			#selectedBuilding {
				width: 170px;
			}
			/* 이용시간 셀렉트 박스 스타일 */
			#startHour, #finishHour {
				width: 60px;
			}
			#conferenceInfoTable th:first-child, #timeTable th:first-child {
				width: 200px;
			}
			.reserve{
				width: 80px;
				height: 30px;
				margin: 0 3px 0 3px;
			}
		</style>
		<script>
			//예약화면 팝업창
			function open_ReserveForm(url, width, height){
				/* alert("width : " + width + "height : " + height); */
				window.open(url, "", 'left='+(screen.availWidth-360)/2+', top='+(screen.availHeight-480)/2 , width, height);
			}
		</script>
	</head>
<body>
<jsp:include page="/view/common/header.jsp"></jsp:include>
	<h2>${roomType} 예약</h2>
	<hr>
	<div>
		<form name="conferenceReservationFrm" method="post">
			<div id="div1">
				<!-- 이전 날짜 이동 버튼 -->
				<input type="button" id="prevDayBtn" class="calBtn" value="&lt;">
				<input type="text" id="selectedDate" name="selectedDate">
				<!-- 다음 날짜 이동 버튼 -->
				<input type="button" id="nextDayBtn" class="calBtn" value="&gt;">
				<input type="hidden" name="roomType" value="${roomType}"/>
			</div>
			<div id="div2">
				<table id="selectTable" class="head">
					<tr>
						<td>●&nbsp;${roomType} 및 이용시간 선택</td>
						<!-- 건물 선택 셀렉트 박스 -->
						<td style="width: 350px;">&nbsp;건물명
						<select name="selectedBuilding" id="selectedBuilding">
							<c:forEach var ="room" items="${roomNameList}" >
								<option value="${room}"><c:out value="${room}" escapeXml="true"></c:out></option>
							</c:forEach>
						</select>
						</td>
						<!-- 이용시간 선택 셀렉트 박스 -->
						<td style="text-align: right; padding-right: 20px;">&nbsp;이용시간 <select id="startHour" name="startHour">
						</select> ~ <select id="finishHour" name="finishHour">
						</select>&nbsp;<input type="submit" id="searchBtn" name="searchBtn" class="btn-bold" value="조회" onclick="return check_select()"/>
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>
	<div>
		<table id="conferenceInfoTable" border="1">
		<!-- 사용자가 선택한 건물의 회의실 정보가 DB에 있는지 확인 -->
		<c:if test="${roomList != null}">
			<tr>
				<th>${roomType}명</th>
				<th style="width: 30%;">위치</th>
				<th>수용인원</th>
				<th>기본요금(30분)</th>
				<th style="width: 200px;">예약가능여부</th>
			</tr>
			<!-- 사용자가 선택한 건물의 회의실 정보가 DB에 있다면,
			     해당 건물의 회의실 정보를 모두 출력 -->
			<c:forEach var="room" items="${roomList}" varStatus="status">
			<tr>
				<!-- 회의실명 -->
				<td><c:out value="${room.roomName}"/></td>
				<!-- 회의실 위치 -->
				<td><c:out value="${room.position}"/></td>
				<!-- 회의실 수용인원 -->
				<td><fmt:formatNumber value="${room.numberOfEmp}" type="number"/>명</td>
				<!-- 회의실 사용요금 -->
				<td><fmt:formatNumber value="${room.fee}" type="number"/>원</td>
				<!-- 회의실 예약가능여부 -->
				<td>
					<!-- 사용자가 선택한 시간에 회의실이 예약가능한지 불가능한지 출력 -->
					<c:if test="${resAbleStr[status.index] == '예약불가'}">
						<input type="button" class="btn-red reserve" id="registerOfEmpBtn" value="${resAbleStr[status.index]}" style="color: #ccc;"/>
					</c:if>
					<c:if test="${resAbleStr[status.index] == '예약가능'}">
						<!-- 예약이 가능한 시간일 경우 예약신청 페이지로 이동 -->
						<input type="button" class="btn-bold reserve" id="registerOfEmpBtn" onclick="javascript:window.open('./conferencereserve?roomId=${room.roomId}&selectedDate=${selectedDate}&startHour=${fn:substring(startHour,0,5)}&finishHour=${fn:substring(finishHour,0,5)}','', 'width=910px, height=710px, left= '+(screen.availWidth/2 - 450)+', top=20');" value="${resAbleStr[status.index]}" />
					</c:if>
						<input type="button" class="btn-gray reserve" id="detailInfoBtn" onclick="javascript:window.open('./roomDetailInfo?roomId=${room.roomId}&selectedBuilding=${selectedBuilding}','', 'width=910px, height=710px, left= '+(screen.availWidth/2 - 450)+', top=20');" value="상세정보" />
					<!-- 사용자가 선택한 회의실 -->
				</td>
			</tr>
			</c:forEach>
		</c:if>
		</table>
	</div>

	<div id="div3">
		<table id="timeTable" border="1">
			<c:if test="${roomList != null}">
				<tr>
					<th>${roomType}명</th>
					<th colspan="2">&nbsp;9시</th>
					<th colspan="2">10시</th>
					<th colspan="2">11시</th>
					<th colspan="2">12시</th>
					<th colspan="2">13시</th>
					<th colspan="2">14시</th>
					<th colspan="2">15시</th>
					<th colspan="2">16시</th>
					<th colspan="2">17시</th>
				</tr>
			</c:if>
		</table>
	</div>

<jsp:include page="/view/common/footer.jsp"></jsp:include>
</body>
</html>
