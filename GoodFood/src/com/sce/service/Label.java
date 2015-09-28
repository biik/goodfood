package com.sce.service;

import java.util.ArrayList;
import java.util.List;

public class Label {
	//private int 
	private String name;
	private List<Item> items;
	
	public Label(String name) {
		this.name = name;
		this.items = new ArrayList<Item>();
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<Item> getItems() {
		return this.items;
	}

	public void setItems(List<Item> items) {
		this.items = items;
	}

	public void addItems(Item item) {
		this.items.add(item);
	}
	
	public Item getItem(int i) {
		return this.items.get(i);
	}

	public void setItem(Item item) {
		this.items.add(item);
	}
	
	public int getSize() {
		return this.items.size();
	}
	
	public boolean isEmpty() {
		return this.items.isEmpty();
	}
}
