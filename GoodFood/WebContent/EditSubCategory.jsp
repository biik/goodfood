<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@page import="iClient.iMenu"%>
<%@page import="iClient.iRestaurant"%>
<%@page import="iClient.iLable"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="Good Food" />

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
				<%
					iRestaurant restaurant = (iRestaurant) session
							.getAttribute("restaurant");
					if (restaurant == null) {
						request.getRequestDispatcher("/ClientsPage.jsp").forward(
								request, response);
						return;
					}
					iMenu menu = restaurant.getMenu();
					iLable choosenLable = null;
					String lableIndexS = (String)request.getParameter("lableIndex");
					int lableIndex_Server = -1;
					if (lableIndexS != null) {
						try {
							lableIndex_Server = Integer.parseInt(lableIndexS);
							if (lableIndex_Server >= 0) {
								choosenLable = menu.getLables().get(lableIndex_Server);
								session.setAttribute("cLable", choosenLable);
				%>
				<form action="handleCategory" method="post" name="edit"
					onsubmit="return isValid()">
					<h3>Edit Category:</h3>
					<hr />
					<span id="lbl_name">Category Name:</span> <input type="text"
						name="Name" id="txtName" style="width: 100%" size="40"
						value="<%=choosenLable.getLable()%>" /> <br /> <input
						type="submit" class="myButton" name="Submit" value="Submit"
						id="btnSubmit" /> &nbsp;<input type="submit" class="myButton"
						name="Cancel" value="Cancel" id="btnCancel"
						onclick="history.go(-1);return true;" />
				</form>
				<%
					}
						} catch (NumberFormatException e) {
							e.printStackTrace();
							request.getRequestDispatcher("/ClientsPage.jsp").forward(
									request, response);
							return;
						}
					}
				%>

				<div class="cleaner"></div>
			</div>
			<!-- END of templatemo_main -->

			<div id="templatemo_footer">
				<jsp:directive.include file="footer.jsp" />
				<%-- <jsp:directive.include file="printSessionData.jsp" /> --%>
			</div>
			<!-- END of templatemo_footer -->

		</div>
		<!-- END of templatemo_wrapper -->
	</div>
	<!-- END of templatemo_body_wrapper -->
	<script>
function isValid() {
	var x = document.forms["edit"]["Name"].value;
	if (x == null || x == "") {
		alert("A valid name must be filled out");
		return false;
	}
	'<%session.setAttribute("isNewL", false);%>'
			return true;
		}
	</script>
</body>
</html>