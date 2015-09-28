package client;

import iClient.iItem;
import iClient.iLable;
import iClient.iMenu;
import iClient.iRestaurant;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.sce.DB.DBConnection;
import com.sce.DB.SingeltonDB;

public class SqlBulider {
	static DBConnection sdb = SingeltonDB.getDbCon();
	static String query = "";
	static ResultSet rs = null;

	public static iItem generateItem(int itemPkid, int lablePkid) {
		query = "SELECT * FROM menuitem WHERE pkid = ? AND pkidLabel = ?";
		try {
			rs = sdb.PQuery(query, itemPkid, lablePkid);
			rs.next();
			iItem item = new Item(itemPkid, lablePkid,
					rs.getString("ItemName"), rs.getString("description"),
					rs.getString("ItemPhoto"), rs.getFloat("price"));
			return item;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	public static iLable generateLable(int lablePkid) {
		query = "SELECT * FROM rest_labels WHERE pkid = ?";
		try {
			rs = sdb.PQuery(query, lablePkid);
			rs.next();
			iLable lable = new Lable(lablePkid, rs.getInt("pkidRest"),
					rs.getString("menu_label"));
			query = "SELECT * FROM menuitem WHERE pkidLabel = ? ";
			rs = sdb.PQuery(query, lablePkid);
			ArrayList<iItem> items = new ArrayList<iItem>();
			while (rs.next()) {
				items.add(new Item(rs.getInt("pkid"), lablePkid, rs
						.getString("ItemName"), rs.getString("description"), rs
						.getString("ItemPhoto"), rs.getFloat("price")));
			}
			lable.setItems(items);
			return lable;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	public static iMenu generateMenu(int restaurntPkid) {
		query = "SELECT pkid FROM rest_labels WHERE pkidRest = ?";
		try {
			rs = sdb.PQuery(query, restaurntPkid);
			ArrayList<Integer> lablesPkid = new ArrayList<Integer>();
			ArrayList<iLable> lables = new ArrayList<iLable>();
			while (rs.next()) {
				lablesPkid.add(rs.getInt("pkid"));
			}
			for (Integer lablePkid : lablesPkid) {
				lables.add(generateLable(lablePkid));
			}
			iMenu menu = new Menu(restaurntPkid, lables);
			return menu;

		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * Create and returns an iRestaurant object from the DB.
	 * 
	 * @param restaurntPkid
	 *            - pkid for selecting data from DB.
	 * @param isClientPkid
	 *            - true if the pkid parameter is the Client pkid and not the
	 *            restaurant.
	 * @return iRestaurnt object.
	 */
	public static iRestaurant generateRestaurant(int restaurntPkid,
			boolean isClientPkid) {
		if (!isClientPkid)
			query = "SELECT * FROM resturant WHERE pkidRest =?;";
		else
			query = "SELECT * FROM resturant WHERE pkidClient =?;";
		int pkidRest, pkidClient, category;
		String picture, name, description, address, phone, openHours;
		try {
			rs = sdb.PQuery(query, restaurntPkid);
			rs.next();
			pkidRest = rs.getInt("pkidRest");
			pkidClient = rs.getInt("pkidClient");
			name = rs.getString("resturantName");
			description = rs.getString("description");
			picture = rs.getString("picRef");
			openHours = rs.getString("openingHours");
			address = rs.getString("address");
			phone = rs.getString("phoneNumber");

			query = "SELECT category FROM rest_categ WHERE pkidRest = ?";
			rs = sdb.PQuery(query, pkidRest);
			rs.next();
			category = rs.getInt("category");
			iMenu menu = generateMenu(pkidRest);
			iRestaurant restaurnt = new Restaurant(pkidRest, pkidClient,
					category, picture, name, description, address, phone,
					openHours, menu);
			return restaurnt;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
}
