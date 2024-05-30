package com.web.shoppingmall.controller;

import static com.web.shoppingmall.model.service.ShoppingmallService.getService;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.web.shoppingmall.model.dto.Review;
/**
 * Servlet implementation class EnrollReviewServlet
 */
@WebServlet("/shoppingmall/enrollreview.do")
public class EnrollReviewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EnrollReviewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 리뷰 등록 하기
		String path=getServletContext().getRealPath("/upload/shoppingmall/review");
		int maxSize=1024*1024*10;
		String encode="UTF-8";
		File f=new File(path);
		if(!f.exists()) {
			f.mkdirs();
		}
		
		MultipartRequest mr=new MultipartRequest(request, path, maxSize, encode, new DefaultFileRenamePolicy());
		
		String userId=mr.getParameter("userId");
		int productKey=Integer.parseInt(mr.getParameter("productKey"));
		String content=mr.getParameter("content");
		int rating=Integer.parseInt(mr.getParameter("rating"));
		
		Enumeration<String> names=mr.getFileNames();
		List<String> fileNames=new ArrayList<>();
		while(names.hasMoreElements()) {
			fileNames.add(mr.getFilesystemName(names.nextElement()));
		}
		
		Review r=new Review().builder().reviewContent(content).rating(rating).userId(userId).productKey(productKey).build();
		int result=getService().insertReview(r, fileNames);
		
		new Gson().toJson(Map.of("result",true),response.getWriter());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
