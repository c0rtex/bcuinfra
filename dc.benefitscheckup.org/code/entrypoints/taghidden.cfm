<CFOUTPUT>
	<INPUT TYPE="hidden" NAME="added_by" VALUE="#session.user#">
	<INPUT TYPE="hidden" NAME="mod_by" VALUE="#session.user#">
	<INPUT TYPE="hidden" NAME="user" VALUE="#session.user#">
	<INPUT TYPE="hidden" NAME="datasrc" VALUE="#application.dbSrc#">
	<CFIF isdefined("level")>
		<INPUT TYPE="hidden" NAME="level" VALUE="#session.user_level#">
	</CFIF>
	<CFIF isdefined("prg_id")>
		<INPUT TYPE="hidden" NAME="prg_id" VALUE="#prg_id#">
	</CFIF>
	<INPUT TYPE="hidden" NAME="added_dt" VALUE="now()">
	<INPUT TYPE="hidden" NAME="mod_dt" VALUE="now()">
</CFOUTPUT>
