package com.sce.servlets;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sce.service.Cart;
import com.sce.service.Item;

@WebServlet("/Ordering")
public class Ordering extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Ordering() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    HttpSession session = request.getSession(true);
	    Cart cart = (Cart)session.getAttribute("cart");
	    
	    try {
		    if(cart != null) {
		    	Map<Item, Integer> items = cart.getItemsData();
		    	session.setAttribute("items", items);
		    	session.setAttribute("restaurant", cart.getPkidRest());
				request.getRequestDispatcher("/ordering.jsp").forward(request, response);
				return;
		    } else {
				request.getRequestDispatcher("/MenuRestarant.jsp").forward(request, response);
				return;
		    }
	    } catch (Exception e) {
			request.getRequestDispatcher("/MenuRestarant.jsp").forward(request, response);
			return;
	    }
	}

}
