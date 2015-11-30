<cfparam name="titlegroup" type="string" default="">
<cfparam name="titlecode" type="string" default="">
<cfparam name="group" type="string">
<cfparam name="code" type="string">
<HTML>
<HEAD>
<TITLE><cf_tagBCU> Help</TITLE>
</HEAD>
<!--- Javascript to close window --->
<BODY ONBLUR="window.close();" BGCOLOR="white" onLoad="window.focus();">


<!--- Display the results of the query --->
<TABLE>
	<TR>
		<TD>
		<cfif titlegroup neq '' and titlecode neq ''>
			<cf_displayText group="#titlegroup#" code="#titlecode#" var="title">
			<cfif title neq ''>
				<FONT FACE="arial" COLOR="Black"><strong><cf_displayText group="#titlegroup#" code="#titlecode#"></strong><BR><BR></FONT>
			</cfif>
		</cfif>
		<FONT FACE="arial" COLOR="Black"><cf_displayText group="#group#" code="#code#"><BR><BR></FONT>
		</TD>
	</TR>
	<TR>
		<TD ALIGN="center">
			<cf_tagClose>
		</TD>
	</TR>
</TABLE>

</BODY>
</HTML>
