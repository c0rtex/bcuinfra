<h1>EDIT USER</h1>
<cfset user = event.getArg("user") />
<cfset address = user.getAddress()>
<cfset roles = event.getArg("roles")>
<cfoutput>
	<div class="nowEditing">
		<b>NOW EDITING</b>: #user.getFirstname()#&nbsp;#user.getLastname()#<br />
    </div>
</cfoutput>
<script type="text/javascript">
	function validate(el){
		if($(el).val() == ""){
				switch($(el).attr("name")){
					case "username":
					case "password":
					case "firstname":
					case "lastname" :
					case "email" :
						alert("you need to enter a value");
						break;
				}
		}
	}
</script>
<cfdump var="#user#" expand="no">
<cfdump var="#user.getRoles()#" expand="no">
<div class="formContainer">
    <form name="createUser" id="createUser" action="index.cfm?event=admin.processUserEdit" method="post">
    	<input type="hidden" name="user_id" value="<cfoutput>#user.getUser_id()#</cfoutput>" />
        <input type="hidden" name="modify_user_id" value="<cfoutput>#session.user.getUser_id()#</cfoutput>" />
        <input type="hidden" name="modify_date" value="<cfoutput>#now()#</cfoutput>" />
        <input type="hidden" name="last_login_date" value="<cfoutput>#user.getLast_login_date()#</cfoutput>" />
        <input type="hidden" name="create_date" value="<cfoutput>#user.getCreate_date()#</cfoutput>" />
        <input type="hidden" name="create_user_id" value="<cfoutput>#user.getCreate_user_id()#</cfoutput>" />
    <table cellpadding="0" cellspacing="0" border="0">
    	<tr>
        	<td>Username: </td>
            <td><input onblur="javascript:validate(this);" type="text" id="username" name="username" value="<cfoutput>#user.getUsername()#</cfoutput>" /></td>
        </tr>
        <tr>
        	<td>Password: </td>
            <td><input onblur="javascript:validate(this);" type="text" id="password" name="password" value="<cfoutput>#user.getPassword()#</cfoutput>" /></td>
        </tr>
        <tr>
        	<td>Fist Name: </td>
            <td><input onblur="javascript:validate(this);" type="text" id="firstame" name="firstname" value="<cfoutput>#user.getFirstname()#</cfoutput>" /></td>
        </tr>
        <tr>
        	<td>Last Name: </td>
            <td><input onblur="javascript:validate(this);" type="text" id="lastname" name="lastname" value="<cfoutput>#user.getLastName()#</cfoutput>" /></td>
        </tr>
        <tr>
        	<td>Email: </td>
            <td><input onblur="javascript:validate(this);" type="text" id="email" name="email" value="<cfoutput>#user.getEmail()#</cfoutput>" /></td>
        </tr>
        <tr>
        	<td>Active: </td>
            <td>Yes: <input type="radio" name="active" value="true" checked="checked" />&nbsp;No: <input type="radio" name="active" value="false" /></td>
        </tr>
        <tr>
        	<td>Street: </td>
            <td><input type="text" id="street" name="street" value="<cfoutput>#address.getStreet()#</cfoutput>" /></td>
        </tr>
        <tr>
        	<td>City: </td>
            <td><input type="text" id="city" name="city" value="<cfoutput>#address.getCity()#</cfoutput>" /></td>
        </tr>
        <tr>
        	<td>State: </td>
            <td><input type="text" id="state" name="state" value="<cfoutput>#address.getState()#</cfoutput>" /></td>
        </tr>
        <tr>
        	<td>Zipcode: </td>
            <td><input type="text" id="zip" name="zip" value="<cfoutput>#address.getZip()#</cfoutput>" /></td>
        </tr>
        <tr>
        	<td>Select Roles: </td>
            <td>
            	<cfloop query="roles">
					<cfoutput>#roles.usertype_name#</cfoutput>:<input <cfif user.hasRole(roles.usertype_code)>checked</cfif> type="checkbox" name="role_ids" value="<cfoutput>#roles.usertype_id#</cfoutput>" /><br />
                </cfloop>
            </td>
        </tr>
        <tr>
        	<td colspan="2"><input type="submit" id="submit" value="Edit User" name="submit" /></td>
        </tr>
    </table>
    </form>
</div>
<br />
