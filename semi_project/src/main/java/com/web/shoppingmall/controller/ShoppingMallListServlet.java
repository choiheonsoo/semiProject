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
		
		String sort="";
		String s=request.getParameter("sort")==null?"1":request.getParameter("sort");
		switch(s) { //1.최신순  2.리뷰순  3.높은가격  4.낮은가격
			case "1":sort="REGISTRATION_DATE DESC"; break;
			case "2":sort="R_COUNT DESC"; break;
			case "3":sort="PRICE*(100-RATE_DISCOUNT)/100 DESC"; break;
			case "4":sort="PRICE*(100-RATE_DISCOUNT)/100 ASC"; break;
		}
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
		
		String pageBar="<div id='pagebar'>";
		if(pageNo==1) {
			pageBar+="<p class='page1'><<</p>";
			pageBar+="<p class='page1'><</p>";
		}else {
			pageBar+="<a class='page1' href='"+request.getRequestURI()+"?cPage=1&sort='"+s+"><<</a>";
			pageBar+="<a class='page1' href='"+request.getRequestURI()+"?cPage="+(pageNo-1)+"&sort="+s+"'><</a>";
		}
		while(!(pageNo>pageEnd||pageNo>totalPage)) {
			if(pageNo==cPage) {
				pageBar+="<p class='page2'>"+pageNo+"</p>";
			}else {
				pageBar+="<a class='page2' href='"+request.getRequestURI()+"?cPage="+pageNo+"&sort="+s+"'>"+pageNo+"</a>";
			}
			pageNo++;
		}
		if(pageNo>totalPage) {
			pageBar+="<p class='page1'>></p>";
//			pageBar+="<p class='page1'>>></p>";
			pageBar+="<a class='page1' href='"+request.getRequestURI()+"?cPage="+(totalPage)+"&sort="+s+"'>>></a>";
		}else {
			pageBar+="<a class='page1' href='"+request.getRequestURI()+"?cPage="+(pageNo)+"&sort="+s+"'>></a>";
			pageBar+="<a class='page1' href='"+request.getRequestURI()+"?cPage="+(totalPage)+"&sort="+s+"'>>></a>";
		}
		pageBar+="</div>";
		
		List<Product> products=getService().selectProduct(category,cPage,numPerpage,sort);
		request.setAttribute("products", products);
		request.setAttribute("pagebar", pageBar);
		request.setAttribute("category", category);
		request.setAttribute("sort", Integer.parseInt(s));
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
