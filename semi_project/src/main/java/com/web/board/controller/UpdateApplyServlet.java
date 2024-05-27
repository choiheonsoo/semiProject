package com.web.board.controller;

import static com.web.board.model.service.BoardService.getService;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/**
 * Servlet implementation class UpdateApplyServlet
 */
@WebServlet("/board/updateApply.do")
public class UpdateApplyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateApplyServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int totalMembers = Integer.parseInt(request.getParameter("totalMembers"));
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
		String name = request.getParameter("userId");
		
		int result = getService().updateApply(totalMembers,boardNo,name);
		if(result>0) {
			 response.setContentType("text/plain");
	         response.setCharacterEncoding("UTF-8");
	          
	         PrintWriter out = response.getWriter();
	         out.println("전송 성공");
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
