<cfparam name="attributes.print" type="boolean" default="false">
<cfparam name="attributes.justify" type="string" default="center">
<cfparam name="attributes.style" type="string" default="default">
<cfoutput><div align="#attributes.justify#"><font face="arial" size="3">



<form>

<cfif attributes.style IS "table">
	<table cellpadding="0" cellspacing="0" width="100%">
	<tr>
	<td align="left"><input type="button" value="Close" onClick="javascript:self.close();"></td>
	<td align="right"><input type="button" value="Print this Page" onClick="javascript:print()"></td>
	</tr>
	</table>
<cfelse>
	<cfif attributes.print>
	<input type="button" value="  Print  " onClick="self.print();"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	</cfif>
	<input type="button" value=" Close " onClick="if (!opener.closed) opener.focus(); self.close();">
</cfif>

</form>
</font></div></cfoutput>