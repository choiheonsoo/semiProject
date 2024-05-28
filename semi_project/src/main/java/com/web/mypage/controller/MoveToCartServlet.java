package com.web.mypage.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.web.mypage.service.MypageService;
import com.web.user.model.dto.User;

/**
 * Servlet implementation class MoveToCartServlet
 */
@WebServlet("/user/movetocart.do")
public class MoveToCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MoveToCartServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		int productKey = Integer.parseInt(request.getParameter("productkey"));
		String productColor = request.getParameter("productcolor");
		String productSize = request.getParameter("productsize");
		String userId = ((User)request.getSession().getAttribute("loginUser")).getUserId();
		
		int result = MypageService.getService().moveToCart(userId, productKey, productColor, productSize);
		 
		String msg = "";
		String loc = "/user/cart.do";
		if(result>0) {
			msg = "선택하신 항목이 장바구니로 이동됐습니다.";
		} else if(result==-100) {	
			msg = "선택하신 항목은 이미 장바구니에 있습니다.";
		} else {
			msg = "장바구니로 이동이 실패했습니다.";
		}
		request.setAttribute("msg",msg);
		request.setAttribute("loc",loc);
		request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
