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
public class ShoppingmallProductOptionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ShoppingmallProductOptionServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 상품 상세 페이지에서 필요한 상품의 사이즈,색상,재고를 담은 ProductOption 객체를 반환하는 기능
		// ajax 사용
		int productKey=Integer.parseInt(request.getParameter("productKey"));
		String size=request.getParameter("size");
		String color=request.getParameter("color");
		
		response.setContentType("application/json; charset=UTF-8");
		Gson gson=new Gson();
		//이게 맞나...
		if(color==null&&size==null) {
			//사이즈와 색상 옵션이 없는 상품
			ProductOption productOption=getService().selectProductOptionByKey(productKey);
			System.out.println(productOption);
			gson.toJson(productOption, response.getWriter());
		}else if(color!=null&&size==null) {
			//색상 옵션만 있는 상품
			ProductOption productOption=getService().selectProductOptionByColor(productKey,color);			
			gson.toJson(productOption, response.getWriter());
		}else {
			//사이즈, 색상 옵션 전부 있는 상품 또는 사이즈만 있는 상품
			List<ProductOption> productOption=getService().selectProductOptionBySize(productKey,size);			
			gson.toJson(productOption, response.getWriter());
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
