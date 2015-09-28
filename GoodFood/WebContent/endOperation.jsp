<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
<meta http-equiv="Refresh" content="4;url=index.jsp" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="Good Food" />
<script type="text/javascript" src="javascript.js"></script>
<link rel="stylesheet" type="text/css" href="styles/style.css" />
<link href="templatemo_style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="styles/styles2.css" />
<title>Good Foods</title>

</head>
<body>
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
			<table border="0" align="center" cellpadding="0" cellspacing="0">
	        	<tr>
	            	<td>
						<jsp:scriptlet>
							Integer sqlResult = (Integer)request.getAttribute("sqlResult");
							String sqlResultString = (String)request.getAttribute("sqlResultString");
							if (sqlResult != null && sqlResultString != null) {
						</jsp:scriptlet>
							<h2 style="color: green;"><jsp:expression>sqlResultString</jsp:expression></h2>
						<jsp:scriptlet>
							}
						</jsp:scriptlet>
							<span>After 5 seconds, you will be automatically redirected to the home page.<br />
							If this does not happen, click on this <a href="index.jsp" title="Main Page">link</a></span>
	            	</td>
	            </tr>
	        </table>
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