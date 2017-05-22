package com.gsitm.servlet.approval;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gsitm.dao.EmployeesDAO;
import com.gsitm.dao.ReservationDAO;
import com.gsitm.dao.RoomDAO;
import com.gsitm.dto.EmployeesDTO;
import com.gsitm.dto.ReservationDTO;
import com.gsitm.dto.RoomDTO;

@WebServlet("/conference/approval")
public class ConferenceApprovalAction extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("conference approval : get()");
		RequestDispatcher dispatcher = request.getRequestDispatcher("../view/approval/conferenceReserveManage.jsp");
	    dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("conference approval : post()");
		String startDate = request.getParameter("startDate");
		String finishDate = request.getParameter("finishDate");
		String roomId = "CR%";

		List<ReservationDTO> reservationCrList = (new ReservationDAO()).select(startDate, finishDate, roomId, "승인대기");
		List<RoomDTO> roomList = new LinkedList<RoomDTO>();
		List<String> empNameList = new LinkedList<String>();

		for(ReservationDTO res : reservationCrList){
			RoomDTO room = (new RoomDAO()).selectRoomInfo(res.getRoomId());
			EmployeesDTO empName = (new EmployeesDAO()).login(res.getEmpId());
			roomList.add(room);
			empNameList.add(empName.getEmpName());
		}

		HttpSession session = request.getSession();

		request.setAttribute("reservationList",reservationCrList );
		request.setAttribute("roomList", roomList);
		request.setAttribute("empNameList", empNameList);
		request.setAttribute("searchClick", "click");
		response.setContentType("text/xml;charset=UTF-8");

		//세션에 저장한 값을 conductArrayInfo에 값을 넘김

		RequestDispatcher dispatcher = request.getRequestDispatcher("../view/approval/conferenceReserveManage.jsp");
	     dispatcher.forward(request, response);

	}

}
