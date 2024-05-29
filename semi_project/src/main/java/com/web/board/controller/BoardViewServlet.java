package com.web.board.controller;

import static com.web.board.model.service.BoardService.getService;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.web.board.model.dto.Bulletin;
import com.web.dog.model.dto.Dog;
/**
 * Servlet implementation class FreeBoardViewServlet
 */
@WebServlet("/board/boardview.do")
public class BoardViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardViewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int no = Integer.parseInt(request.getParameter("no"));
		
		
		//request에 담긴 쿠키를 모두 가져옴
		Cookie[] cookies = request.getCookies();
		//readBoard와 readResult를 초기화
		String readBoard= "";
		boolean readResult=false;
		//만약 쿠키가 존재한다면
		if(cookies!=null) {
			//쿠키는 여러 값이 있을 수 있기 때문에 반복문
			for(Cookie c : cookies) {
				//만약 쿠키의 키에 readBoard가 있는 경우 <-- 이미 조회한 게시글이 있는거임
				if(c.getName().equals("readBoard")) {
					//키값인 readBoard의 value를 가져옴 / 만약 여러 게시글을 읽었다면 |게시글번호1||게시글번호2| 이렇게 저장되어있음.
					readBoard=c.getValue();
					//만약 || 을 기준으로 |안에있는 게시글 번호가 jsp에서 받아온 게시글 번호를 포함하는지 확인
					if(readBoard.contains("|"+no+"|")) {
						//포함한다면 readResult를 true로 변경
						readResult=true;
					}
				}
			}
		}
		//만약 포함을 안한다면
		if(!readResult) {
			//쿠키를 readBoard의 키 값으로 readBoard에 ||로 묶은 게시글 번호를 담아줌.
			Cookie c=new Cookie("readBoard",readBoard+"|"+no+"|");
			//쿠키 저장 기간은 1일
			c.setMaxAge(60*60*24);
			//응답 객체에 저장
			response.addCookie(c);
		}
		//join문을 쓰지않고 게시글과 유저의 강아지를 모두 가져옴
		Bulletin bulletin = getService().selectBoardNo(no,readResult);
		List<Dog> dogs = getService().getDog();
		request.setAttribute("dogs", dogs);
		request.setAttribute("bulletin", bulletin);
		if(bulletin != null) {
			request.getRequestDispatcher("/WEB-INF/views/board/freeboardView.jsp").forward(request, response);
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
