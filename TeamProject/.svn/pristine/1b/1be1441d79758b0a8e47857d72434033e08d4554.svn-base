package com.gsitm.servlet.sign;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gsitm.dao.EmployeesDAO;
import com.gsitm.dao.ReservationDAO;
import com.gsitm.dto.EmployeesDTO;
import com.gsitm.mail.MailSender;

/**
 *
 * @프로그램   : SignInfoAction.java
 * @작성일     : 2017. 5. 18.
 * @작성자     : 지승훈
 * @기능       : 결재를 하기위한 예약 정보 확인
 * @버전       : 1.0
 *
 */
@WebServlet("/sign/info")
public class SignInfoAction extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String password = request.getParameter("password");
		System.out.println("결재 처리 비밀번호 : " + password);
		response.setContentType("text/html;charset=UTF-8");

		HttpSession session = request.getSession();
		EmployeesDTO employDTO = (EmployeesDTO) session.getAttribute("Employee");
		String employPwd = employDTO.getPassword();
		System.out.println("직원 비밀번호"+employDTO.getPassword());

		PrintWriter out = response.getWriter();

		if(password.equals(employPwd)){
			int regInId =  Integer.parseInt(request.getParameter("regInId"));
			System.out.println("regInId : " + regInId);

			try{
				(new ReservationDAO()).update(regInId, "승인대기");
				 out.println("<script type='text/javascript'>alert('결재 승인처리 하였습니다.');");
				 out.println("location.href='../sign';</script>"); //

					//결재승인 메일 발송
					String requestUser = (new EmployeesDAO()).login((new ReservationDAO()).selectById(regInId).getEmpId()).getEmail();
		            (new MailSender()).send(requestUser, "결재승인", regInId);

			        //관리자에게 승인 요청 메일 발송
			         String managerEmail;
			         if(  (new ReservationDAO()).selectById(regInId).getRoomId().indexOf("ER") > -1  ){
			        	 managerEmail = (new EmployeesDAO()).login((new EmployeesDAO()).getAdminId("education")).getEmail();
			         }
			         else {
			        	 managerEmail = (new EmployeesDAO()).login((new EmployeesDAO()).getAdminId("conference")).getEmail();
			         }
			         (new MailSender()).send(managerEmail, "승인요청", regInId);
				     System.out.println("부서장 결재 승인 완료 성공");
				}catch(Exception e){
					out.println("<script type='text/javascript'>alert('결재 승인 처리가 실패하였습니다.\\n" +
							e.getMessage().replace("'", "").replace("\n", "") + "');");
					out.println("location.href='../sign';</script>");
				}
		  }else{
				out.println("<script type='text/javascript'>alert('비밀번호가 일치하지않아 처리 되지 않았습니다.');");
				out.println("location.href='../sign';</script>"); //
				System.out.println("부서장 결재 승인 완료 실패");
		 }
		//response.sendRedirect("../sign");
	}
}
