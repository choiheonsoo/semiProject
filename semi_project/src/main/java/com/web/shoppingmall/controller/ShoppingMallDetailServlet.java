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
import com.web.user.model.dto.User;
/**
 * Servlet implementation class ShoppingMallDetailServlet
 * 쇼핑몰 상품 상세페이지 이동 서블릿
 */
@WebServlet("/shoppingmall/shoppingmalldetail.do")
public class ShoppingMallDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ShoppingMallDetailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 클릭한 상품 상세 페이지로 이동
		int productKey=Integer.parseInt(request.getParameter("productKey"));
		String r=request.getParameter("r");
		
		Product p=getService().selectProductByKey(productKey); //상품관련 정보를 담은 상품객체
		List<User> u=getService().selectReviewByProductKey(productKey); //리뷰정보를 담은 회원객체리스트
		int cPage=1;
		int numPerpage=3;
		int pageBarSize=5;
		int totalData=p.getTotalReviewCount();
		int totalPage=(int)Math.ceil((double)totalData/numPerpage);
		int pageNo=((cPage-1)/pageBarSize)*pageBarSize+1;
		int pageEnd=pageNo+pageBarSize-1;
		
		String pageBar="<div id='pagebar'>";
		pageBar+="<button class=''><<</button>";
		pageBar+="<button class=''><</button>";
		while(!(pageNo>pageEnd||pageNo>totalPage)) {
			if(pageNo==cPage) {
				pageBar+="<button class=''>"+pageNo+"</button>";
			}else {
				pageBar+="<button class=''>"+pageNo+"</button>";
			}
			pageNo++;
		}
		pageBar+="<button class=''>></button>";
		pageBar+="<button class=''>>></button>";
		pageBar+="</div>";
		
		request.setAttribute("pageBar", pageBar);
		request.setAttribute("product", p);
		request.setAttribute("user", u);
		request.getRequestDispatcher("/WEB-INF/views/shoppingmall/shoppingmalldetail.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
