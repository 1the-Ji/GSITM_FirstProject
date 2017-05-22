package com.gsitm.servlet.approval;

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

@WebServlet("/conference/approval/reject")
public class ConferenceApprovalRejectAction extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("conference approval reject : get()");

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("conference approval reject: post()");
		//인코딩 설정
	    request.setCharacterEncoding("UTF-8");
	    response.setContentType("text/html;charset=UTF-8");

		String password = request.getParameter("password");
		System.out.println("승인 처리 비밀번호 : " + password);

		HttpSession session = request.getSession();
		EmployeesDTO employDTO = (EmployeesDTO) session.getAttribute("Employee");
		String employPwd = employDTO.getPassword();
		System.out.println("직원 비밀번호 : "+employDTO.getPassword());

		PrintWriter out = response.getWriter();

		if(password.equals(employPwd)){
			int regInId =  Integer.parseInt(request.getParameter("regInId"));
			System.out.println("regInId : " + regInId);
			try{
				(new ReservationDAO()).update(regInId,"승인반려");

				//승인반려 메일 발송
				String requestUser = (new EmployeesDAO()).login( (new ReservationDAO()).selectById(regInId).getEmpId()).getEmail();
		         (new MailSender()).send( requestUser, "취소확인", regInId);
		         out.println("<script type='text/javascript'>alert('승인 반려 처리가 완료 되었습니다.');");
				 out.println("location.href='../../conference/approval';</script>"); //
				System.out.println("관리자 승인 반려 성공");
			}catch(Exception e){
				out.println("<script type='text/javascript'>alert('승인 반려 처리가 실패하였습니다.\\n" +
						e.getMessage().replace("'", "").replace("\n", "") + "');");
				out.println("location.href='../../conference/approval';</script>");
			}
		}else{
			out.println("<script type='text/javascript'>alert('비밀번호가 일치하지않아 처리 되지 않았습니다.');");
			out.println("location.href='../../conference/approval';</script>"); //
			System.out.println("관리자 승인 반려 실패");
		}
		//response.sendRedirect("../../conference/approval");
	}

}
