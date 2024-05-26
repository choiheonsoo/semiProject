package com.web.mypage.controller;

import java.io.IOException;
import java.text.DecimalFormat;
import java.util.List;
import java.util.Optional;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.web.mypage.model.dto.CartList;
import com.web.mypage.service.MypageService;
import com.web.user.model.dto.User;

/**
 * Servlet implementation class CartPageServlet
 */
@WebServlet("/user/cart.do")
public class CartPageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CartPageServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User loginUser = (User)session.getAttribute("loginUser");
		
		List<CartList> list = MypageService.getService().getCartListByUserId(loginUser.getUserId());
		Optional<Integer> total = list.stream().filter(p->p.getStock()>0).map(e->(int)((100-e.getRateDiscount())/100*e.getPrice())).reduce((p,n)->p+n);
		int totalSum = total.orElse(0);
		DecimalFormat formatter = new DecimalFormat("#,###");
        String sum = formatter.format(totalSum);
		request.setAttribute("total", sum);
		request.setAttribute("cartlist", list);
		request.getRequestDispatcher("/WEB-INF/views/mypage/cart.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
