<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="Good Food" />
<link rel="stylesheet" type="text/css" href="../styles/style.css" />
<script type="text/javascript" src="../javascript.js"></script>
<title>New Administrator account</title>
</head>
<body>
	<jsp:directive.page import="java.util.regex.Pattern" />
	<jsp:directive.page import="java.util.regex.Matcher" />
	<jsp:directive.page import="com.sce.DB.DBConnection" />
	<jsp:directive.page import="com.sce.DB.SingeltonDB" />
	<jsp:directive.page import="java.sql.ResultSet" />
	<jsp:directive.page import="java.sql.SQLException" />
	<table class="style1" align="center">
<jsp:scriptlet>
<![CDATA[
int resultRegistration = 0;
boolean registrationSuccessful = false;

if (request.getParameter("registrationAdmin") != null) {
	String[] fields = {"username", "password", "confirmPassword", "firstName", "lastName", "email"};
	
	request.setAttribute("sqlResult", 2);
	
	String userName = request.getParameter("username");
	String password = request.getParameter("password");
	String confirmpassword = request.getParameter("confirmPassword");
	String firstName = request.getParameter("firstName");
	String lastName = request.getParameter("lastName");
	String email = request.getParameter("email");
	
	boolean flag = false;
	for (String field : fields) {
		if(request.getParameter(field) == null || request.getParameter(field) == "")
		{
			request.setAttribute("a" + Character.toUpperCase(field.charAt(0)) + field.substring(1) + "_er", 1);
			flag = true;
		}
	}
	Pattern pattern = Pattern.compile("^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$");
	Matcher matcher = pattern.matcher(email);
	if(!matcher.matches()) {
		request.setAttribute("aEmailvalidate_er", 1);
		flag = true;
	}
	
	if(password == confirmpassword) {
		request.setAttribute("aConfirmPasswordEqual_er", 1);
		flag = true;
	}
	
	int result = 0;
	int pkId = 0;
	ResultSet resultSet = null;
	
	DBConnection sdb = SingeltonDB.getDbCon();
	
	if(!flag) {
		try {
			String sqlQuerie = "SELECT COUNT(idAccounts) AS ct FROM accounts WHERE userName=?";
			resultSet = sdb.PQuery(sqlQuerie, userName);
			resultSet.next();
			if(resultSet.getInt("ct") != 0)
			{
				request.setAttribute("aUsernameBusy_er", 1);
				throw new SQLException();
			}
			
			sqlQuerie = "INSERT INTO accounts (userName, password, roll) VALUES (?, ?, 0)";
			result = sdb.PInsert(sqlQuerie, userName, password);
			
			if(result != 1) {
				request.setAttribute("sql_er", -1);
				throw new SQLException();
			}
		
			sqlQuerie = "SELECT idAccounts AS id FROM accounts WHERE userName=? AND password=?";
			resultSet = sdb.PQuery(sqlQuerie, userName, password);
			resultSet.next();
			pkId = resultSet.getInt("id");
			
			sqlQuerie = "INSERT INTO administrator (pkIdAccount, firstName, lastName, email)"
					+ "VALUES (?, ?, ?, ?)";
			
			result = sdb.PInsert(sqlQuerie, pkId, firstName, lastName, email);
			
			if(result == 1)
				resultRegistration = 1;
	
		} catch (SQLException e) {
			resultRegistration = 0;
		}
	}
}
if(resultRegistration == 1) {
	registrationSuccessful = true;
}
	Integer sqlResult = (Integer)request.getAttribute("sqlResult");
	if (sqlResult != null) {
]]>
</jsp:scriptlet>
	    <tr>
	        <td>
				<ul id="summaryError" class="er">
				<jsp:scriptlet>if(request.getAttribute("aUsername_er") != null){</jsp:scriptlet>
					<li>The field UserName cannot be empty</li>
				<jsp:scriptlet>} if(request.getAttribute("aPassword_er") != null){</jsp:scriptlet>
					<li>The field Passwords cannot be empty</li>
				<jsp:scriptlet>} if(request.getAttribute("aConfirmPassword_er") != null){</jsp:scriptlet>
					<li>The field Confirm password cannot be empty</li>
				<jsp:scriptlet>} if(request.getAttribute("aEmail_er") != null){</jsp:scriptlet>
					<li>The field Email cannot be empty</li>
				<jsp:scriptlet>} if(request.getAttribute("aConfirmPasswordEqual_er") != null){</jsp:scriptlet>
					<li>ConfirmPassword do not match to password</li>
				<jsp:scriptlet>} if(request.getAttribute("aEmailvalidate_er") != null){</jsp:scriptlet>
					<li>Email is not validated</li>
				<jsp:scriptlet>} if(request.getAttribute("aFirstName_er") != null){</jsp:scriptlet>
					<li>The field First Name cannot be empty</li>
				<jsp:scriptlet>} if(request.getAttribute("aLastName_er") != null){</jsp:scriptlet>
					<li>The field Last Name cannot be empty</li>
				<jsp:scriptlet>} if(request.getAttribute("aUsernameBusy_er") != null){</jsp:scriptlet>
					<li>The Username: <jsp:expression>request.getParameter("username")</jsp:expression> already used</li>
				<jsp:scriptlet>} if(request.getAttribute("sql_er") != null){</jsp:scriptlet>
					<li>SQL DataBase error! Please try again later</li>
				<jsp:scriptlet>}</jsp:scriptlet>
	        	</ul>
	        	
	        	<jsp:scriptlet>if(registrationSuccessful){</jsp:scriptlet>
	        	<ul class="ok"><li>Registration ended successfully!</li></ul>
	        	<jsp:scriptlet>}</jsp:scriptlet>
	      			</td>
	      		</tr>
<jsp:scriptlet>} else {</jsp:scriptlet>
			<tr><td>&nbsp;</td></tr>
<jsp:scriptlet><![CDATA[} if(!registrationSuccessful) {]]></jsp:scriptlet>
			<tr>
				<td>
                    <form id="registrationClient" action="./newaccount.jsp" method="post">
                        <table border="0" align="center" cellpadding="1" cellspacing="1">
                        	<caption style="font-weight: bold; width: 200px;">Register new administrator</caption>
                            <tr>
                                <td>Username</td>
                                <td>
                                    <input type="text" size="20" id="aUsername" name="username" />
                                    <jsp:scriptlet>if(request.getAttribute("aUsername_er") != null){</jsp:scriptlet>
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
                            </tr>
                            <tr>
                                <td>Confirm password</td>
                                <td>
                                    <input type="password" id="aConfirmPassword" name="confirmPassword" size="21"  />
                                    <jsp:scriptlet>if(request.getAttribute("aConfirmPassword_er") != null){</jsp:scriptlet>
                                    <span class="er">*</span>
                                    <jsp:scriptlet>}</jsp:scriptlet>
                                </td>
                            </tr>
                            <tr>
			                    <td>First Name</td>
			                    <td>
				                    <input type="text" id="aFirstName" name="firstName" size="20" />
				                    <jsp:scriptlet>if(request.getAttribute("aFirstName_er") != null){</jsp:scriptlet>
				                   	<span class="er">*</span>
									<jsp:scriptlet>}</jsp:scriptlet>
			                    </td>
                            </tr>
                            <tr>
			                    <td>Last Name</td>
			                    <td>
				                    <input type="text" id="aLastName" name="lastName" size="20"  />
				                    <jsp:scriptlet>if(request.getAttribute("aLastName_er") != null){</jsp:scriptlet>
			                    	<span class="er">*</span>
									<jsp:scriptlet>}</jsp:scriptlet>
			                    </td>
                            </tr>
                            <tr>

                                <td class="separation">E-mail address</td>
                                <td>
                                	<input type="text" id="aEmail" name="email" size="20" />
		                            <jsp:scriptlet>if(request.getAttribute("aEmail_er") != null){</jsp:scriptlet>
		                            <span class="er">*</span>
		                            <jsp:scriptlet>}</jsp:scriptlet>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="center">
                                        <input type="submit" class="myButton" name="registrationAdmin" value="Registration" class="buttonSub" />
                                        <input type="reset" class="myButton" value="Reset" class="buttonSub" />
                                </td>
                            </tr>
                        </table>
                    </form>
				</td>
			</tr>
			<jsp:scriptlet><![CDATA[} else {]]></jsp:scriptlet>
			<tr><td><a href="../index.jsp">Go to main page</a></td></tr>
			<jsp:scriptlet><![CDATA[}]]></jsp:scriptlet>
		</table>
<jsp:scriptlet>
if (sqlResult != null) {
	if (sqlResult == 2) {
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
</jsp:scriptlet>
</body>
</html>