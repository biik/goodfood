<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="Good Food" />
<script type="text/javascript" src="javascript.js"></script>
<title>Good Foods</title>

</head>
<body>
	<table width="900" border="0" align="center" cellpadding="0" cellspacing="0">
		<tr>
        	<td>
        	<!-- Header -->
            <jsp:directive.include file="header.jsp" />
			</td>
		</tr>
		<tr>
			<td>
				<!-- Body -->
				<table border="0" align="center" cellpadding="0" cellspacing="0">
		        	<tr>
		            	<td>
							<jsp:scriptlet>
								Integer sqlResult = (Integer)request.getAttribute("sqlResult");
								String sqlResultString = (String)request.getAttribute("sqlResultString");
								if (sqlResult != null && sqlResultString != null) {
							</jsp:scriptlet>
								<h2 style="color: red;"><jsp:expression>sqlResultString</jsp:expression></h2>
							<jsp:scriptlet>
								}
							</jsp:scriptlet>
		            	</td>
		            </tr>
		        </table>
				<form id="ordering" action="ConfirmationRegistration" method="post">
				<table border="0" align="center" cellpadding="1" cellspacing="1">
	                <tr>
						<td>Username</td>
	                    <td>
	                    	<input type="text" size="20" id="username" name="username" />
	                    </td>
	                </tr>
	                <tr>
	                    <td>Enter the string</td>
	                    <td><input type="text" id="emailHash" name="emailHash" value="!email!" size="40" /></td>
	                </tr>
	                <tr>
	                    <td colspan="2" align="center">
                            <input type="submit" name="sendemailhash" value="Send String" class="buttonSub" />
                            <input type="reset" value="Reset" class="buttonSub" />
	                    </td>
	                </tr>
	            </table>
            	</form>
			</td>
		</tr>
		<tr>
			<td align="center">
				<!-- Footer -->
                <jsp:directive.include file="footer.jsp" />
			</td>
		</tr>
	</table>
</body>
</html>