<tr>
  <td>
  <form action="addCategory?restPkid=<%=request.getParameter("restPkid")%>" method="post">
	<table border="1" >
		<tr>
			<td>
				<table>
					<tr>
						<td colspan="2" style="text-align: center">
							<span id="lbl_edit">New SubCategory:</span>
						</td>
					</tr>
					<tr>
						<td>
							<span id="lbl_name">Name:</span>
						</td>
						<td>
							<input type="text" name="Name" id="txtName" size="40" />
						</td>
					</tr>
					<tr>
						<td colspan="2" style="text-align: center">
							<input type="submit"  name="Save" value="Save changes" id="btnSave" />
							<input type="button" name="Cancel" value="Cancel" id="btnCancel" onclick="location.href = 'ClientsPage.jsp';"  />
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	</form>
  </td>
</tr>