<cfparam name="hardrule" type="string" default="">
<cfparam name="answerfield" type="string" default="">

<cf_checkAccess level="1">

<cfset exists = false>
<cfset added = false>
<cfif hardrule neq '' and answerfield neq ''>
	<cfquery name="hr" datasource="#application.dbSrc#">
		select hardrule_id
		from hardrule
		where code='#hardrule#'
	</cfquery>
	<cfquery name="af" datasource="#application.dbSrc#">
		select answerfield_id
		from answerfield
		where answerfield='#answerfield#'
	</cfquery>
	<cfif hr.RecordCount and af.RecordCount>
		<cfquery name="ck" datasource="#application.dbSrc#">
			select hardrule_id, answerfield_id
			from hardrule_answerfield
			where hardrule_id=#hr.hardrule_id#
				and answerfield_id=#af.answerfield_id#
		</cfquery>
		<cfif ck.RecordCount>
			<cfset exists = true>
		<cfelse>
			<cfquery name="in" datasource="#application.dbSrc#">
				insert into hardrule_answerfield
					(hardrule_id, answerfield_id)
				values
					(#hr.hardrule_id#, #af.answerfield_id#)
			</cfquery>
			<cfset added = true>
		</cfif>
	</cfif>
</cfif>
<cfquery name="ra" datasource="#application.dbSrc#">
	select h.code, a.answerfield
	from hardrule_answerfield ha, hardrule h, answerfield a
	where ha.hardrule_id=h.hardrule_id
		and ha.answerfield_id=a.answerfield_id
	order by h.code, a.answerfield
</cfquery>

<cf_buildPage title="Hard-Coded Rule Associations" section="rule">
<cfoutput>

<cfif exists>
	<h2>{#hardrule#, #answerfield#} already exists</h2>
<cfelseif added>
	<h2>{#hardrule#, #answerfield#} added!</h2>
</cfif>

<form action="hardrule.cfm" method="post">

	hardrule:<br />
	<input type="text" name="hardrule" value="#HTMLEditFormat(hardrule)#" size="30" /><br />
	<br />
	answerfield:<br />
	<input type="text" name="answerfield" value="" size="30" /><br />
	<br />
	<input type="submit" value="add" /><br />

</form>

<cfloop query="ra">
	#code#, #answerfield#<br />
</cfloop>

</cfoutput>
</cf_buildPage>