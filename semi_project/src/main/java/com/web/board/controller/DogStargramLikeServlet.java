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
 * Servlet implementation class DogStargramViewServlet
 */
@WebServlet("/board/boardlike.do")
public class DogStargramLikeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DogStargramLikeServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int no = Integer.parseInt(request.getParameter("no"));
		String id = request.getParameter("id");
		boolean result = getService().boardLike(no,id);
		int likeC = getService().boardLikeTotalCount(no);
		String json = new Gson().toJson(new DataObject(result, likeC));
		response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
	}
	class DataObject {
	       boolean boolValue;
	       int intValue;
	       public DataObject(boolean boolValue, int intValue) {
	           this.boolValue = boolValue;
	           this.intValue = intValue;
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
