package com.gsitm.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.gsitm.common.ConstString;
import com.gsitm.dto.RegOptionDTO;



/**
 *
 * @프로그램   : EmployeesDAO.java
 * @작성일     : 2017. 5. 2.
 * @작성자     : 지승훈
 * @기능       : 회의실/예약실 예약에 필요한 간식 및 비품 개수 관련 DAO
 * @버전       : 1.0
 *
 */

public class RegOptionDAO {
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
	 * @작성일  : 2017. 5. 13.
	 * @작성자  : 김태형
	 * @기능    : 예약 id로 예약 옵션(기자재/간식)id리스트 가져오기
	 * @메소드명 : select
	 * @param regId
	 * @return
	 */
	public List<RegOptionDTO> select(int regId){
		Connection con = getConnection();
		PreparedStatement pstmt = null;
		List<RegOptionDTO> regOptionList = new ArrayList<RegOptionDTO>();
		String sql = "SELECT * FROM reg_option WHERE reg_in_id=?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, regId);

			ResultSet rs = pstmt.executeQuery();

			while(rs.next()){
				RegOptionDTO regOp = new RegOptionDTO();
				regOp.setRegInId(rs.getInt("reg_in_id"));
				regOp.setFixtureId(rs.getInt("fixture_id"));
				regOp.setSnackId(rs.getInt("snack_id"));
				regOp.setSnackCount(rs.getInt("snack_count"));
				regOptionList.add(regOp);
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		} finally {
			RegOptionDAO.close(con, pstmt);;
		}

		return regOptionList;
	}

	/**
	 *
	 * @작성일      : 2017. 5. 2.
	 * @작성자      : 김태형
	 * @기능    	: 회의실/교육실 예약시 선택한 비품 및 간식 등록
	 * @메소드명    : insert
	 * @param roomDTO
	 */
	public void insert(RegOptionDTO regOptionDTO){
		Connection con = getConnection();
		PreparedStatement pstmt = null;
		String sql = "insert into reg_option (REG_IN_ID, SNACK_ID, SNACK_COUNT, FIXTURE_ID) values (?, ?, ?, ?)";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, regOptionDTO.getRegInId());
			pstmt.setInt(2, regOptionDTO.getSnackId());
			pstmt.setInt(3, regOptionDTO.getSnackCount());
			pstmt.setInt(4, regOptionDTO.getFixtureId());

			pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		} finally {
			RegOptionDAO.close(con, pstmt);;
		}
	}

	/**
	 *
	 * @작성일      : 2017. 5. 2.
	 * @작성자      : 지승훈
	 * @기능    	: 회의실/예약실 예약에 필요한 간식 및 비품 개수 수정 메소드
	 * @메소드명    : update
	 * @param roomDTO
	 */
	public void update(RegOptionDTO regOptionDTO,int num){
		Connection con = getConnection();
		PreparedStatement pstmt = null;
		String sql = null; //sql문 작성
		   try {
			   pstmt = con.prepareStatement(sql);

			   pstmt.executeUpdate();
		      } catch (SQLException e) {
		    	  new RuntimeException(e);
		      } finally {
		    	  RegOptionDAO.close(con, pstmt);;
		      }
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
