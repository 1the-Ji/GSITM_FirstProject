package com.gsitm.mail;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.*;

/**
 * @프로그램명 : HtmlReader.java
 * @작성일    : 2017. 4. 21.
 * @작성자    : 김태형
 * @기능     : http 서버상의 문서 html코드를 읽어온다. 메일 양식 jsp로 부터 html을 가져올때 사용
 * @버전     : 1.0
 */
public class HttpReader {
	
	/**
	 * @작성일  : 2017. 4. 21.
	 * @작성자  : 김태형
	 * @기능    : 
	 * @메소드명 : getHtmlString
	 * @param urlToRead - Html코드를 가져올 페이지의 URL
	 * @param query - 메일 폼에 전달할 데이터 쿼리스트링 (예: name=예약자이름&location=재동본사)
	 * @return - URL 페이지의 html코드
	 */
	public static String getHtmlString(String urlToRead, String query) {
		URL url;
		HttpURLConnection conn;
		String result = "";
		
		try {
			url = new URL(urlToRead);
			conn = (HttpURLConnection) url.openConnection();
			
			//요청 헤더 설정
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Accept-Charset", "UTF-8");
			conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			conn.setRequestProperty("charset", "UTF-8");
			conn.setDoInput(true);
			conn.setDoOutput(true);
			
			//POST본문
			OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
			wr.write(query);
			wr.flush(); 
			
			//응답 읽기 
			BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			StringBuilder sb = new StringBuilder();
			String line;
			while ((line = rd.readLine()) != null) {
				sb.append(line).append("\n");
			}
			result = sb.toString();
			
			rd.close();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}
