package com.web.user.controller;

import java.io.IOException;
import java.rmi.ServerException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.web.mail.action.Action;
import com.web.mail.action.ActionForward;
import com.web.mail.action.FindPwAction;
import com.web.mail.action.SendChangePwAction;
import com.web.mail.action.UserChangePwAction;
import com.web.mail.action.VerifyEmailAction;


/**
 * Servlet implementation class SendMailServlet
 */
@WebServlet(urlPatterns={"*.find"})
public class UserFrontServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public UserFrontServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServerException, ServletException, IOException {
    	req.setCharacterEncoding("UTF-8");
    	// 1st. 요청 주소 파악하기
    	String requestURI = req.getRequestURI();
    	System.out.println("requestURI : "+requestURI);
    	// requestURI : /my_project/user/findpw.find
    	String contextPath = req.getContextPath();
    	System.out.println("contextPath : "+contextPath);
    	// contextPath : /my_project
    	String command = requestURI.substring(contextPath.length());
    	System.out.println(command+" : 요청 주소");
    	// /user/findpw.find : 요청 주소
    	
    	// 2nd. 각 요청 주소의 Mapping 처리
    	ActionForward forward = null;
    	Action action = null;
    	
    	// 회원 비밀번호 찾기 처리
    	if(command.equals("/user/findpw.find")) {
    		action = new FindPwAction();
    		// action ? 
    		// 경로가 /user/changepw.find 며 redirect 하는 객체로 만들어짐
    		try {
    			forward = action.execute(req, resp);
    		} catch(Exception e) {
    			e.printStackTrace();
    		}
    	} else if(command.equals("/user/changepw.find")) {
    		// 인증코드 이용 및 새 비밀번호 변경 페이지 요청
    		action = new UserChangePwAction();
    		try {
    			forward=action.execute(req, resp);
    		}catch(Exception e) {
    			e.printStackTrace();
    		}
    	} else if(command.equals("/user/sendpw.find")) {
    		action = new SendChangePwAction();
    		try {
    			forward = action.execute(req, resp);
    		} catch(Exception e) {
    			e.printStackTrace();
    		}
    	} 
    	
    	// 3th. 포워딩 처리
    	if(forward != null) {
    		if(forward.isRedirect()) {
    			// redirect 방식이라면,
    			resp.sendRedirect(forward.getPath());
    		} else {
    			// forward로 처리하는 방식이라면
    			req.getRequestDispatcher(forward.getPath()).forward(req,resp);
    		}
    	}
    	System.out.println("페이지 이동 완료");
    }
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}
