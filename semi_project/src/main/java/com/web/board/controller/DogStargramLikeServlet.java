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
		//수정하면 좋을 부분 getService를 많이 호출하고있음
		//하나의 서비스를 이용하여 dao에서 처리하는게 더 효율적임. 속도가 많이 느려짐
		
		
		//jsp에서 queryString으로 받은 no와 id로 처리
		int no = Integer.parseInt(request.getParameter("no"));
		String id = request.getParameter("id");
		boolean result = getService().boardLike(no,id);
		//좋아요의 갯수를 가져옴
		int likeC = getService().boardLikeTotalCount(no);
		
		//result와 likeC를 클래스를 만들어 객체를 생성 후Gson의 라이브러리의 메소드를 이용해 java 객체를 json 형식의 문자열로 변환
		// json형식의 문자열로 받은 거를 response로 반환해줌
		String json = new Gson().toJson(new DataObject(result, likeC));
		//서버가 클라이언트에게 전송하는 데이터의 유형을 알려줌
		response.setContentType("application/json");
		//JSON의 응답 문자 인코딩을 UTF-8로 하여 다국어 문자를 제대로 처리 할 수 있음
        response.setCharacterEncoding("UTF-8");
        //HTTP 응답의 출력 스트림을 가져온 후 JSON의 문자열을 pout.print(json)으로 보내고
        PrintWriter out = response.getWriter();
        out.print(json);
        //출력 스트림에 있는 데이터가 클라이언트로 전송되기 전에 버퍼를 비움
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
