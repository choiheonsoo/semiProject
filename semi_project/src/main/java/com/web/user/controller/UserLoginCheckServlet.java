package com.web.user.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import static com.web.user.model.service.UserService.getUserService;
import com.web.user.model.dto.User;

/**
 * Servlet implementation class UserLoginCheckServlet
 */
@WebServlet("/user/loginuser.do")
public class UserLoginCheckServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UserLoginCheckServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//id, password만 불러와서 두 개의 값이 일치할 경우에만 가져옴
		//user가 존재한다면 session에 저장. 나머지 로직들은 다 구현해야함
		String id = request.getParameter("username");
		String password = request.getParameter("password");

		User user = getUserService().loginUser(id,password);
		String dogImg = getUserService().getDogImg(id);
		if(user!=null && user.getUserId().equals("admin")) {
			HttpSession session = request.getSession();
			session.setAttribute("loginUser", user);
			session.setAttribute("dogImg", dogImg);
			session.setAttribute("isLogin", true);
			request.getRequestDispatcher("/WEB-INF/views/admin/adminpage.jsp").forward(request, response);	
		} else {
			if(user!=null&& user.getStatus().equals("Y")) {
				request.setAttribute("msg", "탈퇴한 회원입니다.");
				request.setAttribute("loc", "/");
				request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
			}else if(user!=null){
				HttpSession session = request.getSession();
				session.setAttribute("loginUser", user);
				session.setAttribute("dogImg", dogImg);
				session.setAttribute("isLogin", true);
				request.setAttribute("msg", "어서오세요!");
				request.setAttribute("loc", "/");
				request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
			}else {
				request.setAttribute("msg", "아이디 혹은 비밀번호를 확인해주세요.");
				request.setAttribute("loc", "/user/login.do");
				request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
			}
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
