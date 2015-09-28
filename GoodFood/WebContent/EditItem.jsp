<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@page import="iClient.iItem"%>
<%@page import="iClient.iRestaurant"%>
<%@page import="iClient.iLable"%>
<%@page import="iClient.iMenu"%>
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

<script type="text/javascript">
	var _validFileExtensions = [ ".jpg", ".jpeg", ".bmp", ".gif", ".png" ];
	function ValidatePic() {
		var fileU = document.getElementById("FileUp");
		var sFileName = fileU.value;
		if (sFileName.length > 0) {
			var blnValid = false;
			for (var j = 0; j < _validFileExtensions.length; j++) {
				var sCurExtension = _validFileExtensions[j];
				if (sFileName.substr(sFileName.length - sCurExtension.length,
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
		var isPic = false;
		var x = document.forms["itemForm"]["Name"].value;
		if (x == null || x == "") {
			alert("Name must be filled out");
			return false;
		}
		x = document.forms["itemForm"]["Price"].value;
		if (x == null || !isNumber(x)) {
			alert("Price must be filled out and only with numbers!");
			return false;
		}

		x = document.forms["itemForm"]["desc"].value;
		if (x == null || x == "") {
			alert("Description must be filled out");
			return false;
		}
		
		x = document.getElementById("FileUp");
		if ('files' in x) {
			if (x.files.length == 0 || x.files.length > 1) {
				alert("Background picture will stay same as befor :)");
				'<%session.setAttribute("emptyFU", 1);%>';
				'<%session.setAttribute("isNewI", 0);%>';
				return true;
			} else
				isPic = ValidatePic();
		}
		if(isPic){
			'<%session.setAttribute("isNewI", 0);%>';
			'<%session.setAttribute("emptyFU", 0);%>';
		}
		return isPic;

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
				<%
					iRestaurant restaurant = (iRestaurant) session
							.getAttribute("restaurant");
					if (restaurant == null) {
						request.getRequestDispatcher("/ClientsPage.jsp").forward(
								request, response);
						return;
					}
					iMenu menu = restaurant.getMenu();
					iLable choosenLable = null;
					String lableIndexS = (String) request.getParameter("lableIndex");
					String itemIndexS = (String) request.getParameter("itemIndex");
					int itemIndex_Server = -1;
					int lableIndex_Server = -1;
					if (lableIndexS != null && itemIndexS != null) {
						try {
							lableIndex_Server = Integer.parseInt(lableIndexS);
							if (lableIndex_Server >= 0) {
								choosenLable = menu.getLables().get(lableIndex_Server);
								session.setAttribute("cLable", choosenLable);
								itemIndex_Server = Integer.parseInt(itemIndexS);
								if (itemIndex_Server >= 0) {
									iItem item = choosenLable.getItems().get(
											itemIndex_Server);
									session.setAttribute("cItem", item);
				%>
				<form name="itemForm" action="handleItem"
					onsubmit="return validate()" method="post"
					enctype="multipart/form-data">
					<h3>Edit item:</h3>
					<hr />
					<span id="lbl_name">Item Name:</span> <input type="text"
						name="Name" id="txtName" style="width: 100%" size="40"
						value="<%=item.getName()%>" /> <br /> <span id="lbl_pric">Item
						Price:</span> <input type="text" name="Price" id="txtName"
						style="width: 100%" size="40" value="<%=item.getPrice()%>" /> <br />
					<span id="lbl_desc">Item Description:</span> <input type="text"
						name="desc" id="txtName" style="width: 100%" size="40"
						value="<%=item.getDesc()%>" /> <br /> <span id="lbl_pict">Item
						Picture:</span> <input type="file" name="FileUpload" id="FileUp" /><span
						style="color: red;">*Choose new picture to override exist.</span>
					<div class="cleaner"></div>
					<br /> <input type="submit" class="myButton" name="Submit"
						value="Submit" id="btnSubmit" /> &nbsp;<input type="button"
						class="myButton" name="Cancel" value="Cancel" id="btnCancel"
						onclick="history.go(-1);return true;" />
				</form>

				<%
					} else {
									request.getRequestDispatcher("/ClientsPage.jsp")
											.forward(request, response);
									return;
								}
							}
						} catch (NumberFormatException e) {
							e.printStackTrace();
							request.getRequestDispatcher("/ClientsPage.jsp").forward(
									request, response);
							return;
						}
					} else {
						request.getRequestDispatcher("/ClientsPage.jsp").forward(
								request, response);
						return;
					}
				%>

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

</body>
</html>