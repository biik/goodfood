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
		<table class="style1" align="center">
			<tr>
				<td>
					<!-- Body -->
					<jsp:directive.page import="com.sce.service.OrderSet" />
					<jsp:directive.page import="com.sce.service.Order" />
					<table border="1" cellpadding="1" cellspacing="1" style="border-collapse: collapse">
<jsp:scriptlet><![CDATA[
	boolean flagErrorRest = false;
	String parameter = request.getParameter("id");

	if(parameter != null) {
		int idTable = 0;
	
		if(parameter.equals("0")) {
			try {
				idTable = Integer.parseInt(parameter);
	        } catch (NumberFormatException e) {
	        	flagErrorRest = true;
	        }
		}
		else {
			flagErrorRest = true;
		}
		
		if(!flagErrorRest) {
			switch(idTable) {
				case 0:
]]></jsp:scriptlet>
				<tr>
				<td>&#8470;</td>
				<td>Restaurant</td>
				<td>User Name</td>
				<td>Amount</td>
				<td>Date</td>
			</tr>
<jsp:scriptlet><![CDATA[
				OrderSet orderSet = new OrderSet();
					if(!orderSet.isEmpty()) {
						float sum = 0;
						for(int i = 0; i < orderSet.getSize(); i++) {
							Order order = orderSet.getOrder(i);
							sum += order.getAmmount();
]]></jsp:scriptlet>
	                	<tr>
	                		<td><%=order.getIdorders()%></td>
							<td><%=order.getResturantName()%></td>
							<td><%=order.getFirstName() + ' ' + order.getLastName()%></td>
							<td><%=order.getAmmount()%> &#8362;</td>
							<td><%=order.getFormatDate()%></td>
	                	</tr>
<jsp:scriptlet><![CDATA[
						}
]]></jsp:scriptlet>
	                	<tr>
	                		<td>Total ammount:</td>
							<td colspan="4"><%=sum%> &#8362;</td>
	                	</tr>
<jsp:scriptlet><![CDATA[
					} else {
]]></jsp:scriptlet>
	                	<tr>
	                		<td colspan="5">Empty set of orders</td>
	                	</tr>
<jsp:scriptlet><![CDATA[
					}
				break;
			}
		}
	}
]]></jsp:scriptlet>
					</table>
					<table align="center">
						<tr>
							<td colspan="5"><input type="button" class="myButton" value="Back" onclick="location.href='admin.jsp';"/></td>
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