package com.sce.servlets;

import iClient.iItem;

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
import client.SqlUpdtaeDB;

/**
 * Servlet implementation class ItemHandler
 */
@WebServlet("/handleItem")
public class ItemHandler extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static boolean emptyFu;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ItemHandler() {
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
		iItem itemS = null;
		int isNew = -1;
		try {
			isNew = (int) session.getAttribute("isNewI");
			session.removeAttribute("isNewI");
			session.removeAttribute("emptyFU");
			if (isNew == 0) {
				itemS = (iItem) session.getAttribute("cItem");
				oldPath = itemS.getPic();
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
							dict.put(item.getFieldName(), item.getString());
						} else {
							dict.put("filePath",processUploadedFile(item, fullPath,oldPath,isNew));
						}
					}
					int restPkid = (int) session.getAttribute("restPkid");
					int lblPkid = (int) session.getAttribute("lblPkid");
					String name, filePath, desc;
					float price = Float.parseFloat(dict.get("Price"));
					name = dict.get("Name");
					filePath = dict.get("filePath");
					desc = dict.get("desc");
					if (isNew == 1) {
						result = SqlSaveToDB.saveNewItem(restPkid, lblPkid,
								name, price, desc, filePath);
					} else {
						System.out.println("befor:" + itemS);
						if (!emptyFu)
							itemS.setPic(filePath);
						itemS.setName(name);
						itemS.setDesc(desc);
						itemS.setPrice(price);
						System.out.println("after:" + itemS);
						result = SqlUpdtaeDB.updateItem(itemS);
					}
					if (result != 1) {
						System.out.println("1");
						request.setAttribute("sql_er", -1);
						request.getRequestDispatcher("/ClientsPage.jsp")
								.forward(request, response);
						return;
					} else {
						System.out.println("2");
						request.setAttribute("saveItem", 1);
						request.getRequestDispatcher("/ClientsPage.jsp")
								.forward(request, response);
						return;
					}
				} catch (FileUploadException e) {
					System.out.println("3");
					e.printStackTrace();
					request.setAttribute("FU_er", -1);
					request.getRequestDispatcher("/ClientsPage.jsp").forward(
							request, response);
					return;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("4");
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
			emptyFu = true;
			return oldPath;
		} else {// has a new file
			System.out.println("full fu");
			emptyFu = false;
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
