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
		response.setContentType("text/html;charset=utf-8");
		String email = request.getParameter("email");
		NaverMailSend mailSend = new NaverMailSend();
		HttpSession session = request.getSession();
		if((String)session.getAttribute("isLogin")!=null) {
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('잘못된 접근입니다.')");
			// 메인페이지로 이동해버리기
			out.println("location.href='"+request.getContextPath()+"/");
			out.println("</script>");
		} else {
			User user = UserService.getUserService().searchUserByEmail(email);
			if(user==null) {
				try {
					String authenCode = mailSend.sendEmail(email);
					session.setAttribute("authenCode",authenCode);
				} catch (Exception e) {
					e.printStackTrace();
				}
			} 
			Gson gson = new Gson();
			gson.toJson(user, response.getWriter());
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
