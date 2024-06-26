package com.web.user.controller;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

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
import com.web.user.model.service.UserService;

/**
 * Servlet implementation class EnrollUserEndServlet
 */
@WebServlet("/user/enrollend.do")
public class EnrollUserEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EnrollUserEndServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		// 회원 가입 시 대표 반려견 사진 업로드 시 파일 저장하는 로직
		String path = getServletContext().getRealPath("/upload/user");
		File dir = new File(path);
		if(!dir.exists())dir.mkdirs();
		int maxSize=1024*1024*1;
		MultipartRequest mr = new MultipartRequest(request, path, maxSize, "UTF-8", new DefaultFileRenamePolicy());
		// String → java.util.Date
		System.out.println(mr.getParameter("birthday"));
		String dateString ="";
		if(mr.getParameter("birthday")!=null || mr.getParameter("birthday")=="") {
			dateString = mr.getParameter("birthday");
		}
		SimpleDateFormat birthSdf = new SimpleDateFormat("yyyy-MM-dd");
		java.sql.Date sqlDate = null;
		// java.util.Date → java.sql.Date
		try {
			if(dateString!=null) {
				Date utilDate = birthSdf.parse(dateString);
				sqlDate = new java.sql.Date(utilDate.getTime());
			} else {
				long currentTimeMills = System.currentTimeMillis();
				sqlDate = new java.sql.Date(currentTimeMills);
			}
		}catch(ParseException e) { }
		
		
		String[] address = mr.getParameterValues("address");
		//추가 내용들
		String detailAddress = mr.getParameter("detailAddress");
		String extraAddress = mr.getParameter("extraAddress");
		
		// 주소 결합 로직
		StringBuilder addressBuilder = new StringBuilder();
		if (address != null && address.length > 0) {
		    addressBuilder.append(address[0]);
		    if (address.length > 1) {
		        addressBuilder.append(", ").append(address[1]);
		    }
		}
		if (detailAddress != null && !detailAddress.trim().isEmpty()) {
		    addressBuilder.append(", ").append(detailAddress);
		}
		if (extraAddress != null && !extraAddress.trim().isEmpty()) {
		    addressBuilder.append(", ").append(extraAddress);
		}
		String addressString = addressBuilder.toString();
		
		User user = User.builder().userId(mr.getParameter("userId"))
								  .userName(mr.getParameter("name"))
								  .phone(mr.getParameter("phone"))
								  .email(mr.getParameter("email"))
								  .password(mr.getParameter("password"))
								  //.address(mr.getParameterValues("address")[1]==null?address[0]:address[0]+","+address[1])
								  .address(addressString) //추가 내용
								  .mateCount(0)	// default값 설정
								  .point(0) // default값 설정
								  .status("N") // default값 설정
								  .birthDay(sqlDate)
								  .zipCode(mr.getParameter("zipcode"))
								  .build();
		
		int result = UserService.getUserService().enrollUser(user);
		
		if(result>0 && mr.getParameter("ishavingdog").equals("Y")){
//			System.out.println(mr.getParameter("userId")+mr.getParameter("dogBreedKey")+mr.getParameter("dogName")+
//					Double.parseDouble(mr.getParameter("dogWeight"))+mr.getFilesystemName("dogImg"));
			Dog dog = Dog.builder().userId(mr.getParameter("userId"))
								   .dogBreedName(mr.getParameter("dogBreedKey"))
								   .dogName(mr.getParameter("dogName"))
								   .dogWeight(Double.parseDouble(mr.getParameter("dogWeight")))
								   .dogImg(mr.getFilesystemName("dogImg"))	// 파일 저장
								   .build();
			
			// rename된 파일명만 저장 후 결과에 따라 파일 삭제, 등록 결정하는 로직
			int dogResult = DogService.getDogService().enrollDog(dog);
			File delFile = new File(path+"/"+dog.getDogImg());
			if(!(dogResult>0) && delFile.exists()) {
				delFile.delete();
			}
		}
		
		request.setAttribute("result", result);
		request.setAttribute("user", user);
		request.getRequestDispatcher("/WEB-INF/views/user/login.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
