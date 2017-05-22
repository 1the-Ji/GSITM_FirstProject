package com.gsitm.dto;

import java.util.Date;
/**
 *
 * @프로그램   : ReservationDTO.java
 * @작성일     : 2017. 5. 4.
 * @작성자     : 지승훈
 * @기능       : 예약 테이블을 위한 DTO
 * @버전       : 1.0
 *
 */
public class ReservationDTO {
   private int regInId;       // 예약내역 id
   private String empId;      // 직원 id
   private String roomId;      // 회의실 교육실 id
   private String regTerm;      // 예약기간 구분 (일일(day)/기간(period))
   private Date startDate;      // 사용시작일시
   private Date finishDate;   // 사용종료일시
   private int fee;         // 비용
   private int useCount;      // 사용인원
   private Date approDate;      // 승인시간
   private Date regDate;      // 예약 등록 시간
   private String regState;   // 예약상태
   private String useState;   // 사용구분 (내부회의/고객미팅/기타회의)
   private String usePurpose;   // 사용목적
   private String useNetwork;    // 네트워크 이용여부 (Y/N)
   
   /**
    * 
    *  예약상태 regState 상태정의
    *  
	*	결재대기
	*	승인대기
	*	결재완료
	*	승인완료
	*	사용완료
	*	예약취소
	*	결재반려
	*	승인반려
	*	결재지연취소
	*	승인지연취소
    *  
    */

   public int getRegInId() {
      return regInId;
   }
   public void setRegInId(int regInId) {
      this.regInId = regInId;
   }
   public String getEmpId() {
      return empId;
   }
   public void setEmpId(String empId) {
      this.empId = empId;
   }
   public String getRoomId() {
      return roomId;
   }
   public void setRoomId(String roomId) {
      this.roomId = roomId;
   }
   public Date getStartDate() {
      return startDate;
   }
   public void setStartDate(Date startDate) {
      this.startDate = startDate;
   }
   public Date getFinishDate() {
      return finishDate;
   }
   public void setFinishDate(Date finishDate) {
      this.finishDate = finishDate;
   }
   public int getFee() {
      return fee;
   }
   public void setFee(int fee) {
      this.fee = fee;
   }
   public int getUseCount() {
      return useCount;
   }
   public void setUseCount(int useCount) {
      this.useCount = useCount;
   }
   public Date getApproDate() {
      return approDate;
   }
   public void setApproDate(Date approDate) {
      this.approDate = approDate;
   }
   public Date getRegDate() {
      return regDate;
   }
   public void setRegDate(Date regDate) {
      this.regDate = regDate;
   }
   public String getRegState() {
      return regState;
   }
   public void setRegState(String regState) {
      this.regState = regState;
   }
   public String getUseState() {
      return useState;
   }
   public void setUseState(String useState) {
      this.useState = useState;
   }
   public String getUsePurpose() {
      return usePurpose;
   }
   public void setUsePurpose(String usePurpose) {
      this.usePurpose = usePurpose;
   }
   public String getUseNetwork() {
      return useNetwork;
   }
   public void setUseNetwork(String useNetwork) {
      this.useNetwork = useNetwork;
   }
   public String getRegTerm() {
      return regTerm;
   }
   public void setRegTerm(String regTerm) {
      this.regTerm = regTerm;
   }
}