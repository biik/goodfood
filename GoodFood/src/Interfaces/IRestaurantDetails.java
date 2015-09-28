package Interfaces;

import java.sql.SQLException;

import com.sce.service.Client;

public interface IRestaurantDetails {

	public Client getClientObject() throws SQLException;
	
	public int getPkID();

	public void setPkID(int pkID);

	public int getClientPkID();

	public void setClientPkID(int clientPkID);

	public String getName();

	public void setName(String name);

	public String getDescription();

	public void setDescription(String description);

	public String getPicRef();

	public void setPicRef(String picRef);
}