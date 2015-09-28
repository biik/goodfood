package com.sce.service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.sce.DB.DBConnection;
import com.sce.DB.SingeltonDB;

public class OrderSet {
	private List<Order> orders;

	public OrderSet() {
		String sqlQuerie = "SELECT * FROM (SELECT o.idorders, o.resturantpkId, r.resturantName, o.userpkId, u.firstName, u.lastName, o.ammount, o.date FROM orders o, resturant r, user u WHERE o.resturantpkId = r.pkidRest AND o.userpkId = u.pkIdUser UNION SELECT o.idorders, o.resturantpkId, r.resturantName, o.userpkId, NULL, NULL, o.ammount, o.date FROM orders o, resturant r, user u WHERE o.resturantpkId = r.pkidRest AND o.userpkId IS NULL) d ORDER BY date";
		
		DBConnection sdb = SingeltonDB.getDbCon();

		this.orders = new ArrayList<Order>();
		
		ResultSet resultSet;
		try {
			resultSet = sdb.PQuery(sqlQuerie);
			
			while(resultSet.next()) {
				orders.add(new Order(resultSet.getInt("idorders"),
									resultSet.getInt("resturantpkId"),
									resultSet.getInt("userpkId"),
									resultSet.getFloat("ammount"),
									resultSet.getTimestamp("date"),
									resultSet.getString("resturantName"),
									resultSet.getString("firstName"),
									resultSet.getString("lastName")));
			}
			
		} catch (SQLException e) {
			this.orders = null;
			e.printStackTrace();
		}
		orders.size();
	}
	
	public Order getOrder(int i) {
		return this.orders.get(i);
	}
	
	public void addOrder(Order order) {
		this.orders.add(order);
	}
	
	public int getSize() {
		return this.orders.size();
	}
	
	public boolean isEmpty() {
		if(this.orders == null)
			return true;
		return this.orders.isEmpty();
	}
}
