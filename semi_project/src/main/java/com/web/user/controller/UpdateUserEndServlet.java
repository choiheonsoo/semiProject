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
		String dateString = request.getParameter("birthday");
		SimpleDateFormat birthSdf = new SimpleDateFormat("yyyy-MM-dd");
		java.sql.Date sqlDate = null;
		try {
			Date utilDate = birthSdf.parse(dateString);
			sqlDate = new java.sql.Date(utilDate.getTime());
		}catch(ParseException e) {
			e.printStackTrace();
		}
		User user = User.builder().userId(request.getParameter("userId").trim())
					   	 	 	  .userName(request.getParameter("name"))
					   	 	 	  .phone(request.getParameter("phone"))
					   	 	 	  .email(request.getParameter("email"))
					   	 	 	  .address(request.getParameter("address"))
					   	 	 	  .password(request.getParameter("password"))
					   	 	 	  .birthDay(sqlDate)
					   	 	 	  .build();
		int result = UserService.getUserService().updateUser(user);
		if(result>0) {
			request.setAttribute("msg","회원 정보 수정완료");
			request.setAttribute("loc","/");
			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
		} else {
			request.setAttribute("msg","수정에 실패했습니다. 관리자에게 문의해주세요.");
			request.setAttribute("loc","/");
			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
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
