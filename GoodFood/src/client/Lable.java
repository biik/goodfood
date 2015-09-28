package client;

import iClient.iItem;
import iClient.iLable;

import java.util.List;

public class Lable implements iLable{
	private int pkid, pkidRest;
	private String lable;
	private List<iItem> items;
	
	public Lable(int pkid, int pkidRest, String lable) {
		super();
		this.pkid = pkid;
		this.pkidRest = pkidRest;
		this.lable = lable;
	}
	
	public String getLable() {
		return lable;
	}

	public void setLable(String lable) {
		this.lable = lable;
	}

	public int getPkid() {
		return pkid;
	}
	public void setPkid(int pkid) {
		this.pkid = pkid;
	}
	public int getPkidRest() {
		return pkidRest;
	}
	public void setPkidRest(int pkidRest) {
		this.pkidRest = pkidRest;
	}
	public List<iItem> getItems() {
		return items;
	}
	public void setItems(List<iItem> items) {
		this.items = items;
	}

	@Override
	public String toString() {
		return "Lable [pkid=" + pkid + ", pkidRest=" + pkidRest + ", lable="
				+ lable + ", \nitems=" + items + "]";
	}

}
