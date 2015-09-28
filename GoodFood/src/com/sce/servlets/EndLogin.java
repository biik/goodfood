package com.sce.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/EndLogin")
public class EndLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public EndLogin() {
        super();
    }

    @Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session != null) {
			synchronized (session) {
				Integer user_id = (Integer) session.getAttribute("user_id");
				if (user_id != null) {
					session.removeAttribute("user_id");
				}
				session.invalidate();
				
				String redirectTarget = request.getRequestURL().toString();
		        redirectTarget = redirectTarget.replaceFirst("https", "http");
		        if(redirectTarget.contains(":8443")) {
		        	redirectTarget = redirectTarget.replaceFirst(":8443", ":8080");
		        }
		        
		        if(request.isSecure()) {                   
		            response.sendRedirect(redirectTarget);
		            return;
		        } else {  
		        	request.getRequestDispatcher("/index.jsp").forward(request, response);
		            return;
		        }
			}
		}
		request.getRequestDispatcher("/index.jsp").forward(request, response);
	}
}
