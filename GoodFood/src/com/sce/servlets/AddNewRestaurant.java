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

/**
 * Servlet implementation class AddNewRestaurant
 */
@WebServlet("/addRes")
public class AddNewRestaurant extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddNewRestaurant() {
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
		Map<String, String> dict = new HashMap<String, String>();

		// Check that we have a file upload request
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		// Create a factory for disk-based file items
		ServletContext context = getServletContext();
		String fullPath = context.getRealPath("/images");
		if (isMultipart) {
			DiskFileItemFactory factory = new DiskFileItemFactory();

			// Configure a repository (to ensure a secure temp location is used)
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
						dict.put("filePath",
								processUploadedFile(item, fullPath));
					}
				}
				// pkidClient,resturantName,picRef,description,openingHours,address,phoneNumber
				int clientPkid = (int) session.getAttribute("clientPkid");
				String name, picRef, desc, openHours, address, phoneNum, category;
				name = dict.get("Name");
				picRef = dict.get("filePath");
				desc = dict.get("desc");
				address = dict.get("Address");
				openHours = dict.get("openHours");
				phoneNum = dict.get("phone_Num");
				category = dict.get("Category");
				int cat = Integer.parseInt(category);
				iRestaurant restaurant = new Restaurant(0, clientPkid, cat,
						picRef, name, desc, address, phoneNum, openHours, null);
				int result = SqlSaveToDB.saveNewRestaurant(restaurant);
				if (result != 1) {
					request.setAttribute("sql_er", -1);
					request.getRequestDispatcher("/ClientsPage.jsp").forward(
							request, response);
					return;
				} else {
					request.setAttribute("RESsAVE", 1);
				}
				request.getRequestDispatcher("/ClientsPage.jsp").forward(
						request, response);

			} catch (FileUploadException e) {
				e.printStackTrace();
			}
		}
	}

	private String processUploadedFile(FileItem item, String path) {
		String filename = FilenameUtils.getName(item.getName()); // Get
																	// filename.
		File file = new File(path, filename); // Define destination file.
		try {
			item.write(file);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} // Write to destination file.
		return filename;
	}

}
