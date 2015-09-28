package com.sce.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sce.service.Account;
import com.sce.service.CheckLogin;

@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Login() {
        super();
    }
    
    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	//ServletContext servletContext = getServletContext();
    	Account account = null;
    	
		if (request.getParameter("login") != null) {
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			
			boolean flag_er = false;
			
			if(username == null || username == "") {
				request.setAttribute("login_er", "Enter the Username and Password!");
				flag_er = true;
			}
			
			if(password == null || password == "") {
				request.setAttribute("login_er", "Enter the Username and Password!");
				flag_er = true;
			}
			
			if(!flag_er) {
				account = CheckLogin.login(username, password);
	
				if (account != null) {
					HttpSession session = request.getSession(true);

					session.setAttribute("account", account);
					
					if(account.getRoll() == 0) {
						//request.getRequestDispatcher("/admin.jsp").forward(request, response);
						response.sendRedirect(request.getContextPath() + "/admin.jsp");
						return;
					} else if(account.getRoll() == 1) {
						//request.getRequestDispatcher("/ClientsPage.jsp").forward(request, response);
						response.sendRedirect(request.getContextPath() + "/ClientsPage.jsp");
						return;
					} else if(account.getRoll() == 2){
						//request.getRequestDispatcher("/index.jsp").forward(request, response);
						response.sendRedirect(request.getContextPath() + "/index.jsp");
						return;
					} else {
						request.setAttribute("login_er", "Error SQL DataBase!");
						request.getRequestDispatcher("/index.jsp").forward(request, response);
						return;
					}
				} else {
					if(CheckLogin.CheckConfirmation(username, password)) {
						request.setAttribute("login_er", "<a href=\"confirmationregistration.jsp\">You have to confirm this account!</a>");
					} else {
						request.setAttribute("login_er", "Incorrect Username or Password");
					}
				}
			}
		}
		
		request.getRequestDispatcher("/index.jsp").forward(request, response);
		return;
	}
    /*
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	doPost(request, response);
    }*/
}
