<cfparam name="efitem" type="string">
<cfparam name="prg_id" type="string" default="">

<cf_tagHeader onLoad="document.eform.xml.value = document.eform.startxml.value; for (x = 0; x < document.eform.elements.length; x++) {if (document.eform.elements[x].type == 'hidden' && document.eform.elements[x].value == 'include') {document.eform.xml.value = document.eform.xml.value + '<Form>' + document.eform.elements[x].name + '</Form>\n';}} document.eform.xml.value = document.eform.xml.value + document.eform.endxml.value; document.eform.submit();">

<cfoutput><table width=100% border="0" align="center" cellpadding="#session.cellpadding#" cellspacing="#session.cellspacing#"></cfoutput>
	<tr>
	<td bgcolor=#FFFFFF colspan=2>
<!--Dynamic Area--><font face="arial" size="4" color="#000000">

<h2>Preparing Your e-Form to Display...</h2>

<cfoutput>
<form action="#request.eFormURL#" method="post" name="eform">
<cf_genAssistGuideXML code="#efitem#" prg_id="#prg_id#">
<input type="hidden" name="#efitem#" value="include">
<input type="hidden" name="startxml" value="#startAssistGuideXML#">
<input type="hidden" name="endxml" value="#endAssistGuideXML#">
<input type="hidden" name="xml" value="">

We are now preparing your selected e-Form to display.  If the e-Form does not come up automatically within 15 seconds, please <a href="javascript:document.eform.xml.value = document.eform.startxml.value; for (x = 0; x < document.eform.elements.length; x++) {if (document.eform.elements[x].type == 'hidden' && document.eform.elements[x].value == 'include') {document.eform.xml.value = document.eform.xml.value + '<Form>' + document.eform.elements[x].name + '</Form>\n';}} document.eform.xml.value = document.eform.xml.value + document.eform.endxml.value; document.eform.submit();">click here</a>.

</form>
</cfoutput>

</FONT></TD></TR></TABLE>

<!--- call footer tag --->
<cf_tagFooter>
