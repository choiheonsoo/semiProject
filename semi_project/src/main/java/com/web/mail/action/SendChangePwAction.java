package com.web.mail.action;

import static com.web.user.model.service.UserService.getUserService;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.web.user.model.service.UserService;

public class SendChangePwAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		ActionForward forward = null;
		
		// 브라우저에서 건내준  session을 토대로 로그인 상태에선 접근 불가능 처리
		HttpSession session = req.getSession(false);	// 새로 생성 막기
		if(session!=null) {	// 이미 세션이 있다면
			if((String)session.getAttribute("isLogin")!=null) {
				// 로그인 상태라면
				session.invalidate();	// 세션 삭제
				resp.setContentType("text/html;charset=utf-8");
				PrintWriter out = resp.getWriter();
				out.println("<script>");
				out.println("alert('잘못된 접근입니다.');");
				out.println("location.href='"+req.getContextPath()+"/user/login.do';");
				out.println("</script>");
			} else if((String)session.getAttribute("authenticationCode")!=null) {
				System.out.println(1);
				// 로그인도 하지 않은 상태에서 인증코드를 입력한 상태라면
				String authenCode = req.getParameter("authenCode");	// 회원이 입력한 값 가져오기
				if(((String)session.getAttribute("authenticationCode")).equals(authenCode)) {
					// 서버에서 보내준(session에 저장) 인증코드와 회원이 입력한 코드가 일치한다면,
					String m_id = req.getParameter("m_id");	// hidden 으로 처리된 input 태그의 id value 가져옴
					String newPw = req.getParameter("newPw"); // 변경할 새 비밀번호 가져오기
					
					// DB에 접근해서 비밀번호 UPDATE문 실행
					int result = getUserService().changeUserPw(m_id, newPw);
					if(result>0) {	// 수정 성공
						System.out.println(2);
						resp.setContentType("text/html;charset=utf-8");
						PrintWriter out = resp.getWriter();
						out.println("<script>");
						out.println("alert('정상적으로 수정 됐습니다. 로그인 페이지로 돌아갑니다.');");
						out.println("location.href='"+req.getContextPath()+"/user/login.do';");
						out.println("</script>");
					} else { // 수정 실패
						System.out.println(3);
						resp.setContentType("text/html;charset=utf-8");
						PrintWriter out = resp.getWriter();
						out.println("<script>");
						out.println("alert('비밀번호 수정에 실패했습니다.');");
						out.println("history.back(-1);");
						out.println("</script>");				
					}
					
				}
			} else {	// 로그인은 하지않았으나, 인증코드가 발급되지 않은 경우
				System.out.println(4);
				resp.setContentType("text/html;charset=utf-8");
				PrintWriter out = resp.getWriter();
				out.println("<script>");
				out.println("alert('접근 권한이 없습니다.');");
				out.println("location.href='"+req.getContextPath()+"/user/login.do';");
				out.println("</script>");
			}
		} else {	// 세션이 없다면,
			System.out.println(5);
			resp.setContentType("text/html;charset=utf-8");
			PrintWriter out = resp.getWriter();
			out.println("<script>");
			out.println("alert('접근 권한이 없습니다.');");
			out.println("location.href='"+req.getContextPath()+"/user/login.do';");
			out.println("</script>");
		}
		return forward;
	}

}
