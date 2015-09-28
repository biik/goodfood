<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="Good Food" />
<link rel="stylesheet" type="text/css" href="styles/style.css" />

<link href="templatemo_style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="styles/styles2.css" />

<script type="text/javascript" src="javascript.js"></script>

<title>Good Foods</title>

</head>
<body>
<div id="templatemo_body_wrapper">
	<div id="templatemo_wrapper">
	
		<div id="templatemo_header">
					<jsp:directive.include file="header.jsp" />
				<div class="cleaner"></div>
		</div>
			
		<div id="templatemo_main">
				
			<table width="900" border="0" align="center" cellpadding="0" cellspacing="0">			
				<tr>
					<td colspan="2" style="text-align: center">
					<!-- Body -->
						<jsp:directive.page import="com.sce.service.RestaurantsSet" />
						<jsp:directive.page import="com.sce.service.Restaurant" />
						<table border="0" width="100%" align="center" cellpadding="0" cellspacing="1">
		<jsp:scriptlet>
		<![CDATA[
			boolean flagErrorCategory = false;
			String categoryParameter = request.getParameter("id");
			
			if(categoryParameter != null) {
				if(categoryParameter.equals("0") || categoryParameter.equals("1") || categoryParameter.equals("2") || categoryParameter.equals("3")) {
					int category = Integer.parseInt(categoryParameter);
					RestaurantsSet restaurantsSet = new RestaurantsSet(category);
					if(!restaurantsSet.isEmpty()) {
		
						for(int i = 0; i < restaurantsSet.getLengh(); i++) {
							Restaurant restaurant = restaurantsSet.getRestaurant(i);
		]]>
		</jsp:scriptlet>
							<tr>
								<td width="50%" class="separationtop">
									<a href="MenuRestaurant.jsp?id=<%=restaurant.getPkidRest()%>"><img border="0" width="230" height="150" src="images/<%=restaurant.getPicRef()%>" alt="<%=restaurant.getResturantName()%>" /></a>
								</td> 
								<td width="50%" class="separationtop">
		                           	<table align="center">
		                           		<tr>
		                           			<td colspan="2">
		                           				<!-- Restaurant Name -->
		                           				<h3><%=restaurant.getResturantName()%></h3>
		                           			</td>
		                           		</tr>
		                           		<tr>
		                           			<td colspan="2">
		                           				<!-- Restaurant description -->
												<span><%=restaurant.getDescription()%></span>
											</td>
										</tr>
										<tr>
											<td>Opening Hours:</td>
											<td><%=restaurant.getOpeningHours()%></td>
										</tr>
										<tr>
											<td>Address:</td>
											<td><%=restaurant.getAddress()%></td>
										</tr>
										<tr>
											<td>Phone Number:</td>
											<td><%=restaurant.getPhoneNumber()%></td>
										</tr>
									</table>
								</td> 
							</tr>
		<jsp:scriptlet>
						}
					} else {
						flagErrorCategory = true;
					}
				} else {
					flagErrorCategory = true;
				}
			} else {
				flagErrorCategory = true;
			}
			
			if(flagErrorCategory == true) {
		</jsp:scriptlet>
							<tr>
								<td width="100%" colspan="2" class="separationtop">
									<br />Sorry, we still do not have restaurants in this category, please select other category in <a href="index.jsp">main page</a>.
								</td>
							</tr>
		<jsp:scriptlet>
			}
		</jsp:scriptlet>
							<tr>
								<td width="100%" colspan="2" class="separationtop">&nbsp;</td>
							</tr>
						</table>
		            </td>
		        </tr>
			</table>
			
		<div class="cleaner"></div>
		</div> <!-- END of templatemo_main -->
		
		<div id="templatemo_footer">
			<jsp:directive.include file="footer.jsp" />
			<%-- <jsp:directive.include file="printSessionData.jsp" /> --%>
		</div> <!-- END of templatemo_footer -->
		
	</div> <!-- END of templatemo_wrapper -->
</div> <!-- END of templatemo_body_wrapper -->
	
</body>
</html>