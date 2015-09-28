package com.sce.service;

public abstract class Account {
	private int pkId;
	private int roll;
	private String username;
	
	public Account(int pkId, int roll, String username) {
		this.pkId = pkId;
		this.roll = roll;
		this.username = username;
	}
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public int getPkId() {
		return pkId;
	}
	public void setPkId(int pkId) {
		this.pkId = pkId;
	}
	public int getRoll() {
		return roll;
	}
	public void setRoll(int roll) {
		this.roll = roll;
	}
}
