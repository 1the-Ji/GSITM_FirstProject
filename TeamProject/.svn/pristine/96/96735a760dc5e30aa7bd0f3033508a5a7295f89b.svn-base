<%--
author  : 김태형
since   : 2017. 5. 2.
version : 1.0
subject : 회의실 예약 신청 화면
description : 회의실 및 교육실 예약신청 입력 폼 화면
--%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>예약 신청</title>
 	<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/css/jquery-ui.css">
	<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/css/common.css">
	<script src="${pageContext.servletContext.contextPath}/resources/js/jquery.min.js"></script>
	<script src="${pageContext.servletContext.contextPath}/resources/js/jquery-ui.min.js"></script>
	<style type="text/css">
		#body {
			text-align: center;
		}
		form table {
			margin: 0 auto;
			margin-top: 30px;
			border-spacing: 0;
			border: 1px solid #e9e9e9;
			width: 800px;
		}
		form table td {
			padding: 10px;
			border-bottom: 1px solid #e9e9e9;
		}
		form table td:first-child {
			background-color: #e9e9e9;
			font-weight: bold;
			text-align: center;
			width: 120px;
		}
		form table td:last-child {
			text-align: left;
			padding-left: 10px;
		}
		input[type="number"] {
			width: 40px;
		}
		#dayModeTimePicker, #periodModeTimePicker {
			display: inline;
			margin-left: 20px;
		}
		#submitButtonContainer {
			margin: 0 auto;
			margin-top: 10px;
		}
		#teams, #purpose {
			width: 200px;
		}
		.datePicker {
			width: 80px;
			text-align: center;
		}
	</style>
	<script type="text/javascript">
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
		        minDate: 0 // 오늘 이전 날짜 선택 불가
		        
		    });

			//주말 및 예약불가일자 빼기
			function noWeekendsOrHolidays(date) {

				//예약불가일 빼기
				var disabledDays = [ ${disableDays} ];

				for (i = 0; i < disabledDays.length; i++) {
			        if($.inArray(date.getFullYear() + '-' +(date.getMonth()+1) + '-' + date.getDate(), disabledDays) != -1) {
			            return [false];
			        }
			    }

				//주말 빼기
			    var noWeekend = jQuery.datepicker.noWeekends(date);
			    return noWeekend[0] ? [true] : noWeekend;
			}

			//datepicker 기본값 오늘날짜로
			$('.datePicker').val($.datepicker.formatDate('yy-mm-dd', new Date()));


			//파라미터 값이 있으면 해당 날짜 선택 후 변경 불가하게
			if ('${param.selectedDate}' != "") {
				$('#selectedDate').val('${param.selectedDate}');
				$('#selectedDate').attr('readonly', 'readonly');
			}
			else {
				$('#selectedDate').datepicker({
					beforeShowDay: function (date) { //단기예약인 경우 주말만 제거
						var noWeekend = jQuery.datepicker.noWeekends(date);
					    return noWeekend[0] ? [true] : noWeekend;
					}
				});
			}

			if ('${param.startHour}' != '' && '${param.finishHour}' != '') {
				$('#startHour').append('<option value="${param.startHour}">${param.startHour}</option>');
				$('#finishHour').append('<option value="${param.finishHour}">${param.finishHour}</option>');

				$('#startHour').attr('disabled', 'disabled');
				$('#finishHour').attr('disabled', 'disabled');
			}
			else {
				initTimeSelecter();
			}

			//시작일.
            $('#startDate').datepicker({
            	beforeShowDay: noWeekendsOrHolidays, //주말 선택불가
                buttonText: "시작일자",
                onClose: function( selectedDate ) {
                    // 시작일(fromDate) datepicker가 닫힐때 날짜범위 체크
                	if(0 > calDateRange(selectedDate, $("#finishDate").val())){
                    	alert("종료일이 시작일 보다 빠를 수 없습니다.");
                		$("#finishDate").datepicker('setDate', $("#startDate").val());
                    }
                    else if(2 < calDateRange($("#startDate").val(), $("#finishDate").val())){
                		alert("기간은 연속해서 3일을 넘을 수 없습니다. ");
                		$("#finishDate").datepicker('setDate', $("#startDate").val());
                	}
                }
            });

            //종료일
            $('#finishDate').datepicker({
                buttonText: "종료일자",
                beforeShowDay: noWeekendsOrHolidays, //주말 선택불가
                onClose: function( selectedDate ) {
                    // 종료일(toDate) datepicker가 닫힐때 날짜범위 체크
                    if(0 > calDateRange($("#startDate").val(), selectedDate)){
                    	alert("종료일이 시작일 보다 빠를 수 없습니다.");
                		$("#finishDate").datepicker('setDate', $("#startDate").val());
                    }
                    else if(2 < calDateRange($("#startDate").val(), $("#finishDate").val())){
                		alert("기간은 연속해서 3일을 넘을 수 없습니다. ");
                		$("#finishDate").datepicker('setDate', $("#startDate").val());
                	}
                }
            });

			//일일예약 모드 클릭시 시간 선택 뜨도록
			$('#radioDay').click(function(){
				if($('#radioDay').attr('checked') == 'checked'){
					$('#dayModeTimePicker').css('display', 'inline');
					$('#periodModeTimePicker').css('display', 'none');
				}
			});

			//기간예약 선택 시 datePicker 2개 뜨도록
			$('#radioTerm').click(function(){
				if($('#radioTerm').attr('checked') == 'checked'){
					$('#periodModeTimePicker').css('display', 'inline');
					$('#dayModeTimePicker').css('display', 'none');
				}
			});

			//사용인원 변경시마다 요금 다시계산
			$('input').click(function(){
				calcPrice();
			});
			
			$('input[type=number]').change(function(){
				calcPrice();
			});

			$('.datePicker').click(function() {
				calcPrice();
			});
			
			//submit하기 전 입력값 검증
			$('form').bind('submit', function() {
				calcPrice(); //가격 최종계산 (확인)

				//팀선택 목록 form데이터 추가
				$("#teams").find("option").each(function(){
					$('#teamsFormList').append('<input type="hidden" name="teams" value="' + $(this).val() + '"/>');
				});

				return inputValid();
			});

			//사용부서 삭제
			$('#removeTeam').click(function () {
				//기본적으로 자신의 부서는 삭제가 안되도록 함
				if(0 == $("#teams option").index($("#teams option:selected"))){
					alert("예약자의 부서는 삭제할 수 없습니다.");
					return;
				}

				if(1 < $('#teams option').size())
					$('#teams option:selected').remove();
			});
			
			$('#cancel').click(function () {
				if(confirm("예약 신청 작성을 취소하시겠습니까?")!=0){
					window.close();
				}
				return false;
			});

			if ('${param.selectedDate}' != "") {
				$('#startDate').val('${param.selectedDate}'); //기간예약 시작일이 진입화면 선택날짜
				$('#finishDate').val('${param.selectedDate}');
			}
			
			calcPrice(); //이용요금 기본값 출력

   		}); //document.ready

		/*
		*  작성자: 김태형
		*  설  명: 기간, 시간, 인원, 간식, 기자재 입력값에 따른 비용 계산 함수
		*/
		function calcPrice() {

			var priceBase = ${room.fee}; //기본요금
			var price = priceBase; //총 요금 (기본요금*시간)
			var strCalcProc = '(기본요금(' + fmtNum(priceBase) + ') X ';

			//기간예약인 경우 8시간 요금 * 기간일수 적용
			if($('#radioTerm').attr('checked') == 'checked'){
				var startDate = $("#startDate").datepicker("getDate");
				var finishDate = $("#finishDate").datepicker("getDate");
				var diff = finishDate - startDate;
				diff = diff / (24 * 60 * 60 * 1000);
				diff = diff + 1; //diff에 예약 일수가 구해짐
				
				strCalcProc += diff + '일)';
				price = priceBase * (diff * 8 * 2); //30분 단위로 8시간
			}
			else {
				var startHour = parseInt( $('#startHour option:selected').val().replace(':', '') );
				var finishHour = parseInt( $('#finishHour option:selected').val().replace(':', '') );
				
				if(isNaN(finishHour) || isNaN(finishHour)) return;
				
				//30분 == 1로 카운트되는 시간 범위 구하기 (기본요금이 30분당 요금)
				var diff = parseInt(finishHour - startHour);
				var time30Diff = 1 < (diff % 100) ? 1 : 0; 
				var timeHDiff = parseInt(diff/100) * 2;
				diff = time30Diff + timeHDiff;
				
				strCalcProc += (diff / 2) + '시간)';
				price = priceBase * diff; //30분 단위로 8시간
			}
			
			//선택한 기자재 비용 구하기
			var fixturePriceSum = 0;
			$('.fixtureItem').each( function(){
	            //체크된 기자재만 가져와서 더함
				if($(this).children('input[type=checkbox]:checked').val() != undefined){
					var p = parseInt( $(this).children('input[type=hidden]').val() );
		            p = (isNaN(p)) ? 0 : p;
		            fixturePriceSum += p;
				}
			});
			
			//간식 입력한 갯수만큼의 비용 구하기
			var snackPriceSum = 0;
			$('.snackItem').each( function(){
				var p = parseInt( $(this).children('input[type=number]').val() ); //간식수량
				p = p * parseInt( $(this).children('input[type=hidden]').val() ); //간식가격
	            p = (isNaN(p)) ? 0 : p;
	            snackPriceSum += p;
			});
			
			price += fixturePriceSum + snackPriceSum; //기자재 및 간식비용 누적
			if(0 < fixturePriceSum) strCalcProc += ' + 기자재(' + fmtNum(fixturePriceSum) + '원)';
			if(0 < snackPriceSum) strCalcProc += ' + 간식(' + fmtNum(snackPriceSum) + '원)';
			
			//사용요금 부서 수만큼 n빵
			var teamsNum = 0;
			$("#teams option").each(function()
			{
				if( $(this).val() != 'ETC000')
			    	teamsNum++; //외부 고객을 제외한 팀수 세기
			});
			price = parseInt(price / teamsNum);

			//price hidden폼 값 입력
			$('#price').val(price);

			//이용요금 포맷팅 출력
			$('#priceDisp').text(fmtNum(price) + '원');
			$('#priceCalcProc').html(strCalcProc);
			$('#priceCalcProc').attr("title", strCalcProc);
		}
   		
   		/*
   		* 작성자: 김태형
   		* 설  명: 숫자형식을 3자리 단위로 ,표시하여 포맷팅한 결과를 반환
   		*/
   		function fmtNum(num) {
   			num += "";
			return num.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}

		/*
		*  작성자: 김태형
		*  설  명: submit 실행 전 사용목적, 사용인원 등의 필수 입력폼 검사
		*/
		function inputValid() {
			
			//단기예약시 사용시간 선택 여부
			if($('#radioDay').attr('checked') == 'checked'){
				if( $('#startHour').val() == '' || $('#finishHour').val() == ''){
					alert('사용 시간을 선택해주세요.');
					$('#startHour').focus();
					return false;
				} 
			}
			
			//사용목적 작성여부 검사
			if($('#purpose').val() == ""){
				alert('사용목적을 입력하세요.');
				$('#purpose').focus();
				return false;
			}
			
			//팀수보다 사용인원수가 작은지 검사
			if($('#peoples').val() < $('#teams option').size()){
				alert('사용인원이 사용 부서 인원보다 작습니다.');
				$('#peoples').focus();
				return false;
			}
			
			return submitConfirm();
		}

		/**
		 * 작성자: 김태형
	     * 시간 선택 select 값 채우기 및 이벤트 처리
	     */
		function initTimeSelecter() {

			var timeList = ['09:00', '09:30', '10:00', '10:30', '11:00', '11:30', '12:00',
				'13:00', '13:30', '14:00', '14:30', '15:00', '15:30', '16:00',
				'16:30', '17:00', '17:30', '18:00'];

			//startHour값 채우기
			$('#startHour').append('<option value=""> 선택 </option>');
			for(var i=0; i < timeList.length-1; i++){
				if(timeList[i] == '12:00')
					continue;
				$('#startHour').append('<option value="' + timeList[i] + ':00">' + timeList[i] + '</option>');
			}

			//finishHour값 채우기
			$('#finishHour').append('<option value=""> 선택 </option>');

			//startHour선택 시 선택시간 이후의 finishHour값 채우기
			$('#startHour').change(function() {
				$('#finishHour option').remove();
				var selectedIdx = $('#startHour option').index($('#startHour option:selected'));
				var destIdx = timeList.length;

				if(selectedIdx == 0){
					$('#finishHour').append('<option value=""> 선택 </option>');
					return;
				}

				if(selectedIdx <= 6){
					destIdx = 7;
					selectedIdx--; //[선택] 인덱스 빼기
				}

				for(var s = selectedIdx + 1; s < destIdx; s++){
					$('#finishHour').append('<option value="' + timeList[s] + ':00">' + timeList[s] + '</option>');
				}
				
				calcPrice();
			});
			
			$('#finishHour').change(function() {
				calcPrice();
			});
		}
		
		//2017-05-12 kjh 조직도 팝업창
		function open_orgChart(url){
		   window.open(url, "", 'left=' + ((screen.availWidth-290)/2) + ',top=' + ((screen.availHeight-480)/2) + ', width=290px, height=430px');
		}
		//2017-05-12 kjh
		function setUseTeam(depId, depName) {
			//2017.05.16 김태형 - 추가할때 중복으로 안들어가도록 수정
			var checkRdd = true;
			$("#teams").find("option").each(function(){
				if($(this).val() == depId)
					checkRdd = false;
			});
			if(checkRdd == true)
				$('#teams').append('<option value="' + depId + '" selected ="selected">' + depName + '</option>');
		}
		
		/**
		 * 작성자: 김태형
	     * 두 날짜의 차이를 일자로 구한다.(조회 종료일 - 조회 시작일)
	     *
	     * @param val1 - 조회 시작일(날짜 ex.2002-01-01)
	     * @param val2 - 조회 종료일(날짜 ex.2002-01-01)
	     * @return 기간에 해당하는 일자
	     */
	    function calDateRange(val1, val2)
	    {
	        var FORMAT = "-";

	        // FORMAT을 포함한 길이 체크
	        if (val1.length != 10 || val2.length != 10)
	            return null;

	        // FORMAT이 있는지 체크
	        if (val1.indexOf(FORMAT) < 0 || val2.indexOf(FORMAT) < 0)
	            return null;

	        // 년도, 월, 일로 분리
	        var start_dt = val1.split(FORMAT);
	        var end_dt = val2.split(FORMAT);

	        // 월 - 1(자바스크립트는 월이 0부터 시작하기 때문에...)
	        // Number()를 이용하여 08, 09월을 10진수로 인식하게 함.
	        start_dt[1] = (Number(start_dt[1]) - 1) + "";
	        end_dt[1] = (Number(end_dt[1]) - 1) + "";

	        var from_dt = new Date(start_dt[0], start_dt[1], start_dt[2]);
	        var to_dt = new Date(end_dt[0], end_dt[1], end_dt[2]);

	        return (to_dt.getTime() - from_dt.getTime()) / 1000 / 60 / 60 / 24;
	    }
		
		function submitConfirm() {
			if(confirm("예약을 신청하시겠습니까?")!=0){
				return true;
			}
			return false;
		}

	</script>
</head>
<body>
	<div id="title">
		<h3>예약 신청</h3>
		<hr>
	</div>
	<div id="body">
		<form id="frm" method="post">
		<input type="hidden" name="roomId" value="${param.roomId}"/>
		<input type="hidden" id="price" name="price" value="0"/>
		<div id="teamsFormList">
		</div>
		<table>
			<tr>
				<td>예약자명</td>
				<td>${sessionScope.Employee.empName} (${sessionScope.Employee.empId})</td>
			</tr>
			<tr>
				<td>회의실</td>
				<td>${room.buildName}(${room.position}) &gt; ${room.roomName}</td>
			</tr>
			<tr>
				<td>이용기간</td>
				<td>
					<input type="radio" id="radioDay" name="periodMode" value="day" checked="checked" />단기예약
					<input type="radio" id="radioTerm" name="periodMode" value="period"/>기간예약
					<div id="dayModeTimePicker">
						이용일자:
						<input type="text" id="selectedDate" name="selectedDate" class="datePicker"/>
						이용시간:
						<select id="startHour" name="startHour"></select> ~
						<select id="finishHour" name="finishHour"></select>
					</div>
					<div id="periodModeTimePicker"  class="innerDiv" style="display: none">
						이용기간:
						<input type="text" id="startDate" name="startDate" class="datePicker"/> ~
						<input type="text" id="finishDate" name="finishDate" class="datePicker"/>
					</div>
				</td>
			</tr>
			<tr>
				<td>회의구분</td>
				<td>
					<select id="classify" name="classify" style="height: 22px; width: 80px;">
						<option>내부회의</option>
						<option>고객미팅</option>
						<option>기타회의</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>사용목적</td>
				<td>
					<input type="text" id="purpose" name="purpose"/> ※ 사용 목적을 상세하게 입력해주세요.
				</td>
			</tr>
			<tr>
				<td>사용인원</td>
				<td><input type="number" id="peoples" name="peoples" min="1" max="${room.numberOfEmp}" value="1" style="width: 76px;"/> 명</td>
			</tr>
			<tr>
				<td>사용부서</td>
				<td>
					<select id="teams" size='5'>
						<option value="${sessionScope.Employee.depId}">${sessionScope.Employee.depName} (예약자)</option>
					</select>
					<!--   <a href="#open" class="btn">사용팀 추가</a>  -->
					<button class="btn" onclick="open_orgChart('view/reservation/teamOrganizationChart.jsp'); return false;">추가</button>
					<button class="btn" id="removeTeam" onclick="javascript:return false;">삭제</button>
				</td>
			</tr>
			<tr>
				<td>네트워크</td>
				<c:if test="${room.netFlag eq 'yes'}">
					<td><input type="radio" name="networkUse" value="Y" checked="checked"/>사용 <input type="radio" name="networkUse" value="N"/>사용안함</td>
				</c:if>
				<c:if test="${room.netFlag ne 'yes'}">
					<td><input type="radio" name="networkUse" value="N" checked="checked"/><span style="color: #ccc;">지원안함</span></td>
				</c:if>
			</tr>
			<tr>
				<td>기자재</td>
				<td>
					<c:forEach var="fixture" items="${fixtures}" varStatus="status">
						<span class="fixtureItem">
							<input type="checkbox" name="fixtures" value="${fixture.fixtureId}"/>
							${fixture.name}<span style="color: #999;">(<fmt:formatNumber value="${fixture.pay}" type="number"/>원)</span>
							<input type="hidden" id="fixturePrice_${fixture.fixtureId}" value="${fixture.pay}"/>
						</span>
					</c:forEach>	
				</td>
			</tr>
			<tr>
				<td>간식</td>
				<td>
					<c:forEach var="snack" items="${snacks}" varStatus="status">
						<span class="snackItem">
							${snack.name}<span style="color: #999;">(<fmt:formatNumber value="${snack.pay}" type="number"/>원)</span> 
							<input type="number" min="0" max="1000" value="0" name="snack_${snack.snackId}"/>
							<input type="hidden" value="${snack.pay}"/>
						</span>
					</c:forEach>
				</td>
			</tr>
			<tr>
				<td>이용요금</td>
				<td>
				<div style="width:650px; text-overflow:ellipsis; overflow:hidden;">
           			<nobr><span id="priceDisp" style="font-weight: bold;">0원</span>&nbsp;<span id="priceCalcProc" style="color: #999;" title=""></span></nobr>
      			</div>
      			</td>
			</tr>
		</table>
		<div id="submitButtonContainer">
			<button id="cancel" class="btn-gray" style="font-size: 12pt; padding: 10px; width: 100px; margin: 10px;">취소</button>
			<input type="submit" class="btn-bold" value="예약 신청" style="font-size: 12pt; padding: 10px; width: 100px; margin: 10px;">
		</div>
		</form>
	</div>
</body>
</html>
