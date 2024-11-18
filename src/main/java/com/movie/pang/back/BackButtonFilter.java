package com.movie.pang.back;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class BackButtonFilter implements Filter {

	   @Override
	    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
	        HttpServletRequest httpRequest = (HttpServletRequest) request;
	        HttpServletResponse httpResponse = (HttpServletResponse) response;

	        String requestURI = httpRequest.getRequestURI();

	        // Web-INF 디렉토리에 있는 파일들에 대한 요청은 필터를 거치지 않도록 처리
	        if (requestURI.startsWith("/WEB-INF/")) {
	            chain.doFilter(request, response);
	            return;
	        }

	        // Cache-Control 헤더를 추가하여 뒤로가기 막기
	        httpResponse.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	        httpResponse.setHeader("Pragma", "no-cache");
	        httpResponse.setHeader("Expires", "0");

	        chain.doFilter(request, response);
	    }
}
