package com.sce.DB;

import java.sql.*;
	/**
	 * @desc A singleton database access class for MySQL
	 * @author ido
	 */
	public final class SingeltonDB implements DBConnection {
	    public Connection conn;
	    private Statement statement;
	    public static SingeltonDB db;
	    private  SingeltonDB() {
	        String url= "jdbc:mysql://localhost:3306/";
	        String dbName = "javaproject";//The name of our database
	        String driver = "com.mysql.jdbc.Driver";
	        String userName = "admin";
	        String password = "123456789";
	        try {
	            Class.forName(driver).newInstance();
	            this.conn = (Connection)DriverManager.getConnection(url+dbName,userName,password);
	        }
	        catch (Exception sqle) {
	            sqle.printStackTrace();
	        }
	    }
	    /**
	     *
	     * @return MysqlConnect Database connection object
	     */
	    public static synchronized SingeltonDB getDbCon() {
	        if ( db == null ) {
	            db = new SingeltonDB();
	        }
	        return db;
	 
	    }
	    /**
	     *
	     * @param query String The query to be executed
	     * @return a ResultSet object containing the results or null if not available
	     * @throws SQLException
	     */
	    public ResultSet query(String query) throws SQLException{
	        statement = db.conn.createStatement();
	        ResultSet res = statement.executeQuery(query);
	        return res;
	    }
	    /**
	     * @desc Method to insert data to a table
	     * @param insertQuery String The Insert query
	     * @return boolean
	     * @throws SQLException
	     */
	    public int insert(String insertQuery) throws SQLException {
	        statement = db.conn.createStatement();
	        int result = statement.executeUpdate(insertQuery);
	        return result;
	    }
	    
	    public int PInsert(String statement, Object... values) throws SQLException {
	    	PreparedStatement preparedStatement = conn.prepareStatement(statement);
	    	 int i = 1;
	    	 for(Object obj : values) {
	    		 preparedStatement.setObject(i++, obj);
	    	 }

			 return preparedStatement.executeUpdate();
	    }
	 
	    public ResultSet PQuery(String statement, Object... values) throws SQLException {
	    	 PreparedStatement preparedStatement = conn.prepareStatement(statement);
	    	 int i = 1;
	    	 for(Object obj : values) {
	    		 preparedStatement.setObject(i++, obj);
	    	 }

			 return preparedStatement.executeQuery();
	    }
	}