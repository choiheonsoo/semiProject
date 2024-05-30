package com.web.shoppingmall.controller;

import static com.web.shoppingmall.model.service.ShoppingmallService.getService;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.web.shoppingmall.model.dto.Wishlist;
import com.web.user.model.dto.User;
/**
 * Servlet implementation class ClickWishlistServlet
 */
@WebServlet("/shoppingmall/clickHeart.do")
public class ClickWishlistServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ClickWishlistServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 찜 하트버튼 눌렀을 때 insert, delete 기능
		String heart=(String)request.getParameter("heart");
		int productKey=Integer.parseInt(request.getParameter("productKey"));
		String userId=((User)request.getSession().getAttribute("loginUser")).getUserId();
		String color=request.getParameter("color");
		String size=request.getParameter("size");
		Wishlist w=new Wishlist().builder().productKey(productKey).userId(userId).ProductColor(color).ProductSize(size).build();
		int result=0;
		if(heart.equals("redheart")) {
			//이미 찜 등록 상태에서(빨간하트상태) 버튼을 누른경우 - 찜 테이블에서 삭제해야함 
			result=getService().deleteWish(productKey, userId);
		}else {
			//찜 등록 안되어있는 상태(빈 하트버튼)에서 버튼을 누른경우 - 찜테이블에 삽입해야함
			result=getService().insertWish(w);
		}
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
