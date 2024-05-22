package com.web.mail.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.web.mail.util.NaverMailSend;

public class VerifyEmailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		ActionForward forward = null;
		System.out.println("여기 왔나용?");
		// 브라우저에서 건너온 세션 확인 → 로그인 상태라면 접근 불가능
		HttpSession session = req.getSession(true);	// 세션 만들어서
		if((String)session.getAttribute("isLogin")!=null) {
			// isLogin 속성이 있다면, 접근권한 없다고 말해줘야함
			session.invalidate();
			resp.setContentType("text/html;charset=utf-8");
			PrintWriter out =resp.getWriter();
			out.println("<script>");
			out.println("alert('잘못된 접근입니다.')");
			// 메인페이지로 이동해버리기
			out.println("location.href='"+req.getContextPath()+"/");
		} else {
			String email=req.getParameter("email");
			NaverMailSend mailSend = new NaverMailSend();	// 메일 발송
			String authenCode = mailSend.sendEmail(email);	// session에 저장할 인증코드
			session.setAttribute(email, authenCode);
			forward = new ActionForward();
			forward.setPath("/my_project/user/verifyemail.find");
			forward.setRedirect(false);
		}
		return forward;
	}

}
