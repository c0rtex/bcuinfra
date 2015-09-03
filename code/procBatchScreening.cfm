<cfparam name="startrow" default="0">

<cfparam name="endrow" default="0">

<cfif isdefined('form.startrow') and isdefined('form.endrow')>

	<cfset startrow = form.startrow>

	<cfset endrow = form.endrow>

</cfif>

<!-- Get Data from Database -->

<cfquery name="BatchQuery"  datasource="#application.dbSrc#"  >

	SELECT     *

	FROM         kpdata2

</cfquery>

<!-- Loop Through Batch Data -->

<cfloop query ="BatchQuery" startrow="#startrow#" endrow="#endrow#">

	<cfset bdtid = BatchQuery.BDTID>

<cfquery name="mapfields" dbtype="query" >

	SELECT     *

	FROM         BatchQuery

	WHERE BDTID='#bdtid#'

</cfquery>

<!-- map field data -->

<cfinvoke component="mapdata" method="setvalues" returnvariable="mappedresults">

	<cfinvokeargument name="BatchQuery" value="#mapfields#">

</cfinvoke>

<cfoutput><br/>Time:#TimeFormat(Now())# Record #BatchQuery.currentrow# -----  #BDTID#--<br></cfoutput>

<!--- cflog application="yes"  date="yes"  time="yes" text="Record #BatchQuery.currentrow# ---  #BDTID#" --->

<!-- process screening -->

<cfset session.org_id = 0>

<cfset session.prev_id = 0>

<cfset session.language_id = "EN">

<cfset session.access_id = 0>

<cfset session.user_id = "NULL">

<cfset session.subset_id = 37>

<cfset session.partner_id = 17 >

<cfset session.source_id = 7>

<cfset session.state_id = "">

<cfset session.test_id = 0>

<cfset session.client_id = BatchQuery.BDTID >

<!-- map field data -->

<cfinvoke component="mapdata" method="getfieldlist" returnvariable="aflist" >

	<cfinvokeargument name="mappedresults" value="#mappedresults#">

</cfinvoke>

<cfoutput><br/>Answer Field List: afList: #afList#</cfoutput>

<!--- set mapped result variables to form scope --->

<cfloop collection="#mappedresults#"  item="fieldname">

	<cfset newval = #structfind(mappedresults,fieldname)#>

	<cfset results = #structinsert(form,fieldname,newval, "yes")#>

	<cfset results = #structinsert(session,fieldname,newval, "yes")#>

</cfloop>

<cfdump  var="#mappedresults#" label="Mapped Fields" >

<cf_newlogScreening action="start"  >

<!--- START session info loading --->

	<cfquery name="subsetInfo" datasource="#application.dbSrc#">

		SELECT subsettype_id, subset_name, subset_longname, subset_description, subset_text,

			all_flag, grid_flag, schip_flag, drug_flag, optional_flag, rec_flag, eform_flag

		FROM xsubset

		WHERE subset_id=#session.subset_id#

	</cfquery>

	<cfif subsetInfo.RecordCount>

		<cfset session.subsetName = subsetInfo.subset_name>

		<cfset session.subsetLongName = subsetInfo.subset_longname>

		<cfset session.subsetDescription = subsetInfo.subset_description>

		<cfset session.subsetText = subsetInfo.subset_text>

		<cfset session.subsetAllFlag = subsetInfo.all_flag>

		<cfset session.subsetGridFlag = subsetInfo.grid_flag>

		<cfset session.subsetSCHIPFlag = subsetInfo.schip_flag>

		<cfset session.subsetDrugFlag = subsetInfo.drug_flag>

		<cfset session.subsetOptionalFlag = subsetInfo.optional_flag>

		<cfset session.subsetRecFlag = subsetInfo.rec_flag>

		<cfset session.subsetEFormFlag = subsetInfo.eform_flag>

	<cfelse>

		<cfset session.subsetName = ''>

		<cfset session.subsetLongName = ''>

		<cfset session.subsetDescription = ''>

		<cfset session.subsetText = ''>

		<cfset session.subsetAllFlag = 0>

		<cfset session.subsetGridFlag = 0>

		<cfset session.subsetSCHIPFlag = 0>

		<cfset session.subsetDrugFlag = 0>

		<cfset session.subsetOptionalFlag = 0>

		<cfset session.subsetRecFlag = 0>

		<cfset session.subsetEFormFlag = 0>

	</cfif>

	<cfquery name="subsetPartnerInfo" datasource="#application.dbSrc#">

		SELECT resultpage_id

		FROM subset_partner

		WHERE subset_id=#session.subset_id#

			AND partner_id=#session.partner_id#

			AND resultpage_id IS NOT NULL

	</cfquery>

	<cfif subsetPartnerInfo.RecordCount>

		<cfset session.subsetRecFlag = subsetPartnerInfo.resultpage_id - 1>

	</cfif>

	<cf_newlogScreeningInput  aflist="#afList#"    >

	<cf_newlogScreening action="end" screening_id="#session.screening_id#">

<!--- 05/21/2003 BS - Make sure there's a session.selectedDrugs variable --->

<cfif not IsDefined("session.selectedDrugs")>

	<cfset session.selectedDrugs = ''>

</cfif>

<!--- 08/02/2002 Bill - This code is to strip leading zeroes off the household number, so we don't look up a column with a name like "mem02" --->

<cfif isDefined("session.no_hh_members")>

	<cfset session.no_hh_members = val(session.no_hh_members)>

</cfif>

<cfif isDefined("session.hh_disabled")>

	<cfset session.hh_disabled = val(session.hh_disabled)>

</cfif>

<cfif isDefined("session.over_60")>

	<cfset session.over_60 = val(session.over_60)>

</cfif>

<CFSET session.END_TIME = CreateODBCDATETIME(now())>

<cfset session.prg_list = "">

<cfset session.buff_list = "">

<!--- 07/09/2002 REM  The "normal" pass --->



<!--- whats going on --->

<cfset session.skipinc = "no">

<cfset session.SKIPASSETS = "no">

<cfset session.hh_depend = 0>

<cfset session.WANTCHIPS = "No">

<cfset session.SSI_RECEIVE = "">

<cfset session.LIHEAP_RECEIVE = "">

<cf_tagTestRules ynDoBuffer="FALSE">

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

<cf_populateTableFromView table="subset_program_base" subset_id="#session.subset_id#">

<cf_populateTableFromView table="subset_program_sum" subset_id="#session.subset_id#">

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

		<cfset helperIndex = ListContains(session.prg_list, helper_prg_id)>

		<cfif helperIndex gt 0>

			<cfset session.prg_list = ListDeleteAt(session.prg_list, helperIndex)>

		</cfif>

		<cfset helperIndex = ListContains(session.buff_list, helper_prg_id)>

		<cfif helperIndex gt 0>

			<cfset session.buff_list = ListDeleteAt(session.buff_list, helperIndex)>

		</cfif>

	</cfloop>

</cfif>



<!--- Bill Shunn - 10/04/02 --->

<!--- Remove Generic Drugs from the program list --->

<!--- Will display separately, like SCHIP --->

<cfset genericnum=ListContains(session.prg_list, "XXX-311-2387-FD-FD")>

<cfif genericnum gt 0>

	<cfset session.prg_list=ListDeleteAt(session.prg_list, genericnum)>

	<cfset session.genericdrugs = "y">

<cfelse>

	<cfset session.genericdrugs = "n">

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

<cf_loadApplicationVars hashname="prgvars">

<cfloop list="#session.prg_list#" index="prg_id">

	<cfset unseenAdjustedVal = unseenVal>

	<cfif unseenVal eq 0>

		<cfif Mid(prg_id, Find('-', prg_id) + 1, Find('-', prg_id, Find('-', prg_id) + 1) - Find('-', prg_id) - 1) eq '333'>

			<cfset unseenAdjustedVal = 1>

		</cfif>

	</cfif>

	<cfquery name="insertprograms" DATASOURCE="#application.dbSrc#">

		INSERT INTO screening_program

			(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)

		VALUES

			(#session.screening_id#, #StructFind(application.prgvars, Mid(prg_id, 3, Len(prg_id) - 2))#, #unseenAdjustedVal#, 0, 0)

	</CFQUERY>

</cfloop>

<cfif session.wantchips eq 'Y'>

	<CFQUERY NAME="insertchips" DATASOURCE="#application.dbSrc#">

		INSERT INTO screening_program

			(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)

		VALUES

			(#session.screening_id#, #StructFind(application.prgvars, '103-309-2191-FD-FD')#, #unseenVal#, 0, 0)

	</CFQUERY>

</cfif>

<cfif session.genericdrugs eq 'Y'>

	<CFQUERY NAME="insertgeneric" DATASOURCE="#application.dbSrc#">

		INSERT INTO screening_program

			(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)

		VALUES

			(#session.screening_id#, #StructFind(application.prgvars, 'XXX-311-2387-FD-FD')#, #unseenVal#, 0, 0)

	</CFQUERY>

</cfif>

<cfloop list="#session.buff_list#" index="prg_id">

	<cfquery name="insertbuffers" DATASOURCE="#application.dbSrc#">

		INSERT INTO screening_program

			(screening_id, program_id, unseen_flag, buffer_flag, maybe_flag)

		VALUES

			(#session.screening_id#, #StructFind(application.prgvars, Mid(prg_id, 3, Len(prg_id) - 2))#, #unseenVal#, 1, 0)

	</cfquery>

</cfloop>

<cfparam name="customflag" type="boolean" default="false">

<cfparam name="file_format" type="string" default="pdf">

<cfparam name="re_cover" type="boolean" default="false">

<cfparam name="re_toc" type="boolean" default="false">

<cfparam name="re_intro" type="boolean" default="false">

<cfparam name="re_addl" type="boolean" default="false">

<cfparam name="re_local" type="boolean" default="true">

<cfparam name="rf_break" type="boolean" default="false">

<cfparam name="pe_desc" type="boolean" default="true">

<cfparam name="pe_entry" type="boolean" default="true">

<cfparam name="pe_limit" type="numeric" default="1">

<cfparam name="pe_req" type="boolean" default="true">

<cfset reportlist = #replace(session.prg_list,"'","","All")#>

<cftry>

<cf_screenPrintedReport brandname="Kaiser Permanente CheckUp" pdfname="#BDTID#-kaiserreport" fileformat="pdf" coverpage="#re_cover#" toc="#re_toc#" intro="#re_intro#" addedinfo="#re_addl#" localprgs="#re_local#" pgbreaks="#rf_break#" prgdesc="#pe_desc#" prgeps="#pe_entry#" prgepnum="#pe_limit#" prgreqmat="#pe_req#" prglist="#reportlist#">

<cfcatch>

<cfoutput><Br>Problem printing report for screeningid: #session.screening_id#</Br></cfoutput>

<cflog application="yes" time="yes" date="yes" text="Problem printing report for screeningid: #session.screening_id#">

</cfcatch>

</cftry>

<cfoutput>Programlist for ScreeningID:#session.screening_id# : #session.prg_list#-#BDTID#<br></cfoutput>

<cfset result = structclear(form)>

<cfset result2 = structclear(mappedresults)>

<cfflush >

</cfloop>