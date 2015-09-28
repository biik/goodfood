<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
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
    	<div>
        	<h1>Shopping Cart</h1>
        	<table width="680px" cellspacing="0" cellpadding="5">
                   	  <tr bgcolor="#ddd">
                        	<th width="220" align="left">Image </th> 
                        	<th width="180" align="left">Description </th> 
                       	  	<th width="100" align="center">Quantity </th> 
                        	<th width="60" align="right">Price </th> 
                        	<th width="60" align="right">Total </th> 
                        	<th width="90"> </th>
                            
                      </tr>
                    	<tr>
                        	<td><img src="images/product/01.jpg" alt="image 1" /></td> 
                        	<td>Etiam in tellus (Validate <a href="http://validator.w3.org/check?uri=referer" rel="nofollow">XHTML</a> &amp; <a href="http://jigsaw.w3.org/css-validator/check/referer" rel="nofollow">CSS</a>)</td> 
                            <td align="center"><input type="text" value="1" style="width: 20px; text-align: right" /> </td>
                            <td align="right">$100 </td> 
                            <td align="right">$100 </td>
                            <td align="center"> <a href="#"><img src="images/remove_x.gif" alt="remove" /><br />Remove</a> </td>
						</tr>
                        <tr>
                        	<td><img src="images/product/02.jpg" alt="image 2" /> </td>
                            <td>Second Red Shoes</td> 
                       	  	<td align="center"><input type="text" value="1" style="width: 20px; text-align: right" />  </td>
                            <td align="right">$80  </td>
                            <td align="right">$80 </td>
                            <td align="center"> <a href="#"><img src="images/remove_x.gif" alt="remove" /><br />Remove</a>  </td>
						</tr>
                        <tr>
                        	<td><img src="images/product/03.jpg" alt="image 3" /> </td>
                            <td>Hendrerit justo</td> 
                       	  	<td align="center"><input type="text" value="1" style="width: 20px; text-align: right" />  </td>
                            <td align="right">$60  </td>
                            <td align="right">$60 </td>
                            <td align="center"> <a href="#"><img src="images/remove_x.gif" alt="remove" /><br />Remove</a>  </td>
						</tr>
                        <tr>
                        	<td colspan="3" align="right"  height="30px">Have you modified your basket? Please click here to <a href="shoppingcart.html"><strong>Update</strong></a>&nbsp;&nbsp;</td>
                            <td align="right" style="background:#ddd; font-weight:bold"> Total </td>
                            <td align="right" style="background:#ddd; font-weight:bold">$240 </td>
                            <td style="background:#ddd; font-weight:bold"> </td>
						</tr>
					</table>
                    <div style="float:right; width: 215px; margin-top: 20px;">
                        <p><a href="checkout.html">Proceed to checkout</a></p>
                        <p><a href="javascript:history.back()">Continue shopping</a></p>
                    </div>
			</div>
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