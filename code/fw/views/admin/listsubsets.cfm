<h1>LIST SUBSETS</h1>
<cfset subsets = event.getArg("subsets")>
<cfoutput query="subsets">
	<cfif isDefined("session.user") AND session.user.hasRole("superuser")>
        <div class="userListItem">
            <b>ID</b>: #subset_id# | 
            <b>Subset Code</b>: #code# | <a href="index.cfm?event=admin.editSubset&subset_id=#subset_id#">EDIT</a>
        </div>
	<cfelse>
        <div class="userListItem">
            <b>ID</b>: #subset_id# | 
            <b>Subset Code</b>: #program_code#
        </div>
	</cfif>
</cfoutput>