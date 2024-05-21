package com.web.board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.web.board.model.dto.BulletinComment;
import static com.web.board.model.service.BoardService.getService;
/**
 * Servlet implementation class FreeBoardCommentInsertServlet
 */
@WebServlet("/board/insertboardcomment.do")
public class FreeBoardCommentInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FreeBoardCommentInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("user_id");
		int level = Integer.parseInt(request.getParameter("comment_level"));
		int bullNo = Integer.parseInt(request.getParameter("bull_no"));
		String subCommentStr = request.getParameter("sub_comment");
		System.out.println(subCommentStr);
		int subComment = subCommentStr.equals("0")?0:Integer.parseInt(subCommentStr);
		String content = request.getParameter("content");
		
		BulletinComment bc = BulletinComment.builder()
											.bullNo(bullNo)
											.userId(id)
											.content(content)
											.commentLevel(level)
											.delC('n')
											.subComment(subComment)
											.build();
		int result = getService().insertBoardComment(bc);
		String msg = result>0?"댓글 등록 성공" : "댓글 등록 실패";
		String loc = "/board/boardview.do?no="+bullNo;
		request.setAttribute("msg",msg);
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
