package com.sce.servlets;

import iClient.iLable;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import client.SqlSaveToDB;
import client.SqlUpdtaeDB;

/**
 * Servlet implementation class CategoryHandler
 */
@WebServlet("/handleCategory")
public class CategoryHandler extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CategoryHandler() {
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
		try {
			boolean isNew = (boolean) session.getAttribute("isNewL");
			if (isNew) {
				int restPkid = (int) session.getAttribute("restPkid");
				result = SqlSaveToDB.svaeNewLable(request.getParameter("Name"),
						restPkid);
				if (result != 1) {
					request.setAttribute("sql_er", -1);
					return;
				} else {
					request.setAttribute("lblSave", 1);
				}
				request.getRequestDispatcher("/ClientsPage.jsp").forward(
						request, response);
			} else if (!isNew) {
				iLable lable = (iLable) session.getAttribute("cLable");
				lable.setLable(request.getParameter("Name"));
				result = SqlUpdtaeDB.updateLable(lable);
				if (result != 1) {
					request.setAttribute("sql_er", -1);
					return;
				} else {
					request.setAttribute("lblSave", 1);
				}
				request.getRequestDispatcher("/ClientsPage.jsp").forward(
						request, response);
				return;
			} else {
				request.getRequestDispatcher("/index.jsp").forward(request,
						response);
				return;
			}
		} catch (IOException e) {
			e.printStackTrace();
			request.getRequestDispatcher("/index.jsp").forward(request,
					response);

		} catch (NullPointerException e) {
			e.printStackTrace();
			request.getRequestDispatcher("/index.jsp").forward(request,
					response);
		}

	}
}
