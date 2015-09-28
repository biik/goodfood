package com.sce.service;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.sce.DB.DBConnection;
import com.sce.DB.SingeltonDB;

import Interfaces.IRestaurantDetails;

public class RestaurantDetails implements IRestaurantDetails {

	int pkID, clientPkID;
	String name, description, picRef, openHours, address, phone;
	
	public RestaurantDetails(int pkIdRest) {
		try {
			DBConnection sdb = SingeltonDB.getDbCon();
			
			String sqlQuerie = "SELECT pkidClient, resturantName, picRef, description, openingHours, address, phoneNumber FROM resturant WHERE pkidRest = ?";
			
			ResultSet resultSet = sdb.PQuery(sqlQuerie, pkIdRest);
			resultSet.next();
			this.pkID = pkIdRest;
			this.clientPkID = resultSet.getInt("pkidClient");
			this.name = resultSet.getString("resturantName");
			this.description = resultSet.getString("description");
			this.picRef = resultSet.getString("picRef");
			this.openHours = resultSet.getString("openingHours");
			this.address = resultSet.getString("address");
			this.phone = resultSet.getString("phoneNumber");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public RestaurantDetails(int pkID, int clientPkID, String name, String picRef, String description, String openHours, String address, String phone) {
		super();
		this.pkID = pkID;
		this.clientPkID = clientPkID;
		this.name = name;
		this.description = description;
		this.picRef = picRef;
		this.openHours = openHours;
		this.address = address;
		this.phone = phone;
	}

	public String getOpenHours() {
		return openHours;
	}

	public void setOpenHours(String openHours) {
		this.openHours = openHours;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public int getPkID() {
		return pkID;
	}

	public void setPkID(int pkID) {
		this.pkID = pkID;
	}

	public int getClientPkID() {
		return clientPkID;
	}

	public void setClientPkID(int clientPkID) {
		this.clientPkID = clientPkID;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getPicRef() {
		return picRef;
	}

	public void setPicRef(String picRef) {
		this.picRef = picRef;
	}

	public Client getClientObject() throws SQLException {
		String query = "Select * from client where pkidClient=" + this.getClientPkID() + ";";
		ResultSet resSet = null;
		DBConnection sdb = SingeltonDB.getDbCon();
		resSet = sdb.query(query);
		resSet.next();
		return new Client(this.getClientPkID(), resSet.getInt("pkidClient"), "",
				resSet.getString("email"),
				resSet.getString("phone"),
				resSet.getString("firstName"),
				resSet.getString("lastName"));
	}
}
