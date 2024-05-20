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
@WebServlet("/board/freeboardview.do")
public class FreeBoardViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FreeBoardViewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int no = Integer.parseInt(request.getParameter("no"));
		
		Cookie[] cookies = request.getCookies();
		
		String readBoard= "";
		boolean readResult=false;
		if(cookies!=null) {
			for(Cookie c : cookies) {
				if(c.getName().equals("readBoard")) {
					readBoard=c.getValue();
					if(readBoard.contains("|"+no+"|")) {
						readResult=true;
					}
				}
			}
		}
		if(!readResult) {
			Cookie c=new Cookie("readBoard",readBoard+"|"+no+"|");
			c.setMaxAge(60*60*24);
			response.addCookie(c);
		}
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
