<!---if not logged in, send them to login page, else load the index page--->
<cfif NOT StructKeyExists(session, "loggedin") OR NOT session.loggedin>
    <cflocation url="../index.cfm" addToken="no" />
<cfelse>
 <!---Load the page --->
</cfif>