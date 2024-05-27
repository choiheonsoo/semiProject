package com.web.board.controller;

import static com.web.board.model.service.BoardService.getService;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
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

/**
 * Servlet implementation class UpdateMungStargramEndServlet
 */
@WebServlet("/board/updatemungstargramend.do")
public class UpdateMungStargramEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateMungStargramEndServlet() {
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
        
        List<BulletinImg> imgs = getService().selectBoardImg();
        int no = Integer.parseInt(mr.getParameter("no"));
        String title = mr.getParameter("title");
        String content = mr.getParameter("content");
        String id = mr.getParameter("id");
        String prefile1 = mr.getParameter("oriName1");
        String prefile2 = mr.getParameter("oriName2");
        String rename1 = mr.getFilesystemName("upFile1");
        String rename2 = mr.getFilesystemName("upFile2");
        List<String> oriname = new ArrayList<>();

        // 파일 1에 대한 처리
        String fileSystemName1 = mr.getFilesystemName("upfile1");
        if (fileSystemName1 != null) {
            oriname.add(rename1); // 새로운 파일명을 리스트에 추가
        } else {
            oriname.add(prefile1); // 새 파일이 업로드되지 않은 경우, 기존 파일명을 리스트에 추가
        }

        // 파일 2에 대한 처리
        String fileSystemName2 = mr.getFilesystemName("upfile2");
        if (fileSystemName2 != null) {
            oriname.add(rename2); // 새로운 파일명을 리스트에 추가
        } else {
            oriname.add(prefile2); // 새 파일이 업로드되지 않은 경우, 기존 파일명을 리스트에 추가
        }

        // 파일 정보를 저장하고 게시글을 데이터베이스에 추가
        List<BulletinImg> bi = new ArrayList<>();
        for (String name : oriname) {
            bi.add(BulletinImg.builder()
                    .bullImg(name)
                    .build());
        }

        Bulletin b = Bulletin.builder()
            .categoryNo(4)
            .bullNo(no)
            .userId(id)
            .title(title)
            .content(content)
            .imgs(bi)
            .build();
        int result = getService().insertMungStargram(b); // 데이터베이스에 게시글 추가

        String msg, loc;
        if (result > 0) {
            msg = "멍스타그램 수정 성공";
            loc = "/board/dogstargram.do";
        } else {
            msg = "멍스타그램 수정 실패";
            loc = "/board/dogstargram.do";
            for (String rn : oriname) {
                File delFile = new File(path + "/" + rn);
                if (delFile.exists()) delFile.delete(); // 등록 실패 시 업로드된 파일 삭제
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
