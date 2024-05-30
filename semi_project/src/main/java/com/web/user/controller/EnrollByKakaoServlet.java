package com.web.user.controller;

import java.io.BufferedReader;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.web.user.model.dto.User;

/**
 * Servlet implementation class EnrollByKakaoServlet
 */
@WebServlet("/user/enrollbykakao.do")
public class EnrollByKakaoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EnrollByKakaoServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		StringBuilder sb = new StringBuilder();
		BufferedReader reader = request.getReader();
		String line;
		while((line=reader.readLine())!=null) {
			sb.append(line);
		}		
		Gson gson = new Gson();
		KakaoUser user = gson.fromJson(sb.toString(),KakaoUser.class);
		 
		User login = User.builder()
						.userId(user.id)
						.email(user.email)
						.userName("kakao_"+user.id)
						.build();
		HttpSession session = request.getSession();
		session.setAttribute("loginUser", login);
		gson.toJson(sb, response.getWriter());
		
	}
	private class KakaoUser{
		private String id;
		private String email;
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
