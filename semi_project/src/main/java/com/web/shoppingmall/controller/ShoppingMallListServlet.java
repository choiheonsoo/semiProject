package com.web.shoppingmall.controller;

import static com.web.shoppingmall.model.service.ShoppingmallService.getService;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.web.shoppingmall.model.dto.Product;
/**
 * Servlet implementation class ShoppingMallMainServlet
 * 쇼핑몰 메인페이지로 페이지 이동시키는 기능 - 작성자 : GJH
 */
@WebServlet("/shoppingmall/shoppingmalllist.do")
public class ShoppingMallListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ShoppingMallListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//쇼핑몰 상품리스트페이지로 페이지 이동시키는 기능
		
		String sort=request.getParameter("sort");
		int category=1;
		try {
			category=Integer.parseInt(request.getParameter("category"));
		}catch(NumberFormatException e) {
			category=1;
		}
		
		int cPage=1;
		try {
			cPage=Integer.parseInt(request.getParameter("cPage"));
		}catch(NumberFormatException e) {
			cPage=1;
		}
		int pageBarSize=5;
		int numPerpage=12;
		int totalData=getService().allProductCount(category);
		int totalPage=(int)Math.ceil((double)totalData/numPerpage);
		int pageNo=((cPage-1)/pageBarSize)*pageBarSize+1;
		int pageEnd=pageNo+pageBarSize-1;
		StringBuffer sb=new StringBuffer();
		
		if(pageNo==1) {
			sb.append("<p><<</p>");
			sb.append("");
		}
		
		List<Product> products=getService().selectProduct(category,cPage,numPerpage,sort);
		request.setAttribute("products", products);
		request.setAttribute("pagebar", sb);
		request.getRequestDispatcher("/WEB-INF/views/shoppingmall/shoppingmalllist.jsp")
		.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
