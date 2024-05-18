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
import com.web.user.model.service.UserService;

/**
 * Servlet implementation class EnrollUserEndServlet
 */
@WebServlet("/user/enrollend.do")
public class EnrollUserEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EnrollUserEndServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		// String → java.util.Date
		String dateString = request.getParameter("birthday");
		SimpleDateFormat birthSdf = new SimpleDateFormat("yyyy-MM-dd");
		java.sql.Date sqlDate = null;
		// java.util.Date → java.sql.Date
		try {
			Date utilDate = birthSdf.parse(dateString);
			sqlDate = new java.sql.Date(utilDate.getTime());
		}catch(ParseException e) {
			e.printStackTrace();
		}

		User user = User.builder().userId(request.getParameter("userId"))
								  .userName(request.getParameter("name"))
								  .phone(request.getParameter("phone"))
								  .email(request.getParameter("email"))
								  .password(request.getParameter("password"))
								  .address(request.getParameter("address"))
								  .mateCount(0)	// default값 설정
								  .point(0) // default값 설정
								  .status(false) // default값 설정
								  .birthDay(sqlDate)
								  .build();
		if(request.getParameter("ishavingdog").equals("Y")){
			Dog dog = Dog.builder().userId(request.getParameter("userId"))
								   .dogBreedName(request.getParameter("dogBreedKey"))
								   .dogName(request.getParameter("dogName"))
								   .dogWeight(Double.parseDouble(request.getParameter("dogWeight")))
								   .dogImg("")	// 파일 저장
								   .build();
			DogService.getDogService().enrollDog(dog);
		}
		int result = UserService.getUserService().enrollUser(user);
		request.setAttribute("result", result);
		request.setAttribute("user", user);
		request.getRequestDispatcher("/WEB-INF/views/user/login.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
