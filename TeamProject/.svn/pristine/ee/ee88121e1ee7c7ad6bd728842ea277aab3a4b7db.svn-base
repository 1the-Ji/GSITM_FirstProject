package com.gsitm.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.gsitm.common.ConstString;
import com.gsitm.dto.DepartmentsDTO;
/**
 *
 * @프로그램   : EmployeesDAO.java
 * @작성일     : 2017. 5. 2.
 * @작성자     : 지승훈
 * @기능       : 회의실/예약실에 대한 결제비용관련 DAO
 * @버전       : 1.0
 *
 */

public class DepartmentsDAO {
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
	 * @작성일      : 2017. 5. 2.
	 * @작성자      : 지승훈
	 * @기능    	:
	 * @메소드명    : insert
	 * @param payInfoDTO
	 */
	public void insert(DepartmentsDTO departmentsDTO){
		Connection con = getConnection();
		PreparedStatement pstmt = null;
		String sql = null; //sql문 작성
		try {
			pstmt = con.prepareStatement(sql);

			pstmt.executeUpdate();
		} catch (SQLException e) {
			 new RuntimeException(e);
		} finally {
			DepartmentsDAO.close(con, pstmt);;
		}
	}

	/**
	 *
	 * @작성일  : 2017. 5. 13.
	 * @작성자  : 김태형
	 * @기능    :
	 * @메소드명 : select
	 * @param num
	 * @return
	 */
	public DepartmentsDTO select(String depId){
		Connection con = getConnection();
		PreparedStatement pstmt = null;

		DepartmentsDTO dep = new DepartmentsDTO();
		String sql = "SELECT * FROM departments WHERE dep_id=?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, depId);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()){
				dep.setDepId(rs.getString("dep_id"));
				dep.setDepName(rs.getString("dep_name"));
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		} finally {
			DepartmentsDAO.close(con, pstmt);
		}

		return dep;
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
