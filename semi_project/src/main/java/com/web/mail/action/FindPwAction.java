package com.web.mail.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.web.mail.util.NaverMailSend;
import com.web.user.model.dto.User;
import com.web.user.model.service.UserService;

public class FindPwAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		ActionForward forward = null;
		
		// 브라우저에서 건너온 세션 확인 → 로그인 상태라면 접근 못하게 설정
		HttpSession session = req.getSession(true);	// 세션이 없다면 새로 만들기(속성 추가 안되어있음. 로그인에서 속성을 추가하기 때문)
		if((String)session.getAttribute("isLogin")!=null) {
			// 로그인(LoginCheckServlet에서 설정한 값이 있다면) 된 상태라면
			session.invalidate();  // 세션 삭제 → 로그인 취소
			resp.setContentType("text/html;charset=utf-8");
			PrintWriter out = resp.getWriter();
			out.println("<script>");
			out.println("alert('접근 권한이 없습니다.');");
			out.println("location.href='"+req.getContextPath()+"/user/login.do';");
			out.println("</script>");
			// 로그인 된 상태라면 다시 로그인 창으로 보내버리기
		}
		
		// DB 처리(비밀번호 재발급 요청을 위해 입력받은 email, id 있는지 확인)
		String m_email = req.getParameter("m_email");
		String m_id = req.getParameter("m_id");
		
		UserService service = UserService.getUserService();
		User user = service.selectUser(m_id, m_email);
		
		if(user == null || !user.getEmail().equals(m_email)) {
			// 입력한 id와 email을 가진 회원이 없거나 이메일이 일치하지 않는 경우
			resp.setContentType("text/html;charset=utf-8");
			PrintWriter out = resp.getWriter();
			out.println("<script>");
			out.println("alert('일치하는 회원이 없습니다.');");
			out.println("location.href='"+req.getContextPath()+"/user/login.do';");
			out.println("</script>");
			// 일치하는 회원 없을 시뒤로가기 실행
		} else {
			// 일치하는 회원이 있다면, 메일 전송
			NaverMailSend mailSend = new NaverMailSend();
			String authenticationCode = mailSend.sendEmail(m_email);
			// 포워딩 처리
			session.setAttribute("authenticationCode", authenticationCode);
			session.setAttribute("m_id", m_id);
			
			forward = new ActionForward();	// ActionForward 객체 초기화
			forward.setPath("/my_project/user/changepw.find"); // 이동할 경로 설정
			forward.setRedirect(true); // redirect로 넘김
		}
		
		return forward;
	}


}
