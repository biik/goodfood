package com.sce.servlets;

import iClient.iRestaurant;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;

import client.Restaurant;
import client.SqlSaveToDB;
import client.SqlUpdtaeDB;

/**
 * Servlet implementation class RestaurantHandler
 */
@WebServlet("/handleRestaurant")
public class RestaurantHandler extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static boolean emptyFu;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RestaurantHandler() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		int result = 0;
		String oldPath = null;
		iRestaurant restaurantS = null;
		int isNew = -1;
		try {
			isNew = (int) session.getAttribute("isNewR");
			session.removeAttribute("isNewR");
			System.out.println("isNew:" + isNew);
			if (isNew == 0) {
				restaurantS = (iRestaurant) session.getAttribute("restaurant");
				oldPath = restaurantS.getPicture();
			}
			Map<String, String> dict = new HashMap<String, String>();
			// Check that we have a file upload request
			boolean isMultipart = ServletFileUpload.isMultipartContent(request);
			// Create a factory for disk-based file items
			ServletContext context = getServletContext();
			String fullPath = context.getRealPath("/images");
			if (isMultipart) {
				DiskFileItemFactory factory = new DiskFileItemFactory();

				// Configure a repository (to ensure a secure temp location is
				// used)
				ServletContext servletContext = this.getServletConfig()
						.getServletContext();
				File repository = (File) servletContext
						.getAttribute("javax.servlet.context.tempdir");
				factory.setRepository(repository);

				// Create a new file upload handler
				ServletFileUpload upload = new ServletFileUpload(factory);

				// Parse the request
				try {
					List<FileItem> items = upload
							.parseRequest(new ServletRequestContext(request));
					Iterator<FileItem> iter = items.iterator();
					while (iter.hasNext()) {
						FileItem item = iter.next();

						if (item.isFormField()) {
							if (item.getFieldName() != "Save") {
								dict.put(item.getFieldName(), item.getString());
							}
						} else {
							dict.put(
									"filePath",
									processUploadedFile(item, fullPath,
											oldPath, isNew));
						}
					}
					int clientPkid = restaurantS.getPkidClient();
					String name, picRef, desc, openHours, address, phoneNum, category;
					name = dict.get("Name");
					picRef = dict.get("filePath");
					desc = dict.get("desc");
					address = dict.get("Address");
					openHours = dict.get("openHours");
					phoneNum = dict.get("Phone");
					category = dict.get("Category");
					int cat = Integer.parseInt(category);
					if (isNew == 1) {
						iRestaurant restaurant = new Restaurant(0, clientPkid,
								cat, picRef, name, desc, address, phoneNum,
								openHours, null);
						result = SqlSaveToDB.saveNewRestaurant(restaurant);
					} else {
						restaurantS.setName(name);
						restaurantS.setDescription(desc);
						restaurantS.setOpenHours(openHours);
						restaurantS.setPhone(phoneNum);
						restaurantS.setCategory(cat);
						restaurantS.setAddress(address);
						if (!emptyFu)
							restaurantS.setPicture(picRef);
						result = SqlUpdtaeDB.updateRestaurant(restaurantS);
					}
					if (result != 1) {
						System.out.println("sql err catch");
						request.setAttribute("sql_er", -1);
						request.getRequestDispatcher("/ClientsPage.jsp")
								.forward(request, response);
						return;
					}

					request.setAttribute("saveRes", 1);
					request.getRequestDispatcher("/ClientsPage.jsp").forward(
							request, response);
					return;

				} catch (Exception e) {
					System.out.println("fu catch");
					e.printStackTrace();
					request.setAttribute("FU_er", -1);
					request.getRequestDispatcher("/ClientsPage.jsp").forward(
							request, response);
					return;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("null newR catch");
			request.setAttribute("nul_er", -1);
			request.getRequestDispatcher("/ClientsPage.jsp").forward(request,
					response);
			return;
		}
	}

	private String processUploadedFile(FileItem item, String path,
			String oldPath, int isNew) {
		String filename = FilenameUtils.getName(item.getName()); // Get
																	// filename.
		if (filename == null || filename.isEmpty()) { // its a new file.
			System.out.println("empty fu.");
			return oldPath;
		} else {// has a new file
			System.out.println("full fu");
			String newFilename = FilenameUtils.getName(item.getName()); // Get
			// filename.
			File file = new File(path, newFilename); // Define destination file.
			try {
				item.write(file);
				if (isNew == 0) { // need to delete old file
					File delFile = new File(path + "\\" + oldPath);
					delFile.delete();
				}
				return newFilename;
			} catch (Exception e) {
				e.printStackTrace(); // writing new img fails
				return oldPath;
			}

		}
	}

}
