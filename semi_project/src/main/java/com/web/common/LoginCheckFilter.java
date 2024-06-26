package com.web.common;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.web.user.model.dto.User;

/**
 * Servlet Filter implementation class LoginCheckFilter
 */
@WebFilter(servletNames= {
	"loginCheckFilter"
},urlPatterns= {"/board/*","/user/*"})
public class LoginCheckFilter extends HttpFilter implements Filter {
       
    /**
     * @see HttpFilter#HttpFilter()
     */
    public LoginCheckFilter() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req=(HttpServletRequest)request;
		HttpSession session=req.getSession();
		User loginUser=(User)session.getAttribute("loginUser");
		String uri = req.getRequestURI();
		
		if(loginUser==null) {
			if(uri.endsWith("/user/login.do")||uri.endsWith("/user/loginuser.do")||
				uri.endsWith("/user/enrollbykakao.do")||uri.endsWith("/user/enroll.do")||
				uri.endsWith("/user/searchId.do")||uri.endsWith("/user/new_user.do")|| 
				uri.endsWith("/user/finduserid.do")||uri.endsWith("/user/sendemail.do")||
				uri.endsWith("/user/verifyemail.do")||uri.endsWith("/user/enrollend.do")){
				chain.doFilter(request, response);
			}else {
				request.setAttribute("msg","로그인 후 이용할 수 있습니다");
				request.setAttribute("loc","/");
				request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp")
				.forward(request, response);
			}
		}else {
			// pass the request along the filter chain
			chain.doFilter(request, response);
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
