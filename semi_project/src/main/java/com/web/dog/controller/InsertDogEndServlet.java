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

/**
 * Servlet implementation class InsertDogEndServlet
 */
@WebServlet("/dog/insertdogend.do")
public class InsertDogEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertDogEndServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String path = getServletContext().getRealPath("/upload/user");
		int maxSize = 1024*1024*1;
		MultipartRequest mr = new MultipartRequest(request, path, maxSize, "UTF-8", new DefaultFileRenamePolicy());
		String oriDogFileName=mr.getParameter("oriDogFileName");
		String userId=mr.getParameter("userId");
		String dogName=mr.getParameter("addDogName");
		String dogBreedName = mr.getParameter("addDogBreedKey");
		double dogWeight = Double.parseDouble(mr.getParameter("addDogWeight"));
		String dogImg = mr.getFilesystemName("addDogImg");
		
		Dog dog = Dog.builder().dogName(dogName)
								.userId(userId)
								.dogBreedName(dogBreedName)
								.dogWeight(dogWeight)
								.dogImg(dogImg)
								.build();
		
		int insertDogResult = DogService.getDogService().insertDog(dog);
		String msg, loc;
		File delFile = new File(path+"/"+dogImg);
		File oriFile = new File(path+"/"+oriDogFileName);
		if(insertDogResult>0 && dogImg!=null) {
			msg = "반려견 추가 완료";
			loc = "/user/myPage.do";
			if(oriFile.exists()) {
				oriFile.delete();
			}
		}else {
			msg = "반려견 추가 실패";
			loc = "/user/updateDog.do";
			if(delFile.exists()) {
				delFile.delete();
			}
		}
		request.getSession().setAttribute("dogImg", getUserService().getDogImg(userId));
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
