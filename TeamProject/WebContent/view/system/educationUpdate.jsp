<%--
	author  : 지승훈
	since   : 2017. 5. 5.
	version : 1.0
	subject : 교육실을 수정 하기위한 화면
	description : 시스템관리자가 교육실을 수정하기위한 폼
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script src="${pageContext.servletContext.contextPath}/resources/js/jquery.min.js"></script>
		<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/css/common.css">
		<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/css/room-info-form.css">
		<title>교육실 정보 수정</title>
	</head>
	<body>
		<%-- <jsp:include page="/view/common/header.jsp"></jsp:include> --%>
		 <h2> 교육실 정보 수정</h2>
		 <hr/>
		  <form method="post" enctype="multipart/form-data" action="../education/updateaction">
			 <table>
			  <tr>
				   <th text-align="center">교육실명(${room.roomId}) <input type="hidden" name="roomId" value='${room.roomId}'/> </th>
				   <td><input type = "text" id="roomName" name="roomName" value="${room.roomName}"/></td>
			  </tr>
			  <tr>
			  		<th> 교육실 위치 </th>
			   	<td><input type = "text" id="position" name="position" value="${room.position}"></td>
			  </tr>
			  <tr>
			   	<th> 건물명 </th>
			   	<td><input type = "text" id="buildName" name="buildName" value="${room.buildName}"/></td>
			  </tr>
			  <tr>
			   	<th> 교육실 크기 </th>
			   	<td><input type = "text" id="roomSize" name="roomSize" value="${room.roomSize}"/></td>
			  </tr>
			  <tr>
			   	<th> 교육실 수용인원 </th>
			   	<td><input type = "text" id="numberOfEmp" name="numberOfEmp" value="${room.numberOfEmp}"/></td>
			  </tr>
			  <tr>
			   	<th> 비치물품 </th>
			   	<td>
						<table class="fixture">
							<tr>
								<td>
									비치물품명: <input type="text" id="fixtureName" name="name"/>
									요금: <input type="text" id="fixturePay" name="pay"/>
									<input type="button" class="btn-bold btn-opt" id="regFixture" value="추가"> <input type="button" class="btn-red btn-opt" id="delFixture" value="삭제">
								</td>
							</tr>
							<tr>
								<td>
									<div class="fixtureList">
											<table id="fixture">
												<tr>
													<td>비치물품</td>
													<td>이용요금</td>
												</tr>
											  	<c:forEach var="fixture" items="${fixture}">
												<tr class="fixture-colum">
													<td>${fixture.name}<input type="hidden" name="fixtureName" value="${fixture.name}"></td>
													<td>${fixture.pay}원<input type="hidden" name="fixturePay" value="${fixture.pay}"></td>
												</tr>
												</c:forEach>
											</table>
									</div>
								</td>
							</tr>
						</table>
			   	</td>
			  </tr>
			  <tr>
			   	<th> 간식 </th>
			   	<td>
						<table class="snack">
							<tr>
								<td>
									간식명: <input type="text" id="snackName" name="name"/>
									요금: <input type="text" id="snackPay" name="pay"/>
									<input type="button" class="btn-bold btn-opt" style="margin-left: 30px;" id="regsnack" value="추가"> <input type="button" class="btn-red btn-opt" id="delsnack" value="삭제">
								</td>
							</tr>
							<tr>
								<td>
									<div class="snackList">
										<table id="snack">
											<tr>
												<th>간식</th>
												<th>요금</th>
											</tr>
											<c:forEach var="snack" items="${snack}">
												<tr class="snack-colum">
													<td>${snack.name}<input type="hidden" name="snackName" value="${snack.name}"></td>
													<td>${snack.pay}원<input type="hidden" name="snackPay" value="${snack.pay}"></td>
												</tr>
											</c:forEach>
										</table>
									</div>
								</td>
							</tr>
						</table>
			   	</td>
			  </tr>
			  <tr>
				   <th> N/W 사용여부 </th>
				   <td>
				   	<input type = "radio" name = "netFlag" checked> 남자
	   				<input type = "radio" name = "netFlag"> 여자
				   </td>
			  </tr>
			  <tr>
				   <th> 사용요금 </th>
				   <td>
			    		<input type = "text" name = "fee" value="${room.fee}"/> 원
			  		</td>
			  </tr>
			  <tr>
			   	<th> 교육실 이미지 </th>
			   	<td>
			   		<div class="existPhoto" style="display:table">
							<c:forEach var="photo" items="${photo}" varStatus="status">
					   		<%-- <input type="file" id ="test"name="uploadFile${status.count}"> --%>기존 파일명 : ${photo.photoName}<br>
					   	</c:forEach>
				   	</div>
				   	<table id="insertTable" style="margin-left:0px; width:620px; border:0px">
				        <tr>
				        	<td valign=bottom>
				        		<input type="file" maxLength="100" id="uploadFile1" name="uploadFile1" size="25">
				        	</td>
				        	<td width=130>
				        		<input type="button" class="btn-bold btn-opt"value="추가" onClick="addFile(this.form)"  style='cursor:hand'>
				        		<input type="button" class="btn-red btn-opt" value="삭제" onClick='deleteFile(this.form)'  style='cursor:hand'>
				        	</td>
				        </tr>
				     </table>
			   	</td>
			  </tr>
			</table>
			<div class="updateCheck">
				<input type = "reset"  style=" font-size: 12pt; padding: 10px; width: 100px; margin: 10px;" class="btn-gray" value = "다시 입력"/>
				<input type = "submit" style=" font-size: 12pt; padding: 10px; width: 100px; margin: 10px;" class="btn-bold" id="submit" value = "수정"/>
			</div>
		</form>
		<br/>
		<%-- <jsp:include page="/view/common/footer.jsp"></jsp:include> --%>
		<script>
			$(document).ready(function(){
				//비치물품 추가
				$("#regFixture").on("click",function(){
					var fixtureName = $(".fixture #fixtureName").val();
					var fixturePay = $(".fixture #fixturePay").val();
					var tag = "<tr class='fixture-colum'>>";
						 tag += 	"<td>" + fixtureName + "<input type='hidden' name='fixtureName' value='" + fixtureName + "'></td>";
						 tag +=  "<td>" + fixturePay + "원<input type='hidden' name='fixturePay' value='" + fixturePay + "'></td>";
						 tag +="</tr>";
					$("div.fixtureList table").append(tag);
				});
				//간식 추가
				$("#regsnack").on("click",function(){
					var snackName = $(".snack #snackName").val();
					var snackPay = $(".snack #snackPay").val();
					var tag = "<tr class='snack-colum'>>";
						 tag += 	"<td>" + snackName+ "<input type='hidden' name='snackName' value='" + snackName + "'></td>";
						 tag +=  "<td>" + snackPay + "원<input type='hidden' name='snackPay' value='" + snackPay + "'></td>";
						 tag +="</tr>";
					$("div.snackList table").append(tag);
				});

				//비치물품 삭제
				$("#delFixture").on("click",function(){
					console.log("aaaa");
					$('.fixture-selected').remove();
				});

				//간식 삭제
				$("#delsnack").on("click",function(){
					console.log("aaaa");
					$('.snack-selected').remove();
				});

				//비치물품 선택
				 $("#fixture").on("click",".fixture-colum",function(){
					 $(this).toggleClass("fixture-selected");
				});
				//간식 선택
				 $("#snack").on("click",".snack-colum",function(){
					 $(this).toggleClass("snack-selected");
				});
				//회의실 등록 예외 처리
					$("#submit").on("click",function(){
						if(!blankCheck($('#roomName'))){
							alert("회의실 명 미입력");
							$('#roomName').focus();
						}else if(!blankCheck($('#position'))){
							alert("회의실 위치 미입력");
							$('#position').focus();
						}else if(!blankCheck($('#buildName'))){
							alert("건물 명 미입력");
							$('#buildName').focus();
						}else if(!blankCheck($('#roomSize'))){
							alert("회의실 크기 미입력");
							$('#roomSize').focus();
						}else if(!blankCheck($('#numberOfEmp'))){
							alert("회의실 수용인원 미입력");
							$('#numberOfEmp').focus();
						}else if($("#fixture tr").length <= 1){
							alert("비치물풀 미추가");
							$('#fixtureName').focus();
						}else if($("#snack tr").length <= 1){
							alert("간식 미추가");
							$('#snackName').focus();
						}else if(!blankCheck($('#fee'))){
							alert("이용요금 미입력");
							$('#fee').focus();
						}else if(!blankCheck($('#uploadFile1'))){
							alert("파일 미추가");
							$('#uploadFile1').focus();
						}else{
							if(confirm("교육실을 수정하시겠습니까?")!=0){
					            return true;
							}else
					         return false;
						}
						return false;
					});
				});
				//입력하지 않은 예외 체크
				function blankCheck(data){
					var $val = $(data).val();
					if($val!=''){
						return true;
					}else{
						return false;
					}
				}

				//첨부파일 추가
			    var rowIndex = 1;
			    function addFile(form){
			    	 if(rowIndex > 4){
			        		alert("6개 이상 사진을 추가할수 없습니다.");
			        		return false;
			        }
			        rowIndex++;
			        var getTable = document.getElementById("insertTable");
					  var oCurrentRow = getTable.insertRow(getTable.rows.length);
			        var oCurrentCell = oCurrentRow.insertCell(0);
			        oCurrentCell.innerHTML = "<tr><td colspan=2><INPUT TYPE='FILE' NAME='uploadFile" + rowIndex + "' size=25></td></tr>";
			    }
				//첨부파일 삭제
			    function deleteFile(form){
			        if(rowIndex<2){
			            return false;
			        }else{
			        	rowIndex--;
						var getTable = document.getElementById("insertTable");
						getTable.deleteRow(rowIndex);
			       }
			    }
		</script>
	</body>
</html>