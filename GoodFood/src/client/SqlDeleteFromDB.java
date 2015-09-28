package client;

import java.io.File;
import java.sql.SQLException;

import iClient.iItem;

import com.sce.DB.DBConnection;
import com.sce.DB.SingeltonDB;

public class SqlDeleteFromDB {

	static DBConnection sdb = SingeltonDB.getDbCon();
	static String query = "";
	static int result = -1;

	public static int deleteItem(iItem item, String path) {
		query = "DELETE FROM menuitem WHERE PKId=?;";
		try {
			result = sdb.PInsert(query, item.getPkid());
			File pic = new File(path, item.getPic());
			if (pic.delete())
				return result + 1;
			return result - 1;
		} catch (SQLException e) {
			e.printStackTrace();
			return -2;
		}

	}
}