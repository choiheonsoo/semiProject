package com.web.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.web.dog.model.dto.Dog;
import com.web.dog.service.DogService;
import com.web.mypage.service.MypageService;
import com.web.user.model.dto.User;
import com.web.user.model.service.UserService;

/**
 * Servlet implementation class SearchMemberServlet
 */
@WebServlet("/admin/searchmember.do")
public class SearchMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchMemberServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User admin = (User)session.getAttribute("loginUser");
		if(admin==null || !admin.getUserId().equals("admin")) {
			String msg = "잘못된 접근입니다.";
			String loc = "/";
			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
		} else {
			List<User> totalMember = UserService.getUserService().searchAllUser();
			List<Dog> searchDogs = DogService.getDogService().serachAllDog();
			int cPage = 1;
			try {
				cPage = Integer.parseInt(request.getParameter("cPage"));
			} catch(NumberFormatException e) {}
			int numPerpage = 10;
			int pageBarSize = 5;
			int totalData = totalMember.size();
			int pageNo = ((cPage-1)/pageBarSize)*pageBarSize+1;
			int pageEnd = pageNo+pageBarSize-1;
			int totalPage = (int)Math.ceil((double)totalData/numPerpage);
			StringBuffer pageBar = new StringBuffer();
			
			pageBar.append("<ul class='pagination justify-content-center'>");
			if(pageNo==1) {
				pageBar.append("<li class='page-item'>");
				pageBar.append("<p class='page-link'><<</p>");	 
				pageBar.append("</li>");
				pageBar.append("<li class='page-item'>");
				pageBar.append("<p class='page-link'><</p>");	 
				pageBar.append("</li>");
			} else {
				pageBar.append("<li class='page-item'>");
				pageBar.append("<p class='page-link' data-page="+1+"><<</p>");	
				pageBar.append("</li>");
				pageBar.append("<li class='page-item'>");
				pageBar.append("<p class='page-link' data-page="+(pageNo-1)+"><</p>");	
				pageBar.append("</li>");
			}
			
			while(!(pageNo>pageEnd || pageNo>totalPage)) {
				if(cPage==pageNo) {
					pageBar.append("<li class='page-item active'>");
					pageBar.append("<p class='page-link'>"+pageNo+"</p>");
					pageBar.append("</li>");
				} else {
					pageBar.append("<li class='page-item'>");
					pageBar.append("<p class='page-link' data-page="+pageNo+">"+pageNo+"</p>");
					pageBar.append("</li>");
				}
				pageNo++;
			}
			
			if(pageNo>totalPage) {
				pageBar.append("<li class='page-item'>");
				pageBar.append("<p class='page-link'>></p>");
				pageBar.append("</li>");
				pageBar.append("<li class='page-item'>");
				pageBar.append("<p class='page-link'>>></p>");
				pageBar.append("</li>");
			} else {
				pageBar.append("<li class='page-item'>");
				pageBar.append("<p class='page-link' data-page="+pageNo+">></p>");
				pageBar.append("</li>");
				pageBar.append("<li class='page-item'>");
				pageBar.append("<p class='page-link' data-page="+totalPage+">>></p>");
				pageBar.append("</li>");
			} 
			pageBar.append("</ul>");
			List<User> searchmember = UserService.getUserService().searchAllUser(cPage, numPerpage);
			request.setAttribute("pageBar", pageBar);
			request.setAttribute("users", searchmember);
			request.setAttribute("dogs", searchDogs);
			request.getRequestDispatcher("/WEB-INF/views/admin/allmember.jsp").forward(request, response);
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
