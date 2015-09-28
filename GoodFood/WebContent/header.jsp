<jsp:directive.page import="com.sce.service.Account" />
<jsp:directive.page import="com.sce.service.Administrator" />
<jsp:directive.page import="com.sce.service.Client" />
<jsp:directive.page import="com.sce.service.User" />

		<table class="style1" align="center">
			<tr>
<jsp:scriptlet>
synchronized (session) {
	Account account = (Account) session.getAttribute("account");
	if (account == null) {
</jsp:scriptlet>
					<td>
						<div class="logo">
	                   		<a href="index.jsp"><img src="images/logo.jpg" alt="logo"/></a>
	                   	</div>
                   	</td>
                    <td>
                        <form id="userlogin" action="Login" method="post">
                            <table class="style1">
                                <caption>Login</caption>
                                <tr>
                                    <td><span id="lblLogin1">User name:</span></td>
                                    <td align="center">
                                        <input type="text" size="22" name="username" />
                                    </td>
                                </tr>
                                <tr>
                                    <td><span id="lblLogin1">Password:</span></td>
                                    <td align="center">
                                        <input type="password" size="22" name="password"/>
                                    </td>
                                </tr>
                                <tr>
<jsp:scriptlet>
String loginMessage = (String)request.getAttribute("login_er");
if(loginMessage != null) {
</jsp:scriptlet>
									<td colspan="2"><jsp:expression>loginMessage</jsp:expression></td>
<jsp:scriptlet>
} else {
</jsp:scriptlet>
									<td colspan="2">&nbsp;</td>
<jsp:scriptlet>
}
</jsp:scriptlet>
                                </tr>
                                <tr>
                                    <td colspan="2" align="center">
                                        <input type="submit" class="myButton" name="login" value="Login"/>
                                        <input type="button" class="myButton" name="registration" value="Registration" onclick="location.href='registration.jsp';" />
                                    </td>
                                </tr>
                                <tr align="center" valign="bottom">
                                    <td>&nbsp;</td>
                                    <td><a class="hyper" href="PasswordRecovery.jsp">Forgot Password?</a></td>
                                </tr>
                            </table>
                        </form>
                     </td>
<jsp:scriptlet>
	} else {
</jsp:scriptlet>
					<td>
						<div class="logo">
	                   		<a href="index.jsp"><img src="images/logo.jpg" alt="logo"/></a>
	                   	</div>
                   	</td>
                    <td>
                            <table>
                                <caption>Welcome!</caption>
                                <tr>
                                    <td align="center">
<jsp:scriptlet>
Integer roll = (Integer)session.getAttribute("roll");
if(account.getRoll() == 0) {
	Administrator administrator = (Administrator)account;
</jsp:scriptlet>
	<jsp:expression>administrator.getFirstName() + " " + administrator.getLastName()</jsp:expression>
<jsp:scriptlet>
} else if(account.getRoll() == 1) {
	Client client = (Client)account;
</jsp:scriptlet>
								   	<p>
								          	<input type="button" class="myButton" name="editres" value="Edit Restaurant" onclick="location.href='EditRestaurant.jsp';" />
								   	</p>
	<jsp:expression>client.getFirstName() + " " + client.getLastName()</jsp:expression>
<jsp:scriptlet>
} else if(account.getRoll() == 2) {
	User user = (User)account;
</jsp:scriptlet>
	<jsp:expression>user.getFirstName() + " " + user.getLastName()</jsp:expression>
	 <tr>       
       <td><input type="button" class="myButton" name="userPage" value="User-Page" onclick="location.href='UserPage.jsp';" /></td>
      </tr>
<jsp:scriptlet>
}
</jsp:scriptlet>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                    	<form id="userlogin" action="EndLogin" method="post">
                                        	<input type="submit" class="myButton" name="exit" value="Exit" />
                                        </form>
                                    </td>
                                </tr>
                                <tr align="center" valign="bottom">
                                    <td>&nbsp;</td>
                                </tr>
                            </table>
                        </td>
<jsp:scriptlet>
	}
}
</jsp:scriptlet>
</tr>
</table>