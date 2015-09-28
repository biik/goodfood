
<%--DEN'S NEW CODE --%>
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
	<table class="style1" align="center">

		<tr>
       		<td align="center">
       		<form method="post" action="UserPage.jsp">   
         	<input type="submit" class="myButton" name="Orders" value="Orders History"/>
             <input type="submit" class="myButton" name="UserDetails" value="UserDetails"/>    
                <input type="submit" class="myButton" name="Edit" value="Edit"/> 
               </form>        
             </td>
        </tr>  
	<tr>
		<jsp:scriptlet>
	synchronized (session) {
		Account account = (Account) session.getAttribute("account");
		if (account == null || account.getRoll()!=2) {
			request.getRequestDispatcher("/index.jsp").forward(request, response);
			return;
		}
		User user = (User)account;
	if (request.getParameter("Orders") != null) {</jsp:scriptlet>
		<td>
      	<jsp:scriptlet>
	try {
		DBConnection sdb=SingeltonDB.getDbCon();
		String sqlQuerie = "SELECT idorders,resturantName,ammount,date FROM orderdetails WHERE userpkId=(Select pkIdUser From User Where pkidAccount="+Integer.toString(user.getPkId())+")";
		ResultSet resultSet = sdb.query(sqlQuerie);
		</jsp:scriptlet>
		   <TABLE BORDER="3" align="center" id="Orders"><p class="hit-the-floor"><font face="verdana" color="blue">Order History:</font></p>
            <tr>
            <th><p class="hit-the-floor"><font face="verdana" color="blue">Order Number</font></p></th>
            <th><p class="hit-the-floor"><font face="verdana" color="blue">Resturant Name</font></p></th>
           <th> <p class="hit-the-floor"><font face="verdana" color="blue">Price</font></p></th>
           <th><p class="hit-the-floor"><font face="verdana" color="blue">Date</font></p></th>

            </tr>
            	<jsp:scriptlet>
            while(resultSet.next()){	</jsp:scriptlet>

            <TR>
                <TD> <p class="thicker"><font face="verdana" color="black"><jsp:expression>resultSet.getInt(1)</jsp:expression></font></p></TD>
                <TD><p class="thicker"><font face="verdana" color="black"><jsp:expression> resultSet.getString(2)</jsp:expression></font></p> </TD>
                <TD><p class="thicker"><font face="verdana" color="black"><jsp:expression>resultSet.getFloat(3)</jsp:expression> NIS</font></p> </TD>
                <TD><p class="thicker"><font face="verdana" color="black"><jsp:expression>resultSet.getDate(4)</jsp:expression> <jsp:expression>resultSet.getTime(4)</jsp:expression></font></p></TD>
            </TR>
             <jsp:scriptlet>} </jsp:scriptlet>
        </TABLE>
        	<jsp:scriptlet>} catch (SQLException e) {
						e.printStackTrace();
					} </jsp:scriptlet>
			</td>
			
			</tr>
		<jsp:scriptlet>
		
	}
	
	
	
	
	
	
	
	
	else if  (request.getParameter("Edit") != null || request.getParameter("EditUser") != null) {
		if(request.getAttribute("Success")!=null){	</jsp:scriptlet>
		<tr>
		<TD align="center"> <p class="thicker"><font face="verdana" color="black">Update Success!!</font></p></TD>
		</tr>
		<jsp:scriptlet>

		}
	</jsp:scriptlet>
	<tr>
		<td>
		
            <form id="EditUser" action="EditUser" method="post">
            <table border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
					<ul id="summaryError" class="er">
					<jsp:scriptlet> if(request.getAttribute("password_er") != null){</jsp:scriptlet>
						<li><p class="thicker "><font face="verdana" color="black">The field Passwords cannot be empty</font></p></li>
					<jsp:scriptlet>} if(request.getAttribute("confirmPassword_er") != null){</jsp:scriptlet>
						<li><p class="thicker "><font face="verdana" color="black">The field Confirm password cannot be empty</font></p></li>
					<jsp:scriptlet>} if(request.getAttribute("firstName_er") != null){</jsp:scriptlet>
						<li><p class="thicker "><font face="verdana" color="black">The field First Name cannot be empty</font></p></li>
					<jsp:scriptlet>} if(request.getAttribute("lastName_er") != null){</jsp:scriptlet>
						<li><p class="thicker "><font face="verdana" color="black">The field Last Name cannot be empty</font></p></li>
					<jsp:scriptlet>} if(request.getAttribute("email_er") != null){</jsp:scriptlet>
						<li><p class="thicker "><font face="verdana" color="black">The field Email cannot be empty</font></p></li>
						<jsp:scriptlet>} if(request.getAttribute("emailvalidate_er") != null){</jsp:scriptlet>
						<li><p class="thicker "><font face="verdana" color="black">Wrong Email Format</font></p></li>
					<jsp:scriptlet>} if(request.getAttribute("homeNumber_er") != null){</jsp:scriptlet>
						<li><p class="thicker "><font face="verdana" color="black">Home Number can contain only be numbers,Must Enter!</font></p></li>
					<jsp:scriptlet>} if(request.getAttribute("buildingParser_er") != null){</jsp:scriptlet>
						<li><p class="thicker "><font face="verdana" color="black">Building can contain only numbers</font></p></li>
					<jsp:scriptlet>} if(request.getAttribute("phoneNumberParser_er") != null){</jsp:scriptlet>
						<li><p class="thicker "><font face="verdana" color="black">Phone Number can contain only numbers</font></p></li>
					<jsp:scriptlet>} if(request.getAttribute("confirmPasswordEqual_er") != null){</jsp:scriptlet>
						<li><p class="thicker "><font face="verdana" color="black">ConfirmPassword do not match to password</font></p></li>
					<jsp:scriptlet>} if(request.getAttribute("city_er") != null){</jsp:scriptlet>
						<li><p class="thicker "><font face="verdana" color="black">The Field City cannot be empty</font></p></li>
					<jsp:scriptlet>} if(request.getAttribute("street_er") != null){</jsp:scriptlet>
						<li><p class="thicker "><font face="verdana" color="black">The Field Street cannot be empty</font></p></li>
					<jsp:scriptlet>} if(request.getAttribute("sql_er") != null){</jsp:scriptlet>
						<li><p class="thicker "><font face="verdana" color="black">SQL DataBase error! Please try again later</font></p></li>
					<jsp:scriptlet>}</jsp:scriptlet>
		          	</ul>
          			</td>
          		</tr>
          	</table>

            <table border="0" align="center" cellpadding="0" cellspacing="0">
            
                <tr>
                    <td><p class="hit-the-floor"><font face="verdana" color="blue">Username:<%=user.getUsername()%></font></p></td>
                </tr>
                <tr>
                    <td><p class="hit-the-floor"><font face="verdana" color="blue">Password</font></p></td>
                    <td>
                    	<input type="password" id="password" name="password" size="20" class="tb5 " />
                    	<jsp:scriptlet>if(request.getAttribute("password_er") != null){</jsp:scriptlet>
                    	<span class="er">*</span>
						<jsp:scriptlet>}</jsp:scriptlet>
                    </td>
                </tr>
                <tr>
                    <td><p class="hit-the-floor"><font face="verdana" color="blue">Confirm password</font></p></td>
                    <td>
                    	<input type="password" id="confirmPassword" name="confirmPassword" size="20" class="tb5"/>
                    	<jsp:scriptlet>if(request.getAttribute("confirmPassword_er") != null){</jsp:scriptlet>
                    	<span class="er">*</span>
						<jsp:scriptlet>}</jsp:scriptlet>
                    </td>
                </tr>
                <tr>
                    <td><p class="hit-the-floor"><font face="verdana" color="blue">First Name</font></p></td>
                    <td>
	                    <input type="text" id="firstName" name="firstName" size="20" class="tb5" value="<%=user.getFirstName()%>"/>
	                    <jsp:scriptlet>if(request.getAttribute("firstName_er") != null){</jsp:scriptlet>
	                   	<span class="er">*</span>
						<jsp:scriptlet>}</jsp:scriptlet>
                    </td>
                </tr>
                <tr>
                    <td><p class="hit-the-floor"><font face="verdana" color="blue">Last Name</font></p></td>
                    <td>
	                    <input type="text" id="lastName" name="lastName" size="20" class="tb5" value="<%=user.getLastName()%>"/>
	                    <jsp:scriptlet>if(request.getAttribute("lastName_er") != null){</jsp:scriptlet>
                    	<span class="er">*</span>
						<jsp:scriptlet>}</jsp:scriptlet>
                    </td>
                </tr>
                <tr>
                    <td><p class="hit-the-floor"><font face="verdana" color="blue">E-mail address</font></p></td>
                    <td>
                    	<input type="text" id="email" name="email" size="20" class="tb5" value="<%=user.getEmail()%>"/>
                    	<jsp:scriptlet>if(request.getAttribute("email_er") != null){</jsp:scriptlet>
                    	<span class="er">*</span>
						<jsp:scriptlet>}</jsp:scriptlet>
                    </td>
                </tr>
                <tr>
                    <td><p class="hit-the-floor"><font face="verdana" color="blue">City</font></p></td>
                    <td><input type="text" id="city" name="city" size="20" class="tb5"/ value="<%=user.getCity()%>">
                        <jsp:scriptlet>if(request.getAttribute("city_er") != null){</jsp:scriptlet>
                    	<span class="er">*</span>
						<jsp:scriptlet>}</jsp:scriptlet>
                    
                    </td>
                </tr>
                <tr>
                    <td><p class="hit-the-floor"><font face="verdana" color="blue">Street</font></p></td>
                    <td><input type="text" id="street" name="street" size="20" class="tb5" value="<%=user.getStreet()%>"/>
                        <jsp:scriptlet>if(request.getAttribute("street_er") != null){</jsp:scriptlet>
                    	<span class="er">*</span>
						<jsp:scriptlet>}</jsp:scriptlet>
                    
                    </td>
                </tr>
                <tr>
                    <td><p class="hit-the-floor"><font face="verdana" color="blue">Home Number</font></p></td>
                    <td><input type="text" id="homeNumber" name="homeNumber" size="20" class="tb5" value="<%=user.getHomeNumber()%>"/>
                        <jsp:scriptlet>if(request.getAttribute("homeNumber_er") != null){</jsp:scriptlet>
                    	<span class="er">*</span>
						<jsp:scriptlet>}</jsp:scriptlet>
                    </td>
                </tr>
				<tr>
                    <td><p class="hit-the-floor"><font face="verdana" color="blue">Building</font></p></td>
                    <td><input type="text" id="building" name="building" size="20" class="tb5" value="<%=user.getBuilding()%>"/></td>
                </tr>
                <tr>
                    <td><p class="hit-the-floor"><font face="verdana" color="blue">Phone Number</font></p></td>
                    <td><input type="text" id="phoneNumber" name="phoneNumber" size="20" class="tb5" value="<%=user.getPhoneNumber()%>"/></td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                            <input type="submit" name="EditUser" value="EditUser" class="myButton" />
                            <input type="reset" value="Reset" class="myButton" />
                    </td>
                </tr>
            </table>

            </form>

</td>
</tr>

<jsp:scriptlet>
}else{</jsp:scriptlet>
	<tr>
		<td>
		<jsp:scriptlet>
	try {

		DBConnection sdb=SingeltonDB.getDbCon();
		String pkid=Integer.toString(user.getPkId());
		String sqlQuerie = "SELECT * FROM USER WHERE pkidAccount="+pkid;
		ResultSet resultSet = sdb.query(sqlQuerie);
		resultSet.next();
		</jsp:scriptlet>
		<tr>
		<td><p class="div_text_shadowA"><font face="verdana" color="black">First name:<jsp:expression>resultSet.getString(3)</jsp:expression></font></p></td>
		<td><p class="div_text_shadowA"><font face="verdana" color="black">Last name:<jsp:expression>resultSet.getString(4)</jsp:expression></font></p></td>
		</tr>
		<tr>
		<td><p class="div_text_shadowA"><font face="verdana" color="black">Join Site In:<jsp:expression>resultSet.getDate(5)</jsp:expression></font></p></td>
		<td><p class="div_text_shadowA"><font face="verdana" color="black">Credit Points :<jsp:expression>resultSet.getInt(6)</jsp:expression></font></p></td>
		</tr>
		<tr>
		<td><p class="div_text_shadowA"><font face="verdana" color="black">Gender <jsp:scriptlet>
		if(resultSet.getBoolean(7)==true){</jsp:scriptlet>
		Male
		<jsp:scriptlet>}
		else{</jsp:scriptlet>
			Female	
		<jsp:scriptlet>}</jsp:scriptlet></font></p></td>
		<td><p class="div_text_shadowA" ><font face="verdana" color="black">Email :<jsp:scriptlet>
		if(resultSet.getString(8)==null){</jsp:scriptlet>
		Not Insert Yet
		<jsp:scriptlet>}
		else{</jsp:scriptlet>
			<jsp:expression>resultSet.getString(8)</jsp:expression>	
		<jsp:scriptlet>}</jsp:scriptlet></font></p></td>
		</tr>
		<tr>
		<td><p class="div_text_shadowA"><font face="verdana" color="black">City :<jsp:expression>resultSet.getString(9)</jsp:expression></font></p></td>
		<td><p class="div_text_shadowA"><font face="verdana" color="black">Street :<jsp:expression>resultSet.getString(10)</jsp:expression></font></p></td>
		</tr>
		<tr>
		<td><p class="div_text_shadowA"><font face="verdana" color="black">Home number :<jsp:expression>resultSet.getInt(11)</jsp:expression></font></p></td>
		<td><p class="div_text_shadowA" ><font face="verdana" color="black">Building :<jsp:expression>resultSet.getInt(12)</jsp:expression></font></p></td>
		</tr>
		<tr>
		<td><p class="div_text_shadowA"><font face="verdana" color="black">Phone :<jsp:scriptlet>
		if(resultSet.getString(13)==null){</jsp:scriptlet>
		Not Insert Yet
		<jsp:scriptlet>}
		else{</jsp:scriptlet>
			<jsp:expression>resultSet.getString(13)</jsp:expression>
		<jsp:scriptlet>}</jsp:scriptlet></font></p></td>
		</tr>
		<jsp:scriptlet>
		}catch (SQLException e) {
						e.printStackTrace();	}
	</jsp:scriptlet>

					
		</td>
		<jsp:scriptlet>
	}}	</jsp:scriptlet>





		</tr>
		</table>
		
		
		
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