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
			<!-- Body -->
			<jsp:scriptlet>
			Integer sqlResult = (Integer)request.getAttribute("sqlResult");
			if (sqlResult != null) {
			</jsp:scriptlet>
	            <table border="0" align="center" cellpadding="0" cellspacing="0">
	                <tr>
	                    <td>
						<ul id="summaryError" class="er">
						<jsp:scriptlet>if(request.getAttribute("firstName_er") != null){</jsp:scriptlet>
							<li>The field First Name cannot be empty</li>
						<jsp:scriptlet>} if(request.getAttribute("lastName_er") != null){</jsp:scriptlet>
							<li>The field Last Name cannot be empty</li>
						<jsp:scriptlet>} if(request.getAttribute("email_er") != null){</jsp:scriptlet>
							<li>The field Email cannot be empty</li>
						<jsp:scriptlet>} if(request.getAttribute("city_er") != null){</jsp:scriptlet>
							<li>The field City cannot be empty</li>
						<jsp:scriptlet>} if(request.getAttribute("street_er") != null){</jsp:scriptlet>
							<li>The field Street cannot be empty</li>
						<jsp:scriptlet>} if(request.getAttribute("homeNumberParser_er") != null){</jsp:scriptlet>
							<li>Home Number can contain only numbers</li>
						<jsp:scriptlet>} if(request.getAttribute("buildingParser_er") != null){</jsp:scriptlet>
							<li>Building can contain only numbers</li>
						<jsp:scriptlet>} if(request.getAttribute("phoneNumberParser_er") != null){</jsp:scriptlet>
							<li>Phone Number can contain only numbers</li>
						<jsp:scriptlet>} if(request.getAttribute("emailvalidate_er") != null){</jsp:scriptlet>
							<li>Email is not validated</li>
						<jsp:scriptlet>} if(request.getAttribute("sql_er") != null){</jsp:scriptlet>
							<li>SQL DataBase error! Please try again later</li>
						<jsp:scriptlet>}</jsp:scriptlet>
			          	</ul>
	          			</td>
	          		</tr>
	          	</table>
			<jsp:scriptlet>}</jsp:scriptlet>
            <form id="ordering" action="SendOrder" method="post">
	            <table border="0" align="center" cellpadding="0" cellspacing="1">
	                <tr>
	                    <td>City</td>
	                    <td>
	                    	<input type="text" id="city" name="city" size="20" />
	                    	<jsp:scriptlet>if(request.getAttribute("city_er") != null){</jsp:scriptlet>
		                   	<span class="er">*</span>
							<jsp:scriptlet>}</jsp:scriptlet>
						</td>
	                </tr>
	                <tr>
	                    <td>Street</td>
						<td>
							<input type="text" id="street" name="street" size="20" />
		                   	<jsp:scriptlet>if(request.getAttribute("street_er") != null){</jsp:scriptlet>
		                   	<span class="er">*</span>
							<jsp:scriptlet>}</jsp:scriptlet>
						</td>
	                </tr>
	                <tr>
	                    <td>Home Number</td>
	                    <td>
	                    	<input type="text" id="homeNumber" name="homeNumber" size="20" />
		                   	<jsp:scriptlet>if(request.getAttribute("homeNumber_er") != null){</jsp:scriptlet>
		                   	<span class="er">*</span>
							<jsp:scriptlet>}</jsp:scriptlet>
						</td>
	                </tr>
					<tr>
	                    <td>Building</td>
	                    <td><input type="text" id="building" name="building" size="20" /></td>
	                </tr>
					<tr>
	                    <td>Notes to address</td>
	                    <td><textarea id="notesToAddress" name="notesToAddress" cols="40" rows="3"></textarea></td>
	                </tr>
	                <tr>
	                    <td colspan="2"><hr /></td>
	                </tr>
					<tr>
	                    <td>First Name</td>
	                    <td>
		                    <input type="text" id="firstName" name="firstName" size="20" />
		                    <jsp:scriptlet>if(request.getAttribute("firstName_er") != null){</jsp:scriptlet>
		                   	<span class="er">*</span>
							<jsp:scriptlet>}</jsp:scriptlet>
	                    </td>
	                </tr>
	                <tr>
	                    <td>Last Name</td>
	                    <td>
		                    <input type="text" id="lastName" name="lastName" size="20" />
		                    <jsp:scriptlet>if(request.getAttribute("lastName_er") != null){</jsp:scriptlet>
	                    	<span class="er">*</span>
							<jsp:scriptlet>}</jsp:scriptlet>
	                    </td>
	                </tr>
	                <tr>
	                    <td>E-mail address</td>
	                    <td>
	                    	<input type="text" id="email" name="email" size="20" />
	                    	<jsp:scriptlet>if(request.getAttribute("email_er") != null || request.getAttribute("emailvalidate_er") != null){</jsp:scriptlet>
	                    	<span class="er">*</span>
							<jsp:scriptlet>}</jsp:scriptlet>
	                    </td>
	                </tr>
	                <tr>
	                    <td>Phone Number</td>
	                    <td>
	                    	<input type="text" id="phoneNumber" name="phoneNumber" size="20" />
		                    <jsp:scriptlet>if(request.getAttribute("phoneNumber_er") != null){</jsp:scriptlet>
	                    	<span class="er">*</span>
							<jsp:scriptlet>}</jsp:scriptlet>
	                    </td>
	                </tr>
					<tr>
	                    <td colspan="2"><hr /></td>
	                </tr>
	                <tr>
	                    <td colspan="2" align="center">
                            <input type="submit" name="sendorder" value="Send Order" class="buttonSub" />
                            <input type="reset" value="Reset" class="buttonSub" />
	                    </td>
	                </tr>
	            </table>
            </form>
			<jsp:scriptlet>
	    	Account account = (Account)session.getAttribute("account");
			if (sqlResult != null) {
			</jsp:scriptlet>
				<script type="text/javascript">
	            	var controls = {
	          			"firstName" : "<%=request.getParameter("firstName")%>",
		            	"lastName" : "<%=request.getParameter("lastName")%>",
		            	"city" : "<%=request.getParameter("city")%>",
		            	"notesToAddress" : "<%=request.getParameter("city")%>",
		            	"email" : "<%=request.getParameter("email")%>",
		            	"street" : "<%=request.getParameter("street")%>",
		            	"homeNumber" : "<%=request.getParameter("homeNumber")%>",
		            	"phoneNumber" : "<%=request.getParameter("phoneNumber")%>",
		            	"building" : "<%=request.getParameter("building")%>"
		            	};
	
					SetValue(controls);
	            </script>
			<jsp:scriptlet>
			} else if (account != null) {
		    	if(account.getRoll() == 2) {
		    		User user = (User)account;
			</jsp:scriptlet>
				<script type="text/javascript">
	            	var controls = {
	          			"firstName" : "<%=user.getFirstName()%>",
		            	"lastName" : "<%=user.getLastName()%>",
		            	"city" : "<%=user.getCity()%>",
		            	"email" : "<%=user.getEmail()%>",
		            	"street" : "<%=user.getStreet()%>",
		            	"homeNumber" : "<%=user.getHomeNumber()%>",
		            	"phoneNumber" : "<%=user.getPhoneNumber()%>",
		            	"building" : "<%=user.getBuilding()%>"
		            	};
	
					SetValue(controls);
	            </script>
			<jsp:scriptlet>
		    	}
			}
			</jsp:scriptlet>
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