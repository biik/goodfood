package com.sce.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sce.DB.DBConnection;
import com.sce.DB.SingeltonDB;
import com.sce.service.Cart;

@WebServlet("/CartAdd")
public class CartAdd extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
    public CartAdd() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    response.setHeader("Cache-Control", "no-cache");
	    response.setHeader("Pragma", "no-cache");
	    HttpSession session = request.getSession(true);
	    Cart cart = (Cart)session.getAttribute("cart");
	    
	    PrintWriter out = response.getWriter();
	    String message = "";
	    
		try {
			int pkIdItem = Integer.parseInt(request.getParameter("idi"));
			String op = request.getParameter("op");
			//System.out.println(request.getParameter("idi") + ' ' + request.getParameter("op"));

			//if(pkidRest != cart.getPkidRest()) {
			//	request.getRequestDispatcher("/MenuRestarant.jsp").forward(request, response);
			//	return;
			//}
		    if(cart == null) {
		    	cart = new Cart();
			    DBConnection sdb = SingeltonDB.getDbCon();

				String sqlQuerie = "SELECT pkidRest FROM menuitem WHERE PKId=?";
				ResultSet resultSet;
				resultSet = sdb.PQuery(sqlQuerie, pkIdItem);
				resultSet.next();
				
				int pkidRest = resultSet.getInt("pkidRest");

				cart.setPkidRest(pkidRest);
				session.setAttribute("cart", cart);
		    }
			
			if(op.equals("s")) {
	            cart.addItem(pkIdItem);
	            message = "y" + pkIdItem;
			} else if(op.equals("r")) {
				cart.removeItem(pkIdItem);
				message = "y" + pkIdItem;
			} else {
				message = "n";
			}
        } catch (NumberFormatException e) {
        	message = "n";
        } catch (SQLException e) {
        	message = "n";
			e.printStackTrace();
        } catch (Exception e) {
        	message = "n";
        	e.printStackTrace();
        }
		out.print(message);
	}
}
