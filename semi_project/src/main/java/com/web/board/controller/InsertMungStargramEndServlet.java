package com.web.board.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.web.board.model.dto.Bulletin;
import com.web.board.model.dto.BulletinImg;
import static com.web.board.model.service.BoardService.getService;
/**
 * Servlet implementation class InsertMungStargramEndServlet
 */
@WebServlet("/board/insertmungstargramend.do")
public class InsertMungStargramEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertMungStargramEndServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String path = getServletContext().getRealPath("/upload/board");
		File dir = new File(path); // 파일 생성
		if (!dir.exists()) dir.mkdirs(); // 만약 파일이 없다면 상위 폴더까지 생성
		int maxSize = 1024 * 1024 * 10; // 10MB
		String encode = "UTF-8";
		DefaultFileRenamePolicy dfrp = new DefaultFileRenamePolicy(); // 파일 이름이 같을 시 유일한 값

		MultipartRequest mr = new MultipartRequest(request, path, maxSize, encode, dfrp);

		String title = mr.getParameter("title");
		String content = mr.getParameter("content");
		String id = mr.getParameter("id");
		List<String> oriname = new ArrayList<>();
		List<String> rename = new ArrayList<>();

		List<BulletinImg> bi = new ArrayList<>();
		// 파일 1에 대한 처리
		String fileSystemName1 = mr.getFilesystemName("upfile1");
		if (fileSystemName1 != null) {
			bi.add(BulletinImg.builder()
					.bullImg(mr.getFilesystemName("upfile1"))
					.build());
		}

		// 파일 2에 대한 처리
		String fileSystemName2 = mr.getFilesystemName("upfile2");
		if (fileSystemName2 != null) {
			bi.add(BulletinImg.builder()
					.bullImg(mr.getFilesystemName("upfile2"))
					.build());
		}

		Bulletin b = Bulletin.builder()
		    .categoryNo(4)
		    .userId(id)
		    .title(title)
		    .content(content)
		    .imgs(bi)
		    .build();
		int result = getService().insertMungStargram(b);
		String msg,loc;
		if(result>0) {
			msg="멍스타그램 등록 성공";
			loc="/board/dogstargram.do";
		}else {
			msg="멍스타그램 등록 실패";
			loc="/board/dogstargram.do";
			for(String rn : rename) {
					File delFile=new File(path+"/"+rn);
					if(delFile.exists()) delFile.delete();
			}
		}
		request.setAttribute("loc", loc);
		request.setAttribute("msg", msg);
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
