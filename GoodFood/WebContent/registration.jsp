<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<link rel="stylesheet" type="text/css" href="styles/style.css" />
<link href="templatemo_style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="styles/styles2.css" />
<script type="text/javascript" src="javascript.js"></script>

<title>Registration new user</title>
</head>
<body>
<div id="templatemo_body_wrapper">
	<div id="templatemo_wrapper">
	
		<div id="templatemo_header">
			<table border="0" width="100%">
            	<tr>
                    <td width="680">
                        <img src="images/logo.jpg" width="680" height="140" alt="logo" />
                    </td>
                    <td width="220">
                    	<img src="images/registrationLogo.jpg" width="220" height="140" alt="registrationLogo" />
                    </td>
            	</tr>
            </table>
			<div class="cleaner"></div>
		</div>
			
		<div id="templatemo_main">
			<table width="900" border="0" align="center" cellpadding="0" cellspacing="0">
			    <tr>
			        <td colspan="2">
			        	<!-- Body -->
			<jsp:scriptlet>
			Integer sqlResult = (Integer)request.getAttribute("sqlResult");
			if (sqlResult != null) {
			</jsp:scriptlet>
			            <table border="0" align="center" cellpadding="0" cellspacing="0">
			                <tr>
			                    <td>
								<ul id="summaryError" class="er">
								<jsp:scriptlet>if(request.getAttribute("username_er") != null){</jsp:scriptlet>
									<li>The field UserName cannot be empty</li>
								<jsp:scriptlet>} if(request.getAttribute("password_er") != null){</jsp:scriptlet>
									<li>The field Passwords cannot be empty</li>
								<jsp:scriptlet>} if(request.getAttribute("confirmPassword_er") != null){</jsp:scriptlet>
									<li>The field Confirm password cannot be empty</li>
								<jsp:scriptlet>} if(request.getAttribute("firstName_er") != null){</jsp:scriptlet>
									<li>The field First Name cannot be empty</li>
								<jsp:scriptlet>} if(request.getAttribute("lastName_er") != null){</jsp:scriptlet>
									<li>The field Last Name cannot be empty</li>
								<jsp:scriptlet>} if(request.getAttribute("email_er") != null){</jsp:scriptlet>
									<li>The field Email cannot be empty</li>
								<jsp:scriptlet>} if(request.getAttribute("city_er") != null){</jsp:scriptlet>
									<li>The field City cannot be empty</li>
								<jsp:scriptlet>} if(request.getAttribute("street_er") != null){</jsp:scriptlet>
									<li>The field Street cannot be empty</li>
								<jsp:scriptlet>} if(request.getAttribute("homeNumber_er") != null){</jsp:scriptlet>
									<li>The field Home Number cannot be empty</li>
								<jsp:scriptlet>} if(request.getAttribute("building_er") != null){</jsp:scriptlet>
									<li>The field Building cannot be empty</li>
								<jsp:scriptlet>} if(request.getAttribute("gender_er") != null){</jsp:scriptlet>
									<li>You have check Gender</li>
								<jsp:scriptlet>} if(request.getAttribute("homeNumberParser_er") != null){</jsp:scriptlet>
									<li>Home Number can contain only numbers</li>
								<jsp:scriptlet>} if(request.getAttribute("buildingParser_er") != null){</jsp:scriptlet>
									<li>Building can contain only numbers</li>
								<jsp:scriptlet>} if(request.getAttribute("phoneNumberParser_er") != null){</jsp:scriptlet>
									<li>Phone Number can contain only numbers and not less than 8 numbers</li>
								<jsp:scriptlet>} if(request.getAttribute("confirmPasswordEqual_er") != null){</jsp:scriptlet>
									<li>ConfirmPassword do not match to password</li>
								<jsp:scriptlet>} if(request.getAttribute("emailvalidate_er") != null){</jsp:scriptlet>
									<li>Email is not validated</li>
								<jsp:scriptlet>} if(request.getAttribute("usernameBusy_er") != null){</jsp:scriptlet>
									<li>The Username: <jsp:expression>request.getParameter("username")</jsp:expression> already used</li>
								<jsp:scriptlet>} if(request.getAttribute("sql_er") != null){</jsp:scriptlet>
									<li>SQL DataBase error! Please try again later</li>
								<jsp:scriptlet>}</jsp:scriptlet>
					          	</ul>
			          			</td>
			          		</tr>
			          	</table>
			<jsp:scriptlet>}</jsp:scriptlet>
			            <form id="registration" action="Registration" method="post">
			            <table border="0" align="center" cellpadding="0" cellspacing="0">
			                <tr>
			                    <td>Username</td>
			                    <td>
			                    	<input type="text" size="20" id="username" name="username" />
									<jsp:scriptlet>if(request.getAttribute("username_er") != null){</jsp:scriptlet>
			                    	<span class="er">*</span>
									<jsp:scriptlet>}</jsp:scriptlet>
			                    </td>
			                </tr>
			                <tr>
			                    <td>Password</td>
			                    <td>
			                    	<input type="password" id="password" name="password" size="21" />
			                    	<jsp:scriptlet>if(request.getAttribute("password_er") != null){</jsp:scriptlet>
			                    	<span class="er">*</span>
									<jsp:scriptlet>}</jsp:scriptlet>
			                    </td>
			                </tr>
			                <tr>
			                    <td>Confirm password</td>
			                    <td>
			                    	<input type="password" id="confirmPassword" name="confirmPassword" size="21" />
			                    	<jsp:scriptlet>if(request.getAttribute("confirmPassword_er") != null){</jsp:scriptlet>
			                    	<span class="er">*</span>
									<jsp:scriptlet>}</jsp:scriptlet>
			                    </td>
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
			                    <td>Gender</td>
			                    <td>
			                    	<input type="radio" id="male" name="gender" value="male" /> Male
			                    	<input type="radio" id="female" name="gender" value="female"  /> Female
			                    	<jsp:scriptlet>if(request.getAttribute("gender_er") != null){</jsp:scriptlet>
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
			                    <td>Country</td>
			                    <td><select size="1" name="country"><option value="Israel">Israel</option></select></td>
			                </tr>
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
			                    	<jsp:scriptlet>if(request.getAttribute("homeNumber_er") != null || request.getAttribute("homeNumberParser_er") != null){</jsp:scriptlet>
			                    	<span class="er">*</span>
									<jsp:scriptlet>}</jsp:scriptlet>
			                    </td>
			                </tr>
							<tr>
			                    <td>Building</td>
			                    <td>
			                    	<input type="text" id="building" name="building" size="20" />
			                    	<jsp:scriptlet>if(request.getAttribute("building_er") != null || request.getAttribute("buildingParser_er") != null){</jsp:scriptlet>
			                    	<span class="er">*</span>
									<jsp:scriptlet>}</jsp:scriptlet>
			                    </td>
			                </tr>
			                <tr>
			                    <td>Phone Number</td>
			                    <td>
			                    	<input type="text" id="phoneNumber" name="phoneNumber" size="20" />
			                    	<jsp:scriptlet>if(request.getAttribute("phoneNumberParser_er") != null){</jsp:scriptlet>
			                    	<span class="er">*</span>
									<jsp:scriptlet>}</jsp:scriptlet>
			                    </td>
			                </tr>
			                <tr>
			                    <td>Disclaimers</td>
			                    <td>
			                    	<input type="checkbox" name="disclaimers" size="20" />
			                    	<jsp:scriptlet>if(request.getAttribute("disclaimers_er") != null){</jsp:scriptlet>
			                    	<span class="er">*</span>
									<jsp:scriptlet>}</jsp:scriptlet>
			                    </td>
			                </tr>
			                <tr>
			                    <td colspan="2" align="center">
			                            <input type="submit" class="myButton" name="registration" value="Registration" class="buttonSub" />
			                            <input type="reset" class="myButton" value="Reset" class="buttonSub" />
			                            <input type="button" class="myButton" value="Back" onclick="location.href='index.jsp';"/>
			                    </td>
			                </tr>
			            </table>
			            </form>
			<jsp:scriptlet>
			if (sqlResult != null) {
			</jsp:scriptlet>
						<script type="text/javascript">
			            	var controls = {
			          			"username" : "<%=request.getParameter("username")%>",
			          			"firstName" : "<%=request.getParameter("firstName")%>",
				            	"lastName" : "<%=request.getParameter("lastName")%>",
				            	"email" : "<%=request.getParameter("email")%>",
				            	"city" : "<%=request.getParameter("city")%>",
				            	"street" : "<%=request.getParameter("street")%>",
				            	"homeNumber" : "<%=request.getParameter("homeNumber")%>",
				            	"phoneNumber" : "<%=request.getParameter("phoneNumber")%>",
				            	"building" : "<%=request.getParameter("building")%>"
				            	};
			
							SetValue(controls);
			            	SetRadioChecked("<%= request.getParameter("gender") %>");
			            </script>
			<jsp:scriptlet>
			}
			</jsp:scriptlet>
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