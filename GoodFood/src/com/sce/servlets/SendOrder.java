package com.sce.servlets;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sce.DB.DBConnection;
import com.sce.DB.SingeltonDB;
import com.sce.service.Account;
import com.sce.service.Item;
import com.sce.service.SendMail;
import com.sce.service.User;

@WebServlet("/SendOrder")
public class SendOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String EMAIL_PATTERN = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
	final String separator = System.getProperty("line.separator");
	final SimpleDateFormat format = new SimpleDateFormat("dd.MM.yyyy hh:mm");

    public SendOrder() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] fields = {"city", "street", "homeNumber", "firstName", "lastName", "phoneNumber", "email"};
		
		if (request.getParameter("sendorder") != null) {
			request.setAttribute("sqlResult", 1);
			
			String city = request.getParameter("city");
			String street = request.getParameter("street");
			String homeNumber = request.getParameter("homeNumber");
			String firstName = request.getParameter("firstName");
			String lastName = request.getParameter("lastName");
			String userEmail = request.getParameter("email");
			String phoneNumber = request.getParameter("phoneNumber");
			
			boolean flag = false;
			for (String field : fields) {
				if(request.getParameter(field) == null || request.getParameter(field) == "")
				{
					request.setAttribute(field + "_er", 1);
					flag = true;
				}
			}
			
			if (phoneNumber != null) {
				if(!phoneNumber.matches("[0-9]+") || phoneNumber.length() < 9) {
					request.setAttribute("phoneNumber_er", 1);
					flag = true;
				}
			}
			
			if(!Validate(userEmail)) {
				flag = true;
				request.setAttribute("emailvalidate_er", 1);
			}
			
			if(flag) {
				request.getRequestDispatcher("/ordering.jsp").forward(request, response);
				return;
			}
			
			ResultSet resultSet = null;
			HttpSession session = request.getSession(true);
			
			if(session.getAttribute("items") != null && session.getAttribute("cart") != null) {
			
				DBConnection sdb = SingeltonDB.getDbCon();
				
				String sqlQuerie = "SELECT email FROM client, resturant WHERE client.pkidClient=resturant.pkidClient AND resturant.pkidRest=?";
				try {
					Object obj = session.getAttribute("items");
					
					@SuppressWarnings({ "unchecked", "rawtypes" })
					Map<Item, Integer> items = (obj instanceof HashMap) ? (HashMap)obj : null;
			    	Integer pkIdRest = (Integer)session.getAttribute("restaurant");
			    	
					resultSet = sdb.PQuery(sqlQuerie, pkIdRest);
					resultSet.next();
					
					String email = resultSet.getString("email");
					
					float count = 20; // Shipping Cost
					for(Item item : items.keySet()) {
						count += item.getPrice()*items.get(item);
					}
					Integer pkIdUser = null;
					Account account = (Account)session.getAttribute("account");
					if (account != null) {
						if(account.getRoll() == 2) {
							User user = (User)account;
							pkIdUser = user.getPkId();
							
							sqlQuerie = "SELECT pkIdUser FROM user WHERE pkIdAccount=?";
							resultSet = sdb.PQuery(sqlQuerie, pkIdUser);
							resultSet.next();
							pkIdUser = resultSet.getInt("pkIdUser");
						}
					}
									
					sqlQuerie = "INSERT INTO orders (resturantpkId, userpkId, ammount) VALUES (?, ?, ?)";
					int result = sdb.PInsert(sqlQuerie, pkIdRest, pkIdUser, count);
					
					if(result > 0) {
						sqlQuerie = "SELECT MAX(idorders) AS id FROM orders WHERE resturantpkId=? AND ammount=?";
						resultSet = sdb.PQuery(sqlQuerie, pkIdRest, count);
						resultSet.next();
						int idOrder = resultSet.getInt("id");
						
						StringBuilder stringBuilder = new StringBuilder();
						
						stringBuilder.append("Hello!");
						stringBuilder.append("This order from GoodFood by number ").append(idOrder).append(separator);
						stringBuilder.append("Date: ").append(format.format(new Date())).append(separator).append(separator);
						stringBuilder.append("To:").append(separator);
						stringBuilder.append("First name: ").append(firstName).append(separator);
						stringBuilder.append("Last name: ").append(lastName).append(separator);
						stringBuilder.append("Phone number: ").append(phoneNumber).append(separator);
						stringBuilder.append("City: ").append(city).append(separator);
						stringBuilder.append("Street: ").append(street).append(separator);
						stringBuilder.append("HomeNumber: ").append(homeNumber).append(separator).append(separator);
						stringBuilder.append("Order:").append(separator);
						
						int i=0;
						for(Item item : items.keySet()) {
							stringBuilder.append("Item ").append(i++).append(": ").append(item.getPkId()).append(" ").append(item.getItemName()).append(separator);
						}
						
						stringBuilder.append("Total price: ").append(count).append(separator);
						stringBuilder.append(separator).append("Thank you!");
						
						SendMail sendMail = new SendMail();
						sendMail.send(email, "New order", stringBuilder.toString());
						sendMail.send(userEmail, "You order", stringBuilder.toString());
						
						request.setAttribute("sqlResultString", "Your order has been handed over to the restaurant, payment is due on a credit card or cash.");
						
						session.removeAttribute("items");
						session.removeAttribute("cart");

						sqlQuerie = "UPDATE user SET points = points + ? WHERE pkIdUser = ?";
						result = sdb.PInsert(sqlQuerie, (int)(count/10), pkIdUser);
						
						request.getRequestDispatcher("/endOperation.jsp").forward(request, response);
						return;
					}
				} catch (SQLException e) {
					request.setAttribute("sql_er", -1);
					e.printStackTrace();
					request.getRequestDispatcher("/ordering.jsp").forward(request, response);
					return;
				}
			}
			request.getRequestDispatcher("/index.jsp").forward(request, response);
			return;
		}
		request.getRequestDispatcher("/ordering.jsp").forward(request, response);
		return;
	}
	
	public boolean Validate(final String hex) {
		Pattern pattern = Pattern.compile(EMAIL_PATTERN);
		Matcher matcher = pattern.matcher(hex);
		return matcher.matches();
 
	}
}
