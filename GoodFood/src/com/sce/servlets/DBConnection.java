package com.sce.servlets;

import java.sql.ResultSet;
import java.sql.SQLException;

public interface DBConnection {
	public ResultSet query(String query)throws SQLException;
	public int insert(String insertQuery)throws SQLException;

}
