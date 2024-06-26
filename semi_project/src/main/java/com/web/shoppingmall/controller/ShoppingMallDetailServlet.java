package com.web.shoppingmall.controller;

import static com.web.shoppingmall.model.service.ShoppingmallService.getService;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.web.shoppingmall.model.dto.Product;
import com.web.shoppingmall.model.dto.Qna;
import com.web.user.model.dto.User;
/**
 * Servlet implementation class ShoppingMallDetailServlet
 * 쇼핑몰 상품 상세페이지 이동 서블릿
 */
@WebServlet("/shoppingmall/shoppingmalldetail.do")
public class ShoppingMallDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ShoppingMallDetailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 클릭한 상품 상세 페이지로 이동
		int productKey=Integer.parseInt(request.getParameter("productKey")); //해당 상품키
		String r=request.getParameter("r"); //r값으로 리뷰부분으로 스크롤 바로 내리는지 판단
		if(request.getSession().getAttribute("loginUser")!=null) {
			String userId=((User)request.getSession().getAttribute("loginUser")).getUserId();
			int wish=getService().isExistWish(productKey, userId);
			request.setAttribute("wish", wish);
		}
		Product p=getService().selectProductByKey(productKey); //상품관련 정보를 담은 상품객체
		int cPage=1;
		int pageBarSize=5;
		
		int numPerpage=3;
		int totalData=p.getTotalReviewCount();
		int totalPage=(int)Math.ceil((double)totalData/numPerpage);
		int pageNo=((cPage-1)/pageBarSize)*pageBarSize+1;
		int pageEnd=pageNo+pageBarSize-1;
		
		String pageBar="<div id='reviewpagebar'>";
		
		pageBar+="<p class='pagebarinequality'><<</p>";
		pageBar+="<p class='pagebarinequality'><</p>";
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
		
		
		int qnaNumPerpage=5;
		int qnaTotalData=getService().getTotalQnaCount(productKey);
		int qnaTotalPage=(int)Math.ceil((double)qnaTotalData/qnaNumPerpage);
		int qnaPageNo=((cPage-1)/pageBarSize)*pageBarSize+1;
		int qnaPageEnd=qnaPageNo+pageBarSize-1;
		
		String qnaPageBar="<div id='qnapagebar'>";
		qnaPageBar+="<p class='qnapagebarinequality'><<</p>";
		qnaPageBar+="<p class='qnapagebarinequality'><</p>";
		while(!(qnaPageNo>qnaPageEnd||qnaPageNo>qnaTotalPage)) {
			if(qnaPageNo==cPage) {
				qnaPageBar+="<p class='qnapagebarnum'>"+qnaPageNo+"</p>";
			}else {
				qnaPageBar+="<button class='qnapagebarnumbtn'>"+qnaPageNo+"</button>";
			}
			qnaPageNo++;
		}
		if(qnaPageNo>qnaTotalPage) {
			qnaPageBar+="<p class='qnapagebarinequality'>></p>";
			if(cPage<totalPage) {
				qnaPageBar+="<button class='qnapagebarinequalitybtn'>>></button>";
			}else {
				qnaPageBar+="<p class='qnapagebarinequality'>>></p>";
			}
		}else {
			qnaPageBar+="<button class='qnapagebarinequalitybtn'>></button>";
			qnaPageBar+="<button class='qnapagebarinequalitybtn'>>></button>";
		}
		qnaPageBar+="</div>";
		
		List<User> u=getService().selectReviewByProductKey(productKey, cPage, numPerpage, "REVIEW_DATE DESC"); //리뷰정보를 담은 회원객체리스트
		List<Qna> q=getService().selectQnaByProductKey(productKey, cPage, qnaNumPerpage);
		
		
		
		request.setAttribute("pageBar", pageBar);
		request.setAttribute("qnaPageBar", qnaPageBar);
		request.setAttribute("product", p);
		request.setAttribute("user", u);
		request.setAttribute("qna", q);
		request.getRequestDispatcher("/WEB-INF/views/shoppingmall/shoppingmalldetail.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
