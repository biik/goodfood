package com.sce.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import client.SqlSaveToDB;

/**
 * Servlet implementation class AddNewCategory
 */
@WebServlet("/addCategory")
public class AddNewCategory extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddNewCategory() {
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
		int restPkid = (int) session.getAttribute("restPkid");
		int result = 0;
		result = SqlSaveToDB.svaeNewLable(request.getParameter("Name"),
				restPkid);
		if (result != 1) {
			request.setAttribute("sql_er", -1);
			return;
		} else {
			request.setAttribute("lblSave", 1);
		}
		request.getRequestDispatcher("/ClientsPage.jsp").forward(request,
				response);
	}

}
