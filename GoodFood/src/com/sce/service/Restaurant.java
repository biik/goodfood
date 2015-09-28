package com.sce.service;

public class Restaurant {
	private int pkidRest, pkidClient;
	private String resturantName, picRef, description, openingHours, address, phoneNumber;
	
	public Restaurant(int pkidRest, int pkidClient, String resturantName, String picRef, String description, String openingHours, String address, String phoneNumber) {
		this.pkidRest = pkidRest;
		this.pkidClient = pkidClient;
		this.resturantName = resturantName;
		this.picRef = picRef;
		this.description = (description == null ? "" : description);
		this.openingHours = (openingHours == null ? "" : openingHours);
		this.address=(address == null ? "" : address);
		this.phoneNumber=(phoneNumber == null ? "" : phoneNumber);
	}

	public int getPkidRest() {
		return pkidRest;
	}

	public int getPkidClient() {
		return pkidClient;
	}

	public void setPkidClient(int pkidClient) {
		this.pkidClient = pkidClient;
	}

	public String getOpeningHours() {
		return openingHours;
	}

	public void setOpeningHours(String openingHours) {
		this.openingHours = openingHours;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public void setPkidRest(int pkidRest) {
		this.pkidRest = pkidRest;
	}

	public String getResturantName() {
		return resturantName;
	}

	public void setResturantName(String resturantName) {
		this.resturantName = resturantName;
	}

	public String getPicRef() {
		return picRef;
	}

	public void setPicRef(String picRef) {
		this.picRef = picRef;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
}