<!----=======================================
DESCRIPTION: Checks to make sure user is logged in, the contains the top and left table rows
CALLED BY: N/A
GOES TO: Caller
REQUIRED: N/A
============================================---->

<HTML>
<HEAD>
<CFOUTPUT>
<TITLE>You're Entitled</TITLE>
</CFOUTPUT>
<!--- Check to see if page attribute is passed in --->
<CFIF ISDEFINED("Attributes.page")>
	<CFSET Page = #Attributes.page#>
<CFELSE>	
	<CFSET Page = "">
</CFIF>

			
<BODY topmargin=0 leftmargin=0 marginheight="0" marginwidth="0" background="../graphics/bckgrd7.jpg">


<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 width="780">
	<TR>
	<!---background="../graphics/spacer2.gif" --->
	<TD colspan="2" NOWRAP width="100%" background="../graphics/spacer2.gif" height="176">
		<!==NAVIGATION COLUMN==>
			<CFIF Page IS "Results">
			<IMG SRC="../graphics/resultstitle.gif"><BR>
			<cfelseif Page IS "Details">
			<IMG SRC="../graphics/detailstitle.gif"><BR>
			<CFELSE>
			<IMG SRC="../graphics/newtitle.gif"><BR>
			</cfif>

		

	</TD>
	</TR>
	<TR>
	<TD VALIGN=bottom><img src="../graphics/sponsers.gif" alt="Our Sponsers"></td>
	<TD VALIGN=top ALIGN=center><!---  width=700 --->
		<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=570><TR><TD>
			<!===MAIN CONTENT===>
			<FONT FACE="Arial" >