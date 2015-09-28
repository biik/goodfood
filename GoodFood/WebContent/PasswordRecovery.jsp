<!-- NEW CODE Den -->
<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="Good Food" />

<link href="templatemo_style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="css/ido.css" />

<script type="text/javascript" src="javascript.js"></script>

<title>Good Foods</title>
</head>

<!--END OF NEW CODE Den -->

<body>
<jsp:directive.page import="com.sce.service.Account" />
<jsp:directive.page import="com.sce.service.User" />
<jsp:directive.page import="com.sce.DB.DBConnection" />
<jsp:directive.page import="com.sce.DB.SingeltonDB" />
<%@ page import="java.sql.*" %>


<!-- START NEW CODE Den -->
<div id="templatemo_body_wrapper">
	<div id="templatemo_wrapper">
	
		<div id="templatemo_header">
					<jsp:directive.include file="header.jsp" />
				<div class="cleaner"></div>
		</div>
		
	<div id="templatemo_main">
<!-- END NEW CODE Den -->
<tr>
<td>

	<form id="RecoverPassword" action="RecoverPassword" method="post">
		
		<jsp:scriptlet>
				if(request.getAttribute("Success")!=null){	</jsp:scriptlet>
			<tr>
			<TD align="center"> <p class="thicker"><font face="verdana" color="green">An Email With Password Has Been Sent For You!</font></p></TD>
			</tr>
			<jsp:scriptlet>
	
			}
		</jsp:scriptlet>
		
		
	
			<tr>
		    <td><p class="hit-the-floor"><font face="verdana" color="blue">Please Enter User Name And User Email Of Your User And The Password Will Be Sent To Your Email: </font></p></td>
			</tr>
            <table border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
					<ul id="summaryError" class="er">
					<jsp:scriptlet> if(request.getAttribute("username_er") != null){</jsp:scriptlet>
						<li><p class="thicker "><font face="verdana" color="black">The field user name cannot be empty</font></p></li>
					<jsp:scriptlet>} if(request.getAttribute("email_er") != null){</jsp:scriptlet>
						<li><p class="thicker "><font face="verdana" color="black">The field email  cannot be empty</font></p></li>
						<jsp:scriptlet>} if(request.getAttribute("validate_er") != null){</jsp:scriptlet>
						<li><p class="thicker "><font face="verdana" color="black">The Combination Of This User And Email Not Exist!</font></p></li>
						<jsp:scriptlet>} if(request.getAttribute("sql_er") != null){</jsp:scriptlet>
						<li><p class="thicker "><font face="verdana" color="black">SQL DataBase error! Please try again later</font></p></li>
					<jsp:scriptlet>}</jsp:scriptlet>
		          	</ul>
          			</td>
          		</tr>
          	</table>
	<table class="style1" align="center">
		<tr>
		           <td><p class="hit-the-floor"><font face="verdana" color="blue">User Name</font></p></td>
                    <td>
                    	<input type="text" id="username" name="username" size="20" class="tb5 " />
                    	<jsp:scriptlet>if(request.getAttribute("username_er") != null){</jsp:scriptlet>
                    	<span class="er">*</span>
						<jsp:scriptlet>}</jsp:scriptlet>
                    </td>
		
		</tr>
		 <tr>
                    <td><p class="hit-the-floor"><font face="verdana" color="blue">Email</font></p></td>
                    <td>
	                    <input type="text" id="email" name="email" size="20" class="tb5" />
	                    <jsp:scriptlet>if(request.getAttribute("email_er") != null){</jsp:scriptlet>
                    	<span class="er">*</span>
						<jsp:scriptlet>}</jsp:scriptlet>
                    </td>
        </tr>
         <tr>
                    <td colspan="2" align="center">
                            <input type="submit" name="RecoverPassword" value="RecoverPassword" class="myButton" />
                            <input type="reset" value="Reset" class="myButton" />
                    </td>
        </tr>
	</table>



	</form>
</td>
</tr>


<!-- START NEW CODE Den -->		
		<div class="cleaner"></div>
		</div> <!-- END of templatemo_main -->
		
		<div id="templatemo_footer">
			<jsp:directive.include file="footer.jsp" />
			<%-- <jsp:directive.include file="printSessionData.jsp" /> --%>
		</div> <!-- END of templatemo_footer -->
		
	</div> <!-- END of templatemo_wrapper -->
</div> <!-- END of templatemo_body_wrapper -->
<!-- END NEW CODE Den -->
</body>
</html>