package com.web.mypage.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.web.mypage.service.MypageService;

/**
 * Servlet implementation class WishListDeleteServlet
 */
@WebServlet("/user/wishlistdelete.do")
public class WishListDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public WishListDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String targetItems = request.getParameter("targetItems");
		System.out.println(targetItems);
		int result = MypageService.getService().deleteWishListItems(targetItems);
		String msg = "";
		String loc = "/user/wishlist.do";
		if(result>0) {
			msg = "선택하신 항목이 찜에서 삭제됐습니다.";
		} else {
			msg = "선택하신 항목을 삭제하는데 실패했습니다.";
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
