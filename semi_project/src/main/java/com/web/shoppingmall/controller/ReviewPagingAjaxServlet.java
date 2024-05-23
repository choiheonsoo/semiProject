package com.web.shoppingmall.controller;

import static com.web.shoppingmall.model.service.ShoppingmallService.getService;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.web.user.model.dto.User;

/**
 * Servlet implementation class ReviewPagingAjaxServlet
 */
@WebServlet("/shoppingmall/reviewpagingajax.do")
public class ReviewPagingAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewPagingAjaxServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// ajax를 통해 리뷰 정보 넘기기
		int pageBarSize=5;
		int numPerpage=3;
		int totalData=Integer.parseInt(request.getParameter("totalData"));
		int totalPage=(int)Math.ceil((double)totalData/numPerpage);
		int cPage=Integer.parseInt(request.getParameter("cPage"));
		
		//페이지바 버튼에 따른 페이지 판단
		String btnText=request.getParameter("btnText");
		if(btnText.equals("<<")) {
			cPage=1;
		}else if(btnText.equals("<")) {
			cPage=((cPage - 1) / pageBarSize) * pageBarSize + 1 - pageBarSize;
		}else if(btnText.equals(">>")) {
			cPage=totalPage;
		}else if(btnText.equals(">")) {
			cPage=((cPage - 1) / pageBarSize) * pageBarSize + 1 + pageBarSize;
		}else {
			cPage=Integer.parseInt(btnText);
		}
		
		int pageNo=((cPage-1)/pageBarSize)*pageBarSize+1;
		int pageEnd=pageNo+pageBarSize-1;
		
		String pageBar="<div id='reviewpagebar'>";
		if(pageNo==1) {
			pageBar+="<p class='pagebarinequality'><<</p>";
			pageBar+="<p class='pagebarinequality'><</p>";
		}else {
			pageBar+="<button class='pagebarinequalitybtn'><<</button>";
			pageBar+="<button class='pagebarinequalitybtn'><</button>";
		}
		while(!(pageNo>pageEnd||pageNo>totalPage)) {
			if(pageNo==cPage) {
				pageBar+="<p class='pagebarnum'>"+pageNo+"</p>";
			}else {
				pageBar+="<button class='pagebarnumbtn'>"+pageNo+"</button>";
			}
			pageNo++;
		}
		if(pageNo>totalPage) {
			pageBar+="<p class='pagebarinequality'>></p>";
			pageBar+="<p class='pagebarinequality'>>></p>";
		}else {
			pageBar+="<button class='pagebarinequalitybtn'>></button>";
			pageBar+="<button class='pagebarinequalitybtn'>>></button>";
		}
		pageBar+="</div>";
		int productKey=Integer.parseInt(request.getParameter("productKey")); //상품의 고유키
		
		//정렬이 최신순인지 별점순인지 판단
		String sort=request.getParameter("sort");
		if(sort.equals("최신순")) {
			//최신순
			sort="REVIEW_DATE DESC";
		}else {
			//별점순
			sort="RATING DESC";
		}
		
		
		List<User> u=getService().selectReviewByProductKey(productKey, cPage, numPerpage, sort);
		Map<String,Object> m=new HashMap<>();
		m.put("pagebar", pageBar);
		m.put("user", u);
		response.setContentType("application/json;charset=UTF-8");
		Gson gson=new Gson();
		gson.toJson(m,response.getWriter());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
