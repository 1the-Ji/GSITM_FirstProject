package com.gsitm.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.gsitm.common.ConstString;
import com.gsitm.dto.ApprovalInfoDTO;

/**
 *
 * @프로그램   : ApprovalInfoDAO.java
 * @작성일     : 2017. 5. 2.
 * @작성자     : 지승훈
 * @기능       : 승인내역에 대한 DAO
 * @버전       : 1.0
 *
 */
public class ApprovalInfoDAO {
	public static Connection getConnection() {
	      Connection conn = null;
	      try {
	         Class.forName(ConstString.JDBC_DRIVER);
	         conn = DriverManager.getConnection(ConstString.DB_SERVER, ConstString.DB_USER, ConstString.DB_PASSWD);
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	      return conn;
	   }

	/**
	 *
	 * @작성일      : 2017. 5. 13.
	 * @작성자      : 김태형
	 * @기능    	: 예약한 회의실/교육실에 대한 승인 내역 등록
	 * @메소드명    : insert
	 * @param approvalInfoDTO
	 */
	public void insert(ApprovalInfoDTO approvalInfoDTO){
		Connection con = getConnection();
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO approval_info (emp_id, reg_in_id) VALUES (?, ?)"; //sql문 작성
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, approvalInfoDTO.getEmpId());
			pstmt.setInt(2, approvalInfoDTO.getRegInId());

			pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		} finally {
			ApprovalInfoDAO.close(con, pstmt);
		}
	}

	/**
	 *
	 * @작성일      : 2017. 5. 2.
	 * @작성자      : 지승훈
	 * @기능    	: 예약한 회의실/교육실에 대한 승인 내역 조회
	 * @메소드명    : selectAll
	 * @param num
	 * @return
	 */
	public List<ApprovalInfoDTO> selectAll(int num){
		Connection con = getConnection();
		PreparedStatement pstmt = null;
		List<ApprovalInfoDTO> approvalInfoList = new ArrayList<ApprovalInfoDTO>();
		String sql = null; //sql문 작성
		   try {
			   pstmt = con.prepareStatement(sql);

			   pstmt.executeQuery();
		      } catch (SQLException e) {
		    	  new RuntimeException(e);
		      } finally {
		    	  ApprovalInfoDAO.close(con, pstmt);
		      }

		return approvalInfoList;
	}

	/**
	 *
	 * @작성일      : 2017. 5. 2.
	 * @작성자      : 지승훈
	 * @기능    	:
	 * @메소드명    : close
	 * @param con
	 * @param pstmt
	 */
	private static void close(Connection con, PreparedStatement pstmt) {
		 try {
			 pstmt.close();
			 con.close();
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	}
}
