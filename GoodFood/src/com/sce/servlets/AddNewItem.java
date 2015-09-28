package com.sce.servlets;

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

import client.SqlSaveToDB;

/**
 * Servlet implementation class AddNewItem
 */
@WebServlet("/AddItem")
public class AddNewItem extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddNewItem() {
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
				HttpSession session = request.getSession();
				int restPkid = (int) session.getAttribute("restPkid");
				int lblPkid = (int) session.getAttribute("lblPkid");
				String name, filePath, desc;
				float price = Float.parseFloat(dict.get("Price"));
				name = dict.get("Name");
				filePath = dict.get("filePath");
				desc = dict.get("Description");
				int result = SqlSaveToDB.saveNewItem(restPkid, lblPkid, name,
						price, desc, filePath);
				if (result != 1) {
					request.setAttribute("sql_er", -1);
					return;
				} else {
					request.setAttribute("resSaveSave", 1);
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
