package com.sce.service;

public class Item {
	private int pkId;
	private float price;
	private String itemName, itemPhoto, description;
	
	public Item(int pkId, float price, String itemName, String itemPhoto, String description) {
		this.pkId = pkId;
		this.itemName = itemName;
		this.itemPhoto = itemPhoto;
		this.description = description;
		this.price = price;
	}

	public int getPkId() {
		return pkId;
	}

	public void setPkId(int pkId) {
		this.pkId = pkId;
	}

	public float getPrice() {
		return price;
	}

	public void setPrice(float price) {
		this.price = price;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getItemPhoto() {
		return itemPhoto;
	}

	public void setItemPhoto(String itemPhoto) {
		this.itemPhoto = itemPhoto;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Override
    public boolean equals(Object other) {
        if (other == null) {
            return false;
        }
        if (other == this) {
            return true;
        }
        if (!(other instanceof Item)){
            return false;
        }

        return ((Item)other).pkId == this.pkId &&
        		((Item)other).itemName == this.itemName &&
        		((Item)other).itemPhoto.equals(this.itemPhoto) &&
        		((Item)other).description.equals(this.description) &&
        		((Item)other).price == this.price;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + (int) (pkId ^ (pkId >>> 32));
        return result;
    }
}
