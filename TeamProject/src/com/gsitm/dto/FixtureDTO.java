package com.gsitm.dto;
/**
 *
 * @프로그램   : FixtureDTO.java
 * @작성일     : 2017. 5. 4.
 * @작성자     : 지승훈
 * @기능       : 기자재 테이블을 위한 DTO
 * @버전       : 1.0
 *
 */
public class FixtureDTO {
	private int fixtureId;
	private String name;	// 기자재 이름
	private String roomId;	// 회의실/교육실 ID
	private int pay;		// 기자재 비용
	
	public int getFixtureId() {
		return fixtureId;
	}
	public void setFixtureId(int fixtureId) {
		this.fixtureId = fixtureId;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRoomId() {
		return roomId;
	}
	public void setRoomId(String roomId) {
		this.roomId = roomId;
	}
	public int getPay() {
		return pay;
	}
	public void setPay(int pay) {
		this.pay = pay;
	}
}
