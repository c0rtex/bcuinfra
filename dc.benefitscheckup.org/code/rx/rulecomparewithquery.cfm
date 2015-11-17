<cfinclude template="ruleparseforlist.cfm">
<cfinclude template="rulequeryforlist.cfm">
<cfif LCase(rulelist) neq LCase(anslist)>
	<cfif rulelist eq ''>
		<cfset rulelist = anslist>
		<cfset testruleid = 0>
	<cfelse>
		<cfoutput>
		<font size="+2" color="red"><b>THERE IS A PROBLEM!  THE ANSWERFIELDS ASSOCIATED WITH '#testprgid#' DO NOT MATCH UP WITH THE ANSWERFIELDS IN THE RULE!!!  LET BILL KNOW IMMEDIATELY!!!!!<br>rulelist="#rulelist#"<br>anslist="#anslist#"</b></font>
		</cfoutput>
		<cfset causeanerror = thisvariabledoesnotexist>
	</cfif>
</cfif>