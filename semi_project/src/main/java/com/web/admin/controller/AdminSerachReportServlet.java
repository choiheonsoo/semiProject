package com.web.admin.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import static com.web.admin.service.AdminService.getAdminService;
import com.web.board.model.dto.Report;

/**
 * Servlet implementation class AdminSerachReportServlet
 */
@WebServlet("/admin/searchreport.do")
public class AdminSerachReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminSerachReportServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Report> reports = getAdminService().serachReport();
		int cPage = 1;
		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
		} catch(NumberFormatException e) {}
		int numPerpage = 10;
		int pageBarSize = 5;
		int totalData = reports.size();
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
		List<Report> pageReports = getAdminService().serachReport(cPage, numPerpage);
		request.setAttribute("reports", pageReports);
		request.setAttribute("pageBar", pageBar);
		request.getRequestDispatcher("/WEB-INF/views/admin/reports.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
