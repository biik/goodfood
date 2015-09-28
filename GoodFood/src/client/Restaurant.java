package client;

import iClient.iMenu;
import iClient.iRestaurant;

public class Restaurant implements iRestaurant {
	private int pkid, pkidClient, category;
	private String picture, name, description, address, phone, openHours;
	private iMenu menu;
	
	public Restaurant(int pkid, int pkidClient, int category, String picture,
			String name, String description, String address, String phone,String openHours,
			iMenu menu) {
		super();
		this.pkid = pkid;
		this.pkidClient = pkidClient;
		this.category = category;
		this.picture = picture;
		this.name = name;
		this.description = description;
		this.address = address;
		this.phone = phone;
		this.openHours = openHours;
		this.menu = menu;
	}
	public String getOpenHours() {
		return openHours;
	}
	public void setOpenHours(String openHours) {
		this.openHours = openHours;
	}
	public int getPkid() {
		return pkid;
	}
	public void setPkid(int pkid) {
		this.pkid = pkid;
	}
	public int getPkidClient() {
		return pkidClient;
	}
	public void setPkidClient(int pkidClient) {
		this.pkidClient = pkidClient;
	}
	public int getCategory() {
		return category;
	}
	public void setCategory(int category) {
		this.category = category;
	}
	public String getPicture() {
		return picture;
	}
	public void setPicture(String picture) {
		this.picture = picture;
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
	public iMenu getMenu() {
		return menu;
	}
	public void setMenu(iMenu menu) {
		this.menu = menu;
	}
	@Override
	public String toString() {
		return "Restaurant [pkid=" + pkid + ", pkidClient=" + pkidClient
				+ ", category=" + category + ", picture=" + picture + ", name="
				+ name + ", description=" + description + ", address="
				+ address + ", phone=" + phone + ", menu=" + menu + "]";
	}
	
	
}
