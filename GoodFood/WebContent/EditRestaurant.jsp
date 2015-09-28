<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@page import="iClient.iRestaurant"%>
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
				%>
				<form name="editRes" action="handleRestaurant"
					onsubmit="return validate()" method="post"
					enctype="multipart/form-data">
					<h3>Edit your restaurant</h3>
					<hr />
					<span id="lbl_name">Restaurant Name:</span> <input type="text"
						name="Name" id="txtName" style="width: 100%" size="40"
						value="<%=restaurant.getName()==null?"":restaurant.getName()%>" /> <br /> <span id="lbl_desc">Restaurant
						Description:</span> <input type="text" name="desc" id="txtdesc"
						style="width: 100%" value="<%=restaurant.getDescription()==null?"":restaurant.getDescription()%>"
						size="250" /> <br /> <span id="lbl_addr">Restaurant
						Address:</span> <input type="text" name="Address" id="txtAddress"
						value="<%=restaurant.getAddress()==null?"":restaurant.getAddress()%>" style="width: 100%"
						size="80" /> <br /> <span id="lbl_phon">Restaurant Phone
						number:</span> <input type="text" name="Phone" id="txtAddress"
						value="<%=restaurant.getPhone()==null?"":restaurant.getPhone()%>" style="width: 100%" size="80" />
					<br /> <span id="lbl_address">Restaurant Open hours:</span> <input
						type="text" name="openHours" id="txtAddress"
						value="<%=restaurant.getOpenHours()==null?"":restaurant.getOpenHours()%>" style="width: 100%"
						size="80" /> <br /> <select name="Category" style="width: 10%"
						id="slct">
						<option value="0">Meat</option>
						<option value="1">Dairy</option>
						<option value="2">Fish</option>
						<option value="3">Home-Made</option>
					</select> <br /> <span id="lbl_pict">Restaurant Picture:</span><br /> <input
						type="file" name="FileUpload" id="FileUp" /><span
						style="color: red;">*Choose new picture to override exist.</span>
					<br /> <br /> <input type="submit" class="myButton" name="Submit"
						value="Submit" id="btnSubmit" /> &nbsp;<input type="submit"
						class="myButton" name="Cancel" value="Cancel" id="btnCancel"
						onclick="history.go(-1);return true;" />
						<script type="text/javascript">
							var slct = document.getElementById("slct");
							var index = '<%=restaurant.getCategory()%>';
							 slct.selectedIndex=index;
						</script>
				</form>

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
	<script type="text/javascript">
		var _validFileExtensions = [ ".jpg", ".jpeg", ".bmp", ".gif", ".png" ];
		function ValidatePic() {
			var fileU = document.getElementById("FileUp");
			var sFileName = fileU.value;
			if (sFileName.length > 0) {
				var blnValid = false;
				for (var j = 0; j < _validFileExtensions.length; j++) {
					var sCurExtension = _validFileExtensions[j];
					if (sFileName.substr(
							sFileName.length - sCurExtension.length,
							sCurExtension.length).toLowerCase() == sCurExtension
							.toLowerCase()) {
						blnValid = true;
						break;
					}
				}
				if (!blnValid) {
					alert("Sorry, " + sFileName
							+ " is invalid, allowed extensions are: "
							+ _validFileExtensions.join(", "));
					return false;
				}
			}
			return true;
		}

		function isNumber(n) {
			return !isNaN(parseFloat(n)) && isFinite(n);
		}

		function validate() {
			var x = document.forms["editRes"]["Name"].value;
			if (x == null || x == "") {
				alert("Name must be filled out");
				return false;
			}
			x = document.forms["editRes"]["desc"].value;
			if (x == null || x == "") {
				alert("Description must be filled out");
				return false;
			}
			x = document.forms["editRes"]["Address"].value;
			if (x == null || x == "") {
				alert("Address must be filled out");
				return false;
			}
			x = document.forms["editRes"]["openHours"].value;
			if (x == null || x == "") {
				alert("openHours must be filled out");
				return false;
			}
			x = document.forms["editRes"]["Phone"].value;
			if (x == null || !isNumber(x)) {
				alert("Phone number must be filled out and only with numbers!");
				return false;
			}
			x = document.getElementById("FileUp");
			if ('files' in x) {
				if (x.files.length == 0 || x.files.length > 1) {
					'<%session.setAttribute("isNewR", 0);%>';
					alert("Background picture will stay the same as before :)");
					return true;
				} else
					isPic = ValidatePic();
			}
			if(isPic){
				alert('New picture!');
				'<%session.setAttribute("isNewR", 0);%>';
			}
			return isPic;
		}
	</script>
</body>
</html>