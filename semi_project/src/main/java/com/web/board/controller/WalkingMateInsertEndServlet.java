package com.web.board.controller;

import static com.web.board.model.service.BoardService.getService;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.web.board.model.dto.WalkingMate;

/**
 * Servlet implementation class WalkingMateInsertEndServlet
 */
@WebServlet("/board/insertwalkingmateend.do")
public class WalkingMateInsertEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public WalkingMateInsertEndServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String title= request.getParameter("title");
		String content = request.getParameter("content");
		String place = request.getParameter("place");
		String placeTime = request.getParameter("placeTime");
		int mateC = Integer.parseInt(request.getParameter("mateC"));
		double latitude = Double.parseDouble(request.getParameter("latitude"));
		double longitude = Double.parseDouble(request.getParameter("longitude"));
		LocalDateTime localDateTime = LocalDateTime.parse(placeTime, DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm"));
		Timestamp placeTimeStr = Timestamp.valueOf(localDateTime);

		WalkingMate wm = WalkingMate.builder()
									.userId(id)
									.title(title)
									.content(content)
									.place(place)
									.placeTime(placeTimeStr)
									.recruitmentNumber(mateC)
									.latitue(latitude)
									.logitude(longitude)
									.build();
		int result = getService().insertWalkingMate(wm);
		
		String msg,loc;
		msg=result>0?"산책메이트 등록 성공" : "산책메이트 등록 실패";
		loc="/board/walkingmate.do";
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
