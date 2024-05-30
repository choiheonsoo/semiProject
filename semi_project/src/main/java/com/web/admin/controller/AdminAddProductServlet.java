package com.web.admin.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.web.admin.product.dto.AddProduct;
import com.web.admin.service.AdminService;

/**
 * Servlet implementation class AdminAddProductServlet
 */
@WebServlet("/admin/addproduct.do")
public class AdminAddProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminAddProductServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String tempPath = getServletContext().getRealPath("/")+"upload/temp";	// 임시 사진 저장소 설정
		File tempDir = new File(tempPath);
		if(!tempDir.exists()) {
			tempDir.mkdirs();
		}
		MultipartRequest temp = new MultipartRequest(request, tempPath, 100*1024*1024, "UTF-8", new DefaultFileRenamePolicy());
		
		String productJson = temp.getParameter("productJson");
		
		Gson gson = new Gson();
		AddProduct product = gson.fromJson(productJson, AddProduct.class);	// JSON 문자열 → List<String> 객체로 역직렬화
        int category = product.getCategory();
        String realPath = getServletContext().getRealPath("/")+"upload/shoppingmall/product/";
        switch(category) {
        // 카테고리별 파일 위치 설정 변경
	        case 1: realPath += "feed"; break;
	        case 2: realPath += "snack"; break;
	        case 3: realPath += "dogpad"; break;
	        case 4: realPath += "clothes"; break;
	        case 5: realPath += "bathproduct"; break;
	        case 6: realPath += "beautyequipment"; break;
	        case 7: realPath += "harnessLeash"; break;
	        case 8: realPath += "etc"; break;
	        default : System.out.println("카테고리 오류"); break;
        }
        
        File realDir = new File(realPath);
        if(!realDir.exists()) {
        	realDir.mkdirs();
        }
        System.out.println(1);
        String descriptImages="";
        
        Enumeration<String> filenames=temp.getFileNames();
        
        while(filenames.hasMoreElements()) {
        	String filename=filenames.nextElement();	
        	// filename ? temp.getFileNames().nextElement(); = HTML에서 보내주는 formData의 key값
        	String renameFileName=temp.getFilesystemName(filename);
        	File tempFile=temp.getFile(filename);
        	// 파일을 temp폴더에서 parsing한 원래 위치로 복사하기 위하여 새로운 파일 객체 생성
        	File copyFile=new File(realPath+"/"+renameFileName);
        	// 파일복사 → 옵션값으로 덮어쓰기 부여
        	java.nio.file.Files.copy(tempFile.toPath(),copyFile.toPath(),StandardCopyOption.REPLACE_EXISTING);
        	tempFile.delete();
        	
        	if(filename.equals("mainImage")) product.setMainImage(renameFileName); 
        	else product.setDescriptionImages(renameFileName);
      
        }
        
        
        // DB에 저장
        int result = AdminService.getAdminService().addProduct(product);
        boolean flag = false;
        if(result > 0) flag = true;
        
        // ajax 요청에 대한 응답 보내주기
        response.getWriter().write(String.valueOf(flag));
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
