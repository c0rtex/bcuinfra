<cfsilent>
<cfparam name="attributes.program_id" type="numeric">
<cfparam name="attributes.var" type="string" default="">
<cfparam name="attributes.append" type="boolean" default="false">

<cfset outstr = ''>
<cf_cacheProgramPool action="get" id="#attributes.program_id#" var="pobj">
<cfif IsDefined('session.selectedDrugs')>
	<cfquery name="matchingdrugs" datasource="#application.dbSrc#">
		select a.answerfield, convert(varchar(255), dl.display_text) option_nm
		from program_rule pr, rule_answerfield ra, answerfield a, display_language dl
		where pr.program_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.program_id#" maxlength="6">
			and pr.rule_id=ra.rule_id
			and ra.answerfield_id=a.answerfield_id
			and a.answerfieldtype_id in (13, 14)
			and a.display_id=dl.display_id
			and dl.language_id='#session.language_id#'
		ORDER BY option_nm
	</cfquery>
	<cfset hasOutputted = 0>
	<cfloop query="matchingdrugs">
		<cfif ListFindNoCase(session.selectedDrugs, answerfield) gt 0>
			<cfif hasOutputted eq 0>
				<cfset outstr = outstr & "<b>This program applies to the following medications you are currently taking:</b><ul>">
				<cfset hasOutputted = 1>
			</cfif>
			<cfset outstr = outstr & "<li>#option_nm#</li>">
		</cfif>
	</cfloop>
	<cfif hasOutputted eq 1>
		<cfset outstr = outstr & "</ul>">
	</cfif>
	<cfset genericList = "">
	<cfloop list="#session.selectedDrugs#" index="thisdrug">
        <cfset afobj = application.AnswerfieldPool.getAnswerfield('#thisdrug#')>
		<cfif afobj.type eq 'generic'>
			<cfset genericList = ListAppend(genericList, afobj.id)>
		</cfif>
	</cfloop>
	<cfif genericList eq ''>
		<cfquery name="genericMatch" datasource="#application.dbSrc#">
			select answerfield, answerfield option_nm
			from answerfield
			where answerfield_id is null
		</cfquery>
	<cfelse>
		<cfquery name="genericMatch" datasource="#application.dbSrc#">
			select a.answerfield, convert(varchar(255), dl.display_text) as option_nm
			from answerfield_relationship ar, answerfield a, display_language dl
			where ar.right_answerfield_id in (#genericList#)
				and ar.relationship_id=1
				and ar.left_answerfield_id=a.answerfield_id
				and a.answerfieldtype_id=13
				and a.display_id=dl.display_id
				and dl.language_id='#session.language_id#'
			order by option_nm
		</cfquery>
	</cfif>
	<cfset hasOutputted = 0>
	<cfloop query="matchingdrugs">
		<cfif ListFindNoCase(ValueList(genericMatch.answerfield), answerfield) gt 0>
			<cfif hasOutputted eq 0>
				<cfset outstr = outstr & "<b>">
				<cfif pobj.cat eq 'medicareta'>
					<cfset outstr = outstr & "This program provides discounts on many brand-name and generic drugs, including the following brand-name versions of generic medications you are currently taking">
				<cfelse>
					<cfset outstr = outstr & "This program applies to the following brand-name versions of generic medications you are currently taking">
				</cfif>
				<cfset outstr = outstr & ":</b><ul>">
				<cfset hasOutputted = 1>
			</cfif>
			<cfset outstr = outstr & "<li>#option_nm#</li>">
		</cfif>
	</cfloop>
	<cfif hasOutputted eq 1>
		<cfset outstr = outstr & "</ul><b>Please note:</b> ">
		<cfif pobj.cat eq 'medicareta'>
			<cfset outstr = outstr & "This card also offers additional savings on the brand-name form of the generic drug(s) you are currently taking.  These extra savings are available after you have used up your additional assistance.  You should discuss with your healthcare provider to see if it makes sense to switch to the brand-name medication in order to take advantage of these extra savings.">
		<cfelse>
			<cfset outstr = outstr & "Since the generic versions of some drugs you selected are not available through this program, you may want to contact your healthcare provider to find out if the brand name equivalent(s) are appropriate for you.  If so, you may be able to save money by applying for this program.  Some pharmaceutical programs provide brand-name drugs at little or no cost to those who qualify.">
		</cfif>
		<cfset outstr = outstr & "<br /><br />">
	</cfif>
</cfif>

</cfsilent><cfif attributes.var eq ''><cfsilent>
	</cfsilent><cfoutput>#outstr#</cfoutput><cfsilent>
</cfsilent><cfelseif attributes.append><cfsilent>
	<cfset "caller.#attributes.var#" = Evaluate("caller.#attributes.var#") & outstr>
</cfsilent><cfelse><cfsilent>
	<cfset "caller.#attributes.var#" = outstr>
</cfsilent></cfif>