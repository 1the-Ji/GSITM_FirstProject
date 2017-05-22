package com.gsitm.mail;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gsitm.dao.DepOfUseRoomDAO;
import com.gsitm.dao.DepartmentsDAO;
import com.gsitm.dao.EmployeesDAO;
import com.gsitm.dao.FixtureDAO;
import com.gsitm.dao.RegOptionDAO;
import com.gsitm.dao.ReservationDAO;
import com.gsitm.dao.RoomDAO;
import com.gsitm.dao.SnackDAO;
import com.gsitm.dto.DepOfUseRoomDTO;
import com.gsitm.dto.EmployeesDTO;
import com.gsitm.dto.RegOptionDTO;
import com.gsitm.dto.ReservationDTO;
import com.gsitm.dto.RoomDTO;

/**
 * @프로그램명 : MailFormGeneratorServlet.java
 * @작성일    : 2017. 4. 24.
 * @작성자    : 김태형
 * @기능     : 사용자에게 발송되는 이메일 본문 내용 양식으로부터 내용을 채워 html 응답.
 * @버전     : 1.0
 */
@WebServlet("/mailformgen")
public class MailFormGeneratorAction extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//인코딩 설정
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");

		PrintWriter out = response.getWriter();
		String mailType = request.getParameter("type");
		String roomType = "회의실";
		
		try {
			int regId = Integer.parseInt(request.getParameter("regId"));
			
			//예약내역 가져오기
			ReservationDTO resDTO = (new ReservationDAO()).selectById(regId);
			
			//예약자 정보 가져오기
			EmployeesDTO resEmp = (new EmployeesDAO()).login(resDTO.getEmpId());
	
			//예약 룸정보
			RoomDTO room = (new RoomDAO()).selectRoomInfo(resDTO.getRoomId());
			
			//예약옵션(기자재, 간식) 정보
			String fixtureListStr = "";
			String snackListStr = "";
			List<RegOptionDTO> regOptionList = (new RegOptionDAO()).select(regId);
			for(RegOptionDTO regOption : regOptionList){
				if(regOption.getFixtureId() != 0){
					//기자재 이름 문자열 가져오기
					fixtureListStr += (new FixtureDAO()).select(regOption.getFixtureId()).getName() + ", ";
				}
				if(regOption.getSnackId() != 0){
					snackListStr += (new SnackDAO()).select(regOption.getSnackId()).getName()
							+ "(" + regOption.getSnackCount() + "개), ";
				}
			}
			//맨끝 컴마, 제거
			if(2 < fixtureListStr.length())
				fixtureListStr = fixtureListStr.substring(0, fixtureListStr.lastIndexOf(", "));
			if(2 < snackListStr.length())
				snackListStr = snackListStr.substring(0, snackListStr.lastIndexOf(", ")); 
	
			//예약 부서정보 문자열 리스트
			String teamsListStr = "";
			//예약 부서정보
			List<DepOfUseRoomDTO> depList = (new DepOfUseRoomDAO().select(resDTO.getRegInId()));
			for(DepOfUseRoomDTO dep : depList){
				String teamName = (new DepartmentsDAO()).select(dep.getDepId()).getDepName();
				teamsListStr += teamName + ", ";
			}
			teamsListStr = teamsListStr.substring(0, teamsListStr.lastIndexOf(", ")); 
	
			if( 0 <= "ER".indexOf(room.getRoomId()) )
				roomType = "교육실";
			
			request.setAttribute("roomType", roomType);
			request.setAttribute("res", resDTO);
			request.setAttribute("resEmp", resEmp);
			request.setAttribute("room", room);
			request.setAttribute("teams", teamsListStr);
			request.setAttribute("fixtureListStr", fixtureListStr);
			request.setAttribute("snackListStr", snackListStr);
	
			//type == //예약확인 변경확인 취소확인 결재승인 사용승인 결재요청 승인요청 비용청구
			if( "mypage".equals(mailType) ){
				//상세보기시 로그인체크
				EmployeesDTO currentUser = (EmployeesDTO) request.getSession().getAttribute("Employee");
				if(currentUser == null){
					out.println("<script type='text/javascript'>alert('로그인 후 이용해주세요.');");
					out.println("window.close();</script>");
					return;
				}
				//상세보기시 예약자 권한 체크
				if(!(resEmp.getEmpId() == currentUser.getEmpId() || !"user".equals(currentUser.getAuthority()))){
					out.println("<script type='text/javascript'>alert('권한이 없습니다.');");
					out.println("window.close();</script>");
					return;
				}
				
				request.setAttribute("titleStr", "&quot;" 
						+ resEmp.getEmpName() + "&quot;님의 예약 내역입니다.");
				request.setAttribute("btnUrl", "javascript:window.close();");
				request.setAttribute("btnText", "   닫기   ");
			}else if( "예약확인".equals(mailType) ){
				request.setAttribute("titleStr", "&quot;" 
						+ resEmp.getEmpName() + "&quot;님의 예약 내역입니다.");
				request.setAttribute("btnUrl", (request.getRequestURL().toString()).replace("/mailformgen", "/mypage") );
				request.setAttribute("btnText", "예약내역 보기");
			}
			else if ("변경확인".equals(mailType)){
				request.setAttribute("titleStr", "&quot;" 
						+ resEmp.getEmpName() + "&quot;님의 예약이 변경되었습니다.");
				request.setAttribute("btnUrl", (request.getRequestURL().toString()).replace("/mailformgen", "/mypage") );
				request.setAttribute("btnText", "예약내역 보기");
			}
			else if ("취소확인".equals(mailType)){
				request.setAttribute("titleStr", "&quot;" 
						+ resEmp.getEmpName() + "&quot;님의 예약이 취소되었습니다.");
				request.setAttribute("btnUrl", (request.getRequestURL().toString()).replace("/mailformgen", "/mypage") );
				request.setAttribute("btnText", "예약내역 보기");
			}
			else if ("결재승인".equals(mailType)){
				request.setAttribute("titleStr", "&quot;" 
						+ resEmp.getEmpName() + "&quot;님의 예약 결재가 승인되었습니다.");
				request.setAttribute("btnUrl", (request.getRequestURL().toString()).replace("/mailformgen", "/mypage") );
				request.setAttribute("btnText", "예약내역 보기");
			}
			else if ("사용승인".equals(mailType)){
				request.setAttribute("titleStr", "&quot;" 
						+ resEmp.getEmpName() + "&quot;님의 " + roomType + " 사용이 승인되었습니다.");
				request.setAttribute("btnUrl", (request.getRequestURL().toString()).replace("/mailformgen", "/mypage") );
				request.setAttribute("btnText", "예약내역 보기");
			}
			else if ("결재요청".equals(mailType)){
				request.setAttribute("titleStr", "&quot;" 
						+ resEmp.getEmpName() + "&quot;님의 " + roomType + " 예약 결재 요청입니다.");
				String approPage = "/conference/approval";
				if("교육실".equals(roomType))
					approPage = "/education/approval";
				request.setAttribute("btnUrl", (request.getRequestURL().toString()).replace("/mailformgen", approPage) );
				request.setAttribute("btnText", "결재화면 이동");
			}
			else if ("승인요청".equals(mailType)){
				request.setAttribute("titleStr", "&quot;" 
						+ resEmp.getEmpName() + "&quot;님의 " + roomType + "사용 승인 요청입니다.");
				String approPage = "/conference/approval";
				if("교육실".equals(roomType))
					approPage = "/education/approval";
				request.setAttribute("btnUrl", (request.getRequestURL().toString()).replace("/mailformgen", approPage) );
				request.setAttribute("btnText", "승인화면 이동");
			}
			else if ("비용청구".equals(mailType)){
				request.setAttribute("titleStr", roomType + "사용 내역입니다. 비용을 납부해주세요.");
				request.setAttribute("btnUrl", (request.getRequestURL().toString()).replace("/mailformgen", "/mypage") );
				request.setAttribute("btnText", "사용내역 보기");
			}
			else{
				throw new RuntimeException("알 수 없는 메일타입");
			}
			
			//양식 jsp로 포워드
			request.getRequestDispatcher("/WEB-INF/template/reservConfirmMail.jsp").forward(request, response);

		} catch (Exception e) {
			//지정되지 않은 형식일 경우 "Error" 출력 (error일 경우 메일이 전송되지않음)
			out.println("<h1>Error: No Parameter</h1>");
			e.printStackTrace();
			return;
		}
	}
}