package com.web.admin.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.web.admin.service.AdminService;
import com.web.board.model.dto.Bulletin;

/**
 * Servlet implementation class ManageFreeBoardServlet
 */
@WebServlet("/admin/managefreeboard.do")
public class ManageFreeBoardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	// gson.toJson으로 2가지 정보를 보내기 위하여 innerClass 선언
	class ResponseData{
		private List<Bulletin> bulletins;
		private StringBuffer pageBar;
		
		public ResponseData(List<Bulletin>bulletins, StringBuffer pageBar) {
			 this.bulletins = bulletins;
	         this.pageBar = pageBar;
		}
		public List<Bulletin> getBulletins() {
            return bulletins;
        }

        public void setBulletins(List<Bulletin> bulletins) {
            this.bulletins = bulletins;
        }

        public StringBuffer getPageBar() {
            return pageBar;
        }

        public void setPageBar(StringBuffer pageBar) {
            this.pageBar = pageBar;
        }
	}
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManageFreeBoardServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json;charset=utf-8");
		List<Bulletin> allBulletins = AdminService.getAdminService().searchFreeBulletins();
		
		int cPage = 1;
		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
		} catch(NumberFormatException e) {}
		int numPerpage = 10;
		int pageBarSize = 5;
		int totalData = allBulletins.size();
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
			pageBar.append("<p class='page-link' data-page="+1+" data-url="+request.getRequestURI()+"><<</p>");	
			pageBar.append("</li>");
			pageBar.append("<li class='page-item'>");
			pageBar.append("<p class='page-link' data-page="+(pageNo-1)+" data-url="+request.getRequestURI()+"><</p>");	
			pageBar.append("</li>");
		}
		
		while(!(pageNo>pageEnd || pageNo>totalPage)) {
			if(cPage==pageNo) {
				pageBar.append("<li class='page-item active'>");
				pageBar.append("<p class='page-link'>"+pageNo+"</p>");
				pageBar.append("</li>");
			} else {
				pageBar.append("<li class='page-item'>");
				pageBar.append("<p class='page-link' data-page="+pageNo+" data-url="+request.getRequestURI()+">"+pageNo+"</p>");
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
			pageBar.append("<p class='page-link' data-page="+pageNo+" data-url="+request.getRequestURI()+">></p>");
			pageBar.append("</li>");
			pageBar.append("<li class='page-item'>");
			pageBar.append("<p class='page-link' data-page="+totalPage+" data-url="+request.getRequestURI()+">>></p>");
			pageBar.append("</li>");
		} 
		pageBar.append("</ul>");
		List<Bulletin> bulletins = AdminService.getAdminService().searchFreeBulletins(cPage, numPerpage);
		
		ResponseData data = new ResponseData(bulletins, pageBar);
		
		Gson gson=new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		gson.toJson(data, response.getWriter());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
