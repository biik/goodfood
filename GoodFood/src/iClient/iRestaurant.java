package iClient;

public interface iRestaurant {

	public String getOpenHours() ;
	public int getPkid();
	public int getPkidClient() ;
	public int getCategory();
	public String getPicture() ;
	public String getName() ;
	public String getDescription() ;
	public String getAddress();
	public String getPhone();
	public iMenu getMenu();
	public void setOpenHours(String openHours) ;
	public void setPkid(int pkid) ;
	public void setPkidClient(int pkidClient) ;
	public void setCategory(int category);
	public void setPicture(String picture) ;
	public void setName(String name) ;
	public void setDescription(String description) ;
	public void setAddress(String address) ;
	public void setPhone(String phone) ;
	public void setMenu(iMenu menu) ;
}
