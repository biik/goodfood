package com.sce.servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sce.DB.DBConnection;
import com.sce.DB.SingeltonDB;
import com.sce.service.Account;
import com.sce.service.User;

/**
 * Servlet implementation class EditUser
 */
@WebServlet("/EditUser")
public class EditUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String EMAIL_PATTERN = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";

    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditUser() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/index.jsp").forward(request, response);
		return;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("Edit", 1);
		request.setAttribute("Success", null);

		HttpSession session = request.getSession(false);
		synchronized (session) {
		if (session == null) {
			request.getRequestDispatcher("/index.jsp").forward(request, response);
			return;
		}}
		Account account = (Account) session.getAttribute("account");
		User user = (User)account;
		String[] fields = {"password", "confirmPassword", "firstName", "lastName", "email","city","street","homeNumber"};
		
		if (request.getParameter("EditUser") != null) {
			request.setAttribute("sqlResult", 1);
			String password = request.getParameter("password");
			String confirmPassword = request.getParameter("confirmPassword");
			String firstName = request.getParameter("firstName");
			String lastName = request.getParameter("lastName");
			String email = request.getParameter("email");
			String city = request.getParameter("city");
			String street = request.getParameter("street");
			String homenNmber = request.getParameter("homeNumber");
			String phoneNumber = request.getParameter("phoneNumber");
			String building = request.getParameter("building");
			
			boolean flag = false;
			for (String field : fields) {
				if(request.getParameter(field) == null || request.getParameter(field) == "")
				{
					request.setAttribute(field + "_er", 1);
					flag = true;
				}
			}

			if (homenNmber != null && homenNmber != "") {
				try {
					Integer.parseInt(homenNmber);
				} catch (NumberFormatException nfe) {
					request.setAttribute("homeNumberParser_er", 1);
					flag = true;
				}
			}
			
			if (building != null && building != "") {
				try {
					Integer.parseInt(building);
				} catch (NumberFormatException nfe) {
					request.setAttribute("buildingParser_er", 1);
					flag = true;
				}
			}else{
				building="0";
				try {
					Integer.parseInt(building);
				} catch (NumberFormatException nfe) {
					request.setAttribute("buildingParser_er", 1);
					flag = true;
				}
			}
			

			if (phoneNumber != null) {
				if(!phoneNumber.matches("[0-9]+") || phoneNumber.length() < 5 || phoneNumber.length() > 16) {
					request.setAttribute("phoneNumberParser_er", 1);
					flag = true;
				}
			}
			
			if(!Validate(email)) {
				flag = true;
				request.setAttribute("emailvalidate_er", 1);
			}
			
			if(flag) {
				request.getRequestDispatcher("/UserPage.jsp").forward(request, response);
				return;
			}
			
			if(!(password.equals(confirmPassword))) {
				request.setAttribute("confirmPasswordEqual_er", 1);
				request.getRequestDispatcher("/UserPage.jsp").forward(request, response);
				return;
			}
			int result = 0;
			DBConnection sdb = SingeltonDB.getDbCon();
			
			try {
				String sqlQuerie = "Update Accounts Set password=? Where idAccounts=?";
				result = sdb.PInsert(sqlQuerie, password,account.getPkId());
				
				if(result != 1) {
					request.setAttribute("sql_er", -1);
					request.getRequestDispatcher("/UserPage.jsp").forward(request, response);
					return;
				}
							
				sqlQuerie = "Update User SET firstName=?,lastName=?,email=?,city=?,street=?,homeNumber=?,building=?,phoneNumber=? WHERE pkidAccount=?";
				result = sdb.PInsert(sqlQuerie, firstName, lastName, email, city, street, homenNmber, building, phoneNumber,account.getPkId());
				
				if(result == 1) {
					user.setFirstName(firstName);
					user.setLastName(lastName);
					user.setEmail(email);
					user.setCity(city);
					user.setHomeNumber(Integer.parseInt(homenNmber));
					user.setBuilding(Integer.parseInt(building));
					user.setPhoneNumber(phoneNumber);
					request.setAttribute("Success", 1);
					request.getRequestDispatcher("/UserPage.jsp").forward(request, response);
					return;
				}
			} catch (SQLException e) {
				request.setAttribute("sql_er", -1);
				e.printStackTrace();
			}
		}
		
		request.setAttribute("sql_er", -1);
		request.getRequestDispatcher("/UserPage.jsp").forward(request, response);	}
	
		public boolean Validate(final String hex) {
			Pattern pattern = Pattern.compile(EMAIL_PATTERN);
			Matcher matcher = pattern.matcher(hex);
			return matcher.matches();
 
	}

}
