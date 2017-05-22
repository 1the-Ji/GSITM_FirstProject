package com.gsitm.servlet.sign;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gsitm.dao.ReservationDAO;
import com.gsitm.dto.EmployeesDTO;
/**
 * 
 * @프로그램   : SignRejectAction.java
 * @작성일     : 2017. 5. 18.
 * @작성자     : 지승훈
 * @기능       : 
 * @버전       : 1.0
 *
 */
@WebServlet("/sign/reject")
public class SignRejectAction extends HttpServlet {
	private static final long serialVersionUID = 1L;



	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("sign reject : post()");

		String password = request.getParameter("password");
		System.out.println("결재 처리 비밀번호 : " + password);

		HttpSession session = request.getSession();
		EmployeesDTO employDTO = (EmployeesDTO) session.getAttribute("Employee");
		String employPwd = employDTO.getPassword();
		System.out.println("직원 비밀번호"+employDTO.getPassword());
		if(password.equals(employPwd)){
			int regInId =  Integer.parseInt(request.getParameter("regInId"));
			System.out.println("regInId : " + regInId);
			(new ReservationDAO()).delete(regInId);
			System.out.println("부서장 결재 반려 성공");
		}else{
			System.out.println("부서장 결재 반려 실패");
		}
		response.sendRedirect("../sign");
	}

}
