package com.sce.service;

public class Client extends Account {
	private int pkIDAccount, pkidClient;
	private String email, phone, firstName, lastName;
	
	
	public Client(int pkID, int pkidClient, String username, String firstName, String lastName, String email, String phone) {
		super(pkID, 1, username);
		this.pkidClient = pkidClient;
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.phone = phone;
	}
	
	public int getPkidClient() {
		return pkidClient;
	}

	public void setPkidClient(int pkidClient) {
		this.pkidClient = pkidClient;
	}

	public int getPkIDAccount() {
		return pkIDAccount;
	}
	public void setPkIDAccount(int pkIDAccount) {
		this.pkIDAccount = pkIDAccount;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
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
	
}
