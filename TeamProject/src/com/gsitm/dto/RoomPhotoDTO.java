package com.gsitm.dto;
/**
 *
 * @프로그램   : RoomPhotoDTO.java
 * @작성일     : 2017. 5. 4.
 * @작성자     : 지승훈
 * @기능       : 회의실/교육실 사진테이블을 위한 DTO
 * @버전       : 1.0
 *
 */
public class RoomPhotoDTO {
	private String photoName; // 사진이름
	private String roomId;	   // 회의실/예약실 ID

	public String getPhotoName() {
		return photoName;
	}
	public void setPhotoName(String photoName) {
		this.photoName = photoName;
	}
	public String getRoomId() {
		return roomId;
	}
	public void setRoomId(String roomId) {
		this.roomId = roomId;
	}


}
