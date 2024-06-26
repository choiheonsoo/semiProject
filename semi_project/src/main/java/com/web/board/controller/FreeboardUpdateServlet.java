package com.web.board.controller;
import static com.web.board.model.service.BoardService.getService;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
/**
 * Servlet implementation class FreeboardUpdateServlet
 */
@WebServlet("/board/freeobardupdate.do")
public class FreeboardUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FreeboardUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int bullNo=Integer.parseInt(request.getParameter("id"));
		String content=request.getParameter("content");
		int result = getService().updateFreeBoard(bullNo,content);
	
		response.setContentType("aplication/json;charset=utf-8");
		PrintWriter out = response.getWriter();
	    out.print(result);
	    out.flush();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
