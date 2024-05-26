package com.web.board.controller;

import static com.web.board.model.service.BoardService.getService;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.web.board.model.dto.Bulletin;
import com.web.board.model.dto.BulletinComment;
import com.web.board.model.dto.BulletinImg;
import com.web.board.model.dto.BulletinLike;
import com.web.dog.model.dto.Dog;

/**
 * Servlet implementation class DogStargramSerlvet
 */
@WebServlet("/board/dogstargram.do")
public class DogStargramServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DogStargramServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String type = request.getParameter("type") == null ? "title" : request.getParameter("type");
		String keyword = request.getParameter("keyword") == null ? "" : request.getParameter("keyword");
		System.out.println(type+keyword);
		int cPage=1;
		try {
			cPage=Integer.parseInt(request.getParameter("cPage"));
		}catch(NumberFormatException e) {
		}
		int numPerpage=8;
		List<Bulletin> bulletins = getService().selectBoardAll(cPage,numPerpage,type,keyword,4);
		
		int totalData = getService().selectBoardCount(4);
		int totalPage = (int)Math.ceil((double)totalData/numPerpage);
		int pageBarSize = 5;
		int pageNo=((cPage-1)/pageBarSize)*pageBarSize+1;
		int pageEnd=pageNo+pageBarSize-1;
		
		String pageBar="<div id='freeboardFooter2'>";
		if(pageNo==1) {
			pageBar+="<p class='page1'><<</p>";
			pageBar+="<p class='page1'><</p>";
		}else {
			pageBar+="<a class='page1' href='"+request.getRequestURI()+"?cPage=1'><<</a>";
			pageBar+="<a class='page1' href='"+request.getRequestURI()+"?cPage="+(pageNo-1)+"'><</a>";
		}
		while(!(pageNo>pageEnd||pageNo>totalPage)) {
			if(pageNo==cPage) {
				pageBar+="<p class='page2'>"+pageNo+"</p>";
			}else {
				pageBar+="<a class='page2' href='"+request.getRequestURI()+"?cPage="+pageNo+"'>"+pageNo+"</a>";
			}
			pageNo++;
		}
		if(pageNo>totalPage) {
			pageBar+="<p class='page1'>></p>";
			pageBar+="<p class='page1'>>></p>";
		}else {
			pageBar+="<a class='page1' href='"+request.getRequestURI()+"?cPage="+(pageNo)+"'>></a>";
			pageBar+="<a class='page1' href='"+request.getRequestURI()+"?cPage="+(totalPage)+"'>>></a>";
		}
		pageBar+="</div>";
		List<Dog> dogs = getService().getDog();
		List<BulletinImg> bi = getService().selectBoardImg();
		List<BulletinLike> bk = getService().selectBoardLike();
		List<BulletinComment> bc = getService().selectBoardComment();
		request.setAttribute("bc", bc);
		request.setAttribute("bk", bk);
		request.setAttribute("dogs", dogs);
		request.setAttribute("pageBar", pageBar);
		request.setAttribute("bulletins",bulletins);
		request.setAttribute("imgs", bi);
		request.getRequestDispatcher("/WEB-INF/views/board/dogstargram.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
