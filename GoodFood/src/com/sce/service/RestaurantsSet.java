package com.sce.service;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.sce.DB.DBConnection;
import com.sce.DB.SingeltonDB;

public class RestaurantsSet {
	private Restaurant[] restaurants = null;

	public RestaurantsSet(int category) {
		
		DBConnection sdb = SingeltonDB.getDbCon();
		ResultSet resultSet = null;
		
		String sqlQuerie = "SELECT resturant.pkidRest, resturant.pkidClient, resturant.resturantName, resturant.picRef,"
				+ " resturant.description, resturant.openingHours, resturant.address, resturant.phoneNumber"
				+ " FROM resturant, rest_categ WHERE resturant.pkidRest=rest_categ.pkidRest AND rest_categ.category=?";
		
		try {
			resultSet = sdb.PQuery(sqlQuerie, category);

		
			int count = 0;
			while(resultSet.next()) {
				++count;
			}
			
			if(count > 0) {
				restaurants = new Restaurant[count];
				resultSet.beforeFirst();

				for(int i = 0; resultSet.next(); i++) {
					restaurants[i] = new Restaurant(
							resultSet.getInt("pkidRest"),
							resultSet.getInt("pkidClient"),
							resultSet.getString("resturantName"),
							resultSet.getString("picRef"),
							resultSet.getString("description"),
							resultSet.getString("openingHours"),
							resultSet.getString("address"),
							resultSet.getString("phoneNumber"));
				}
			}
		
		} catch (SQLException e) {
			this.restaurants = null;
			e.printStackTrace();
		}
	}
	
	public boolean isEmpty() {
		if(this.restaurants == null)
			return true;
		if(this.restaurants.length == 0)
			return true;
		return false;
	}
	
	public Restaurant[] getRestaurants() {
		return restaurants;
	}

	public void setRestaurants(Restaurant[] restaurants) {
		this.restaurants = restaurants;
	}

	public int getLengh() {
		return this.restaurants.length;
	}
	
	public Restaurant getRestaurant(int i) {
		return this.restaurants[i];
	}
}
