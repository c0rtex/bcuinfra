<cfparam name="target" type="string" default="">
<cfparam name="src" type="string" default="">
<cfparam name="sr" type="numeric" default="1">
<HTML>
<HEAD>
	<TITLE></TITLE>
	<script language="JavaScript" src="ValidationFunctions.js"></script>
	<script language="JavaScript">
	<!--
		function checkLowerFrame(thisForm) {
			if (window.parent.lowerframe.frames.length == 0) {
				if (confirm('WARNING: If you leave this e-Form without having completed it and chosen to "Review and Print" it, any responses you entered here will not be carried over to the next e-Form you access.  Are you sure you want to continue?')) {
					thisForm.submit();
				}
			} else {
				thisForm.submit();
			}
		}
	// -->
	</script>
</HEAD>

<body 
	<cfif session.partner_id eq 7>
		bgcolor="#999966"
	<cfelseif IsDefined('session.cobrand_bgcolor') and session.cobrand_bgcolor neq '' and session.cobrand_bgcolor neq 0>
		bgcolor="<cfoutput>#session.cobrand_bgcolor#</cfoutput>"
	<cfelse>
		bgcolor="#00594b"
	</cfif>
>
	<cfoutput>

	<table border="0" cellspacing="0" cellpadding="0" width="100%">
		<tr>
			
			<td valign="top" align="left">

<!---
	<table border="0" cellspacing="0" cellpadding="5">
		<tr>
			
			
			<td valign="top" align="left" width="10%">
					<input type="button" name="facthelp" value="Help" onClick="help2('hlpEFormsFrame.cfm')">
			</td>
		</tr>
	</table>
--->
	
			</td>
			<td valign="top" align="right">

	<table border="0" cellspacing="0" cellpadding="5">
		<tr>
		<cfif application.debug>
			<td valign="top" align="right">
				<form action="xml.cfm" method="post" name="eform" target="_blank">
				<cf_genAssistGuideXML includePrgIDs="true">
				<input type="hidden" name="#url.code#" value="include">
				<input type="hidden" name="startxml" value="#startAssistGuideXML#">
				<input type="hidden" name="endxml" value="#endAssistGuideXML#">
				<input type="hidden" name="xml" value="">
				<input type="button" value="XML" onClick="document.eform.xml.value = document.eform.startxml.value; for (x = 0; x < document.eform.elements.length; x++) {if (document.eform.elements[x].type == 'hidden' && document.eform.elements[x].value == 'include') {document.eform.xml.value = document.eform.xml.value + '<Form>' + document.eform.elements[x].name + '</Form>\n';}} document.eform.xml.value = document.eform.xml.value + document.eform.endxml.value; document.eform.submit();">
				</form>
			</td>
		</cfif>
			<td valign="top" align="right">
			<cfif src eq 'rec'>
			<form action="frmRecommend.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" method="post" target="_top">
				<input type="submit" value="Return to ABC Recommendations"><br>
			<cfelseif target eq ''>
			<form action="frmEForms.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" method="post" target="_parent">
				<input type="submit" value="Return to Application Guide"><br>
			<cfelse>
			<form action="frmDetails.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#&prg_id=#target#&src=#src#&sr=#sr#" method="post" target="_top">
				<input type="submit" value="Return to Program Details"><br>
			</cfif>
				<!---
				<input type="button" value="Return to Application Guide" onClick="checkLowerFrame(this.form);"><br>
				--->
				<img src="images/pixel.gif" width="1" height="5" alt=""><br>
				<span style="background: ##ffffff; font-family: Arial, Helvetica, Verdana, sans-serif; font-size: 10pt;">
					<a href="javascript:help2('http://www.assistguide.com/ncoaprivacy')">Privacy&nbsp;Policy</a></span>&nbsp;
			</form>
			</td>
		</tr>
	</table>
		
			</td>
			
		</tr>
	</table>

</cfoutput>

</body>
</html>
