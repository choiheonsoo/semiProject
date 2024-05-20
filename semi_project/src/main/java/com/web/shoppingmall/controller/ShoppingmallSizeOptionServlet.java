package com.web.shoppingmall.controller;

import static com.web.shoppingmall.model.service.ShoppingmallService.getService;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.web.shoppingmall.model.dto.ProductOption;
/**
 * Servlet implementation class ShoppingmallSizeOptionServlet
 * 
 */
@WebServlet("/shoppingmall/productoption.do")
public class ShoppingmallSizeOptionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ShoppingmallSizeOptionServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 상품 상세 페이지에서 사이즈 옵션에 해당하는 색상 옵션을 받아서 넘겨주는 기능
		int productKey=Integer.parseInt(request.getParameter("productKey"));
		String size=request.getParameter("size");
		
		List<ProductOption> productOption=getService().selectColorBySize(productKey,size);
		response.setContentType("application/json; charset=UTF-8");
		Gson gson=new Gson();
		gson.toJson(productOption, response.getWriter());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
