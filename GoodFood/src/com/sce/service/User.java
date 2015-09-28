package com.sce.service;

public class User extends Account {
	private String firstName;
	private String lastName;
	private String email;
	private String city;
	private boolean gender;
	private String street;
	private Integer homeNumber;
	private String phoneNumber;
	private Integer building;
	
	public User(int pkId, String username, String firstName, String lastName, String email, String city, boolean gender, String street, Integer homeNumber, String phoneNumber, Integer building) {
		super(pkId, 2, username);
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.city = city;
		this.gender = gender;
		this.street = street;
		this.homeNumber = homeNumber;
		this.phoneNumber = phoneNumber;
		this.building = building;
	}
	public boolean isGender() {
		return gender;
	}
	public void setGender(boolean gender) {
		this.gender = gender;
	}
	public Integer getBuilding() {
		return building;
	}
	public void setBuilding(Integer building) {
		this.building = building;
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
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getStreet() {
		return street;
	}
	public void setStreet(String street) {
		this.street = street;
	}
	public Integer getHomeNumber() {
		return homeNumber;
	}
	public void setHomeNumber(Integer homeNumber) {
		this.homeNumber = homeNumber;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
}
