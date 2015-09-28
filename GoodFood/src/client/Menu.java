package client;

import iClient.iLable;
import iClient.iMenu;

import java.util.List;

public class Menu implements iMenu{
	private int pkidRest;
	private List<iLable> lables;
	
	public Menu(int pkidRest, List<iLable> lables) {
		super();
		this.pkidRest = pkidRest;
		this.lables = lables;
	}
	public int getPkidRest() {
		return pkidRest;
	}
	public void setPkidRest(int pkidRest) {
		this.pkidRest = pkidRest;
	}
	public List<iLable> getLables() {
		return lables;
	}
	public void setLables(List<iLable> lables) {
		this.lables = lables;
	}
	@Override
	public String toString() {
		return "Menu [pkidRest=" + pkidRest + ",\nlables=" + lables + "]";
	}

	
}
