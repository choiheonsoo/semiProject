package com.web.mypage.controller;

import static com.web.shoppingmall.model.service.ShoppingmallService.getService;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.web.shoppingmall.model.dto.Orders;
import com.web.shoppingmall.model.dto.Product;
import com.web.shoppingmall.model.dto.Review;
import com.web.user.model.dto.User;
/**
 * Servlet implementation class OrderListServlet
 */
@WebServlet("/mypage/oderlist.do")
public class OrderListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OrderListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 주문내역 확인 페이지
		// 주문한 상품들의 상태를 확인할 수 있다
		
		String userId=((User)request.getSession().getAttribute("loginUser")).getUserId();
		//주문 객체 리스트
		List<Orders> orders=getService().selectOrdersById(userId);
		//상품 객체 맵
		Map<String, Product> products=getService().selectProductById(userId);
		//리뷰 판단용 리뷰객체 리스트
		List<Review> reviews=getService().selectReviewById(userId);
		
		request.setAttribute("reviews", reviews);
		request.setAttribute("orders", orders);
		request.setAttribute("products", products);
		request.getRequestDispatcher("/WEB-INF/views/mypage/orderlist.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
