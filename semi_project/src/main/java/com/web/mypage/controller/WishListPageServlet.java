package com.web.mypage.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.web.mypage.model.dto.WishList;
import com.web.mypage.service.MypageService;
import com.web.user.model.dto.User;

/**
 * Servlet implementation class WishListServlet
 */
@WebServlet("/user/wishlist.do")
public class WishListPageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public WishListPageServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User loginUser = (User)session.getAttribute("loginUser");
		
		int cPage = 1;
		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
		} catch(NumberFormatException e) {}
		int numPerpage = 5;
		int pageBarSize = 5;
		int totalData = MypageService.getService().getTotalWishList(loginUser.getUserId());
		int pageNo = ((cPage-1)/pageBarSize)*pageBarSize+1;
		int pageEnd = pageNo+pageBarSize-1;
		int totalPage = (int)Math.ceil((double)totalData/numPerpage);
		StringBuffer pageBar = new StringBuffer();
		
		pageBar.append("<ul class='pagination justify-content-center'>");
		if(pageNo==1) {
			pageBar.append("<li class='page-item' disabled>");
			pageBar.append("<a class='page-link' disabled><<</a>");	 
			pageBar.append("</li>");
			pageBar.append("<li class='page-item' disabled>");
			pageBar.append("<a class='page-link' disabled><</a>");	 
			pageBar.append("</li>");
		} else {
			pageBar.append("<li class='page-item'>");
			pageBar.append("<a class='page-link' href='"+request.getRequestURI()+"?cPage="+1+"'><<</a>");	
			pageBar.append("</li>");
			pageBar.append("<li class='page-item'>");
			pageBar.append("<a class='page-link' href='"+request.getRequestURI()+"?cPage="+(pageNo-1)+"'><</a>");	
			pageBar.append("</li>");
		}
		
		while(!(pageNo>pageEnd || pageNo>totalPage)) {
			if(cPage==pageNo) {
				pageBar.append("<li class='page-item active'>");
				pageBar.append("<a class='page-link' href='#'>"+pageNo+"</a>");
				pageBar.append("</li>");
			} else {
				pageBar.append("<li class='page-item'>");
				pageBar.append("<a class='page-link' href='"+request.getRequestURI()+"?cPage="+pageNo+"'>"+pageNo+"</a>");
				pageBar.append("</li>");
			}
			pageNo++;
		}
		
		if(pageNo>totalPage) {
			pageBar.append("<li class='page-item' disabled>");
			pageBar.append("<a class='page-link' >></a>");
			pageBar.append("</li>");
			pageBar.append("<li class='page-item' disabled>");
			pageBar.append("<a class='page-link'>>></a>");
			pageBar.append("</li>");
		} else {
			pageBar.append("<li class='page-item'>");
			pageBar.append("<a class='page-link' href='"+request.getRequestURI()+"?cPage="+pageNo+"'>></a>");
			pageBar.append("</li>");
			pageBar.append("<li class='page-item'>");
			pageBar.append("<a class='page-link' href='"+request.getRequestURI()+"?cPage="+totalPage+"'>>></a>");
			pageBar.append("</li>");
		} 
		pageBar.append("</ul>");
		List<WishList> list = MypageService.getService().getWishListByUserId(loginUser.getUserId(), cPage, numPerpage);
		request.setAttribute("pageBar", pageBar);
		request.setAttribute("wishlist", list);
		request.getRequestDispatcher("/WEB-INF/views/mypage/wishlist.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
