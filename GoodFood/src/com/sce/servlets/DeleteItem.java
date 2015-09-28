package com.sce.servlets;

import iClient.iItem;
import iClient.iLable;
import iClient.iMenu;
import iClient.iRestaurant;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import client.SqlDeleteFromDB;

/**
 * Servlet implementation class DeleteItem
 */
@WebServlet("/DeleteItem")
public class DeleteItem extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DeleteItem() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		ServletContext context = getServletContext();
		String fullPath = context.getRealPath("/images");
		try {
			iRestaurant restaurant = (iRestaurant) session
					.getAttribute("restaurant");
			if (restaurant == null) {
				request.getRequestDispatcher("/ClientsPage.jsp").forward(
						request, response);
				return;
			}
			iMenu menu = restaurant.getMenu();
			iLable choosenLable = null;
			String lableIndexS = (String) request.getParameter("lableIndex");
			String itemIndexS = (String) request.getParameter("itemIndex");
			int itemIndex_Server = -1;
			int lableIndex_Server = -1;
			if (lableIndexS != null && itemIndexS != null) {
				try {
					lableIndex_Server = Integer.parseInt(lableIndexS);
					if (lableIndex_Server >= 0) {
						choosenLable = menu.getLables().get(lableIndex_Server);
						session.setAttribute("cLable", choosenLable);
						itemIndex_Server = Integer.parseInt(itemIndexS);
						if (itemIndex_Server >= 0) {
							iItem item = choosenLable.getItems().get(
									itemIndex_Server);
							int res = SqlDeleteFromDB
									.deleteItem(item, fullPath);
							if (res > 1) {
								request.setAttribute("Good", 1);
								request.getRequestDispatcher("/ClientsPage.jsp")
										.forward(request, response);
								return;
							} else {
								request.setAttribute("sqlEr", -1);
								request.getRequestDispatcher("/ClientsPage.jsp")
										.forward(request, response);
								return;
							}
						}
					} else {
						request.setAttribute("indxEr", -1);
						request.getRequestDispatcher("/ClientsPage.jsp")
								.forward(request, response);
						return;
					}
				} catch (Exception e) {
					e.printStackTrace();
					request.getRequestDispatcher("/ClientsPage.jsp").forward(
							request, response);
					return;
				}
			} else {
				request.setAttribute("indxEr", -2);
				request.getRequestDispatcher("/ClientsPage.jsp").forward(
						request, response);
				return;
			}
		} catch (Exception e) {
			request.setAttribute("unk", -1);
			request.getRequestDispatcher("/ClientsPage.jsp").forward(request,
					response);
			return;
		}

	}

}
