package com.sce.DB;

import java.sql.ResultSet;
import java.sql.SQLException;

public interface DBConnection {
	public ResultSet query(String query)throws SQLException;
	public int insert(String insertQuery)throws SQLException;
	public ResultSet PQuery(String statement, Object... values) throws SQLException;
	public int PInsert(String statement, Object... values) throws SQLException;
}
