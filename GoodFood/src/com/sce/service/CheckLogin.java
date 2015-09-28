package com.sce.service;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.sce.DB.DBConnection;
import com.sce.DB.SingeltonDB;


public class CheckLogin {
	//private static String connectionURL = "jdbc:mysql://localhost:3306/goodfood";
	
	public static Account login(String username, String password)
	{
		Account result = null;
		ResultSet resultSet = null;

		try {
			DBConnection sdb = SingeltonDB.getDbCon();
			
			String sqlQuerie = "SELECT COUNT(idAccounts) AS result FROM accounts "
					+ "WHERE userName=? AND password=? AND status=1";
			
			//Statement statement = connection.createStatement();
			//statement.executeQuery(sqlQuerie);
			//resultSet = statement.getResultSet();
			resultSet = sdb.PQuery(sqlQuerie, username, password);
			resultSet.next();
			
			if(resultSet.getInt("result") > 0 ) {
				sqlQuerie = "SELECT idAccounts, roll FROM accounts WHERE userName=? AND password=?";
				//statement.executeQuery(sqlQuerie);
				//resultSet = statement.getResultSet();
				resultSet = sdb.PQuery(sqlQuerie, username, password);
				resultSet.next();
				int pkId = resultSet.getInt("idAccounts");
				int roll = resultSet.getInt("roll");
				
				if(roll == 0) {
					sqlQuerie = "SELECT firstName, lastName, email FROM administrator"
							+ " WHERE pkIdAccount=?";
					Administrator administrator = null;
					try {
						resultSet = sdb.PQuery(sqlQuerie, pkId);
						resultSet.next();
						
						administrator = new Administrator(pkId, username,
												resultSet.getString("firstName"),
											    resultSet.getString("lastName"),
											    resultSet.getString("email"));
					} catch (SQLException e) {
						e.printStackTrace();
					} finally{
						resultSet.close();
					}
					result = administrator;
					
				} else if(roll == 1) {
					sqlQuerie = "SELECT pkidClient, firstName, lastName, email, phone FROM Client "
							+ "WHERE pkIdAccount=?";
					Client client = null;
					try {
						resultSet.close();
						resultSet = sdb.PQuery(sqlQuerie, pkId);
						resultSet.next();

						client = new Client(pkId, resultSet.getInt("pkidClient"), username,
								resultSet.getString("firstName"),
								resultSet.getString("lastName"),
								resultSet.getString("email"),
								resultSet.getString("phone"));
						resultSet.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
					
					result = client;
				} else if(roll == 2){
					sqlQuerie = "SELECT firstName, lastName, gender, email, city, street, homeNumber, phoneNumber, building FROM user "
							+ "WHERE pkIdAccount=?";
					User user = null;
					try {
						resultSet.close();
						resultSet = sdb.PQuery(sqlQuerie, pkId);
						resultSet.next();

						user = new User(pkId, username,
								resultSet.getString("firstName"),
								resultSet.getString("lastName"),
								resultSet.getString("email"),
								resultSet.getString("city"),
								resultSet.getBoolean("gender"),
								resultSet.getString("street"),
								resultSet.getInt("homeNumber"),
								resultSet.getString("phoneNumber"),
								resultSet.getInt("building"));
						resultSet.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
					
					result = user;
				}
			}
			//statement.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		//} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
		}

		return result;
	}
	
	public static boolean CheckConfirmation(String username, String password) {
		DBConnection sdb = SingeltonDB.getDbCon();
		
		int result = 0;
		
		String sqlQuerie = "SELECT COUNT(confirmation.idconfirmation) AS result FROM accounts, confirmation"
				+ " WHERE accounts.idAccounts=confirmation.accountNumber AND accounts.userName=?"
				+ " AND accounts.password=? AND accounts.status=0";
		
		try {
			ResultSet resultSet = sdb.PQuery(sqlQuerie, username, password);
			resultSet.next();
			result = resultSet.getInt("result");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result > 0;
	}
}
