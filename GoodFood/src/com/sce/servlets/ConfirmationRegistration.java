package com.sce.servlets;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sce.DB.DBConnection;
import com.sce.DB.SingeltonDB;

@WebServlet("/ConfirmationRegistration")
public class ConfirmationRegistration extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ConfirmationRegistration() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (request.getParameter("sendemailhash") != null) {
			request.setAttribute("sqlResult", 1);
			
			String username = request.getParameter("username");
			String emailHash = request.getParameter("emailHash");
			
			DBConnection sdb = SingeltonDB.getDbCon();
			
			if(username != null && username != "" && emailHash != null && emailHash != "") {
				String sqlQuerie = "SELECT COUNT(accounts.idAccounts) as result FROM accounts, user, confirmation"
								+ " WHERE accounts.idAccounts=user.pkidAccount AND accounts.idAccounts=confirmation.accountNumber"
								+ " AND user.pkIdUser=confirmation.userNumber AND accounts.userName=? AND confirmation.hashCode=?";
				ResultSet resultSet;
				try {
					resultSet = sdb.PQuery(sqlQuerie, username, emailHash);
					resultSet.next();
					
					if(resultSet.getInt("result") > 0 ) {
						sqlQuerie = "SELECT accounts.idAccounts as idAccounts FROM accounts, user, confirmation"
									+ " WHERE accounts.idAccounts=user.pkidAccount AND accounts.idAccounts=confirmation.accountNumber"
									+ " AND user.pkIdUser=confirmation.userNumber AND accounts.userName=? AND confirmation.hashCode=?";
						resultSet = sdb.PQuery(sqlQuerie, username, emailHash);
						resultSet.next();
						int idAccounts = resultSet.getInt("idAccounts");
						
						sqlQuerie = "UPDATE accounts SET status=1 WHERE idAccounts=?";
						int result = sdb.PInsert(sqlQuerie, idAccounts);
						if(result == 1) {
							
							sqlQuerie = "DELETE FROM confirmation WHERE accountNumber=? AND hashCode=?";
							result = sdb.PInsert(sqlQuerie, idAccounts, emailHash);
							
							request.setAttribute("sqlResultString", "You have successfully confirmed your email!");
							request.getRequestDispatcher("/endOperation.jsp").forward(request, response);
							return;
						}
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					//e.printStackTrace();
				}
			}
		}
		
		request.setAttribute("sqlResultString", "An error has occurred, check your Username or Hex code!");
		request.getRequestDispatcher("/confirmationregistration.jsp").forward(request, response);
		return;
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
}
