<!---sets frames for program window--->

<!--- frames --->
<frameset rows="40%,*">
<CFOUTPUT>
  <frame NAME="top" src="program.cfm?prg_id=#prg_id#&user=#user#&datasrc=#datasrc#&level=#level#" marginwidth="10"
  marginheight="10" scrolling="auto">
    <frame NAME="btm" src="prg_rule.cfm?prg_id=#prg_id#&user=#user#&add='false'&datasrc=#datasrc#&level=#level#">
  </frameset>
</frameset>
</CFOUTPUT>
