package iClient;

import java.util.List;

public interface iLable {

	public void setItems(List<iItem> items);
	public String getLable();
	public int getPkid() ;
	public int getPkidRest() ;
	public void setLable(String lable);
	public List<iItem> getItems() ;
}
