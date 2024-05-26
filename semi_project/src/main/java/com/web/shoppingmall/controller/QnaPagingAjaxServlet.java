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
import com.google.gson.GsonBuilder;
import com.web.shoppingmall.model.dto.Qna;
/**
 * Servlet implementation class QnaPagingAjaxServlet
 */
@WebServlet("/shoppingmall/qnapagingajax.do")
public class QnaPagingAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QnaPagingAjaxServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// qna ajax 페이징처리 서블릿
		int productKey=Integer.parseInt(request.getParameter("productKey"));
		int pageBarSize=5;
		int numPerpage=5;
		int totalData=getService().getTotalQnaCount(productKey);
		int totalPage=(int)Math.ceil((double)totalData/numPerpage);
		int currPage=Integer.parseInt(request.getParameter("currPage"));
		int cPage=1;
		//페이지바 버튼에 따른 페이지 판단
		String btnText=request.getParameter("btnText");
		if(btnText.equals("<<")) {
			cPage=1;
		}else if(btnText.equals("<")) {
			cPage=((currPage - 1) / pageBarSize) * pageBarSize + 1 - pageBarSize;
		}else if(btnText.equals(">>")) {
			cPage=totalPage;
		}else if(btnText.equals(">")) {
			cPage=((currPage - 1) / pageBarSize) * pageBarSize + 1 + pageBarSize;
		}else {
			cPage=Integer.parseInt(btnText);
		}
		
		int pageNo=((cPage-1)/pageBarSize)*pageBarSize+1;
		int pageEnd=pageNo+pageBarSize-1;
		
		String pageBar="<div id='qnapagebar'>";
		if(pageNo==1) {
			if(cPage==1) {
				pageBar+="<p class='qnapagebarinequality'><<</p>";
			}else {
				pageBar+="<button class='qnapagebarinequalitybtn'><<</button>";
			}
			pageBar+="<p class='qnapagebarinequality'><</p>";
		}else {
			pageBar+="<button class='qnapagebarinequalitybtn'><<</button>";
			pageBar+="<button class='qnapagebarinequalitybtn'><</button>";
		}
		while(!(pageNo>pageEnd||pageNo>totalPage)) {
			if(pageNo==cPage) {
				pageBar+="<p class='qnapagebarnum'>"+pageNo+"</p>";
			}else {
				pageBar+="<button class='qnapagebarnumbtn'>"+pageNo+"</button>";
			}
			pageNo++;
		}
		if(pageNo>totalPage) {
			pageBar+="<p class='qnapagebarinequality'>></p>";
			if(cPage<totalPage) {
				pageBar+="<button class='qnapagebarinequalitybtn'>>></button>";
			}else {
				pageBar+="<p class='qnapagebarinequality'>>></p>";
			}
		}else {
			pageBar+="<button class='qnapagebarinequalitybtn'>></button>";
			pageBar+="<button class='qnapagebarinequalitybtn'>>></button>";
		}
		pageBar+="</div>";
		
		List<Qna> qnas=getService().selectQnaByProductKey(productKey, cPage, numPerpage);
		Map<String,Object> m=new HashMap<>();
		m.put("pagebar", pageBar);
		m.put("qna", qnas);
		
		response.setContentType("application/json;charset=UTF-8");
		Gson gson=new GsonBuilder()
                .setDateFormat("yyyy-MM-dd")
                .create();
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
