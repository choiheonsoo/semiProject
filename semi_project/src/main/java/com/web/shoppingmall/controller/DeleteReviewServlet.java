package com.web.shoppingmall.controller;

import static com.web.shoppingmall.model.service.ShoppingmallService.getService;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonParser;
/**
 * Servlet implementation class DeleteReviewServlet
 */
@WebServlet("/shoppingmall/deletereview.do")
public class DeleteReviewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteReviewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 리뷰 삭제 기능
		 // JSON 문자열을 읽기 위한 BufferedReader 생성
        BufferedReader reader = request.getReader();
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }
        reader.close();

        // 받은 JSON 데이터 출력
        String jsonData = sb.toString();
        System.out.println("Received JSON data: " + jsonData);

        // JSON 데이터 파싱
        Gson gson = new Gson();
        JsonArray jsonArray = JsonParser.parseString(jsonData).getAsJsonArray();

        // 리뷰 키 
        int reviewKey = jsonArray.get(0).getAsInt();
        System.out.println("Review key: " + reviewKey);

        // 이미지 이름들
        List<String> imgNames = new ArrayList<>();
        for (int i = 1; i < jsonArray.size(); i++) {
            imgNames.add(jsonArray.get(i).getAsString());
        }
        
        
		int result=getService().deleteReview(reviewKey);
		String path=getServletContext().getRealPath("/upload/shoppingmall/review/");
		if(result>0) {
			 // 이미지 삭제
	        for (String imgName : imgNames) {
	            File file = new File(path + imgName);
	            if (file.exists()) {
	                if (file.delete()) {
	                    System.out.println("Deleted image: " + imgName);
	                } else {
	                    System.out.println("Failed to delete image: " + imgName);
	                }
	            } else {
	                System.out.println("Image not found: " + imgName);
	            }
	        }
	        
		}else {
			System.out.println("리뷰 삭제 실패");
		}
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		gson.toJson(result, response.getWriter());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
