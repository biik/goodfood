package iClient;

public interface iItem {

	public int getPkid() ;
	public String getName();
	public String getDesc() ;
	public String getPic() ;
	public float getPrice();
	public int getPkidLable();
	
	public void setPkid(int pkid) ;
	public void setName(String name);
	public void setDesc(String desc) ;
	public void setPic(String pic) ;
	public void setPrice(float price);
	public void setPkidLable(int pkidL);
}
