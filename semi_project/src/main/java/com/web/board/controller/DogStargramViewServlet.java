package com.web.board.controller;

import static com.web.board.model.service.BoardService.getService;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.web.board.model.dto.Bulletin;
import com.web.board.model.dto.BulletinImg;
import com.web.board.model.dto.BulletinLike;
import com.web.dog.model.dto.Dog;
/**
 * Servlet implementation class DogStargramViewServlet
 */
@WebServlet("/board/dogstargramview.do")
public class DogStargramViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DogStargramViewServlet() {
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
		Bulletin b = getService().selectBoardNo(no, readResult);
		List<BulletinLike> like = getService().selectBoardLike();
		List<BulletinImg> boardImg = getService().selectBoardImg();
		List<Dog> dog = getService().getDog();
		Gson gson = new Gson();
		JsonObject jsonResponse = new JsonObject();
		jsonResponse.add("b", gson.toJsonTree(b));
		jsonResponse.add("like", gson.toJsonTree(like));
		jsonResponse.add("boardImg", gson.toJsonTree(boardImg));
		jsonResponse.add("dog", gson.toJsonTree(dog));
		response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse.toString());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
