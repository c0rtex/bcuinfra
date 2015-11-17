<cfparam name="datasource" type="string" default="BCU">
<cfparam name="error" type="boolean" default="false">
<cfparam name="delcount" type="numeric" default="0">
<cfparam name="ssndate" type="numeric" default="0">
<cfparam name="zzyzx_ssndate_day" type="numeric" default="0">
<cfparam name="zzyzx_ssndate_month" type="numeric" default="0">
<cfparam name="zzyzx_ssndate_year" type="numeric" default="0">


<cfif ssndate eq 2>

<cfquery name="delSSN" datasource="#datasource#">
	delete
	from screening_answerfield
	where submit_datetime < '#zzyzx_ssndate_year#/#zzyzx_ssndate_month#/#zzyzx_ssndate_day#'
	        and answerfield_id in (
	                select a.answerfield_id
	                from answerfieldtype t, answerfield a
	                where t.code='ssn'
	                and t.answerfieldtype_id=a.answerfieldtype_id
	        )
</cfquery>

</cfif>



<cf_buildPage section="upload" title="Clean Personal Data"><cfoutput>


<h2>Clean Personal Data</h2>

<cftry>
<cfquery name="countSSN" datasource="#datasource#">
select count(*) c, min(sa.submit_datetime) m
from answerfieldtype t, answerfield a, screening_answerfield sa
where t.code='ssn'
        and t.answerfieldtype_id=a.answerfieldtype_id
        and a.answerfield_id=sa.answerfield_id
</cfquery>
<cfcatch type="database">
	<cfset error=true>
	<p style="font-weight: bold; background: ##FF9999; padding: 5px;">The data connection to production is not currently open.  Please contact Kiryl before using this page.</p>
</cfcatch>
</cftry>

<cfif not error>

<cfif ssndate eq 1>

	Are you sure you want to delete all SSNs from earlier than <strong>#zzyzx_ssndate_day# #MonthAsString(zzyzx_ssndate_month)# #zzyzx_ssndate_year#</strong>?<br><br>
	
	<form action="clean.cfm" method="post">
		<input type="submit" value="OK">
		<input type="hidden" name="datasource" value="#datasource#">
		<input type="hidden" name="ssndate" value="2">
		<input type="hidden" name="zzyzx_ssndate_day" value="#zzyzx_ssndate_day#">
		<input type="hidden" name="zzyzx_ssndate_month" value="#zzyzx_ssndate_month#">
		<input type="hidden" name="zzyzx_ssndate_year" value="#zzyzx_ssndate_year#">
		<input type="button" value="Cancel" onClick="history.go(-1);">
	</form>

<cfelse>

<cfif ssndate eq 2>
	<p style="font-weight: bold; background: ##99FF99; padding: 5px;">SSNs removed from database</p>
</cfif>

<strong>Number of SSNs stored:</strong>&nbsp;  #countSSN.c#<br>
<strong>Earliest SSN stored:</strong>&nbsp; #countSSN.m#<br><br>

<form action="clean.cfm" method="post">
	<cf_buildDateSelect name="ssndate" date="#countSSN.m#" required="false"><br><br>
	<input type="submit" value="Remove SSNs earlier than this date">
	<input type="hidden" name="datasource" value="#datasource#">
</form>


</cfif>

</cfif>

</cfoutput></cf_buildpage>