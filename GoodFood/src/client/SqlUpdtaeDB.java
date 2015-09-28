package client;

import java.sql.SQLException;

import iClient.iClient;
import iClient.iItem;
import iClient.iLable;
import iClient.iRestaurant;

import com.sce.DB.DBConnection;
import com.sce.DB.SingeltonDB;

public class SqlUpdtaeDB {

	static DBConnection sdb = SingeltonDB.getDbCon();
	static String query = "";
	static int result = -1;

	public static int updateItem(iItem item) {
		query = "UPDATE menuitem SET  pkidLabel = ? ,ItemName = ? ,price = ? ,description = ? ,ItemPhoto = ? WHERE PKId = ?;";
		try {
			result = sdb.PInsert(query, item.getPkidLable(), item.getName(),
					item.getPrice(), item.getDesc(), item.getPic(),
					item.getPkid());
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		}
		return result;
	}

	public static int updateLable(iLable lable) {
		query = "UPDATE rest_labels SET menu_label =? WHERE PKId = ?";
		try {
			result = sdb.PInsert(query, lable.getLable(), lable.getPkid());
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		}
		return result;
	}

	public static int updateRestaurant(iRestaurant restaurant) {
		query = " UPDATE resturant SET resturantName=?,picRef=?,description=?,openingHours=?,address=?,phoneNumber=? WHERE pkidRest = ? AND pkidClient = ?;";
		try {
			result = sdb.PInsert(query, restaurant.getName(),
					restaurant.getPicture(), restaurant.getDescription(),
					restaurant.getOpenHours(), restaurant.getAddress(),
					restaurant.getPhone(), restaurant.getPkid(),
					restaurant.getPkidClient());
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		}
		
		query = "UPDATE rest_categ SET category=? WHERE pkidRest = ?";
		try {
			result = sdb.PInsert(query, restaurant.getCategory(),restaurant.getPkid());
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		}
		return result;
	}

	public static int updateClient(iClient client) {
		query = "UPDATE client SET email = ?,phone = ?,firstName = ?,lastName = ? WHERE pkidClient = ? AND pkidAccount = ?;";
		try {
			result = sdb.PInsert(query, client.getEmail(), client.getPhone(),
					client.getFirstName(), client.getLastName(),
					client.getPkidClient(), client.getPkidAccount());
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		}
		return result;
	}
}



