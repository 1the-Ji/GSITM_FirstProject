package com.gsitm.servlet.system;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gsitm.dao.RoomDAO;

/**
 * Servlet implementation class ConferenceManageAction
 */
@WebServlet("/education/manageaction")
public class EducationManageAction extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("education/manageaction : get()");
		//인코딩 설정
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		//로그인 체크
		if(request.getSession().getAttribute("Employee") == null){
			response.sendRedirect( request.getContextPath() + "/login");
			return;
		}

		//권한체크
		if(!("system".equals(request.getSession().getAttribute("Authority")))){
			out.println("<script type='text/javascript'>alert('시스템 관리자만 접근할 수 있는 메뉴입니다.');");
			out.println("history.back();</script>"); //
			return;
		}

		String buildname = "%%";
		if(buildname != null){
			buildname =  request.getParameter("buildName");
			if("전체건물".equals(buildname))
				buildname = "%%";
		}

		String pageNo = request.getParameter("pageNo");
		HttpSession session = request.getSession();
			int intPageNo = 1;
			if (pageNo == null) {
			} else {
				intPageNo = Integer.parseInt(pageNo);
			}
			session.setAttribute("pageNo", String.valueOf(intPageNo));//세션에 현재 저장된 페이지 전달


			int rowsPerPage = 10;
			int pagesPerGroup = 5;

			int totalBoardNo = (new RoomDAO()).getCount(buildname);//전체 게시물 수 구하기

			int totalPageNo = (totalBoardNo/rowsPerPage)+((totalBoardNo%rowsPerPage!=0)?1:0);//전체 페이지수
			int totalGroupNo = (totalPageNo/pagesPerGroup)+((totalPageNo%pagesPerGroup!=0)?1:0);//전체 그룹수

			int groupNo = (intPageNo-1)/pagesPerGroup + 1;//현재 그룹의 번호
			int startPageNo = (groupNo-1)*pagesPerGroup + 1;//그룹의 첫번째 번호 구하기
			int endPageNo = startPageNo + pagesPerGroup - 1;//그룹의 마지막 번호 구하기

			if (groupNo == totalGroupNo) {
				endPageNo = totalPageNo;
			}

			List<Object> roomList = (new RoomDAO()).selectAllEduRoom(intPageNo, rowsPerPage,request,buildname);
			List<String> roomNameEduList = (new RoomDAO()).selectAllErBuildName();
			System.out.println("roomList" + roomList);
			session.setAttribute("Room", roomList);
			session.setAttribute("roomNameEduList", roomNameEduList);
			session.setAttribute("pageNo",intPageNo);
			session.setAttribute("rowsPerPage",rowsPerPage);
			session.setAttribute("pagesPerGroup",pagesPerGroup);
			session.setAttribute("totalBoardNo",totalBoardNo);
			session.setAttribute("totalPageNo",totalPageNo);
			session.setAttribute("totalGroupNo",totalGroupNo);
			session.setAttribute("groupNo",groupNo);
			session.setAttribute("startPageNo",startPageNo);
			session.setAttribute("endPageNo",endPageNo);

			response.setContentType("text/xml;charset=UTF-8");

			//세션에 저장한 값을 conductArrayInfo에 값을 넘김

			RequestDispatcher dispatcher = request.getRequestDispatcher("../view/system/educationManage.jsp");
		     dispatcher.forward(request, response);

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
