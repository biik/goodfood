<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
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
				
			<table class="style1" align="center">
				<tr>
					<!-- Body -->
					<td colspan="1">
							<div class="img">
								 <a href="CategoryPage.jsp?id=0"><img src="images/Basar.jpg" alt="meat" width="400px" height="200px"/></a>
							</div>
					</td>
					<td colspan="2">
						  <span id="lblBasar">Meat</span>
					</td>
			   </tr>
			   <tr>
						<td colspan="1">
							<div class="img">
								 <a href="CategoryPage.jsp?id=1"><img src="images/Halavi.jpg" alt="dairy" width="400px" height="200px"/></a>
							</div>
						</td>
						<td colspan="2">
							<span id="lblHalavi">Dairy</span>
						</td>
			   </tr>
			   <tr>
						<td colspan="1">
							<div class="img">
								<a href="CategoryPage.jsp?id=2"><img src="images/Bait.jpg" alt="home-made" width="400px" height="200px"/></a>
							</div>
						</td>
						<td colspan="2">
							<span id="lblBait">Home-made food</span>
						</td>
			   </tr>
			   <tr>
						<td colspan="1">
							<div class="img">
								 <a href="CategoryPage.jsp?id=3"><img src="images/Dagim.jpg" alt="fish" width="400px" height="200px"/></a>
							</div>
						</td>
						<td colspan="2">
						   <span id="lblDagim">Fishes</span>
						</td>
				</tr>
			</table>
			<a href="./admin/newaccount.jsp">newaccount</a>
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