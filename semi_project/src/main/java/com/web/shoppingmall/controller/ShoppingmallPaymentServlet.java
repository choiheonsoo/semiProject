package com.web.shoppingmall.controller;

import java.io.BufferedReader;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

/**
 * Servlet implementation class ShoppingmallPaymentServlet
 */
@WebServlet("/shoppingmall/payment.do")
public class ShoppingmallPaymentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ShoppingmallPaymentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 결제정보 가져오기
		StringBuilder requestData = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            requestData.append(line);
        }

        // 읽어들인 JSON 데이터를 파싱하여 JsonObject로 변환합니다.
        JsonObject jsonObject = JsonParser.parseString(requestData.toString()).getAsJsonObject();

        // JsonObject로부터 필요한 값을 추출합니다.
        String impUid = jsonObject.get("imp_uid").getAsString();
        String merchantUid = jsonObject.get("merchant_uid").getAsString();
        System.out.println(impUid+"  /  "+merchantUid);
        // 추출한 값들을 사용하여 필요한 작업을 수행합니다.
        // 예: 결제 정보 저장, 로깅 등

        // 클라이언트에게 응답을 보냅니다.
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("Payment received successfully!");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
