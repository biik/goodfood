<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@page import="com.sun.org.apache.bcel.internal.generic.LALOAD"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="iClient.iItem"%>
<%@page import="iClient.iLable"%>
<%@page import="iClient.iMenu"%>
<%@page import="com.sce.service.Client"%>
<%@page import="client.SqlBulider"%>
<%@page import="client.Restaurant"%>
<%@page import="iClient.iRestaurant"%>
<%@page import="com.sce.service.RestaurantDetails"%>
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
	<div id="AddNewItem">
		<!-- Popup Div Starts Here -->
		<div id="popup">
			<!-- The Form -->
			<form name="itemForm" action="handleItem"
				onsubmit="return validate()" method="post"
				enctype="multipart/form-data" id="formPOP" class="formPOP">
				<img id="close" src="images/x.png" onclick="div_hide()" />
				<h3>Add new item:</h3>
				<hr />
				<span id="lbl_name">Item Name:</span> <br />
				<input type="text" name="Name" id="txtName" style="width: 100%"
					size="40" /> <br /> <span id="lbl_price">Item Price:</span> <input
					type="text" name="Price" id="txtPrice" style="width: 100%"
					size="40" /> <br /> <span id="lbl_Desc">Item Description:</span>
				<input type="text" name="desc" id="txtdesc" style="width: 100%"
					size="250" /> <br /> <span id="lbl_Background">Background
					Picture:</span><br /> <input type="file" name="FileUpload" id="FileUp" />
				<br /> <br />
				<input type="submit" name="Save" value="Save changes" id="btnSave" />
			</form>
		</div>
		<!-- Popup Div Ends Here -->
	</div>

	<div id="AddNewCategory">
		<!-- Popup Div Starts Here -->
		<div id="popup">
			<!-- The Form -->
			<form name="CategoryForm" action="handleCategory" method="post"
				onsubmit="return validText()" class="formPOP">
				<img id="close" src="images/x.png" onclick="div_hide2()" />
				<h3>New SubCategory:</h3>
				<hr />
				<span id="lbl_name">Category Name:</span> <input type="text"
					name="Name" id="txtName" style="width: 100%" size="40" /> <br />
				<input type="submit" name="Save" value="Save changes" id="btnSave" />
			</form>
		</div>
		<!-- Popup Div Ends Here -->
	</div>

	<div id="templatemo_body_wrapper">
		<div id="templatemo_wrapper">

			<!-- CHECKING THE LOGIN -->
			<jsp:scriptlet>synchronized (session) {
				Account account2 = (Account) session.getAttribute("account");
				session.setAttribute("clientPkid",
						((Client) account2).getPkidClient());</jsp:scriptlet>



			<!-- IF THE USER IS CLINT THEN SHOW THIS: -->
			<div id="templatemo_header">
				<jsp:directive.include file="header.jsp" />
				<div class="cleaner"></div>
			</div>
			<jsp:scriptlet>iRestaurant restaurant = SqlBulider.generateRestaurant(
						((Client) account2).getPkidClient(), true);
				if (restaurant == null) {</jsp:scriptlet>
			<!-- IF THE CLIENT DONT HAVE A RESTAURANT YET  -->
			<h3>You dont have a restaurant!!!!</h3>
			<img src="images/sad.png" />
			<div class="cleaner"></div>
			<a href="AddNewRestaurant.jsp"
				style="pitch: high; float: left; text-decoration: underline; size: auto; font-size: xx-large;">Click
				here to create your restaurant!</a>
			<div class="cleaner"></div>
			<jsp:scriptlet>} else {
					session.setAttribute("restPkid", restaurant.getPkid());
					iMenu menu = restaurant.getMenu();
					session.setAttribute("restaurant", restaurant);
					String lblIndex = request.getParameter("lblIndex");
					int lblIndex_i = -1;
					if (lblIndex != null) {
						try {
							lblIndex_i = Integer.parseInt(lblIndex);
							iLable lable = menu.getLables().get(lblIndex_i);
							session.setAttribute("lblPkid", lable.getPkid());
						} catch (Exception e) {
							e.printStackTrace();
						}
					}

					iLable lable;</jsp:scriptlet>

			<div id="templatemo_main">
				<div id="sidebar" class="float_l">
					<div class="sidebar_box">
						<span class="bottom"></span>
						<h3>Menu</h3>
						<div class="content">
							<ul class="sidebar_list">
								<jsp:scriptlet><![CDATA[for (int lableIndex = 0; lableIndex < menu.getLables()
							.size(); lableIndex++) {
						lable = menu.getLables().get(lableIndex);
						if (lableIndex == 0) {]]></jsp:scriptlet>
								<li class="first"><a
									href="ClientsPage.jsp?lableIndex=<%=lableIndex%>"><%=lable.getLable()%></a>
									&nbsp;
									<div class="float_r">
										<u><a
											href="EditSubCategory.jsp?lableIndex=<%=lableIndex%>">edit</a></u>
									</div></li>
								<jsp:scriptlet>} else {</jsp:scriptlet>
								<li><a href="ClientsPage.jsp?lableIndex=<%=lableIndex%>"><%=lable.getLable()%></a>
									&nbsp;
									<div class="float_r">
										<b><u><a
												href="EditSubCategory.jsp?lableIndex=<%=lableIndex%>">edit</a></u></b>
									</div></li>
								<jsp:scriptlet>}
					}</jsp:scriptlet>
								<li class="last"><a href="#" onclick="div_show2()">+Add
										new category.</a></li>
							</ul>
						</div>
					</div>
				</div>
				<div id="content" class="float_r">
					<div class="float_c">
						<h4>
							Welcome to
							<%=restaurant.getName()%></h4>
					</div>
					<div class="cleaner"></div>
					<div class="float_l">
						<h6>
							Our address:<%=restaurant.getAddress()%></h6>
					</div>
					<div class="float_r">
						<h6>
							Our Number:<%=restaurant.getPhone()%></h6>
					</div>
					<div class="cleaner"></div>

					<div id="ShopLogo">
						<img src="images/<%=restaurant.getPicture()%>" alt="" width="100%"
							height="250px" border="1px" />
						<h5><%=restaurant.getDescription()%></h5>
					</div>
					<script type="text/javascript">
						$(window).load(function() {
							$('.CenteralImage').find('img').each(function() {
							        var imgClass = (this.width / this.height > 1) ? 'wide' : 'tall';
							        $(this).addClass(imgClass);
							    })
						});
					</script>

					<br />
					<jsp:scriptlet>iLable choosenLable = null;
					String lableIndexS = (String) request
							.getParameter("lableIndex");
					int lableIndex_Server = -1;
					if (lableIndexS != null) {
						try {
							lableIndex_Server = Integer.parseInt(lableIndexS);
							if (lableIndex_Server >= 0) {
								choosenLable = menu.getLables().get(
										lableIndex_Server);
								session.setAttribute("lblPkid",
										choosenLable.getPkid());</jsp:scriptlet>
					<h1><%=choosenLable.getLable()%></h1>
					<jsp:scriptlet><![CDATA[iItem item = null;
								for (int itemIndex = 0; itemIndex < choosenLable
										.getItems().size(); itemIndex++) {
									item = choosenLable.getItems().get(
											itemIndex);]]></jsp:scriptlet>
					<div class="product_box">
						<h3><%=item.getName()%></h3>
						<div class="CenteralImage">
							<img class="CenteralImage" src="images/<%=item.getPic()%>"
								alt="Items" />
						</div>
						<p><%=item.getDesc()%></p>
						<p class="product_price"><%=item.getPrice()%>$
						</p>
						<p align="left">
							<a
								href="EditItem.jsp?itemIndex=<%=itemIndex%>&lableIndex=<%=lableIndex_Server%>"
								style="font-size: 12pt; color: blue;">Edit Item</a>
							<a style="font-size: 12pt; color: blue;" onclick="alert('The item will be deleted permently.')"
								href="DeleteItem?itemIndex=<%=itemIndex%>&lableIndex=<%=lableIndex_Server%>">Delete</a>
						</p>
					</div>
					<div class="cleaner"></div>
					<jsp:scriptlet>}</jsp:scriptlet>
					<!-- WITH JAVASCRIPT -->
					<div class="cleaner"></div>
					<div class="product_box">
						<img src="images/plus.png"
							onclick="div_show(<%=restaurant.getPkid()%>)"
							style="cursor: pointer;" width="10%" height="10%" />
					</div>

					<jsp:scriptlet>}
						} catch (NumberFormatException e) {
							e.printStackTrace();
							request.getRequestDispatcher("/ClientsPage.jsp")
									.forward(request, response);
						}
					}</jsp:scriptlet>
				</div>
				<div class="cleaner"></div>
			</div>

			<!-- END of templatemo_main -->
			<jsp:scriptlet>}
			}</jsp:scriptlet>

			<!-- END OF THE LOGIN CHECK-->

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
	function validText() {
		var x = document.forms["CategoryForm"]["Name"].value;
	    if (x == null || x == "") {
			alert("A valid name must be filled out");
			return false;
			}
		'<%session.setAttribute("isNewL", true);%>'
		return true;
	}
	
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
				if (x.files.length == 0 || x.files.length> 1 ) {
					alert("Background picture must be added");
					return false;
				} else
					isPic = ValidatePic();
			}
			if(isPic){
				'<%session.setAttribute("isNewI", 1);%>';
			}
			return isPic;
	
		}
	</script>

	<script type="text/javascript">
	
		//Function To Display Popup
		function div_show(pkid) {
			document.getElementById('AddNewItem').style.display = "block";
			document.getElementById('templatemo_main').style.display = "none";
		}
		//Function to Hide Popup
		function div_hide(){
			document.getElementById('AddNewItem').style.display = "none";
			document.getElementById('templatemo_main').style.display = "block";
		}
		
		//Function To Display Popup
		function div_show2() {
			document.getElementById('AddNewCategory').style.display = "block";
			document.getElementById('templatemo_main').style.display = "none";
		}
		
		//Function to Hide Popup
		function div_hide2(){
			document.getElementById('AddNewCategory').style.display = "none";
			document.getElementById('templatemo_main').style.display = "block";
		}
	</script>

</body>
</html>