package client;

import iClient.iItem;

public class Item implements iItem {
	private int pkid, pkidLable;
	private String name, desc, pic;
	private float price;

	public Item(int pkid, int pkidLable, String name, String desc, String pic,
			float price) {
		super();
		this.pkid = pkid;
		this.pkidLable = pkidLable;
		this.name = name;
		this.desc = desc;
		this.pic = pic;
		this.price = price;
	}

	public int getPkid() {
		return pkid;
	}

	public void setPkid(int pkid) {
		this.pkid = pkid;
	}

	public void setPkidLable(int pkidLable) {
		this.pkidLable = pkidLable;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public String getPic() {
		return pic;
	}

	public void setPic(String pic) {
		this.pic = pic;
	}

	public float getPrice() {
		return price;
	}

	public void setPrice(float price) {
		this.price = price;
	}

	@Override
	public String toString() {
		return "Item [pkid=" + pkid + ", pkidLable=" + pkidLable + ", name="
				+ name + ", desc=" + desc + ", pic=" + pic + ", price=" + price
				+ "]";
	}

	@Override
	public int getPkidLable() {
		return pkidLable;
	}

}
