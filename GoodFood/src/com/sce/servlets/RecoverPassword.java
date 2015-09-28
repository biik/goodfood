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
import com.sce.service.SendMail;

/**
 * Servlet implementation class RecoverPassword
 */
@WebServlet("/RecoverPassword")
public class RecoverPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RecoverPassword() {
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
		// TODO Auto-generated method stub
		String[] fields = {"email","username"};

		if (request.getParameter("RecoverPassword") != null) {
			String username = request.getParameter("username");
			String email = request.getParameter("email");
			boolean flag = false;
			for (String field : fields) {
				if(request.getParameter(field) == null || request.getParameter(field) == "")
				{
					request.setAttribute(field + "_er", 1);
					flag = true;
				}
			}
			if(flag) {
				request.getRequestDispatcher("/PasswordRecovery.jsp").forward(request, response);
				return;
			}
			int result = 0;
			DBConnection sdb = SingeltonDB.getDbCon();
			try {
				String sqlQuerie = "Select idAccounts,roll,password From accounts where userName=?";
				ResultSet resultSet = sdb.PQuery(sqlQuerie, username);

				if(!resultSet.next()){
				
					request.setAttribute("validate_er", -1);
					request.getRequestDispatcher("/PasswordRecovery.jsp").forward(request, response);
					return;
				}
				int pkid=resultSet.getInt(1);
				int roll=resultSet.getInt(2);
				String password=resultSet.getString(3);

				if(roll==0){
					sqlQuerie="SELECT email From administrator Where pkIdAccount=?";
				}
				if(roll==1){
					sqlQuerie="SELECT email From Client Where pkIdAccount=?";
				}
				if(roll==2){
					sqlQuerie="SELECT email From User Where pkIdAccount=?";
				}
				resultSet = sdb.PQuery(sqlQuerie, pkid);
				resultSet.next();
				if(resultSet.wasNull()){
					request.setAttribute("validate_er", -1);
					request.getRequestDispatcher("/PasswordRecovery.jsp").forward(request, response);
					return;
				}
				String mail=resultSet.getString(1);
				if(!mail.equals(email)){
					request.setAttribute("validate_er", -1);
					request.getRequestDispatcher("/PasswordRecovery.jsp").forward(request, response);
					return;
				}
				StringBuilder stringBuilder = new StringBuilder();
				stringBuilder.append("Hello!\n");
				stringBuilder.append("Your Password for GoodFood Site Is:").append(password);
				stringBuilder.append("\nPlease LogIn with this password,Sincerley");
				stringBuilder.append("\nGoodFood Team!");
				(new SendMail()).send(email, "Password Recovery", stringBuilder.toString());
				request.setAttribute("Success", 1);
				request.getRequestDispatcher("/PasswordRecovery.jsp").forward(request, response);
				return;

				
		}catch (SQLException e) {
			request.setAttribute("sql_er", -1);
			e.printStackTrace();
		}
	}
		request.setAttribute("sql_er", -1);
		request.getRequestDispatcher("/PasswordRecovery.jsp").forward(request, response);
	}
}


