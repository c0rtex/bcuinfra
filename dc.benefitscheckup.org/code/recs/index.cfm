



<!--- default application & session values for local system --->

 

<!---<cfset application.dbSrc = "rec">--->

<cfset session.user_level = "admin"> 

<cfparam name="action" default="list">



<!--- Include the menu --->

<cfinclude template="recmenu.cfm">



<cfswitch expression="#action#">



<cfcase value="list">

	<cfinclude template="reclist.cfm">

</cfcase>



<cfcase value="edit,edit_,addnew,addnew_,delete,export" delimiters=",">

	<cfinclude template="recedit.cfm">

</cfcase>





</cfswitch>



<cfinclude template="../footer.cfm"><!---  --->