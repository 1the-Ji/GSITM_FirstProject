package com.gsitm.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gsitm.common.ConstString;
import com.gsitm.dao.EmployeesDAO;
import com.gsitm.dto.EmployeesDTO;

@WebServlet("/login")
public class LoginAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
	EmployeesDAO employeesDAO = new EmployeesDAO();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		session.invalidate();
		
		//서버 루트 url정보 구해놓기
		ConstString.SERVER_ROOT_URL = request.getRequestURL().toString().replace("/login", "");
		System.out.println("서버 주소: " + ConstString.SERVER_ROOT_URL);

		//20170514 김태형 - 로그인 후 이동시킬 주소가 있으면 이동하도록 처리
		if(request.getParameter("goUrl") != null){
			request.getSession().setAttribute("goUrl", request.getParameter("goUrl"));
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher("./view/login/login.jsp");
	    dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();

		String url = "./view/login/login.jsp";
		String userId = request.getParameter("userId").toUpperCase();
		String userPwd = request.getParameter("userPwd");


		EmployeesDTO employDTO = employeesDAO.login(userId, userPwd) ;
		String authority = employDTO.getAuthority();

		System.out.println("권한 : " + authority);

		int result = employeesDAO.userCheck(userId, userPwd);

		//로그인 체크
		if(result == 1){
			System.out.println("로그인 성공!!");
			session.setAttribute("Employee", employDTO);
			session.setAttribute("login", employDTO.getEmpId());
			session.setAttribute("Authority",employDTO.getAuthority());

			//20170514 김태형 - 로그인 후 이동시킬 주소가 있으면 이동하도록 처리
			if(session.getAttribute("goUrl") != null){
				url = session.getAttribute("goUrl").toString();
				session.removeAttribute("goUrl");
			}
			else{
				//기본 이동주소
				//권한에 따라서 페이지 다르게 처리
				if(authority.equals("user")){
					System.out.println("예약자 로그인");
					url = "./reservation/guidance";
				}else{
					if(authority.equals("system")){
						System.out.println("시스템 관리자 로그인");
						url = "./conference/manageaction";
					}else if(authority.equals("conference")){
						System.out.println("승인 관리자(회의실) 로그인");
						url = "./reservation/guidance";
					}else if(authority.equals("education")){
						System.out.println("승인 관리자(교육실) 로그인");
						url = "./reservation/guidance";
					}
				}
			}
		}else if(result==0){
			System.out.println("비밀번호 오류");
			request.setAttribute("message", "비밀번호가 맞지 않습니다.");
			RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		     dispatcher.forward(request, response);
		}else if(result==-1){
			System.out.println("존재하지 않은 회원 오류");
			request.setAttribute("message", "존재하지 않는 회원입니다.");
			RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		    dispatcher.forward(request, response);
		}

		response.sendRedirect(url);
	}
}
