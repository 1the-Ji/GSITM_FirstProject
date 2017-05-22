package com.gsitm.servlet.conferenceinfo;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gsitm.dao.ReservationDAO;
import com.gsitm.dao.RoomDAO;
import com.gsitm.dto.RoomDTO;

/**
 *
 * @프로그램명 : ConferenceInfoAction.java
 * @작성일     : 2017. 5. 14.
 * @작성자     : 김준호
 * @기능       : 예약 조회 서블릿
 * @버전       : 1.0
 *
 */

@WebServlet("/conferenceinfo")
public class ConferenceInfoAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String[] timeList =
		{"09:00", "09:30", "10:00", "10:30", "11:00", "11:30", "12:00", "12:30",
				"13:00", "13:30", "14:00", "14:30", "15:00", "15:30", "16:00",
				"16:30", "17:00", "17:30", "18:00"};

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String roomType = request.getParameter("type");

		try{
			if(roomType == null) {
				throw new RuntimeException("필수 파라미터가 없습니다.");
			}
			//roomType이 CR일 경우 회의실을 조회
			if("CR".equalsIgnoreCase(roomType)) {
				//회의실 정보 가져오기
				List <String> roomNameList = (new RoomDAO()).selectAllCrBuildName();
				request.setAttribute("roomNameList", roomNameList);
				//roomType이 ER일 경우 회의실을 조회
			} else if("ER".equalsIgnoreCase(roomType)) {
				//교육실 정보 가져오기
				List <String> roomNameList = (new RoomDAO()).selectAllErBuildName();
				request.setAttribute("roomNameList", roomNameList);
				request.setAttribute("roomType", "교육실");
			}
			else {
				throw new RuntimeException("필수 파라미터가 올바르지 않습니다.");
			}
			//최초 서블릿 요청시 회의실 조회 페이지로 이동
			RequestDispatcher dispatcher = request.getRequestDispatcher("./view/reservation/conferenceInfo.jsp");
			dispatcher.forward(request, response);
		}catch(Exception e) {
			response.sendRedirect( request.getContextPath() + "/reservation/guidance");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");

		String roomType = request.getParameter("type");		                //회의실, 교육실 구분
		String selectedDate = request.getParameter("selectedDate");         //선택한 날짜
		String startHour = request.getParameter("startHour");               //선택한 사용시작 시간
		String finishHour = request.getParameter("finishHour");             //선택한 사용종료 시간
		String selectedBuilding = request.getParameter("selectedBuilding"); //건물명

		RoomDAO roomDao = new RoomDAO();
		ReservationDAO reservationDao = new ReservationDAO();

		try{
			if(roomType == null) {
				throw new RuntimeException("필수 파라미터가 없습니다.");
			}

			//사용자가 선택한 건물의 회의실 정보를 roomList에 저장
			List<RoomDTO> roomList = roomDao.selectAll(selectedBuilding, roomType);

			//roomType이 CR일 경우 회의실을 조회
			if("CR".equalsIgnoreCase(roomType)) {
				//회의실 정보 가져오기
				List <String> roomNameList = (new RoomDAO()).selectAllCrBuildName();
				request.setAttribute("roomNameList", roomNameList);
				request.setAttribute("roomType", "회의실");
				//roomType이 ER일 경우 교육실을 조회
			} else if("ER".equalsIgnoreCase(roomType)) {
				//교육실 정보 가져오기
				List <String> roomNameList = (new RoomDAO()).selectAllErBuildName();
				request.setAttribute("roomNameList", roomNameList);
				request.setAttribute("roomType", "교육실");
			}
			else {
				throw new RuntimeException("필수 파라미터가 올바르지 않습니다.");
			}

			String[] resAbleStr = new String[roomList.size()]; //각 회의실별 예약가능/불가능 여부 리스트
			String timeTableHtml = "";

			//사용자가 선택한 건물의 회의실이 예약가능한지 불가능한지 조회
			for(int i=0; i < roomList.size(); i++){

				timeTableHtml += "<tr><td>" + roomList.get(i).getRoomName() + "</td>";

				boolean b = reservationDao.selectAbleReservation(roomList.get(i).getRoomId(), selectedDate, startHour, finishHour);
				boolean t = true;
				//이미 지난시각 체크
				Date now = new Date();
				Date startD = new Date();
				try{
					startD = (new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).parse(selectedDate + " " + startHour);
				}catch (Exception ex){
					ex.printStackTrace();
				}
				//이미 지난 시각이면
				if(now.getTime() >= startD.getTime()){
					t = false;
				}

				if(b == true && t == true)
					resAbleStr[i] = "예약가능";
				else
					resAbleStr[i] = "예약불가";

				//각 시간별 회의실 사용 현황을 조회하기 위해 30분 단위로 사용중인 회의실이 있는지 쿼리
				for(int j=0; j < timeList.length - 1; j++){

					try{
						t = true;
						startD = (new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).parse(selectedDate + " " + timeList[j] + ":00");
					}catch (Exception ex){
						ex.printStackTrace();
					}
					//이미 지난 시각이면 || 12시(점심시간) 예약 불가로 표시
					if(now.getTime() >= startD.getTime() || startD.getHours() == 12){
						t = false;
						b = true;
					} else {
						b = reservationDao.selectAbleReservation(roomList.get(i).getRoomId(), selectedDate, timeList[j] + ":00", timeList[j+1] + ":00");
					}

					if(t == false){
						timeTableHtml += "<td style='background-color: #ddd'></td>"; //지난 시각
					} else if (b == false){
						timeTableHtml += "<td class='reserved'></td>";	//이미 예약된 시각
					}
					else {
						timeTableHtml += "<td></td>"; //예약 가능시각
					}
				}
				timeTableHtml += "</tr>";
			}

			request.setAttribute("selectedBuilding", selectedBuilding);  //건물명
			request.setAttribute("roomList", roomList);				     //회의실/교육실 테이블 정보
			request.setAttribute("resAbleStr", resAbleStr);			     //예약가능/예약불가 정보
			request.setAttribute("timeTableHtml", timeTableHtml);	     //예약된 시간 표시 CSS 클래스
			request.setAttribute("selectedDate", selectedDate);		     //사용선택 시간
			request.setAttribute("startHour", startHour);			     //사용시작 시간
			request.setAttribute("finishHour", finishHour);			     //사용종료 시간

			//해당 건물의 회의실 정보를 회의실 조회 페이지로 전달
			RequestDispatcher dispatcher = request.getRequestDispatcher("./view/reservation/conferenceInfo.jsp");
			dispatcher.forward(request, response);
		}
		catch(Exception e) {
			response.sendRedirect( request.getContextPath() + "/reservation/guidance");
		}
	}
}
