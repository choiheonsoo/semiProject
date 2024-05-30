package com.web.shoppingmall.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.web.shoppingmall.model.dto.Color;
import com.web.shoppingmall.model.dto.Product;
import com.web.shoppingmall.model.dto.ProductOption;
import com.web.shoppingmall.model.dto.ProductSize;

/**
 * Servlet implementation class PurchaseServlet
 */
@WebServlet("/shoppingmall/shoppingmallpay.do")
public class PurchaseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PurchaseServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 구매 페이지로 이동
		request.setCharacterEncoding("utf-8");
		List<Product> products=new ArrayList<Product>();
		List<Integer> quantitys=new ArrayList<Integer>();
		for(int i=0;;i++) {
			String productName = request.getParameter("products[" + i + "].productName");
			if (productName == null) {
		        break;
			}
			int productKey=Integer.parseInt(request.getParameter("products["+i+"].productKey"));
		    String color = request.getParameter("products[" + i + "].color");
		    String size = request.getParameter("products[" + i + "].size");
		    int quantity = Integer.parseInt(request.getParameter("products[" + i + "].quantity"));
		    int discount = Integer.parseInt(request.getParameter("products[" + i + "].discount"));
		    int price = Integer.parseInt(request.getParameter("products[" + i + "].price"));
		    if(quantity!=0) {
			    Product p=new Product().builder().productKey(productKey).productName(productName).rateDiscount(discount).price(price).build();
			    ProductOption po=new ProductOption().builder().color(new Color().builder().color(color).build())
			    		.productSize(new ProductSize().builder().pSize(size).build()).build();
			    List<ProductOption> pos=new ArrayList<>();
			    pos.add(po);
			    p.setProductOption(pos);
			    products.add(p);
			    quantitys.add(quantity);
		    }
		}
		
        // 객체 배열을 request 객체에 속성으로 추가
        request.setAttribute("products", products);
		request.setAttribute("quantitys", quantitys);
		request.getRequestDispatcher("/WEB-INF/views/shoppingmall/paymentpage.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
