<jsp:directive.page import="java.util.Enumeration" />
<jsp:directive.page import="java.util.Date" />

<table>
<tr><th>Saved Session Data</th></tr>
<jsp:scriptlet>
if(request.getSession(false) != null) {
	<![CDATA[Enumeration<String> setNames = session.getAttributeNames();]]>
	while (setNames.hasMoreElements()) {
		String name = setNames.nextElement().toString();
		Object value = session.getAttribute(name);
</jsp:scriptlet>
	<tr>
		<td>
			<jsp:expression>name + " = " + value</jsp:expression>
		</td>
	</tr>
<jsp:scriptlet>
	}
</jsp:scriptlet>
	<tr><th>Session Statistics</th></tr>
	<tr><td>Session ID:</td><td><jsp:expression>session.getId()</jsp:expression></td></tr>
	<tr><td>New Session:</td><td><jsp:expression>session.isNew()</jsp:expression></td></tr>
	<tr><td>Creation Time:</td><td><jsp:expression>session.getCreationTime()</jsp:expression>
						<i>(<jsp:expression>new Date(session.getCreationTime())</jsp:expression>)</i></td></tr>
	<tr><td>Last Accessed Time:</td><td><jsp:expression>session.getLastAccessedTime()</jsp:expression>
						<i>(<jsp:expression>new Date(session.getLastAccessedTime())</jsp:expression>)</i></td></tr>
	<tr><td>Session Inactive Interval:</td><td><jsp:expression>session.getMaxInactiveInterval()</jsp:expression></td></tr>
<jsp:scriptlet>
} else {
</jsp:scriptlet>
	<tr><th>Session is 'null'</th></tr>
<jsp:scriptlet>
}
</jsp:scriptlet>
	<tr><td>Session ID in Request:</td><td><jsp:expression>request.getRequestedSessionId()</jsp:expression></td></tr>
	<tr><td>Is session id from Cookie:</td><td><jsp:expression>request.isRequestedSessionIdFromCookie()</jsp:expression></td></tr>
	<tr><td>Is session id from URL:</td><td><jsp:expression>request.isRequestedSessionIdFromURL()</jsp:expression></td></tr>
	<tr><td>Is session id valid:</td><td><jsp:expression>request.isRequestedSessionIdValid()</jsp:expression></td></tr>
</table>