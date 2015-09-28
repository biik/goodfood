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
<script type="text/javascript">
	function visableItems(index) {
		if(document.getElementById("data"+index).style.display == "block")
			document.getElementById("data"+index).style.display = "none";
		else
			document.getElementById("data"+index).style.display = "block";
	}
</script>
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
					<table class="style1" align="center">
	                	<tr>
	                		<td width="1%" valign="top">&nbsp;</td>
	                		<td>
					<jsp:scriptlet>
						Integer sqlResult = (Integer)request.getAttribute("sqlResult");
						if (sqlResult != null) {
					</jsp:scriptlet>
					            <table class="style0" align="center">
					                <tr>
					                    <td>
										<ul id="summaryError" class="er">
										<jsp:scriptlet>if(request.getAttribute("cUsername_er") != null || request.getAttribute("aUsername_er") != null || request.getAttribute("eUsername_er") != null){</jsp:scriptlet>
											<li>The field UserName cannot be empty</li>
										<jsp:scriptlet>} if(request.getAttribute("cPassword_er") != null || request.getAttribute("aPassword_er") != null){</jsp:scriptlet>
											<li>The field Passwords cannot be empty</li>
										<jsp:scriptlet>} if(request.getAttribute("cConfirmPassword_er") != null || request.getAttribute("aConfirmPassword_er") != null){</jsp:scriptlet>
											<li>The field Confirm password cannot be empty</li>
										<jsp:scriptlet>} if(request.getAttribute("cEmail_er") != null || request.getAttribute("aEmail_er") != null || request.getAttribute("eEmail_er") != null){</jsp:scriptlet>
											<li>The field Email cannot be empty</li>
										<jsp:scriptlet>} if(request.getAttribute("cPhoneNumberParser_er") != null){</jsp:scriptlet>
											<li>Phone Number can contain only numbers and not less than 8 numbers</li>
										<jsp:scriptlet>} if(request.getAttribute("cConfirmPasswordEqual_er") != null || request.getAttribute("aConfirmPasswordEqual_er") != null || request.getAttribute("eConfirmPasswordEqual_er") != null){</jsp:scriptlet>
											<li>ConfirmPassword do not match to password</li>
										<jsp:scriptlet>} if(request.getAttribute("cEmailvalidate_er") != null || request.getAttribute("aEmailvalidate_er") != null || request.getAttribute("eEmailvalidate_er") != null){</jsp:scriptlet>
											<li>Email is not validated</li>
										<jsp:scriptlet>} if(request.getAttribute("aFirstName_er") != null || request.getAttribute("eFirstName_er") != null){</jsp:scriptlet>
											<li>The field First Name cannot be empty</li>
										<jsp:scriptlet>} if(request.getAttribute("aLastName_er") != null || request.getAttribute("eLastName_er") != null){</jsp:scriptlet>
											<li>The field Last Name cannot be empty</li>
										<jsp:scriptlet>} if(request.getAttribute("aUsernameBusy_er") != null || request.getAttribute("cUsernameBusy_er") != null || request.getAttribute("eUsernameBusy_er") != null){</jsp:scriptlet>
											<li>The Username: <jsp:expression>request.getParameter("username")</jsp:expression> already used</li>

										<jsp:scriptlet>} if(request.getAttribute("bUserDoesNotExist_er") != null){</jsp:scriptlet>
											<li>This user does not exist</li>
										<jsp:scriptlet>} if(request.getAttribute("bUserBlocked_er") != null){</jsp:scriptlet>
											<li>This user already blocked</li>
										<jsp:scriptlet>} if(request.getAttribute("bIdAccount_er") != null){</jsp:scriptlet>
											<li>The id Account can contain only numbers</li>

										<jsp:scriptlet>} if(request.getAttribute("sql_er") != null){</jsp:scriptlet>
											<li>SQL DataBase error! Please try again later</li>
										<jsp:scriptlet>}</jsp:scriptlet>
							          	</ul>
							          	
							          	<jsp:scriptlet>if(request.getAttribute("registrationSuccessful") != null){</jsp:scriptlet>
							          	<ul class="ok"><li><jsp:expression>(String)request.getAttribute("registrationSuccessful")</jsp:expression></li></ul>
							          	<jsp:scriptlet>}</jsp:scriptlet>
					          			</td>
					          		</tr>
					          	</table>
					<jsp:scriptlet>} else {</jsp:scriptlet>
					&nbsp;
					<jsp:scriptlet>}</jsp:scriptlet>
							</td>
						</tr>
						<tr>
							<td width="1%" valign="top"><span id="element0" class="click" onclick="visableItems(0);">+</span></td>
							<td>
		                        <form id="registrationClient" action="Admin" method="post">
		                            <table border="0" align="center" cellpadding="1" cellspacing="1">
		                            	<caption style="font-weight: bold; width: 200px;">Register restaurant owner</caption>
		                            	<tbody id="data0" style="display: block;">
		                                <tr>
		                                    <td>Username</td>
		                                    <td>
		                                        <input type="text" size="20" id="cUsername" name="username"  />
		                                        <jsp:scriptlet>if(request.getAttribute("cUsername_er") != null){</jsp:scriptlet>
		                                        <span class="er">*</span>
		                                        <jsp:scriptlet>}</jsp:scriptlet>
		                                    </td>
		                                    <td class="separation">Last Name</td>
						                    <td>
							                    <input type="text" id="cLastName" name="lastName" size="20"  />
							                    <jsp:scriptlet>if(request.getAttribute("cLastName_er") != null){</jsp:scriptlet>
						                    	<span class="er">*</span>
												<jsp:scriptlet>}</jsp:scriptlet>
						                    </td>
		                                </tr>
		                                <tr>
		                                    <td>Password</td>
		                                    <td>
		                                        <input type="password" id="cPassword" name="password" size="21" />
		                                        <jsp:scriptlet>if(request.getAttribute("cPassword_er") != null){</jsp:scriptlet>
		                                        <span class="er">*</span>
		                                        <jsp:scriptlet>}</jsp:scriptlet>
		                                    </td>
		                                    <td class="separation">Country</td>
		                                    <td>
		                                    	<select size="1" name="country" >
		                                        <option value="Israel">Israel</option>
		                                    	</select>
		                                    </td>
		                                </tr>
		                                <tr>
		                                    <td>Confirm password</td>
		                                    <td>
		                                        <input type="password" id="cConfirmPassword" name="confirmPassword" size="21"  />
		                                        <jsp:scriptlet>if(request.getAttribute("cConfirmPassword_er") != null){</jsp:scriptlet>
		                                        <span class="er">*</span>
		                                        <jsp:scriptlet>}</jsp:scriptlet>
		                                    </td>
		                                    <td class="separation">E-mail address</td>
		                                    <td>
		                                    	<input type="text" id="cEmail" name="email" size="20" />
			                                    <jsp:scriptlet>if(request.getAttribute("cEmail_er") != null){</jsp:scriptlet>
			                                    <span class="er">*</span>
			                                    <jsp:scriptlet>}</jsp:scriptlet>
		                                    </td>
		                                </tr>
		                                <tr>
						                    <td>First Name</td>
						                    <td>
							                    <input type="text" id="cFirstName" name="firstName" size="20"  />
							                    <jsp:scriptlet>if(request.getAttribute("cFirstName_er") != null){</jsp:scriptlet>
							                   	<span class="er">*</span>
												<jsp:scriptlet>}</jsp:scriptlet>
						                    </td>
		                                    <td class="separation">Phone Number</td>
		                                    <td>
		                                    	<input type="text" id="cPhoneNumber" name="phoneNumber" size="20" />
												<jsp:scriptlet>if(request.getAttribute("cPhoneNumber_er") != null){</jsp:scriptlet>
		                                      	<span class="er">*</span>
		                                      	<jsp:scriptlet>}</jsp:scriptlet>
		                                    </td>
		                                </tr>
		                                <tr>
		                                    <td colspan="4" align="center">
		                                            <input class="myButton" type="submit" name="registrationClient" value="Registration" class="buttonSub" />
		                                            <input class="myButton" type="reset" value="Reset" class="buttonSub" />
		                                    </td>
		                                </tr>
		                                </tbody>
		                            </table>
		                        </form>
							</td>
						</tr>
						<tr>
							<td width="100%" colspan="2" class="separationtop">&nbsp;</td>
						</tr>
						<tr>
							<td width="1%" valign="top"><span id="element1" class="click" onclick="visableItems(1);">+</span></td>
							<td>
	                        <form id="registrationClient" action="Admin" method="post">
	                            <table border="0" align="center" cellpadding="1" cellspacing="1">
	                            	<caption style="font-weight: bold; width: 200px;">Register new administrator</caption>
	                            	<tbody id="data1" style="display: block;">
	                                <tr>
	                                    <td>Username</td>
	                                    <td>
	                                        <input type="text" size="20" id="aUsername" name="username" />
	                                        <jsp:scriptlet>if(request.getAttribute("aUsername_er") != null){</jsp:scriptlet>
	                                        <span class="er">*</span>
	                                        <jsp:scriptlet>}</jsp:scriptlet>
	                                    </td>
					                    <td class="separation">First Name</td>
					                    <td>
						                    <input type="text" id="aFirstName" name="firstName" size="20" />
						                    <jsp:scriptlet>if(request.getAttribute("aFirstName_er") != null){</jsp:scriptlet>
						                   	<span class="er">*</span>
											<jsp:scriptlet>}</jsp:scriptlet>
					                    </td>
	                                </tr>
	                                <tr>
	                                    <td>Password</td>
	                                    <td>
	                                        <input type="password" id="aPassword" name="password" size="21" />
	                                        <jsp:scriptlet>if(request.getAttribute("aPassword_er") != null){</jsp:scriptlet>
	                                        <span class="er">*</span>
	                                        <jsp:scriptlet>}</jsp:scriptlet>
	                                    </td>
					                    <td class="separation">Last Name</td>
					                    <td>
						                    <input type="text" id="aLastName" name="lastName" size="20"  />
						                    <jsp:scriptlet>if(request.getAttribute("aLastName_er") != null){</jsp:scriptlet>
					                    	<span class="er">*</span>
											<jsp:scriptlet>}</jsp:scriptlet>
					                    </td>
	                                </tr>
	                                <tr>
	                                    <td>Confirm password</td>
	                                    <td>
	                                        <input type="password" id="aConfirmPassword" name="confirmPassword" size="21"  />
	                                        <jsp:scriptlet>if(request.getAttribute("aConfirmPassword_er") != null){</jsp:scriptlet>
	                                        <span class="er">*</span>
	                                        <jsp:scriptlet>}</jsp:scriptlet>
	                                    </td>
	                                    <td class="separation">E-mail address</td>
	                                    <td>
	                                    	<input type="text" id="aEmail" name="email" size="20" />
		                                    <jsp:scriptlet>if(request.getAttribute("aEmail_er") != null){</jsp:scriptlet>
		                                    <span class="er">*</span>
		                                    <jsp:scriptlet>}</jsp:scriptlet>
	                                    </td>
	                                </tr>
	                                <tr>
	                                    <td colspan="4" align="center">
	                                            <input type="submit" class="myButton" name="registrationAdmin" value="Registration" class="buttonSub" />
	                                            <input type="reset" class="myButton" value="Reset" class="buttonSub" />
	                                    </td>
	                                </tr>
	                                </tbody>
	                            </table>
	                        </form>
						  </td>
						</tr>
						<tr>
							<td width="100%" colspan="2" class="separationtop">&nbsp;</td>
						</tr>
						<tr>
							<td width="1%" valign="top"><span id="element1" class="click" onclick="visableItems(1);">+</span></td>
							<td>
	                        <form id="registrationClient" action="Admin" method="post">
	                            <table border="0" align="center" cellpadding="1" cellspacing="1">
	                            	<caption style="font-weight: bold; width: 200px;">Edit you user data</caption>
	                            	<tbody id="data1" style="display: block;">
	                                <tr>
	                                    <td>Username</td>
	                                    <td>
	                                        <input type="text" size="20" id="eUsername" name="username" />
	                                        <jsp:scriptlet>if(request.getAttribute("eUsername_er") != null){</jsp:scriptlet>
	                                        <span class="er">*</span>
	                                        <jsp:scriptlet>}</jsp:scriptlet>
	                                    </td>
					                    <td class="separation">First Name</td>
					                    <td>
						                    <input type="text" id="eFirstName" name="firstName" size="20" />
						                    <jsp:scriptlet>if(request.getAttribute("aFirstName_er") != null){</jsp:scriptlet>
						                   	<span class="er">*</span>
											<jsp:scriptlet>}</jsp:scriptlet>
					                    </td>
	                                </tr>
	                                <tr>
	                                    <td>Password</td>
	                                    <td>
	                                        <input type="password" id="ePassword" name="password" size="21" />
	                                        <jsp:scriptlet>if(request.getAttribute("ePassword_er") != null){</jsp:scriptlet>
	                                        <span class="er">*</span>
	                                        <jsp:scriptlet>}</jsp:scriptlet>
	                                    </td>
					                    <td class="separation">Last Name</td>
					                    <td>
						                    <input type="text" id="eLastName" name="lastName" size="20"  />
						                    <jsp:scriptlet>if(request.getAttribute("eLastName_er") != null){</jsp:scriptlet>
					                    	<span class="er">*</span>
											<jsp:scriptlet>}</jsp:scriptlet>
					                    </td>
	                                </tr>
	                                <tr>
	                                    <td>Confirm password</td>
	                                    <td>
	                                        <input type="password" id="eConfirmPassword" name="confirmPassword" size="21"  />
	                                        <jsp:scriptlet>if(request.getAttribute("eConfirmPassword_er") != null){</jsp:scriptlet>
	                                        <span class="er">*</span>
	                                        <jsp:scriptlet>}</jsp:scriptlet>
	                                    </td>
	                                    <td class="separation">E-mail address</td>
	                                    <td>
	                                    	<input type="text" id="eEmail" name="email" size="20" />
		                                    <jsp:scriptlet>if(request.getAttribute("eEmail_er") != null){</jsp:scriptlet>
		                                    <span class="er">*</span>
		                                    <jsp:scriptlet>}</jsp:scriptlet>
	                                    </td>
	                                </tr>
	                                <tr>
	                                    <td colspan="4" align="center">
	                                            <input type="submit" class="myButton" name="editAdmin" value="Save Edit" class="buttonSub" />
	                                            <input type="reset" class="myButton" value="Reset" class="buttonSub" />
	                                    </td>
	                                </tr>
	                                </tbody>
	                            </table>
	                        </form>
						  </td>
						</tr>
						<tr>
							<td width="100%" colspan="2" class="separationtop">&nbsp;</td>
						</tr>
						<tr>
							<td width="1%" valign="top"><span id="element1" class="click" onclick="visableItems(1);">+</span></td>
							<td>
	                        <form id="registrationClient" action="Admin" method="post">
	                            <table border="0" align="center" cellpadding="1" cellspacing="1">
	                            	<caption style="font-weight: bold; width: 300px;">Block account (by Username or AccountID)</caption>
	                            	<tbody id="data1" style="display: block;">
	                                <tr>
	                                    <td>Enter Username</td>
	                                    <td>
	                                        <input type="text" size="20" id="bUsername" name="username" />
	                                    </td>
					                    <td class="separation">&nbsp;or AccountID</td>
					                    <td>
						                    <input type="text" id="bIdAccount" name="idAccount" size="20" />
						                    <jsp:scriptlet>if(request.getAttribute("bIdAccount_er") != null){</jsp:scriptlet>
						                   	<span class="er">*</span>
											<jsp:scriptlet>}</jsp:scriptlet>
					                    </td>
	                                </tr>
	                                <tr>
	                                    <td colspan="4" align="center">
                                            <input type="submit" class="myButton" name="blockAccount" value="Block account" class="buttonSub" />
                                            <input type="reset" class="myButton" value="Reset" class="buttonSub" />
	                                    </td>
	                                </tr>
	                                </tbody>
	                            </table>
	                        </form>
						  </td>
						</tr>
						<tr>
							<td width="100%" colspan="2" class="separationtop">&nbsp;</td>
						</tr>
						<tr>
							<td colspan="2" align="center">
								<input type="button" onclick="location.href='adminTable.jsp?id=0';" class="myButton" name="registrationAdmin" value="Statistic of orders" />
							</td>
						</tr>
					</table>
	<jsp:scriptlet>
	if (sqlResult != null) {
		if(sqlResult == 1) {
	</jsp:scriptlet>
				<script type="text/javascript">
	            	var controls = {
	          			"cUsername" : "<%=request.getParameter("username")%>",
	          			"cFirstName" : "<%=request.getParameter("firstName")%>",
		            	"cLastName" : "<%=request.getParameter("lastName")%>",
		            	"cEmail" : "<%=request.getParameter("email")%>",
		            	"cPhoneNumber" : "<%=request.getParameter("phoneNumber")%>"
		            	};
	
					SetValue(controls);
	            </script>
	<jsp:scriptlet>
		} else if (sqlResult == 2) {
	</jsp:scriptlet>
				<script type="text/javascript">
	            	var controls = {
	          			"aUsername" : "<%=request.getParameter("username")%>",
	          			"aFirstName" : "<%=request.getParameter("firstName")%>",
		            	"aLastName" : "<%=request.getParameter("lastName")%>",
		            	"aEmail" : "<%=request.getParameter("email")%>"
		            	};
	
					SetValue(controls);
	            </script>
	<jsp:scriptlet>
		}
	}
	
	Administrator administrator = (Administrator)session.getAttribute("account");
	</jsp:scriptlet>
				<script type="text/javascript">
	            	var controls = {
	          			"eUsername" : "<%=administrator.getUsername()%>",
	          			"eFirstName" : "<%=administrator.getFirstName()%>",
		            	"eLastName" : "<%=administrator.getLastName()%>",
		            	"eEmail" : "<%=administrator.getEmail()%>"
		            	};
	
					SetValue(controls);
	            </script>
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