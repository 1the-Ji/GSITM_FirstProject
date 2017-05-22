package com.gsitm.mail;

import java.util.Base64;

import com.gsitm.common.ConstString;

/**
 * @프로그램명 : MailSender.java
 * @작성일    : 2017. 5. 12.
 * @작성자    : 김태형
 * @기능     : 시스템이 예약 건에 대해 메일을 발송하도록 메일 정보를 설정하고 메일전송 호출
 * @버전     : 1.0
 *
 */
public class MailSender {
	
	/**
	 * 
	 * @작성일  : 2017. 5. 12.
	 * @작성자  : 김태형
	 * @기능    : 시스템이 사용자 예약정보를 조회하여 메일을 전송한다.
	 * @메소드명 : send
	 * @param emailAddress - 수신자 이메일주소
	 * @param type - 발송 메일양식 종류 (예약확인 변경확인 취소확인 결재승인 사용승인 결재요청 승인요청 비용청구)
	 * @param regId - 예약 ID
	 * @return - 전송결과 (true:성공/false:실패)
	 */
	public boolean send(String emailAddress, String type, int regId){
		
		if(ConstString.DISABLE_MAIL_SEND){
			System.out.println("▶ 이메일 발송 가정 - 수신자: " 
					+ emailAddress + " 타입: " + type + " regId:" + regId);
			return true;
		}
		
		String body = "";
		String subject = "";

		StringBuilder query = new StringBuilder();
		query.append("type=" + type); //메일타입
		query.append("&regId=" + regId); //예약id
		
		String formUrl = ConstString.SERVER_ROOT_URL;
		if(formUrl == null || "".equals(formUrl))
			return false;
		formUrl += "/mailformgen";
		
		try {
			if ("예약확인".equals(type)){
				subject = "[GS ITM] 예약하신 내역입니다.";
			}
			else if ("변경확인".equals(type)){
				subject = "[GS ITM] 예약이 변경되었습니다.";
			}
			else if ("취소확인".equals(type)){
				subject = "[GS ITM] 예약이 취소되었습니다.";
			}
			else if ("결재승인".equals(type)){
				subject = "[GS ITM] 예약 결재가 승인되었습니다.";
			}
			else if ("사용승인".equals(type)){
				subject = "[GS ITM] 예약이 승인되었습니다.";
			}
			else if ("결재요청".equals(type)){
				subject = "[GS ITM] 예약 결재 요청입니다.";
			}
			else if ("승인요청".equals(type)){
				subject = "[GS ITM] 예약 승인 요청입니다.";
			}
			else if ("비용청구".equals(type)){
				subject = "[GS ITM] 비용 청구 메일입니다.";
			}
			else if ("결재반려취소".equals(type)){
				subject = "[GS ITM] 비용 청구 메일입니다.";
			}
			else if ("승인반려취소".equals(type)){
				subject = "[GS ITM] 비용 청구 메일입니다.";
			}
			else if ("지연취소".equals(type)){
				subject = "[GS ITM] 비용 청구 메일입니다.";
			}
			else {
				return false;
			}

			body = HttpReader.getHtmlString(formUrl, query.toString());

			//에러 페이지일 경우 메일 보내지 않음
			if( 0 <= body.indexOf("Error") ){
				System.out.println("메일 전송 실패 - 폼 작성 에러");
				return false;
			}

			//발신자 정보 설정
			MailManager mn = new MailManager("김태형", "it0907@gsitm.com", new String(Base64.getDecoder().decode("MTg5OTkxNQ==")));

			//수신자로 전송
			String result = mn.sendMail(emailAddress, subject, body);

			//debug
			System.out.println("메일 전송 결과 - " + result);
			
			if("Send OK".equals(result)){
				return true;
			} else {
				return false;
			}

		} catch (Exception e) {
			return false;
		}
	}
}
