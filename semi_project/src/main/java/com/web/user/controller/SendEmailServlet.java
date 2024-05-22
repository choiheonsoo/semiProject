package com.web.user.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.web.mail.util.NaverMailSend;
import com.web.user.model.dto.User;
import com.web.user.model.service.UserService;

/**
 * Servlet implementation class VerifyEmailServlet
 */
@WebServlet("/user/sendemail.do")
public class SendEmailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SendEmailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json;charset=utf-8");
		String email = request.getParameter("email");
		NaverMailSend mailSend = new NaverMailSend();
		HttpSession session = request.getSession();
		String authenCode = "";
		User user = UserService.getUserService().searchUserByEmail(email);
		System.out.println(user);
		if(user==null) {
			try {
				authenCode = mailSend.sendEmail(email);
				session.setAttribute("authenCode",authenCode);
			} catch (Exception e) {
				e.printStackTrace();
				// 유효한 이메일이 아니라면 알림 보내주기 로직구현 필요
			}
		} 
		System.out.println("session에 저장된 코드 : "+authenCode);
		Gson gson = new Gson();
		gson.toJson(user, response.getWriter());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
