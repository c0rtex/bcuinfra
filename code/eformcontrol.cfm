<cfparam name="eflist" type="string">
<cfparam name="efindex" type="numeric">
<cfparam name="efnums" type="string" default="">
<cfparam name="src" type="string" default="">

<html>
<head>
<title>BenefitsCheckUp</title>
	<script language="JavaScript">
	<!--
		function checkLowerFrame(thisForm) {
			if (window.parent.application.frames.length == 0) {
				if (confirm('WARNING: If you leave this e-Form without having completed it and chosen to "Review and Print" it, any responses you entered here will not be carried over to the next e-Form you access.  Are you sure you want to continue?')) {
					thisForm.submit();
				}
			} else {
				thisForm.submit();
			}
		}
	// -->
	</script>
</head>

	<cfif IsDefined('session.cobrand_bgcolor') and session.cobrand_bgcolor neq '' and session.cobrand_bgcolor neq 0>
		<body bgcolor="<cfoutput>#session.cobrand_bgcolor#</cfoutput>">
	<cfelse>
		<body bgcolor="#00594b">
	</cfif>
	<cfoutput>
	<cfif application.debug>
	<table border="0" cellspacing="0" cellpadding="0" width="100%">
		<tr>
			<td align="left" valign="top">
	</cfif>
	<table border="0" cellspacing="0" cellpadding="5">
		<tr>
			<cfif efindex gt 1>
			<td valign="top">
			<form action="eformframe.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" method="post" name="preveform" target="_parent">
				<input type="hidden" name="eflist" value="#eflist#">
				<input type="hidden" name="efindex" value="#Evaluate("efindex - 1")#">
				<input type="hidden" name="efnums" value="#efnums#">
				<input type="hidden" name="src" value="#src#">
				<input type="button" value="Previous e-Form" onClick="checkLowerFrame(this.form);">
			</form>
			<cfelse>
			<td valign="top"><img src="images/pixel.gif" width="1" height="4" border="0" alt=""><br>
				<span style="background: ##FFFFFF; font-family: Arial, Helvetica, Verdana, sans-serif;">&nbsp;[&nbsp;<i>No&nbsp;Previous&nbsp;e-Form</i>&nbsp;]&nbsp;</span>
			</cfif>
			</td>
			<cfif efindex lt ListLen(eflist)>
			<td valign="middle">
			<form action="eformframe.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" method="post" name="nexteform" target="_parent">
				<input type="hidden" name="eflist" value="#eflist#">
				<input type="hidden" name="efindex" value="#Evaluate("efindex + 1")#">
				<input type="hidden" name="efnums" value="#efnums#">
				<input type="hidden" name="src" value="#src#">
				<input type="button" value="Next e-Form" onClick="checkLowerFrame(this.form);">
			</form>
			<cfelse>
			<td valign="top"><img src="images/pixel.gif" width="1" height="4" border="0" alt=""><br>
				<span style="background: ##FFFFFF; font-family: Arial, Helvetica, Verdana, sans-serif;">&nbsp;[&nbsp;<i>No&nbsp;Next&nbsp;e-Form</i>&nbsp;]&nbsp;</span>
			</cfif>
			</td>
			<td valign="middle">
			<form action="<cfif src eq 'test'>eformtest<cfelse>frmEForms</cfif>.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" method="post" name="returneform" target="_parent">
				<input type="hidden" name="eflist" value="#eflist#">
				<input type="hidden" name="efnums" value="#efnums#">
				<input type="hidden" name="src" value="#src#">
				<input type="button" value="Return to <cfif src eq 'comp'>e-Forms Page<cfelseif src eq 'test'>Test Page<cfelse>Application Guide</cfif>" onClick="checkLowerFrame(this.form);">
			</form>
			</td>
			<cfif session.source_id eq 2 or session.source_id eq 3>
			<td valign="middle">
			<cf_displayButton return_oe="true">
			</td>
			</cfif>
		</tr>
	</table>
		<cfif application.debug>
			</td>
			<td align="left" valign="top">
	<table border="0" cellspacing="0" cellpadding="5">
		<tr>
			<td>
				<form action="xml.cfm" method="post" name="eform" target="_blank">
				<cf_genAssistGuideXML>
				<input type="hidden" name="#ListGetAt(eflist, efindex)#" value="include">
				<input type="hidden" name="startxml" value="#startAssistGuideXML#">
				<input type="hidden" name="endxml" value="#endAssistGuideXML#">
				<input type="hidden" name="xml" value="">
				<input type="button" value="XML" onClick="javascript:document.eform.xml.value = document.eform.startxml.value; for (x = 0; x < document.eform.elements.length; x++) {if (document.eform.elements[x].type == 'hidden' && document.eform.elements[x].value == 'include') {document.eform.xml.value = document.eform.xml.value + '<Form>' + document.eform.elements[x].name + '</Form>\n';}} document.eform.xml.value = document.eform.xml.value + document.eform.endxml.value; document.eform.submit();">
				</form>
			</td>
		</tr>
	</table>
			</td>
		</tr>
	</table>
		</cfif>
	</cfoutput>

</body>
</html>