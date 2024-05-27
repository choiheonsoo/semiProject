package com.web.board.controller;

import static com.web.board.model.service.BoardService.getService;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

/**
 * Servlet implementation class BoardReportServlet
 */
@WebServlet("/board/boardreport.do")
public class BoardReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardReportServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String content = request.getParameter("content");
		String category = request.getParameter("category");
		int no = Integer.parseInt(request.getParameter("no"));
		String reportedId = request.getParameter("reportedId");
		int categoryNo = 0;
		switch(category) {
		case "욕설" : categoryNo = 1; break;
		case "음란물" :categoryNo = 2; break;
		case "도배" :categoryNo = 3; break;
		}
		int result = getService().insertReport(id,reportedId,content,categoryNo,no);
		
		
		 JSONObject jo = new JSONObject(); jo.put("result",result);
		 response.setContentType("application/json");
		 response.setCharacterEncoding("UTF-8");
		 response.getWriter().write(jo.toString());
		 
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
