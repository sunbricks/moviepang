package com.my.web.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

public class Interceptor implements HandlerInterceptor{

//	static final String[] EXCLUDE_URL_LIST = { "/login", "/join", "/home" };
	
	@Override
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, Object handler) 
			throws Exception {
		String reqUrl = request.getRequestURL().toString(); 
		System.out.println("reqUrl: "+reqUrl); 
		
//		로그인체크 제외 리스트 
//		for (String target : EXCLUDE_URL_LIST) { //{ "/login", "/join", "/home" };
//			  
//			if (reqUrl.indexOf(target) > -1) return true;
//		}
		
		HttpSession session = request.getSession();
		String userId = (String)session.getAttribute("userId"); // 없으면 null값 반환
		
		if(userId == null || userId.trim().equals("")) {
			session.invalidate();			
			response.sendRedirect(request.getContextPath() + "/login.do");
			return false;
		}
		
		return true;
	}
}
