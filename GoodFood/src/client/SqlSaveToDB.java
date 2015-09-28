package client;

import iClient.iRestaurant;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.sce.DB.DBConnection;
import com.sce.DB.SingeltonDB;

public class SqlSaveToDB {

	static DBConnection sdb = SingeltonDB.getDbCon();
	static String query = "";
	static int result = -1;

	public static int svaeNewLable(String lableName, int restPkid) {
		query = "INSERT into rest_labels (pkidRest, menu_label) VALUES(?,?);";
		try {
			result = sdb.PInsert(query, restPkid, lableName);
		} catch (SQLException e) {
			e.printStackTrace();
			return -2; // SQLException
		}
		return result;
	}

	public static int saveNewItem(int restPkid, int labkePkid, String name,
			float price, String desc, String picRef) {
		query = "INSERT into menuitem (pkidRest, pkidLabel, ItemName, price, description, ItemPhoto) VALUES(?,?,?,?,?,?);";
		try {
			result = sdb.PInsert(query, restPkid, labkePkid, name, price, desc,
					picRef);
		} catch (SQLException e) {
			e.printStackTrace();
			return -2; // SQLException
		}
		return result;

	}

	public static int saveNewRestaurant(iRestaurant restaurant) {
		ResultSet rs = null;
		query = "INSERT INTO resturant (pkidClient,resturantName,picRef,description,openingHours,address,phoneNumber) VALUES(?,?,?,?,?,?,?);";
		try {
			result = sdb.PInsert(query, restaurant.getPkidClient(),
					restaurant.getName(), restaurant.getPicture(),
					restaurant.getDescription(), restaurant.getOpenHours(),
					restaurant.getAddress(), restaurant.getPhone());
			query = "SELECT pkidRest FROM `resturant` WHERE pkidClient = ?;";
			if (result > 0) {
				rs = sdb.PQuery(query, restaurant.getPkidClient());
				rs.next();
				query = "INSERT INTO rest_categ(pkidRest,category) VALUES(?,?);";
				if (result > 0) {
					result = sdb.PInsert(query, rs.getInt("pkidRest"),
							restaurant.getCategory());
					return result;
				}
				return -1;
			} else {
				return -1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return -2; // SQLException
		}
	}
}
