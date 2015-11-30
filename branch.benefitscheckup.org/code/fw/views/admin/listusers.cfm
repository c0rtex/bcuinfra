<h1>LIST USERS</h1>
<cfset users = event.getArg("users")>

<cfif isDefined("session.user") AND session.user.hasRole("superuser")>
	<cfoutput query="users">
        <div class="userListItem">
            <b>ID</b>: #user_id# | 
            <b>Username</b>: #username# | <a href="index.cfm?event=admin.editUser&user_id=#user_id#">EDIT</a>
        </div>
    </cfoutput>
<cfelse>
	<cfoutput query="users">
        <div class="userListItem">
            <b>ID</b>: #user_id# | 
            <b>Username</b>: #username#
        </div>
    </cfoutput>
</cfif>
