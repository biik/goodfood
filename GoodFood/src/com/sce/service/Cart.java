package com.sce.service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import com.sce.DB.DBConnection;
import com.sce.DB.SingeltonDB;

public class Cart {
	Map<Integer, Integer> items;
	int pkidRest;

	public Cart() {
		this.items = new HashMap<Integer, Integer>();
		pkidRest = 0;
	}
	
	public int getPkidRest() {
		return pkidRest;
	}

	public void setPkidRest(int pkidRest) {
		this.pkidRest = pkidRest;
	}
	
	public Map<Integer, Integer> getItems() {
		return items;
	}

	public Map<Item, Integer> getItemsData() {
		DBConnection sdb = SingeltonDB.getDbCon();
		StringBuffer stringBuffer = new StringBuffer();
		Map<Item, Integer> itemsData = new HashMap<Item, Integer>();
		
		try {
			int i = 0;
			for (Integer key : items.keySet()) {
				stringBuffer.append(key);
		        if(i+1 < items.size()){
		        	stringBuffer.append(",");
		        }
		        i++;
			}
			
			String sqlQuerie = "SELECT PKId, ItemName, price, description, ItemPhoto FROM menuitem"
						+ " WHERE PKId IN (" + stringBuffer.toString() + ")";
			
			ResultSet resultSet = sdb.query(sqlQuerie);
				
				
			while(resultSet.next()) {
					
			itemsData.put(new Item(
							resultSet.getInt("PKId"),
							resultSet.getFloat("price"),
							resultSet.getString("itemName"),
							resultSet.getString("ItemPhoto"),
							resultSet.getString("description"))
						, this.items.get(resultSet.getInt("PKId")));
			}
        } catch (SQLException e) {
			e.printStackTrace();
			return null;
        } catch (Exception e) {
        	e.printStackTrace();
        	return null;
        }
		return itemsData;
	}

	public void setItems(Map<Integer, Integer> items) {
		this.items = items;
	}
	
	public String getJavaScriptData() {
		StringBuffer stringBuffer = new StringBuffer();
	    stringBuffer.append("[");
	    int i = 0;
		for (Integer key : items.keySet()) {
			stringBuffer.append("[\"").append(key).append("\",");
			stringBuffer.append(items.get(key)).append("]");
	        if(i+1 < items.size()){
	        	stringBuffer.append(",");
	        }
	        i++;
	    }
		stringBuffer.append("]");
		return stringBuffer.toString();
	}
	
	public int getItem(int i) {
		return this.items.get(i);
	}
	
	public void removeItem(int pkIdItem) {
		if(this.items.containsKey(pkIdItem)) {
			this.items.put(pkIdItem, this.items.get(pkIdItem)-1);
			if(this.items.get(pkIdItem) < 1)
				this.items.remove(pkIdItem);
		}
	}

	public void addItem(int pkIdItem) {
		if(this.items.containsKey(pkIdItem))
			this.items.put(pkIdItem, this.items.get(pkIdItem)+1);
		else
			this.items.put(pkIdItem, 1);
	}
	
	public int getSize() {
		return this.items.size();
	}
	
	public boolean isEmpty() {
		return this.items.isEmpty();
	}
}