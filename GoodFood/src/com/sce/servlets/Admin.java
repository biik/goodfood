package com.sce.servlets;

import java.io.IOException;
import java.sql.ResultSet;
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
import com.sce.service.Administrator;

/**
 * Servlet implementation class Admin
 */
@WebServlet("/Admin")
public class Admin extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String EMAIL_PATTERN = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Admin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int resultRegistration = 1;
		
		if (request.getParameter("registrationClient") != null) {
			resultRegistration = RegistrationClient(request);
			if(resultRegistration == 0)
				request.setAttribute("registrationSuccessful", "Registration ended successfully!");
		} else if (request.getParameter("registrationAdmin") != null) {
			resultRegistration = RegistrationAdmin(request);
			if(resultRegistration == 0)
				request.setAttribute("registrationSuccessful", "Registration ended successfully!");
		} else if (request.getParameter("editAdmin") != null) {
			resultRegistration = EditAdmin(request);
			if(resultRegistration == 0)
				request.setAttribute("registrationSuccessful", "Edited data successfully!");
		} else if (request.getParameter("blockAccount") != null) {
			resultRegistration = BlockAccount(request);
			if(resultRegistration == 0)
				request.setAttribute("registrationSuccessful", "Account blocked successfully!");
		}
		

		
		request.getRequestDispatcher("/admin.jsp").forward(request, response);
	}

	private int RegistrationClient(HttpServletRequest request)
	{
		String[] fields = {"username", "password", "confirmPassword", "firstName", "lastName", "email", "phoneNumber"};
		
		request.setAttribute("sqlResult", 1);
		
		String userName = request.getParameter("username").trim();
		String password = request.getParameter("password").trim();
		String confirmpassword = request.getParameter("confirmPassword").trim();
		String firstName = request.getParameter("firstName").trim();
		String lastName = request.getParameter("lastName").trim();
		String email = request.getParameter("email").trim();
		//String country = request.getParameter("country");
		//String city = request.getParameter("city");
		//String street = request.getParameter("street");
		//String homenumber = request.getParameter("homeNumber");
		String phonenumber = request.getParameter("phoneNumber").trim();
		
		boolean flag = false;
		for (String field : fields) {
			if(request.getParameter(field).trim() == null || request.getParameter(field).trim() == "")
			{
				request.setAttribute("c" + Character.toUpperCase(field.charAt(0)) + field.substring(1) + "_er", 1);
				flag = true;
			}
		}
		
		if (phonenumber != null) {
			if(!phonenumber.matches("[0-9]+") || phonenumber.length() < 5 || phonenumber.length() > 16) {
				request.setAttribute("cPhoneNumberParser_er", 1);
				flag = true;
			}
		}
		
		if(!Validate(email)) {
			request.setAttribute("cEmailvalidate_er", 1);
			flag = true;
		}
		
		if(!(password.equals(confirmpassword))) {
			request.setAttribute("cConfirmPasswordEqual_er", 1);
			flag = true;
		}
		
		if(flag)
			return 1;
		
		int result = 0;
		int pkId = 0;
		ResultSet resultSet = null;
		
		DBConnection sdb = SingeltonDB.getDbCon();
		
		try {
			String sqlQuerie = "SELECT COUNT(idAccounts) AS ct FROM accounts WHERE userName=?";
			resultSet = sdb.PQuery(sqlQuerie, userName);
			resultSet.next();
			if(resultSet.getInt("ct") != 0)
			{
				request.setAttribute("cUsernameBusy_er", 1);
				return 1;
			}
			
			sqlQuerie = "INSERT INTO accounts (userName, password, roll) VALUES (?, ?, 1)";
			result = sdb.PInsert(sqlQuerie, userName, password);
			
			if(result != 1) {
				request.setAttribute("sql_er", -1);
				return 1;
			}
		
			sqlQuerie = "SELECT idAccounts AS id FROM accounts WHERE userName=? AND password=?";
			resultSet = sdb.PQuery(sqlQuerie, userName, password);
			resultSet.next();
			pkId = resultSet.getInt("id");
			
			sqlQuerie = "INSERT INTO client  (pkIdAccount, firstName, lastName, email, phone)"
					+ "VALUES (?, ?, ?, ?, ?)";
			result = sdb.PInsert(sqlQuerie, pkId, firstName, lastName, email, phonenumber);
			
			if(result == 1)
				return 0;

		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return 1;
	}
	
	private int RegistrationAdmin(HttpServletRequest request)
	{
		String[] fields = {"username", "password", "confirmPassword", "firstName", "lastName", "email"};
		
		request.setAttribute("sqlResult", 2);
		
		String userName = request.getParameter("username").trim();
		String password = request.getParameter("password").trim();
		String confirmpassword = request.getParameter("confirmPassword").trim();
		String firstName = request.getParameter("firstName").trim();
		String lastName = request.getParameter("lastName").trim();
		String email = request.getParameter("email").trim();
		
		boolean flag = false;
		for (String field : fields) {
			if(request.getParameter(field).trim() == null || request.getParameter(field).trim() == "")
			{
				request.setAttribute("a" + Character.toUpperCase(field.charAt(0)) + field.substring(1) + "_er", 1);
				flag = true;
			}
		}
		
		if(!Validate(email)) {
			request.setAttribute("aEmailvalidate_er", 1);
			flag = true;
		}
		
		if((!(password.equals(confirmpassword)))) {
			request.setAttribute("aConfirmPasswordEqual_er", 1);
			flag = true;
		}
		
		if(flag)
			return 1;
		
		int result = 0;
		int pkId = 0;
		ResultSet resultSet = null;
		
		DBConnection sdb = SingeltonDB.getDbCon();
		
		try {
			String sqlQuerie = "SELECT COUNT(idAccounts) AS ct FROM accounts WHERE userName=?";
			resultSet = sdb.PQuery(sqlQuerie, userName);
			resultSet.next();
			if(resultSet.getInt("ct") != 0)
			{
				request.setAttribute("aUsernameBusy_er", 1);
				return 1;
			}
			
			sqlQuerie = "INSERT INTO accounts (userName, password, roll) VALUES (?, ?, 0)";
			result = sdb.PInsert(sqlQuerie, userName, password);
			
			if(result != 1) {
				request.setAttribute("sql_er", -1);
				return 1;
			}
		
			sqlQuerie = "SELECT idAccounts AS id FROM accounts WHERE userName=? AND password=?";
			resultSet = sdb.PQuery(sqlQuerie, userName, password);
			resultSet.next();
			pkId = resultSet.getInt("id");
			
			sqlQuerie = "INSERT INTO administrator (pkIdAccount, firstName, lastName, email)"
					+ "VALUES (?, ?, ?, ?)";
			
			result = sdb.PInsert(sqlQuerie, pkId, firstName, lastName, email);
			
			if(result == 1)
				return 0;

		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return 1;
	}
	
	private int EditAdmin(HttpServletRequest request)
	{
		HttpSession session = request.getSession(true);

		Account account = (Account)session.getAttribute("account");
		
		String[] fields = {"username", "firstName", "lastName", "email"};
		
		request.setAttribute("sqlResult", 3);
		
		String userName = request.getParameter("username").trim();
		String password = request.getParameter("password").trim();
		String confirmPassword = request.getParameter("confirmPassword").trim();
		String firstName = request.getParameter("firstName").trim();
		String lastName = request.getParameter("lastName").trim();
		String email = request.getParameter("email").trim();
		
		boolean flag = false;
		
		for (String field : fields) {
			if(request.getParameter(field).trim() == null || request.getParameter(field).trim() == "")
			{
				request.setAttribute("e" + Character.toUpperCase(field.charAt(0)) + field.substring(1) + "_er", 1);
				flag = true;
			}
		}
		
		int result = 0;
		int pkId = 0;
		ResultSet resultSet = null;
		
		if(flag)
			return 1;
		
		DBConnection sdb = SingeltonDB.getDbCon();
		
		try {
			String sqlQuerie;
			
			if(!(account.getUsername().equals(userName))) {
				sqlQuerie = "SELECT COUNT(idAccounts) AS ct FROM accounts WHERE userName=?";
				resultSet = sdb.PQuery(sqlQuerie, userName);
				resultSet.next();
				if(resultSet.getInt("ct") != 0)
				{
					request.setAttribute("eUsernameBusy_er", 1);
					return 1;
				}
				
				sqlQuerie = "UPDATE accounts SET userName=? WHERE idAccounts=? AND userName=?";
				result = sdb.PInsert(sqlQuerie, userName, account.getPkId(), account.getUsername());
				
				if(result != 1) {
					request.setAttribute("sql_er", -1);
					return 1;
				}
				account.setUsername(userName);
			}
			
			if(password != null && confirmPassword != null && password != "" && confirmPassword != "") {
				if(!(password.equals(confirmPassword))) {
					request.setAttribute("eConfirmPasswordEqual_er", 1);
					return 1;
				}
				
				sqlQuerie = "UPDATE accounts SET password=? WHERE idAccounts=? AND userName=?";
				result = sdb.PInsert(sqlQuerie, password, account.getPkId(), account.getUsername());
				
				if(result != 1) {
					request.setAttribute("sql_er", -1);
					return 1;
				}
			}
			
			Administrator administrator = (Administrator)account;
			
			if(email != administrator.getEmail() || firstName != administrator.getFirstName() || lastName != administrator.getLastName()) {
				if(!Validate(email)) {
					request.setAttribute("eEmailvalidate_er", 1);
					return 1;
				}
			
				sqlQuerie = "UPDATE administrator SET firstName=?, lastName=?, email=? WHERE pkIdAccount=?";
			
				result = sdb.PInsert(sqlQuerie, firstName, lastName, email, account.getPkId());
			}
			
			if(result == 1) {
				administrator.setFirstName(firstName);
				administrator.setLastName(lastName);
				administrator.setEmail(email);
				
				return 0;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return 1;
	}
	
	private int BlockAccount(HttpServletRequest request)
	{
		request.setAttribute("sqlResult", 4);
		String userName = request.getParameter("username").trim();
		String idAccount = request.getParameter("idAccount").trim();
		
		DBConnection sdb = SingeltonDB.getDbCon();
		String sqlQuerie;
		
		if(userName != null && userName != "") {
			
			try {
				sqlQuerie = "SELECT COUNT(idAccounts) AS ct FROM accounts WHERE userName=?";
				ResultSet resultSet = sdb.PQuery(sqlQuerie, userName);
				resultSet.next();
				if(resultSet.getInt("ct") < 1)
				{
					request.setAttribute("bUserDoesNotExist_er", 1);
					return 1;
				}
				
				sqlQuerie = "SELECT idAccounts, status FROM accounts WHERE userName=?";
				resultSet = sdb.PQuery(sqlQuerie, userName);
				resultSet.next();
				if(resultSet.getInt("status") == 0)
				{
					request.setAttribute("bUserBlocked_er", 1);
					return 1;
				}

				int idAccounts = resultSet.getInt("idAccounts");
				
				sqlQuerie = "UPDATE accounts SET status=0 WHERE idAccounts=? AND userName=?";
				int result = sdb.PInsert(sqlQuerie, idAccounts, userName);
				
				if(result == 1) {
					return 0;
				}
				
			} catch (SQLException e) {
			e.printStackTrace();
			}
			
		} else if(idAccount != null) {
			if(!idAccount.matches("[0-9]+")) {
				request.setAttribute("bIdAccount_er", 1);
				return 1;
			}
			
			try {
				sqlQuerie = "SELECT COUNT(idAccounts) AS ct FROM accounts WHERE idAccounts=?";
				ResultSet resultSet = sdb.PQuery(sqlQuerie, idAccount);
				resultSet.next();
				if(resultSet.getInt("ct") < 1)
				{
					request.setAttribute("bUserDoesNotExist_er", 1);
					return 1;
				}
				
				sqlQuerie = "SELECT status FROM accounts WHERE idAccounts=?";
				resultSet = sdb.PQuery(sqlQuerie, idAccount);
				resultSet.next();
				if(resultSet.getInt("status") == 0)
				{
					request.setAttribute("bUserBlocked_er", 1);
					return 1;
				}
				
				sqlQuerie = "UPDATE accounts SET status=0 WHERE idAccounts=?";
				int result = sdb.PInsert(sqlQuerie, idAccount);
				
				if(result == 1) {
					return 0;
				}
				
			} catch (SQLException e) {
			e.printStackTrace();
			}
		}
		
		return 1;
	}
    
	public boolean Validate(final String hex) {
		Pattern pattern = Pattern.compile(EMAIL_PATTERN);
		Matcher matcher = pattern.matcher(hex);
		return matcher.matches();
	}
}
