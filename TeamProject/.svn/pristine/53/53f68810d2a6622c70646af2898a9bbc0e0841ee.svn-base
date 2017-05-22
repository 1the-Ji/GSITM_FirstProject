
package com.gsitm.scheduler;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

/**
 * 기본으로 서버 start와 shutdown 시에 quartz동작에 대해 servlet으로 띄워준다.
 */
@WebServlet("/QuartzInitializerAction")
public class QuartzInitializerAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public QuartzInitializerAction() {
        super();
        System.out.println("서버 시작 스케쥴러 초기화!");
    }
}
