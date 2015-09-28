<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@page import="javax.swing.text.StyledEditorKit.ForegroundAction"%>
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
		var visableItem = 0;
		function visableItems(index) {
			document.getElementById("items"+visableItem).style.display = "none";
			visableItem = index;
			document.getElementById("items"+visableItem).style.display = "block";
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
			<table width="900" border="0" align="center" cellpadding="0" cellspacing="0">			
		<tr>
			<td colspan="2" style="text-align: center">
			<!-- Body -->
				<jsp:directive.page import="java.util.Map" />
				<jsp:directive.page import="java.util.Set" />
				<jsp:directive.page import="com.sce.service.Menu" />
				<jsp:directive.page import="com.sce.service.Label" />
				<jsp:directive.page import="com.sce.service.Item" />
				<jsp:directive.page import="com.sce.service.RestaurantDetails" />
				<jsp:directive.page import="com.sce.service.Cart" />
				<table border="0" align="center" cellpadding="0" cellspacing="1">
<jsp:scriptlet>
<![CDATA[
    /*Cart temp = new Cart();
    temp.setItem(2);
    temp.setItem(3);
	session.setAttribute("cart", temp);*/
	boolean flagErrorRest = false;
	String pkIdRestParameter = request.getParameter("id");
	
	if(pkIdRestParameter != null) {
		int pkIdRest = 0;
		
		try {
            pkIdRest = Integer.parseInt(pkIdRestParameter);
        } catch (NumberFormatException e) {
        	flagErrorRest = true;
        }
		
		if(!flagErrorRest) {
			Menu menu = new Menu(pkIdRest);
			RestaurantDetails restaurantDetails = new RestaurantDetails(pkIdRest);
			if(!menu.isEmpty() && !menu.isEmpty()) {
]]>
</jsp:scriptlet>
					<tr>
						<td colspan="2"><img src="images/<%=restaurantDetails.getPicRef()%>" width="400" height="230" /></td>
					</tr>
                    <tr>
                    	<td align="left" valign="top">
<jsp:scriptlet>
<![CDATA[
          		Cart cart = (Cart)session.getAttribute("cart");
          		boolean cartErrorFlag = false;
				if(cart != null) {
					
	          		if(cart.getPkidRest() != pkIdRest) {
	    		    	cart = new Cart();
	    		    	cart.setPkidRest(pkIdRest);
	    		    	session.removeAttribute("cart");
	    		    	session.setAttribute("cart", cart);
	          		}
	          		
					if(!cart.isEmpty()) {
						
]]>
</jsp:scriptlet>
							<script type="text/javascript">
								var items = <%=cart.getJavaScriptData()%>;
							</script>
<jsp:scriptlet>
<![CDATA[
					} else {
						cartErrorFlag = true;
					}
				} else {
					cartErrorFlag = true;
				}
				
				if(cartErrorFlag) {
]]>
</jsp:scriptlet>
							<script type="text/javascript">
								var items = [];
							</script>
<jsp:scriptlet>
<![CDATA[		}]]>
</jsp:scriptlet>
                    		<table id="orders" border="0" cellpadding="1" cellspacing="1">
                    			<caption>Orders</caption>
                    			<tr><td>&#8470;</td><td>Name</td><td>Price</td><td>Count</td><td>&nbsp;</td></tr>
                    		</table>
                    		<table id="orders" border="0" cellpadding="1" cellspacing="1">
                    			<tr><td>Shipping cost: <span id="shippingcost">20</span> &#8362;</td></tr>
                    			<tr><td>Total price: <span id="totalprice">0</span> &#8362;</td></tr>
                    			<tr><td><input type="button" value="Order" onclick="ordering()" /></td></tr>
                    		</table>
                    	</td>
						<td align="right" valign="top">
<jsp:scriptlet>
<![CDATA[
				for(int i = 0; i < menu.getSize(); i++) {
					Label label = menu.getLabel(i);
]]>
</jsp:scriptlet>
                        	<table id="items<%=i%>" border="0" cellpadding="0" cellspacing="1" style="display: none;">
                            
<jsp:scriptlet>
<![CDATA[
					for(int j = 0; j < label.getSize(); j++) {
						Item item = label.getItem(j);
]]>
</jsp:scriptlet>
							<tr><td class="menu">
                                <table border="0" cellpadding="0" cellspacing="1" width="100%">
                                    <tr>
                                        <td rowspan="3" width="102" height="102"><img src="images/<%=item.getItemPhoto()%>" width="170" height="170" /></td>
                                        <td style="font-weight:bold;"><span id="itemname<%=item.getPkId()%>"><%=item.getItemName()%></span></td>
                                        <td><img onclick="ajaxAddToCart(<%=item.getPkId()%>);" src="images/cart.png" /></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">Price: <span id="itemprice<%=item.getPkId()%>"><%=item.getPrice()%></span> &#8362;</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2"><%=item.getDescription()%></td>
                                    </tr>
                                </table>
                            </td></tr>
<jsp:scriptlet>
<![CDATA[
					}
]]>
</jsp:scriptlet>
                            </table>
<jsp:scriptlet>
<![CDATA[
				}
]]>
</jsp:scriptlet>
                        </td>
                        <td align="left" valign="top">
                        	<table border="0" cellpadding="0" cellspacing="1">
<jsp:scriptlet>
<![CDATA[
				for(int i = 0; i < menu.getSize(); i++) {
]]>
</jsp:scriptlet>
                            <tr><td class="label">
                                <span onclick="visableItems(<%=i%>)"><%=menu.getLabel(i).getName()%></span>
                            </td></tr>
<jsp:scriptlet>
<![CDATA[
				}
]]>
</jsp:scriptlet>
                            </table>
                        </td>
					</tr>
<jsp:scriptlet>
<![CDATA[
			} else {
				flagErrorRest = true;
			}
		} else {
			flagErrorRest = true;
		}
	} else {
		flagErrorRest = true;
	}
	
	if(flagErrorRest == true) {
]]>
</jsp:scriptlet>
					<tr>
						<td width="100%" colspan="2">
							<br />Sorry, but an error occurred database, or site owner has not yet had time to add the items.
						</td>
					</tr>
<jsp:scriptlet>
<![CDATA[}]]>
</jsp:scriptlet>
				</table>
				<script type="text/javascript">
					visableItem = 0;
					document.getElementById("items"+visableItem).style.display = "block";
					
					for(i = 0; i < items.length; i++) {
						AddToCartTable(items[i][0], items[i][1]);
					}
					
					function Ordering()
					{
						var sum = 0;
						for(i = 0; i < items.length; i++) {
							sum += parseInt(document.getElementById("itemprice"+idi).innerHTML);
						}
						
						location.href='ordering.jsp';
					}
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