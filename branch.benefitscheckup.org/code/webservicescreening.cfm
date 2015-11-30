	<cfset screeningresults = structnew()>
	<cfset error_code = 0 >
	<cfset prev_id = 0>
	<cfset language_id = "EN">
	<cfset access_id = 0>
	<cfset user_id = "NULL">
	<cfset source_id = 8>
	<cfset state_id = "">
	<cfset test_id = 1 >
	<cfset form.dob_month = "10">
	<cfset form.dob_year = "1930">
	<cfset form.no_hh_members = "1">
	<cfset form.s_income_earned = 0 >
	<cfset form.s_income_other_nw = 0 >
	<cfset form.s_asset_other_a = 0 >
	<cfset form.hh_depend = 1>
	<cfset form.CLIENT1="1353-Self">
	<cfset form.CLIENT_OTHER="">
	<cfset form.medicare_receive = "y">
	<cfset form.CITIZEN="13-Citizen">
<cfparam name="form.disabled" default = "y">
<cfparam name="form.blind" default = "y">
<cfparam name="form.dob_month" default = "12">
<cfparam name="form.dob_year" default = "1901">
<cfparam name="form.rx_ins" default = "100">
<cfparam name="form.client" default = "1353-Self">
<cfparam name="form.client_other" default = "">
<cfparam name="form.lis_apply" default = "n">
<cfparam name="form.receive" default = "y">
<cfparam name="form.dep_child" default = "y">
<cfparam name="form.s_income_earned" default = "0">
<cfparam name="form.s_sp_income_earned" default = "0">
<cfparam name="form.s_income_other_nw" default = "0">
<cfparam name="form.s_sp_income_other_nw" default = "0">
<cfparam name="form.s_asset_other_a" default = "0">
<cfparam name="form.s_sp_asset_other_a" default = "0">
<cfparam name="form.med_costs" default = "0">
<cfparam name="form.rx_ins_co_pay" default = "0">
<cfparam name="form.rx_drugcosts" default = "0">
<cfparam name="form.rx_all_drugs" default = "">
<cfparam name="form.gender" default = "m">
<cfparam name="form.st" default = "IL">
<cfparam name="form.pri_resident" default = "n">
<cfparam name="form.stateduration" default = "5">
<cfparam name="form.zip" default = "60606">
<cfparam name="form.hh_depend" default = "2">
<cfparam name="form.no_hh_members" default = "3">
<cfparam name="form.marital_stat" default = "1353-Self">
<cfparam name="form.citizen" default = "y">
<cfparam name="form.hurricane" default = "n">
<cfparam name="form.lis_undeemed" default = "n">
<cfparam name="form.receive_lis" default = "n">
<cfparam name="form.fdstmp_receive" default = "n">
<cfparam name="form.rec_il_caresrx" default = "n">
<cfparam name="form.rec_il_rxbuyingclub" default = "n">
<cfparam name="form.med_receive" default = "y">
<cfparam name="form.medicare_receive" default = "n">
<cfparam name="form.receive_partd" default = "n">
<cfparam name="form.receive_msp" default = "n">
<cfparam name="form.receive_creditable_coverage" default = "n">
<cfparam name="form.receive_pub_housing" default = "n">
<cfparam name="form.receive_section_8" default = "y">
<cfparam name="form.rec_nj_seniorgold" default = "n">
<cfparam name="form.ssi_receive" default = "">
<cfparam name="form.ss_receive" default = "n">
<cfparam name="form.ssd_receive_2" default = "n">
<cfparam name="form.ssd_receive" default = "n">



	<cfset afList = "s-st,o-client1-client,s-client_other,g-gender,y-pri_resident,y-city,y-citysubcc,s-zip,n-dob_month,n-dob_year,o-citizen,o-marital_stat,c-medicare_receive,c-receive_partd,c-receive_lis,c-med_receive,c-receive_creditable_coverage,c-receive_msp,c-rec_il_caresrx,c-rec_il_rxbuyingclub,c-ssi_receive,y-disabled,y-hurricane,s-hh_depend,s-no_hh_members,y-lis_undeemed,y-lis_apply,i-s_income_earned,i-s_income_other_nw,a-s_asset_other_a">

	<cfloop collection="#form#"  item="fieldname">
		<cfset newval = #structfind(form,fieldname)#>
		<cfset results = #structinsert(session,fieldname,newval, "yes")#>
	</cfloop>
	<cfdump var="#form#">
	<cfdump var="#session#">
	<!-- process screening -->
	<cfset session.org_id = 2081>
	<cfset session.prev_id = prev_id>
	<cfset session.language_id = "EN">
	<cfset session.access_id = 0 >
	<cfset session.user_id = "NULL">
	<cfset session.subset_id = 27>
	<cfset session.partner_id = 26 >
	<cfset session.source_id = 8>
	<cfset session.state_id = "">
	<cfset session.test_id = 0>
	<cfset session.client_id = 0>
	<cfset aflist = "">
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

	<cfset session.skipinc = "yes">

	<cfset session.SKIPASSETS = "yes">

	<cfset session.S_INCOME_TOTAL_UNEARNED = 0>

	<cfset session.S_INCOME_TANF = 0>

	<cfset session.S_INCOME_CASH_ASSIST =0>

	<cfset session.hh_depend = 0>

	<cfset session.s_asset_life_face = 0>

	<cfset session.s_asset_life_cash = 0>

	<cfset session.S_ASSET_IRREVOCABLE = 0>

	<cfset session.S_ASSET_REVOCABLE = 0>

	<cfset session.s_asset_auto1 = 0>

	<cfset session.S_ASSET_HOME = 0>

	<cfset session.S_ASSET_TOTAL_COMPLETE = 0>

	<cfset session.WANTCHIPS = "No">

	<cfset session.SSI_RECEIVE = "">

	<cfset session.LIHEAP_RECEIVE = "">

	<cfset session.zip = form.zip >

	<cfset session.st = form.st >

	<cfset SESSION.S_INCOME_EARNED =0>

	<cfset session.dob_month = form.dob_month >

	<cfset session.dob_year = form.dob_year >

	<cfset session.marital_stat = form.marital_stat >

	<cfset session.no_hh_members = form.no_hh_members>

	<cf_tagTestRules ynDoBuffer="FALSE">

	<cfset session.zipradius = 100>

	<cfset session.st = "AZ">

	



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
	<cfset result = structclear(form)>
	<cfset screeningresults.date_time = #now()# >
	<cfset screeningresults.error_code = error_code >
	<cfset screeningresults.program_list = session.prg_list>
	<cfset screeningresults.language_id = language_id >
	<cfset screeningresults.screening_id = session.screening_id >
	<cfset screeningresults.report_url = "https://bcuqa.benefitscheckup.org/util/procGetReport.cfm?clientnum=#session.screening_id#&source=webservice">
	<cfdump var=#screeningresults#>

	