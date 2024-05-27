package com.web.shoppingmall.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

/**
 * Servlet implementation class ShoppingmallPaymentServlet
 */
@WebServlet("/shoppingmall/payment.do")
public class ShoppingmallPaymentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String IMP_KEY = "6053655050658122";
    private static final String IMP_SECRET = "85oIphf2bNhAxLG3yEjEjc6PRk3hK9yUk4bnvOurRL8ZgxFDjBaXmDFUJmx3FNNZp4Ynvv30zYnfEdTa";
    
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
		StringBuilder sb = new StringBuilder();
        try (BufferedReader reader = request.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        }

        // JSON 문자열을 파싱하여 JSONObject 생성
        JSONParser parser = new JSONParser();
        JSONObject jsonObject;
        try {
            jsonObject = (JSONObject) parser.parse(sb.toString());
        } catch (ParseException e) {
            e.printStackTrace();
            return;
        }
        // JsonObject로부터 필요한 값을 추출합니다.
        String impUid = (String)jsonObject.get("imp_uid");
        String merchantUid = (String)jsonObject.get("merchant_uid");
        String pg_provider = (String)jsonObject.get("pg_provider");
        String buyer_addr = (String)jsonObject.get("buyer_addr");
        System.out.println(impUid+"  /  "+merchantUid+"   /   "+pg_provider+"  /  "+buyer_addr);
        // 추출한 값들을 사용하여 필요한 작업을 수행합니다.
        // 포트원 토큰 발급
//        String token = getPortOneToken();
//        if (token == null) {
//            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
//            response.getWriter().write("{\"success\": false, \"message\": \"토큰 발급 실패\"}");
//            return;
//        }
//        boolean isValid = validatePayment(impUid, token);
//        JSONObject result = new JSONObject();
//        result.put("success", isValid);

        // 클라이언트에게 응답을 보냅니다.
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("success");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
//	private String getPortOneToken() throws IOException {
//	    // IMP_KEY와 IMP_SECRET은 포트원에서 발급받은 API 키로 채워넣어야 합니다.
//
//	    URL url = new URL("https://api.iamport.kr/users/getToken");
//	    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
//	    conn.setRequestMethod("POST");
//	    conn.setRequestProperty("Content-Type", "application/json;charset=utf-8");
//	    conn.setDoOutput(true);
//
//	    JSONObject json = new JSONObject();
//	    json.put("imp_key", IMP_KEY);
//	    json.put("imp_secret", IMP_SECRET);
//
//	    try (OutputStream os = conn.getOutputStream()) {
//	        byte[] input = json.toString().getBytes("utf-8");
//	        os.write(input, 0, input.length);
//	    }
//
//	    try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"))) {
//	        StringBuilder response = new StringBuilder();
//	        String responseLine;
//	        while ((responseLine = br.readLine()) != null) {
//	            response.append(responseLine.trim());
//	        }
//
//	        JSONObject responseJson = new JSONObject(response.toString());
//	        long code = (long) responseJson.get("code");
//	        if (code == 0) {
//	            JSONObject responseObject = (JSONObject) responseJson.get("response");
//	            return (String) responseObject.get("access_token");
//	        } else {
//	            return null;
//	        }
//	    }
//	}
//
//	private boolean validatePayment(String impUid, String token) throws IOException {
//	    URL url = new URL("https://api.iamport.kr/payments/" + impUid);
//	    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
//	    conn.setRequestMethod("GET");
//	    conn.setRequestProperty("Authorization", token);
//
//	    try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"))) {
//	        StringBuilder response = new StringBuilder();
//	        String responseLine;
//	        while ((responseLine = br.readLine()) != null) {
//	            response.append(responseLine.trim());
//	        }
//
//	        JSONObject responseJson = new JSONObject(response.toString());
//	        long code = (long) responseJson.get("code");
//	        if (code == 0) {
//	            return true;
//	        } else {
//	            return false;
//	        }
//	    }
//	}
}
