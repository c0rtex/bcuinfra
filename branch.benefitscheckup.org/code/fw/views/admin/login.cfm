<h1>LOGIN</h1>
<form name="login" id="login" action="index.cfm?event=admin.authenticate" method="post">
<table cellpadding="0" cellspacing="0" border="0">
	<tr>
    	<td>Username: </td>
        <td><input type="text" id="username" name="username" />
    </tr>
	<tr>
    	<td>Password: </td>
        <td><input type="password" id="password" name="password" /></td>
    </tr>
    <tr>
    	<td colspan="2"><input type="submit" id="submit" value="LOGIN" /></td>
    </tr>
</table>
</form>