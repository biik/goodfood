package com.sce.service;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Order {
	final SimpleDateFormat format = new SimpleDateFormat("dd.MM.yyyy hh:mm");
	
	private int idorders, resturantpkId, userpkId;
    private float ammount;
    private Date date;
    private String firstName, lastName, resturantName;
	public Order(int idorders, int resturantpkId, int userpkId, float ammount, Date date, String resturantName, String firstName, String lastName) {
		this.idorders = idorders;
		this.resturantpkId = resturantpkId;
		this.userpkId = userpkId;
		this.ammount = ammount;
		this.date = date;
		this.resturantName = (resturantName == null ? "" : resturantName);
		this.firstName = (firstName == null ? "" : firstName);
		this.lastName = (lastName == null ? "" : lastName);
	}
	
	public int getIdorders() {
		return idorders;
	}
	public void setIdorders(int idorders) {
		this.idorders = idorders;
	}
	public int getResturantpkId() {
		return resturantpkId;
	}
	public void setResturantpkId(int resturantpkId) {
		this.resturantpkId = resturantpkId;
	}
	public int getUserpkId() {
		return userpkId;
	}
	public void setUserpkId(int userpkId) {
		this.userpkId = userpkId;
	}
	public float getAmmount() {
		return ammount;
	}
	public void setAmmount(float ammount) {
		this.ammount = ammount;
	}
	public Date getDate() {
		return date;
	}
	public String getFormatDate() {
		return format.format(date);
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getResturantName() {
		return resturantName;
	}
	public void setResturantName(String resturantName) {
		this.resturantName = resturantName;
	}
}
