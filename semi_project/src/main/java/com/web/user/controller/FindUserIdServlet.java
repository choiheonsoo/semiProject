package com.web.user.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.web.user.model.dto.User;
import com.web.user.model.service.UserService;

/**
 * Servlet implementation class FindUserIdServlet
 */
@WebServlet("/user/finduserid.do")
public class FindUserIdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FindUserIdServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String targetEmail = request.getParameter("userEmail");
		String targetName = request.getParameter("userName");
		String userId = UserService.getUserService().searchUserId(targetEmail, targetName);
		System.out.println(userId.equals(""));
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(userId);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
