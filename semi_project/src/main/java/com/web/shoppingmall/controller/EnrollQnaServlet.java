package com.web.shoppingmall.controller;

import static com.web.shoppingmall.model.service.ShoppingmallService.getService;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.web.shoppingmall.model.dto.Qna;
/**
 * Servlet implementation class EnrollQnaServlet
 */
@WebServlet("/shoppingmall/enrollqna.do")
public class EnrollQnaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EnrollQnaServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Q&A 문의글 등록 기능
		int productKey=Integer.parseInt(request.getParameter("productKey"));
		String userId=request.getParameter("userId");
		String content=request.getParameter("content");
		
		Qna q=new Qna().builder().productKey(productKey).qnaContent(content).userId(userId).build();
		
		int result=getService().insertQna(q);
		
		Gson gson=new GsonBuilder()
                .setDateFormat("yyyy-MM-dd")
                .create();
		gson.toJson(result,response.getWriter());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
