package com.web.user.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.web.dog.model.dto.Dog;
import com.web.dog.service.DogService;
import com.web.user.model.dto.User;

/**
 * Servlet implementation class UpdateUserEndServlet
 */
@WebServlet("/user/updateend.do")
public class UpdateUserEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateUserEndServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String dateString = request.getParameter("birthDay");
		SimpleDateFormat birthSdf = new SimpleDateFormat("yyyy-MM-dd");
		java.sql.Date sqlDate = null;
		try {
			Date utilDate = birthSdf.parse(dateString);
			sqlDate = new java.sql.Date(utilDate.getTime());
		}catch(ParseException e) {
			e.printStackTrace();
		}
		User.builder().userId(request.getParameter("userId"))
					  .userName(request.getParameter("userName"))
					  .phone(request.getParameter("phone"))
					  .email(request.getParameter("email"))
					  .address(request.getParameter("address"))
					  .password(request.getParameter("password"))
					  .birthDay(sqlDate)
					  .build();
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
