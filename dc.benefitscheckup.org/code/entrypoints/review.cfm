<cfmodule template="../header.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<!-- shows data entry activity for entry points -->
<HTML>
<HEAD>
	<TITLE>Review</TITLE>
</HEAD>

<BODY>
<CFSET dt = #dateFORMat(now(),"MM/DD/YY")# & ' 00:00:00.000'>
<CFQUERY DATASOURCE="#application.dbSrc#" NAME="activity">
	SELECT org_name,address,org_id
	FROM tbl_entry
	WHERE added_by='#session.user#' AND added_dt = now()
</CFQUERY>

<CFOUTPUT query="activity">
	<A HREF="spons_agcy2.cfm?org_id=#org_id#&datasrc=#application.dbSrc#&user=#session.user#">#org_name# - #address#</A><BR>
</CFOUTPUT>
<CFIF activity.recordcount IS 0>
	No entry points could be found for the user, <CFOUTPUT>#session.user#</CFOUTPUT>. If you think this is
	incorrect please see Jennifer.
</CFIF>
</BODY>
</HTML>
<cfmodule template="../footer.cfm">