package com.sce.service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sce.DB.DBConnection;
import com.sce.DB.SingeltonDB;

public class Menu {
	private int pkIdRest;
	private List<Label> labels;

	public Menu(int pkIdRest) {
		this.pkIdRest = pkIdRest;
		DBConnection sdb = SingeltonDB.getDbCon();
		ResultSet resultSet = null;

		Map<String, Label> dictionary = new HashMap<String, Label>();
		
		try {
			String sqlQuerie = "SELECT COUNT(PKId) AS result FROM rest_labels WHERE pkidRest = ?";
			resultSet = sdb.PQuery(sqlQuerie, pkIdRest);
			resultSet.next();

			if(resultSet.getInt("result") > 0 ) {
				sqlQuerie = "SELECT menuitem.PKId, menu_label, ItemName, price, description, ItemPhoto FROM menuitem, rest_labels"
						+ " WHERE menuitem.pkidLabel = rest_labels.PKId AND menuitem.pkidRest = ?";
				resultSet = sdb.PQuery(sqlQuerie, pkIdRest);
				
				while(resultSet.next()) {
					String labelName = resultSet.getString("menu_label");
					
					if(dictionary.containsKey(labelName)) {
						dictionary.get(labelName).addItems(new Item(
								resultSet.getInt("PKId"),
								resultSet.getFloat("price"),
								resultSet.getString("itemName"),
								resultSet.getString("ItemPhoto"),
								resultSet.getString("description")));
					} else {
						Label label = new Label(labelName);
						label.addItems(new Item(
								resultSet.getInt("PKId"),
								resultSet.getFloat("price"),
								resultSet.getString("itemName"),
								resultSet.getString("ItemPhoto"),
								resultSet.getString("description")));
						dictionary.put(labelName, label);
					}
				}
				this.labels = new ArrayList<Label>(dictionary.values());
			} else {
				this.labels = null;
			}
		
		} catch (SQLException e) {
			this.labels = null;
			e.printStackTrace();
		}
	}

	public int getPkIdRest() {
		return this.pkIdRest;
	}

	public void setPkIdRest(int pkIdRest) {
		this.pkIdRest = pkIdRest;
	}

	public List<Label> getLabels() {
		return this.labels;
	}
	
	public void setLabels(List<Label> labels) {
		this.labels = labels;
	}
	
	public Label getLabel(int i) {
		return this.labels.get(i);
	}
	
	public void setLabel(Label label) {
		this.labels.add(label);
	}
	
	public Label getItem(int i) {
		return this.labels.get(i);
	}
	
	public void setItem(Label label) {
		this.labels.add(label);
	}
	
	public int getSize() {
		return this.labels.size();
	}
	
	public boolean isEmpty() {
		if(this.labels == null)
			return true;
		return this.labels.isEmpty();
	}
}
