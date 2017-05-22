package com.gsitm.servlet.reservation;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gsitm.dao.ReservationDAO;

/**
 *
 * @프로그램명 : ConferenceReserveDeleteAction.java
 * @작성일     : 2017. 5. 14.
 * @작성자     : 김준호
 * @기능       : 예약 취소 서블릿
 * @버전       : 1.0
 *
 */
@WebServlet("/reservedelete")
public class ConferenceReserveDeleteAction extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//인코딩 설정
		response.setContentType("text/html;charset=UTF-8");
	    request.setCharacterEncoding("UTF-8");

	    //로그인 체크
  		if(request.getSession().getAttribute("login") == null){
  			response.sendRedirect(request.getContextPath() + "/login");
  			return;
  		}

		PrintWriter out = response.getWriter();

	    try{
	    	//예약 번호
			int regInId = Integer.parseInt(request.getParameter("regInId"));
			//예약 번호를 이용하여 예약테이블에서 사용시작 시간을 조회
	    	Date startDate = (new ReservationDAO()).selectById(regInId).getStartDate();
	    	//현재 시간
	    	Date now = new Date();

	    	//사용시작 시간 - 현재 시간
	    	long term = startDate.getTime() - now.getTime();

	    	//사용시작 시간과 현재 시간의 차이가 2시간 이내일 경우 예약 취소 불가
	    	if((term / (1000 * 60)) <= 120){
	    		throw new RuntimeException("사용 시작시간 2시간 이내에는 예약 취소를 할 수 없습니다.");
	    	}

	    	//사용시작 시간과 현재 시간의 차이가 2시간 이내가 아닐 경우 예약 취소
	    	(new ReservationDAO()).update(regInId, "예약취소");

	    	out.println("<script type='text/javascript'>alert('예약이 취소되었습니다.');</script>");
	    }catch(Exception e){
	    	e.printStackTrace();
	    	out.println("<script type='text/javascript'>alert('예약 취소가 실패하였습니다.\\n" +
	    			e.getMessage().replace("'", "").replace("\n", "") + "');</script>");
	    }finally{
	    	out.println("<script type='text/javascript'>location.href = './mypage';</script>");
	    }
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
