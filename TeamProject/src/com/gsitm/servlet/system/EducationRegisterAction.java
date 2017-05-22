package com.gsitm.servlet.system;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gsitm.dao.FixtureDAO;
import com.gsitm.dao.RoomDAO;
import com.gsitm.dao.RoomPhotoDAO;
import com.gsitm.dao.SnackDAO;
import com.gsitm.dto.FixtureDTO;
import com.gsitm.dto.RoomDTO;
import com.gsitm.dto.RoomPhotoDTO;
import com.gsitm.dto.SnackDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;


/**
 * Servlet implementation class RegisterAction
 */
@WebServlet("/education/registeraction")
public class EducationRegisterAction extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("education/registerAction : get()");

		//인코딩 설정
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		//로그인 체크
		if(request.getSession().getAttribute("Employee") == null){
			out.println("<script type='text/javascript'>alert('로그인 후 이용해주세요.');");
			out.println("window.close();</script>");
			return;
		}

		//권한체크
		if(!("system".equals(request.getSession().getAttribute("Authority")))){
			out.println("<script type='text/javascript'>alert('시스템 관리자만 접근할 수 있는 메뉴입니다.');");
			out.println("window.close();</script>");
			return;
		}
	    
		RequestDispatcher dispatcher = request.getRequestDispatcher("../view/system/educationRegister.jsp");
	    dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("RegisterAction_post");
		HttpSession session = request.getSession();

		//인코딩 설정
	    request.setCharacterEncoding("UTF-8");
	    response.setContentType("text/html;charset=UTF-8");
	    PrintWriter out = response.getWriter();

	    //권한체크
	    if(!("system".equals(request.getSession().getAttribute("Authority")))){
	    	out.println("<script type='text/javascript'>alert('권한이 없습니다.');");
	    	out.println("history.back();</script>"); //
	    	return;
	    }

	    //회의실 이미지
  		String savePath = "resources/image";
  		int uploadFileSizeLimit = 20 * 1024 * 1024;
  		String encType = "UTF-8";

  		ServletContext context = getServletContext();
  		String uploadFilePath = context.getRealPath(savePath);


  		MultipartRequest multi = new MultipartRequest(request,
  			uploadFilePath,										//파일 저장될 위치
  			uploadFileSizeLimit,								//업로드 파일 크기제한
  			encType,											//파일 형식
  			new DefaultFileRenamePolicy()
  		);

  		try{
	    	//필수 파라미터 체크
			String[] paramCheckList
				= {"roomName", "position", "buildName", "roomSize", "numberOfEmp", "netFlag",
				   "fee","fixtureName","fixturePay","snackName","snackPay"};
			for(String paramCheck : paramCheckList){
				if(checkWhiteSpace(multi.getParameter(paramCheck))){
					throw new RuntimeException("필수 파라미터 " + paramCheck + "가 없습니다.");
				}
			}

			String[] paramCheckListPhoto = {"uploadFile1", "uploadFile2", "uploadFile3"};
			Enumeration files = multi.getFileNames();
			int count = 0;
			while(files.hasMoreElements()){
				if(checkWhiteSpace(multi.getFilesystemName((String)files.nextElement()))){
					throw new RuntimeException("필수 파라미터 " + paramCheckListPhoto[count] + "가 없습니다.");
				};
				count++;
			}
		    String empId= (String) session.getAttribute("login");
		    System.out.println("login : "+session.getAttribute("login"));

	  		int roomIdNum = (new RoomDAO()).selectGetNextSequence();
			RoomDTO roomDTO = new RoomDTO();
			roomDTO.setRoomId("ER" + String.format("%04d", roomIdNum));
			roomDTO.setRoomName(multi.getParameter("roomName"));
			System.out.println("roomName " + roomDTO.getRoomName());
			roomDTO.setPosition(multi.getParameter("position"));
			System.out.println("position :" + roomDTO.getPosition());
			roomDTO.setBuildName(multi.getParameter("buildName"));
			System.out.println("buildName : " + roomDTO.getBuildName());
			roomDTO.setRoomSize(multi.getParameter("roomSize"));
			System.out.println("roomSize : " + roomDTO.getRoomSize());
			roomDTO.setNetFlag(multi.getParameter("netFlag"));
			System.out.println("netFlag : " + roomDTO.getNetFlag());
			roomDTO.setFee(Integer.parseInt(multi.getParameter("fee")));
			System.out.println("fee : " + roomDTO.getFee());
			roomDTO.setNumberOfEmp(Integer.parseInt(multi.getParameter("numberOfEmp")));
			System.out.println("numberOfEmp : " + roomDTO.getNumberOfEmp());
			roomDTO.setEmpId(empId);
			System.out.println("empId : " + empId);
			(new RoomDAO()).insert(roomDTO);
			//비치물품 저장
			String[] fixtureName = multi.getParameterValues("fixtureName");
			System.out.println("fixtureNameLength : " +fixtureName.length);
			String[] pay = multi.getParameterValues("fixturePay");
			System.out.println("payLength : " + pay.length);
			FixtureDTO fixtureDTO = new FixtureDTO();
			for(int i=0; i<fixtureName.length; i++){
				fixtureDTO.setRoomId("ER" + String.format("%04d", roomIdNum));
				fixtureDTO.setName(fixtureName[i]);
				System.out.println("fixtureName : " + fixtureDTO.getName());
				fixtureDTO.setPay(Integer.parseInt(pay[i]));
				System.out.println("fixturePay : " + fixtureDTO.getPay());
				(new FixtureDAO()).insert(fixtureDTO);
			}
			//간식 저장
			String[] snackName = multi.getParameterValues("snackName");
			String[] snackPay = multi.getParameterValues("snackPay");
			SnackDTO snackDTO = new SnackDTO();
			for(int i=0; i<snackName.length; i++){
				snackDTO.setRoomId("ER" + String.format("%04d", roomIdNum));
				snackDTO.setName(snackName[i]);
				System.out.println("snackName : " + snackDTO.getName());
				snackDTO.setPay(Integer.parseInt(snackPay[i]));
				System.out.println("snackPay : " + snackDTO.getPay());
				(new SnackDAO()).insert(snackDTO);
			}
			//이미지 저장
			files = multi.getFileNames();
			RoomPhotoDTO roomPhotoDTO = new RoomPhotoDTO();
			while(files.hasMoreElements()){
				String file = (String)files.nextElement();
				String file_name = multi.getFilesystemName(file);
				roomPhotoDTO.setPhotoName(file_name);
				roomPhotoDTO.setRoomId("ER" + String.format("%04d", roomIdNum));
				System.out.println("file_name : " + roomPhotoDTO.getPhotoName());

				(new RoomPhotoDAO()).insert(roomPhotoDTO);
			}

  		}catch(Exception e){
  			out.println("<script type='text/javascript'>alert('교육실 등록에 실패하였습니다.\\n" +
					e.getMessage().replace("'", "").replace("\n", "") + "');");
			out.println("window.close();</script>");
  		}
		//response.sendRedirect("../education/manageaction");
  		 out.println("<script type='text/javascript'>alert('교육실을 등록하였습니다.');");
  		 out.println("opener.parent.location.reload();window.close();</script>");
	}

	private boolean checkWhiteSpace(String str) {
		if(str == null || "".equals(str))
			return true;
		else
			return false;
	}
}
