<CFIF NOT ISDEFINED("a")>
	<CFSET a = 1>
</CFIF>
	
<CFIF #a# MOD 2 EQ "0">
	<CFSET Bgclr = "99CCCC">
<CFELSE>
	<CFSET Bgclr = "DEDFD2">
</CFIF>	
<CFSET a = a + 1>
