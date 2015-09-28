<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="Good Food" />
<script type="text/javascript" src="javascript.js"></script>
<link rel="stylesheet" type="text/css" href="styles/styles2.css" />
<title>Good Foods</title>
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

		x = document.forms["itemForm"]["Description"].value;
		if (x == null || x == "") {
			alert("Description must be filled out");
			return false;
		}
		x = document.getElementById("FileUp");
		if ('files' in x) {
			if (x.files.length == 0 || x.files.length> 1 ) {
				alert("Background picture must be added");
				return false;
			} else
				isPic = ValidatePic();
		}
		return true && isPic;

	}
</script>
</head>
<body>

	<!-- I am added the html part only for the css (for now). -->
	<!-- when evgenii make this page inside the index then-->
	<!-- Only this part will be in this page -->
	<form name="itemForm"
		action="AddItem?restPkid=<%=request.getParameter("restPkid")%>&lblPkid=<%=request.getParameter("lblPkid")%>"
		onsubmit="return validate()" method="post"
		enctype="multipart/form-data">
		<table class="tableInfo">
			<tr>
				<td colspan="2" style="text-align: center"><span id="lbl_edit">Add
						new item:</span></td>
			</tr>
			<tr>
				<td><span id="lbl_name">Item Name:</span></td>
				<td><input type="text" name="Name" id="txtName" size="40" /></td>
			</tr>
			<tr>
				<td><span id="lbl_price">Item Price:</span></td>
				<td><input type="text" name="Price" id="txtPrice" size="40" />
				</td>
			</tr>
			<tr>
				<td><span id="lbl_Desc">Item Description:</span></td>
				<td><input type="text" name="Description" id="txtDesc"
					size="80" /></td>
			</tr>
			<tr>
				<td><span id="lbl_Background">Background Picture:</span></td>
				<td><input type="file" name="FileUpload" id="FileUp" /></td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center"><input type="submit"
					name="Save" value="Save changes" id="btnSave" /> &nbsp;<input
					type="button" name="Cancel" value="Cancel" id="btnCancel"
					onclick="location.href = 'ClientsPage.jsp';" /></td>
			</tr>
		</table>
	</form>

</body>
</html>