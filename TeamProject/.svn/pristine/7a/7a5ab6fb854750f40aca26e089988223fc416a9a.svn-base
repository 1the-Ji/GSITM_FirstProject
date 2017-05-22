package com.gsitm.servlet.provisioning;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gsitm.dao.ProvisioningDAO;
import com.gsitm.dto.EmployeesDTO;

@WebServlet("/provisioning")
public class ProvisioningAction extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();

		//로그인 체크
	    if(request.getSession().getAttribute("Employee") == null){
	    	response.sendRedirect(request.getContextPath() + "/login");
	    	return;
	    }

	    //권한체크
	    if(!("system".equals(request.getSession().getAttribute("Authority")))){
	    	out.println("<script type=\"text/javascript\">alert('시스템 관리자만 접근할 수 있는 메뉴입니다.');");
			out.println("history.back();</script>");
	    	return;
	    }

		ProvisioningDAO pDao = new ProvisioningDAO();
		//기존 회의실 관리자 정보를 검색
		EmployeesDTO oldConfAdmin = pDao.selectConferenceAdmin();
		//기존 교육실 관리자 정보를 검색
		EmployeesDTO oldEduAdmin = pDao.selectEducationAdmin();

		//기존 회의실 관리자 정보
		request.setAttribute("oldConfAdmin", oldConfAdmin);
		//기존 교육실 관리자 정보
		request.setAttribute("oldEduAdmin", oldEduAdmin);

		RequestDispatcher dispatcher = request.getRequestDispatcher("./view/provisioning/provisioning.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();

		String oldConfAdminEmpId = request.getParameter("oldConfAdminEmpId"); //기존 회의실 관리자 아이디
		String oldEduAdminEmpId = request.getParameter("oldEduAdminEmpId");   //기존 교육실 관리자 아이디

		String newConfAdminEmpId = request.getParameter("newConfAdminEmpId"); //새로 지정한 회의실 관리자 아이디
		String newEduAdminEmpId = request.getParameter("newEduAdminEmpId");   //새로 지정한 교육실 관리자 아이디
		try {

			//권한체크
		    if(!("system".equals(request.getSession().getAttribute("Authority")))){
		    	throw new Exception("권한은 시스템 관리자만 변경할 수 있습니다.");
		    }

		    //파라미터 체크
			if(checkWhiteSpace(oldConfAdminEmpId) || checkWhiteSpace(oldEduAdminEmpId)
					||  checkWhiteSpace(newConfAdminEmpId) ||  checkWhiteSpace(newEduAdminEmpId)){
				throw new Exception("필수 파라미터가 없습니다.");
			}

			//중복 체크
			if(newConfAdminEmpId.equals(newEduAdminEmpId))
				throw new Exception("회의실 관리자와 교육실 관리자는 같을 수 없습니다.");

			ProvisioningDAO pDao = new ProvisioningDAO();

			//시스템 관리자 변경 막기
			String sysAdminId =  pDao.selectSystemAdmin().getEmpId();
			if(sysAdminId.equals(newConfAdminEmpId) || sysAdminId.equals(newEduAdminEmpId) )
				throw new RuntimeException("시스템 관리자는 변경할 수 없습니다.");

			//기존의 회의실 관리자의 권한을 일반 사용자로 변경
			pDao.updateOldConferenceAdmin(oldConfAdminEmpId);
			//기존의 교육실 관리자의 권한을 일반 사용자로 변경
			pDao.updateOldEducationAdmin(oldEduAdminEmpId);

			//새로 지정한 사원에게 회의실 관리자 권한을 부여
			pDao.updateNewConferenceAdmin(newConfAdminEmpId);
			//새로 지정한 사원에게 교육실 관리자 권한을 부여
			pDao.updateNewEducationAdmin(newEduAdminEmpId);

			out.println("<script type=\"text/javascript\">alert('권한을 변경하였습니다.');");
			out.println("location.href='./provisioning';</script>");
		} catch (Exception e) {
			out.println("<script type=\"text/javascript\">alert('권한 변경에 실패하였습니다.\\n"
					+ e.getMessage().replace("'", "").replace("\n", "")  + "');");
			out.println("location.href='./provisioning';</script>");
		}
	}

	private boolean checkWhiteSpace(String str){
		if(str == null || "".equals(str))
			return true;
		else
			return false;
	}
}
