package com.web.shoppingmall.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.google.gson.Gson;
import com.web.shoppingmall.model.dto.Orders;
import static com.web.shoppingmall.model.service.ShoppingmallService.getService;
/**
 * Servlet implementation class InsertOrderServlet
 */
@WebServlet("/shoppingmall/insertorder.do")
public class InsertOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertOrderServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 주문 정보 db에 insert
		String jsonString;
	       try (BufferedReader reader = request.getReader()) {
	           jsonString = reader.lines().collect(Collectors.joining());
	       }

	    // Gson을 사용하여 JSON 문자열을 Java 객체로 변환
        Gson gson = new Gson();
        Orders orders = gson.fromJson(jsonString, Orders.class);
        
        int result=getService().insertOrders(orders);
        JSONObject json = new JSONObject();
        
        if(result>0) {
        	// insert 성공
            json.put("success", "true");
        }else {
        	// insert 실패
        	json.put("success","false");
        }
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json.toJSONString());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
