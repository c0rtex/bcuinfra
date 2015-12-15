
<cfset debugOutput = false>
<cfif debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Starting eligibility processing template<br /><br /></cfoutput></cfif>

<!--- MH 4/14/10: Bug 5207 - Reset session values from screening in db --->
<cfif IsDefined("session.ch_income_total_unearned")>
<cfquery name="resetChIncTotUnearned" datasource="#application.dbSrc#">
SELECT response
  FROM screening_answerfield
  where screening_id = #session.screening_id# and answerfield_id = 5444
</cfquery>
<cfoutput query="resetChIncTotUnearned">
<cfset session.ch_income_total_unearned = #response#>
</cfoutput>
</cfif>

<cfif IsDefined("session.ch_income_earned")>
<cfquery name="resetChIncEarned" datasource="#application.dbSrc#">
SELECT response
  FROM screening_answerfield
  where screening_id = #session.screening_id# and answerfield_id = 5445
</cfquery>
<cfoutput query="resetChIncEarned">
<cfset session.ch_income_earned = #response#>
</cfoutput>
</cfif>

<cfif IsDefined("session.ch_asset_total_complete")>
<cfquery name="resetChAssTotComp" datasource="#application.dbSrc#">
SELECT response
  FROM screening_answerfield
  where screening_id = #session.screening_id# and answerfield_id = 5449
</cfquery>
<cfoutput query="resetChAssTotComp">
<cfset session.ch_asset_total_complete = #response#>
</cfoutput>
</cfif>

<cfif IsDefined("session.ch_income_child_support")>
<cfquery name="resetChIncChSup" datasource="#application.dbSrc#">
SELECT response
  FROM screening_answerfield
  where screening_id = #session.screening_id# and answerfield_id = 5443
</cfquery>
<cfoutput query="resetChIncChSup">
<cfset session.ch_income_child_support = #response#>
</cfoutput>
</cfif>

<cfif IsDefined("session.ch_dep_care_costs")>
<cfquery name="resetChDepCare" datasource="#application.dbSrc#">
SELECT response
  FROM screening_answerfield
  where screening_id = #session.screening_id# and answerfield_id = 5450
</cfquery>
<cfoutput query="resetChDepCare">
<cfset session.ch_dep_care_costs = #response#>
</cfoutput>
</cfif>

<!----=======================================
DESCRIPTION: takes possible programs, pulls the rules, then checks the answers to see if the user
   qualifies
CALLED BY: proc_asset.cfm
GOES TO: N/A
REQUIRED: N/A
============================================---->
<cfif debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Starting logScreeningInput<br /><br /></cfoutput></cfif>
<cf_logScreeningInput>
<cfif debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Starting logScreening action="end"<br /><br /></cfoutput></cfif>
<cf_handleScreening action="end">
<!--- 05/21/2003 BS - Make sure there's a session.selectedDrugs variable --->
<cfif not IsDefined("session.selectedDrugs")>
	<cfset session.selectedDrugs = ''>
</cfif>
<cfif not IsDefined('session.city')>
	<cfset session.city = 0>
</cfif>
<!--- 08/02/2002 Bill - This code is to strip leading zeroes off the household number, so we don't look up a column with a name like "mem02" --->
<cfif isDefined("session.no_hh_members")>
	<cfset session.no_hh_members = val(session.no_hh_members)>
	<cfif isdefined('session.marital_stat')>
		<cfif session.marital_stat eq 'Married'>
			<cfif session.no_hh_members lt 2>
				<cfset session.no_hh_members = 2 >
			</cfif>
		<cfelseif session.marital_stat neq 'Married'>
		<!--- 01/12/2010 MH - Set no_hh_members to default to 1 if single and no_hh_members doesn't have a value --->
			<cfif session.no_hh_members lt 1>
				<cfset session.no_hh_members = 1 >
			</cfif>
		</cfif>
	</cfif>
</cfif>

<cfif isDefined("session.hh_depend")>
	<cfset session.hh_depend = val(session.hh_depend)>
	<cfif isdefined('session.marital_stat') and session.marital_stat eq 'Married'>
		<cfif session.hh_depend lt 2>
			<cfset session.hh_depend = 2 >
		</cfif>
	<cfelseif isdefined('session.marital_stat') and session.marital_stat neq 'Married'>
		<!--- 01/12/2010 MH - Set hh_depend to default to 1 if single and hh_depend doesn't have a value --->
		<cfif session.hh_depend lt 1>
			<cfset session.hh_depend = 1 >
		</cfif>
	</cfif>
</cfif>

<cfif isDefined("session.hh_disabled")>
	<cfset session.hh_disabled = val(session.hh_disabled)>
</cfif>
<cfif isDefined("session.over_60")>
	<cfset session.over_60 = val(session.over_60)>
</cfif>
<CFSET session.END_TIME = CreateODBCDATETIME(now())>
<cfset session.prg_list = ''>
<cfset session.buff_list = ''>
<!--- 07/09/2002 REM  The "normal" pass --->
<cfif debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Starting tagTestRules<br /><br /></cfoutput></cfif>
<cf_tagTestRules debugOutput="#debugOutput#">

<cfif Not IsDefined('session.subset_id') Or session.subset_id neq 1>
<!--- 07/09/2002 REM  Now we set up for Buffer --->
<!--- need to offset the total figures by 500 and 100 respectively --->
<CFSET SESSION.S_asset_TOTAL_COMPLETE = SESSION.s_asset_TOTAL_COMPLETE - 500>
<CFSET SESSION.S_SP_asset_TOTAL_COMPLETE = SESSION.S_SP_asset_TOTAL_COMPLETE - 500>
<CFSET SESSION.HH_asset_TOTAL_COMPLETE = SESSION.HH_asset_TOTAL_COMPLETE - 500>
<CFSET SESSION.S_INCOME_TOTAL_COMPLETE = SESSION.s_INCOME_TOTAL_COMPLETE - 100>
<CFSET SESSION.S_SP_INCOME_TOTAL_COMPLETE = SESSION.S_SP_INCOME_TOTAL_COMPLETE - 100>
<CFSET SESSION.HH_INCOME_TOTAL_COMPLETE = SESSION.HH_INCOME_TOTAL_COMPLETE - 100>
<cfif debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Starting tagTestRules ynDoBuffer="true"<br /><br /></cfoutput></cfif>
<cf_tagTestRules ynDoBuffer="true" debugOutput="#debugOutput#">
<!--- now we put the total figures back again :)--->
<CFSET SESSION.S_asset_TOTAL_COMPLETE = SESSION.s_asset_TOTAL_COMPLETE + 500>
<CFSET SESSION.S_SP_asset_TOTAL_COMPLETE = SESSION.S_SP_asset_TOTAL_COMPLETE + 500>
<CFSET SESSION.HH_asset_TOTAL_COMPLETE = SESSION.HH_asset_TOTAL_COMPLETE + 500>
<CFSET SESSION.S_INCOME_TOTAL_COMPLETE = SESSION.s_INCOME_TOTAL_COMPLETE + 100>
<CFSET SESSION.S_SP_INCOME_TOTAL_COMPLETE = SESSION.S_SP_INCOME_TOTAL_COMPLETE + 100>
<CFSET SESSION.HH_INCOME_TOTAL_COMPLETE = SESSION.HH_INCOME_TOTAL_COMPLETE + 100>
</cfif>
<!--- 07/09/2002 REM  DONE WITH BUFFER --->

<cfset session.zipradius = 100>
<!--- Bill Shunn - 10/04/02 --->
<!--- Remove SSI from the program list if in RX questionnaire --->
<!--- We only use SSI to check eligibility for drug programs --->
<!--- Bill Shunn - 10/07/02 --->
<!--- Remove SSI from the buffer list if in RX questionnaire --->
<!--- We only use SSI to check eligibility for drug programs --->
<!--- 01/26/2004 BShunn  Changed to remove subset helper programs from prog and buffer lists.
                         Helpers are base_flag=0 (derived) and base_flag=2 (explicit).
                         Part of the generalization of subset screenings. --->
<!--- 05/04/2005 BShunn  For new subset implementation, rewrote query for finding ancestor programs;
                         query finds all programs that are in the _sum table but not in the _base
						 table, then loop removes those programs from the results lists --->
<cfif debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Starting helperPrg query<br /><br /></cfoutput></cfif>
<cfif IsDefined('session.subset_id') And session.subset_id gt 0>
	<cfquery name="helperPrg" datasource="#application.dbSrc#">
		SELECT p.prg_id AS helper_prg_id
		FROM subset_program_base spb RIGHT OUTER JOIN subset_program_sum sps
				ON spb.subset_id=sps.subset_id AND spb.program_id=sps.program_id
			INNER JOIN tbl_prg_all p
				ON sps.program_id=p.RecID
		WHERE sps.subset_id=#session.subset_id#
			AND spb.subset_id IS NULL
		ORDER BY p.prg_id
	</cfquery>
	<cfloop query="helperPrg">
		<cfset helperIndex = ListFind(session.prg_list, "'#helper_prg_id#'")>
		<cfif helperIndex gt 0>
			<cfset session.prg_list = ListDeleteAt(session.prg_list, helperIndex)>
		</cfif>
		<cfset helperIndex = ListFind(session.buff_list, "'#helper_prg_id#'")>
		<cfif helperIndex gt 0>
			<cfset session.buff_list = ListDeleteAt(session.buff_list, helperIndex)>
		</cfif>
	</cfloop>
</cfif>

<!--- Bill Shunn - 06/06/08 --->
<!--- Remove SCHIP from the program list --->
<!--- Will display separately --->
<cfset schipnum = ListFind(session.prg_list, "'103-309-2191-FD-FD'")>
<cfif schipnum gt 0>
	<cfset session.prg_list=ListDeleteAt(session.prg_list, schipnum)>
</cfif>
<!--- Bill Shunn - 10/04/02 --->
<!--- Remove Generic Drugs from the program list --->
<!--- Will display separately, like SCHIP --->
<cfset genericnum = ListFind(session.prg_list, "'XXX-311-2387-FD-FD'")>
<cfif genericnum gt 0>
	<cfset session.prg_list=ListDeleteAt(session.prg_list, genericnum)>
	<cfset session.genericdrugs = 'y'>
<cfelse>
	<cfset session.genericdrugs = 'n'>
</cfif>
<!--- Store client prg_id's 5-15-2001--->
<!--- 03/03/2002 REM  NOTE THAT THIS NEEDS TO BE REFINED TO FIGURE OUT HOW TO AVOID WRITING A 
DUPLICATE SET OF ENTRIES IF THE USER BACKS UP AND RESUBMITS HIS ANSWERS TO THIS PROCESS 
PAGE. --->
<cfif session.subsetRecFlag eq 1>
	<cfset unseenVal = 1>
<cfelse>
	<cfset unseenVal = 0>
</cfif>
<cfif debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Starting loadApplicationVars hashname="prgvars"<br /><br /></cfoutput></cfif>
<cf_loadApplicationVars hashname="prgvars">
<cfif debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Starting loop through program list<br /><br /></cfoutput></cfif>
<cfloop list="#session.prg_list#" index="prg_id">
	<cfset unseenAdjustedVal = unseenVal>
	<cfif unseenVal eq 0>
		<cfif Mid(prg_id, Find('-', prg_id) + 1, Find('-', prg_id, Find('-', prg_id) + 1) - Find('-', prg_id) - 1) eq '333'>
			<cfset unseenAdjustedVal = 1>
		</cfif>
	</cfif>
	<cfif debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Executing screening_program insert for #prg_id#<br /></cfoutput></cfif>
	<cftry><cfquery name="insertprograms" DATASOURCE="#application.dbSrc#">
		INSERT INTO screening_program
			(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)
		VALUES
			(#session.screening_id#, #StructFind(application.prgvars, Mid(prg_id, 3, Len(prg_id) - 2))#, #unseenAdjustedVal#, 0, 0)
	</CFQUERY><cfcatch></cfcatch></cftry>
	<cfif debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Finishing screening_program insert for #prg_id#<br /><br /></cfoutput></cfif>
</cfloop>
<cfif debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Finished loop through program list<br /><br /></cfoutput></cfif>
<cfif IsDefined('session.wantchips') and session.wantchips eq 'Y'>
	<cfif debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Executing screening_program insert for 103-309-2191-FD-FD<br /><br /></cfoutput></cfif>
	<CFQUERY NAME="insertchips" DATASOURCE="#application.dbSrc#">
		INSERT INTO screening_program
			(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)
		VALUES
			(#session.screening_id#, #StructFind(application.prgvars, '103-309-2191-FD-FD')#, #unseenVal#, 0, 0)
	</CFQUERY>
	<cfif debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Finishing screening_program insert for 103-309-2191-FD-FD<br /><br /></cfoutput></cfif>
</cfif>
<cfif session.genericdrugs eq 'Y'>
	<cfif debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Executing screening_program insert for XXX-311-2387-FD-FD<br /><br /></cfoutput></cfif>
	<CFQUERY NAME="insertgeneric" DATASOURCE="#application.dbSrc#">
		INSERT INTO screening_program
			(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)
		VALUES
			(#session.screening_id#, #StructFind(application.prgvars, 'XXX-311-2387-FD-FD')#, #unseenVal#, 0, 0)
	</CFQUERY>
	<cfif debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Finishing screening_program insert for XXX-311-2387-FD-FD<br /><br /></cfoutput></cfif>
</cfif>
<cfif debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Starting loop through buffer program list<br /><br /></cfoutput></cfif>
<cfloop list="#session.buff_list#" index="prg_id">
	<cfif debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Executing screening_program insert for #prg_id#<br /></cfoutput></cfif>
	<cftry><cfquery name="insertbuffers" DATASOURCE="#application.dbSrc#">
		INSERT INTO screening_program
			(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)
		VALUES
			(#session.screening_id#, #StructFind(application.prgvars, Mid(prg_id, 3, Len(prg_id) - 2))#, #unseenVal#, 1, 0)
	</cfquery><cfcatch></cfcatch></cftry>
	<cfif debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Finishing screening_program insert for #prg_id#<br /><br /></cfoutput></cfif>
</cfloop>
<cfif debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Finished loop through buffer program list<br /><br /></cfoutput></cfif>

<cfif IsDefined('session.partner_id') And session.partner_id eq 5>
	<cfif ListLen(session.prg_list)>
		<cfif session.citizen eq 'Citizen'>
			<cfset showAddedInfo="false">
		<cfelse>
			<cfset showAddedInfo="true">
		</cfif>
		<cfif debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Starting screenPrintedReport<br /></cfoutput></cfif>
		<cf_screenPrintedReport pdfname="#session.cftoken#-#session.cfid#" fileformat="html" coverpage="false" toc="false" addedinfo="#showAddedInfo#" ltccinfo="false" pgbreaks="false" brandname="LTCC Public Programs">
		<cfif debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Finished screenPrintedReport<br /></cfoutput></cfif>
	<cfelse>
		<cfif debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Starting screenPrintedReport blankreport="true"<br /></cfoutput></cfif>
		<cf_screenPrintedReport pdfname="#session.cftoken#-#session.cfid#" blankreport="true">
		<cfif debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Finished screenPrintedReport blankreport="true"<br /></cfoutput></cfif>
	</cfif>
</cfif>

<cfif debugOutput><cfoutput>#CreateODBCDateTime(Now())#: All processing finished -- printing "continue" link<br /></cfoutput></cfif>
<cfif session.subsetRecFlag eq 1>
	<cfset session.returnToCode = 'rec'>
	
	<cfif session.subset_id eq 39> 
		<cfset rpt = "presdrug">
	<cfelseif session.subset_id eq 27 >
		<cfset rpt = "medicarerx">
	<cfelse>
		<cfset rpt = "rxother">
	</cfif>
	<cfif not debugOutput>
		<cfoutput><cflocation url="frmRecommend.cfm?adj=1&rpt=#rpt#" addtoken="Yes"></cfoutput>
	<cfelse>
		<br><br><cfoutput><a href="frmRecommend.cfm?adj=1&cfid=#session.cfid#&cftoken=#session.cftoken#">continue</a></cfoutput>
	</cfif>
<cfelse>
	<cfset session.returnToCode = 'elig'>
	<cfif session.subset_id eq 0> 
		<cfset rpt = "comprehensive">
	<cfelse>
		<cfset rpt = "eligother">
	</cfif>
	<cfif not debugOutput>
		<cflocation url="frmeligibility.cfm?rpt=#rpt#" addtoken="Yes">
	<cfelse>
		<br><br><cfoutput><a href="frmeligibility.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#">continue</a></cfoutput>
	</cfif>
</cfif>

