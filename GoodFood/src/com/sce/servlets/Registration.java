package com.sce.servlets;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;
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
import com.sce.service.Hex;
import com.sce.service.SendMail;

@WebServlet("/Registration")
public class Registration extends HttpServlet {
	private static final long serialVersionUID = 1L;
	//String connectionURL = "jdbc:mysql://localhost:3306/goodfood";
	private static final String EMAIL_PATTERN = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
	
    public Registration() {
        super();
        // TODO Auto-generated constructor stub
    }

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] fields = {"username", "password", "confirmPassword", "firstName", "lastName", "email", "gender", "city", "street", "homeNumber", "building"};
		
		if (request.getParameter("registration") != null) {
			request.setAttribute("sqlResult", 1);
			
			String username = request.getParameter("username").trim();
			String password = request.getParameter("password").trim();
			String confirmPassword = request.getParameter("confirmPassword").trim();
			String firstName = request.getParameter("firstName").trim();
			String lastName = request.getParameter("lastName").trim();
			String email = request.getParameter("email").trim();
			String gender_s = request.getParameter("gender");
			//String country = request.getParameter("country");
			String city = request.getParameter("city").trim();
			String street = request.getParameter("street").trim();
			String homenNmber = request.getParameter("homeNumber").trim();
			String phoneNumber = request.getParameter("phoneNumber").trim();
			String building = request.getParameter("building").trim();
			String disclaimers = request.getParameter("disclaimers");
			
			boolean flag = false;
			for (String field : fields) {
				if(request.getParameter(field) == null || request.getParameter(field) == "")
				{
					request.setAttribute(field + "_er", 1);
					flag = true;
				}
			}
			
			if (homenNmber != null) {
				if(!homenNmber.matches("[0-9]+") || homenNmber.length() > 8) {
					request.setAttribute("homeNumberParser_er", 1);
					flag = true;
				}
			}
			
			if (building != null) {
				if(!building.matches("[0-9]+") || building.length() > 8) {
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
			
			if(disclaimers != null) {
				if(!disclaimers.equals("on")) {
					flag = true;
					request.setAttribute("disclaimers_er", 1);
				}
			} else {
				flag = true;
				request.setAttribute("disclaimers_er", 1);
			}
			
			if(!Validate(email)) {
				flag = true;
				request.setAttribute("emailvalidate_er", 1);
			}
			
			if(flag) {
				request.getRequestDispatcher("/registration.jsp").forward(request, response);
				return;
			}
			
			int gender = (gender_s.equals("male") ? 1 : 0);
			
			if(!(password.equals(confirmPassword))) {
				request.setAttribute("confirmPasswordEqual_er", 1);
				request.getRequestDispatcher("/registration.jsp").forward(request, response);
				return;
			}
			
			int result = 0;
			int pkId = 0;
			ResultSet resultSet = null;
			
			DBConnection sdb = SingeltonDB.getDbCon();
			
			try {
				String sqlQuerie = "SELECT COUNT(idAccounts) AS ct FROM accounts WHERE userName=?";
				resultSet = sdb.PQuery(sqlQuerie, username);
				resultSet.next();
				if(resultSet.getInt("ct") != 0)
				{
					request.setAttribute("usernameBusy_er", username);
					request.getRequestDispatcher("/registration.jsp").forward(request, response);
					return;
				}
				
				sqlQuerie = "INSERT INTO accounts (userName, password, roll, status) VALUES (?, ?, 2, 0)";
				result = sdb.PInsert(sqlQuerie, username, password);
				
				if(result != 1) {
					request.setAttribute("sql_er", -1);
					request.getRequestDispatcher("/registration.jsp").forward(request, response);
					return;
				}
				
				sqlQuerie = "SELECT idAccounts AS id FROM accounts WHERE userName=? AND password=?";
				resultSet = sdb.PQuery(sqlQuerie, username, password);
				resultSet.next();
				pkId = resultSet.getInt("id");
				
				// Rendom ------------------------------------------------
				Random random = new Random(System.currentTimeMillis());
				StringBuffer stringBuffer = new StringBuffer();
				for(int i = 0; i < 20; i++) {
					stringBuffer.append(random.nextInt(10));
				}
				// MD5 ---------------------------------------------------
				/*
		        MessageDigest messageDigest = MessageDigest.getInstance("MD5");
		        messageDigest.update(stringBuffer.toString().getBytes());
		        byte byteData[] = messageDigest.digest();
		        stringBuffer.setLength(0);
		    	for (int i=0;i<byteData.length;i++) {
		    		String hex=Integer.toHexString(0xff & byteData[i]);
		   	     	if(hex.length()==1) stringBuffer.append('0');
		   	     	stringBuffer.append(hex);
		    	}*/
		    	String hexMD5 = (new Hex()).getHexMD5(stringBuffer.toString());// stringBuffer.toString();
		        // MD5 ---------------------------------------------------
				
				sqlQuerie = "INSERT INTO user (pkIdAccount, firstName, lastName, gender, email, city, street, homenumber, building, phonenumber)"
						+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
				result = sdb.PInsert(sqlQuerie, pkId, firstName, lastName, gender, email, city, street, homenNmber, building, phoneNumber);
				
				sqlQuerie = "SELECT pkIdUser AS id FROM user WHERE pkidAccount=?";
				resultSet = sdb.PQuery(sqlQuerie, pkId);
				resultSet.next();
				int pkidAccount = resultSet.getInt("id");
				
				sqlQuerie = "INSERT INTO confirmation (accountNumber, userNumber, hashCode) VALUES (?, ?, ?)";
				int result_2 = sdb.PInsert(sqlQuerie, pkId, pkidAccount, hexMD5);
				
				if(result == 1) {
			        stringBuffer.setLength(0);
			        stringBuffer.append("Please go to this <a href=\"http://localhost:8080/GoodFood/confirmationregistration.jsp?username=").append(username);
			        stringBuffer.append("&emailHash=").append(hexMD5).append("\">link</a>");
			        stringBuffer.append("or enter to this <a href=\"http://localhost:8080/GoodFood/confirmationregistration.jsp\">page</a>");
			        stringBuffer.append("and enter this string: ").append(hexMD5);
					
			        (new SendMail()).send(email, "Confirmation email to GoodFood", stringBuffer.toString());
					
					request.setAttribute("sqlResultString", "Registration is almost finished, to your email send confirmation registration link.");
					
					request.getRequestDispatcher("/endOperation.jsp").forward(request, response);
					return;
				}
			} catch (NoSuchAlgorithmException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				//e.printStackTrace();
			}
		}
		
		request.setAttribute("sql_er", -1);
		request.getRequestDispatcher("/registration.jsp").forward(request, response);
	}
    
	public boolean Validate(final String hex) {
		Pattern pattern = Pattern.compile(EMAIL_PATTERN);
		Matcher matcher = pattern.matcher(hex);
		return matcher.matches();
	}
}
