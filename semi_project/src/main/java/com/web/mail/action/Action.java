package com.web.mail.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface Action {
	// execute 메소드? 특정한 액션(ex. 회원가입, 로그인, 비밀번호 찾기 등)을 처리하는 추상 메소드
	public ActionForward execute(HttpServletRequest req,HttpServletResponse resp) throws Exception;
}
