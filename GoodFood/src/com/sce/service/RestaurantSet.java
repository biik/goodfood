package com.sce.service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import Interfaces.IRestaurantSet;
import Interfaces.IRestaurantDetails;

import com.sce.DB.DBConnection;
import com.sce.DB.SingeltonDB;

public class RestaurantSet implements IRestaurantSet {

	private List<IRestaurantDetails> resList ;
	private Iterator<IRestaurantDetails> it;

	public RestaurantSet(int category) {
		resList = new ArrayList<IRestaurantDetails>();
		ResultSet categoryRs = null, restaurantRs = null;
		IRestaurantDetails rd = null;
		int restaurantPkID;
		DBConnection sdb = SingeltonDB.getDbCon();
		String query = "SELECT * FROM rest_categ  WHERE category = " + category+";";
		try {
			categoryRs = sdb.query(query);			
			while (categoryRs.next()) {
				restaurantPkID = categoryRs.getInt("pkidRest");
				query = "SELECT * FROM resturant WHERE pkidRest = "+restaurantPkID+";";
				restaurantRs = sdb.query(query);
				restaurantRs.next();
				rd = new RestaurantDetails(restaurantPkID,
						restaurantRs.getInt("pkidClient"), restaurantRs.getString("resturantName"),
						restaurantRs.getString("picRef"), restaurantRs.getString("description"),
						restaurantRs.getString("openingHours"), restaurantRs.getString("address"),
						restaurantRs.getString("phoneNumber"));
				resList.add(rd);
			}
			this.it = resList.iterator();
		} catch (SQLException e) {
			e.printStackTrace();
		}catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	@Override
	public boolean hasNext() {
		return it.hasNext();
	}

	@Override
	public IRestaurantDetails next() {
		return it.next();
	}

}
