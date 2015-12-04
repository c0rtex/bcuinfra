<head><title>BenefitsCheckUp - NCOA's Online Screening Service</title></head>
<cfset urlstring=CGI.QUERY_STRING >
<cfif len('ST') eq 2>
	<cfset session.st = url.st>
<cfelse>
	<cfset session.st = 'FD'>
</cfif>
<frameset rows="1,98" frameborder="NO" >
<cfoutput>
  <frame src="../frmAccessMeta.cfm?#urlstring#" name="mainFrame" scrolling="no">
  
  <frame src="../frmDetails.cfm?#urlstring#&content_title_override=#urlencodedformat('Application Forms Center')#" name="bottomFrame" scrolling="Yes" noresize>
</cfoutput>
</frameset><noframes></noframes>

