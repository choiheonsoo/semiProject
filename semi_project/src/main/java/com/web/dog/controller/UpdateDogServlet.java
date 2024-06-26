package com.web.dog.controller;

import static com.web.dog.service.DogService.getDogService;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.web.dog.model.dto.Dog;
import com.web.user.model.dto.User;

/**
 * Servlet implementation class UpdateDogServlet
 */
@WebServlet("/user/dogupdate.do")
public class UpdateDogServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateDogServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = (User)request.getSession().getAttribute("loginUser");
		String userId = user.getUserId();
		List<Dog> dogs = getDogService().selectDogs(userId);
		
		request.setAttribute("dogs", dogs);
		request.getRequestDispatcher("/WEB-INF/views/user/updateDog.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
