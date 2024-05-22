package com.web.mail.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class UserChangePwAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		ActionForward forward = null;
		
		// 브라우저에서 건내주는 Session 확인하여 로그인 상태에서는 접근 막기
		HttpSession session = req.getSession(false);	// 자동 생성 막기
		if(session != null) {	// 이미 만들어진 session이 있다면(FindPwAction 에서 session을 항상 만듦)
			if((String)session.getAttribute("isLogin")!=null) { // 로그인 했다면
				session.invalidate();
				resp.setContentType("text/html;charset=utf-8");
				PrintWriter out = resp.getWriter();
				out.println("<script>");
				out.println("alert('잘못된 접근입니다.');");
				out.println("location.href='"+req.getContextPath()+"/user/login.do';");
				out.println("</script>");

			} else {
				// 로그인 안한 상태라면,
				String authenticationCode = (String)session.getAttribute("authenticationCode");
				System.out.println("authenticationCode : "+authenticationCode);
				if(authenticationCode!=null) {
					// 로그인 안한 상태에서 인증코드는 있는 상태라면 ( 이메일 인증 했다면 ) 
					forward = new ActionForward();
					forward.setPath("/WEB-INF/views/user/changePwForm.jsp");
					forward.setRedirect(false);	// requestDispatcher 방식으로 요청
				} else {
					// 인증 코드가 session에 저장 안되어 있다면 = 이메일 인증 안했다면
					resp.setContentType("text/html;charset=utf-8");
					PrintWriter out = resp.getWriter();
					out.println("<script>");
					out.println("alert('잘못된 접근입니다.');");
					out.println("location.href='"+req.getContextPath()+"/user/login.do';");
					out.println("</script>");
				}
			}
		} else {
			// session 조차 생성되지 않았다면
			resp.setContentType("text/html;charset=utf-8");
			PrintWriter out = resp.getWriter();
			out.println("<script>");
			out.println("alert('잘못된 접근입니다.');");
			out.println("location.href='"+req.getContextPath()+"/user/login.do';");
			out.println("</script>");
		}
		return forward;
	}

}
