package com.web.shoppingmall.controller;

import static com.web.shoppingmall.model.service.ShoppingmallService.getService;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.web.shoppingmall.model.dto.Cart;
/**
 * Servlet implementation class InsertCartServlet
 */
@WebServlet("/shoppingmall/insertCart.do")
public class InsertCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertCartServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 장바구니 담기 기능^^
		Cart c=new Cart().builder()
				.productKey(Integer.parseInt(request.getParameter("productKey")))
				.userId(request.getParameter("userId"))
				.productColor(request.getParameter("color"))
				.productSize(request.getParameter("size"))
				.build();
		int result=getService().insertCart(c);
		boolean success=false;
		if(result>0) {
			success=true;
		}
		response.setContentType("application/json;charset=UTF-8");
		Gson gson=new Gson();
		gson.toJson(success,response.getWriter());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
