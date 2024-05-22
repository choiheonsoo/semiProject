package com.web.mail.action;

public class ActionForward {
	
	private String path;	// 이동할 경로에 대한 필드
	private boolean redirect; // 이동 방식에 대한 필드(true? sendRedirect)

	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public boolean isRedirect() {
		return redirect;
	}
	public void setRedirect(boolean redirect) {
		this.redirect = redirect;
	}
}
