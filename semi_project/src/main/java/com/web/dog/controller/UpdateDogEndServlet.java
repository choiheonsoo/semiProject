package com.web.dog.controller;

import static com.web.user.model.service.UserService.getUserService;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.web.dog.model.dto.Dog;
import com.web.dog.service.DogService;
import com.web.user.model.dto.User;

/**
 * Servlet implementation class UpdateDogEndServlet
 */
@WebServlet("/dog/updatedogend.do")
public class UpdateDogEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateDogEndServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String path = getServletContext().getRealPath("/upload/user");
		File dir = new File(path);
		if(!dir.exists()) dir.mkdirs();
		int maxSize=1024*1024*1;
		MultipartRequest mr= new MultipartRequest(request,path,maxSize,"UTF-8",new DefaultFileRenamePolicy());
		String userId = mr.getParameter("userId");
		String dogName = mr.getParameter("dogName");
		String dogBreedName = mr.getParameter("dogBreedKey");
		double dogWeight = Double.parseDouble(mr.getParameter("dogWeight"));
		String dogImg = mr.getFilesystemName("dogImg");
		String oriName = mr.getOriginalFileName("dogImg");
		
		Dog dog = Dog.builder().dogName(dogName)
				 			   .userId(userId)
				 			   .dogBreedName(dogBreedName)
				 			   .dogWeight(dogWeight)
				 			   .dogImg(dogImg)
				 			   .build();
		
		int updateDogResult = DogService.getDogService().updateDog(dog);
		
		request.getSession().setAttribute("dogImg", getUserService().getDogImg(userId));
		
		
		String msg, loc;
		if(updateDogResult>0) {
			msg = "반려견 정보 수정 완료";
			loc = "/user/myPage.do";
		}else {
			msg = "정보 수정 실패";
			loc = "/user/updateDog.do";
			File delFile = new File(path+"/"+dogImg);
			if(delFile.exists()) {
				delFile.delete();
			}
		}
		request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
//		if(updateDogResult>0 && delFile.exists()) {
//			delFile.delete();
//			request.setAttribute("msg","반려견 정보 수정 완료");
//			request.setAttribute("loc","/user/myPage.do");
//		} else if(!(updateDogResult>0)){
//			delFile.delete();
//			request.setAttribute("msg", "정보 수정 실패");
//			request.setAttribute("loc", "/WEB-INF/views/user/updateDog.jsp");
//		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
