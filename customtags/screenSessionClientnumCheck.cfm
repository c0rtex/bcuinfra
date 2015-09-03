<!--- IF CLIENTNUM ALREADY EXISTS IN DB, THEN SET AND STORE NEW CLIENTNUM --->
<cfif not IsDefined('session.clientnum')>
	<cf_screenSessionClientnum>
<cfelse>
	<cfquery name="test4Clientnum" datasource="#application.dbSrc#">
		select clientnum
		from tbl_user_ans
		where CLIENTNUM=#session.clientnum#
	</cfquery>
	<cfif test4Clientnum.RecordCount gt 0>
		<cf_screenSessionClientnum>
	</cfif>
</cfif>