package com.sce.servlets;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sce.service.Account;

/**
 * Servlet Filter implementation class AuthenFilter
 */
@WebFilter("/AuthenFilter")
public class FilterAdmin implements Filter {

    /**
     * Default constructor. 
     */
    public FilterAdmin() {
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
		
		if(request instanceof HttpServletRequest && response instanceof HttpServletResponse) {
			HttpServletRequest httpServletRequest = (HttpServletRequest) request;
			HttpSession session = httpServletRequest.getSession(true);
			Account account = (Account)session.getAttribute("account");
			if (account != null) {
				try {
					if(account.getRoll() == 0) {
			            chain.doFilter(request, response); // Pass request back down the filter chain
						return;
					} else if(account.getRoll() == 1) {
						((HttpServletResponse)response).sendRedirect(httpServletRequest.getContextPath() + "/ClientsPage.jsp");
			            return;
					} else if(account.getRoll() == 2) {
			            ((HttpServletResponse)response).sendRedirect(httpServletRequest.getContextPath() + "/index.jsp");
			            return;
					}
				} catch (Exception e) {}
			}
	        ((HttpServletResponse)response).sendRedirect(httpServletRequest.getContextPath() + "/index.jsp");
	        return;
		}
		/*
	    if(request instanceof HttpServletRequest && response instanceof HttpServletResponse) {
           HttpServletRequest httpReq = (HttpServletRequest) request;
           String redirectTarget = httpReq.getRequestURL().toString();
           redirectTarget = redirectTarget.replaceFirst("https", "http");
           redirectTarget = redirectTarget.replaceFirst(":8443", ":8080");
           //redirectTarget = redirectTarget.replaceFirst("home", "home.do");  
           if(request.isSecure()) {                   
               ((HttpServletResponse)response).sendRedirect(redirectTarget);  
           } else {  
               chain.doFilter(request, response);  
           }
	    }*/		
	    // Log the IP address and current timestamp.

	    // Pass request back down the filter chain
		//chain.doFilter(request, response);
		//request.getRequestDispatcher("/index.jsp").forward(request, response);
		//return;
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
