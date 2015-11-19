<cfparam name="attributes.answerset" type="string" default="none">
<cfparam name="attributes.prglistvar" type="string" default="prg_list">
<cfparam name="attributes.bufflistvar" type="string" default="buff_list">
<cfparam name="tempzip" type="string" >
<!--- IF ANSWERS PASSED IN AS QUERY, TRANSFORM TO SESSION VARS --->
<cfif attributes.answerset neq "none">
	<cf_screenSessionStrip>
<!--- 4. set defaults for all session answerfield values and get field array for later--->
<!--- Pull in all answerfields--->
<CFQUERY DATASOURCE="#application.dbSrc#" NAME="af">
SELECT answerfield, type, validation
FROM tbl_questions_new
WHERE answerfield is not null
	AND answerfield != ''
	AND client = 'self'
ORDER BY answerfield
</CFQUERY>
<CFQUERY DATASOURCE="#application.dbSrc#" NAME="af2">
SELECT fieldtext answerfield, opt_type type, validation
FROM tbl_opt
WHERE fieldtext is not null
	AND fieldtext != ''
	AND SUBSTRING(fieldtext, 1, 3) != 'dn_'
	AND SUBSTRING(fieldtext, 1, 3) != 'dc_'
ORDER BY fieldtext
</CFQUERY>
<CFQUERY DATASOURCE="#application.dbSrc#" NAME="af3">
SELECT answerfield
FROM tbl_answerfield_list
WHERE SUBSTRING(answerfield, 1, 3) != 'dn_'
	AND SUBSTRING(answerfield, 1, 3) != 'dc_'
ORDER BY answerfield
</CFQUERY>

<!--- fill session answerfields to default values --->
<CFLOOP QUERY="af">
	<cfset ansfld = Replace(answerfield, '-', '_', 'ALL')>
	<cfif type eq 'yn'>
		<CFSET "session.#ansfld#" = "N">
	<cfelseif type eq 'txt'>
		<cfif validation eq "integer">
			<CFSET "session.#ansfld#" = 0>
		<cfelse>
			<CFSET "session.#ansfld#" = "">
		</cfif>
	<cfelse>
		<CFSET "session.#ansfld#" = "">
	</cfif>
</CFLOOP>
<CFLOOP QUERY="af2">
	<cfset ansfld = Replace(answerfield, '-', '_', 'ALL')>
	<cfif type eq 'chk'>
		<CFSET "session.#ansfld#" = "N">
	<cfelseif type eq 'txt'>
		<cfif validation eq "integer">
			<CFSET "session.#ansfld#" = 0>
		<cfelse>
			<CFSET "session.#ansfld#" = "">
		</cfif>
	<cfelse>
		<CFSET "session.#ansfld#" = "">
	</cfif>
</CFLOOP>
<cfloop query="af3">
	<cfset ansfld = Replace(answerfield, '-', '_', 'ALL')>
	<cfif not IsDefined("session.#ansfld#")>
		<CFSET "session.#ansfld#" = 0>
	</cfif>
</cfloop>

	<cfloop query="caller.#attributes.answerset#">
		<cfset "session.#question#" = content>
	</cfloop>
</cfif>

<!--- CREATE CRITICAL SESSION VARS --->
<cfif not IsDefined('session.start_time')>
	<cfset session.start_time = CreateODBCDateTime(Now())>
</cfif>
<cfif not IsDefined('session.subset_id')>
	<cfset session.subset_id = 0>
</cfif>
<cfset session.int_saving_money = 'Y'>
<cfif not IsDefined('session.wantchips')>
	<cfset session.wantchips = "N">
</cfif>
<cfif not IsDefined('session.no_hh_members') or session.no_hh_members eq "">
	<cfset session.no_hh_members = 0>
</cfif>
<CFSET session.Count = 5>


<!--- SET AND STORE CLIENTNUM --->
<cf_screenSessionClientnum>

<!--- DEAL WITH INCOME AND ASSET FIGURES --->
<cfif IsDefined("session.asset")>
	<cfset session.skipassets = session.asset>
<cfelse>
	<cfif not IsDefined("session.skipassets")>
		<cfset session.skipassets = 'N'>
	</cfif>
</cfif>
<cfif session.skipassets is 'n'>
	<cfloop index="fieldname" list="s_asset_cash,sp_asset_cash,s_sp_asset_cash,hh_asset_cash,s_asset_auto1,sp_asset_auto1,s_sp_asset_auto1,hh_asset_auto1,s_asset_auto2,sp_asset_auto2,s_sp_asset_auto2,hh_asset_auto2,s_asset_home,sp_asset_home,s_sp_asset_home,hh_asset_home,s_asset_retirement,sp_asset_retirement,s_sp_asset_retirement,hh_asset_retirement,s_asset_stocks,sp_asset_stocks,s_sp_asset_stocks,hh_asset_stocks,s_asset_life_cash,sp_asset_life_cash,s_sp_asset_life_cash,hh_asset_life_cash,s_asset_life_face,sp_asset_life_face,s_sp_asset_life_face,hh_asset_life_face,s_asset_irrevocable,sp_asset_irrevocable,s_sp_asset_irrevocable,hh_asset_irrevocable,s_asset_other_a,sp_asset_other_a,s_sp_asset_other_a,hh_asset_other_a">
		<cfset "session.#fieldname#" = 1000000>
	</cfloop>
<cfelse>
	<cfloop index="fieldname" list="s_asset_cash,sp_asset_cash,s_sp_asset_cash,hh_asset_cash,s_asset_auto1,sp_asset_auto1,s_sp_asset_auto1,hh_asset_auto1,s_asset_auto2,sp_asset_auto2,s_sp_asset_auto2,hh_asset_auto2,s_asset_home,sp_asset_home,s_sp_asset_home,hh_asset_home,s_asset_retirement,sp_asset_retirement,s_sp_asset_retirement,hh_asset_retirement,s_asset_stocks,sp_asset_stocks,s_sp_asset_stocks,hh_asset_stocks,s_asset_life_cash,sp_asset_life_cash,s_sp_asset_life_cash,hh_asset_life_cash,s_asset_life_face,sp_asset_life_face,s_sp_asset_life_face,hh_asset_life_face,s_asset_irrevocable,sp_asset_irrevocable,s_sp_asset_irrevocable,hh_asset_irrevocable,s_asset_other_a,sp_asset_other_a,s_sp_asset_other_a,hh_asset_other_a">
		<cfif not IsDefined("session.#fieldname#")>
			<cfset "session.#fieldname#" = 0>
		</cfif>
	</cfloop>
</cfif>
<cfif session.skipinc is 'n'>
	<cfloop index="fieldname" list="s_income_pri_retire,sp_income_pri_retire,s_sp_income_pri_retire,hh_income_pri_retire,s_income_dividends,sp_income_dividends,s_sp_income_dividends,hh_income_dividends,s_income_ssi,sp_income_ssi,s_sp_income_ssi,hh_income_ssi,s_income_ss_disable,sp_income_ss_disable,s_sp_income_ss_disable,hh_income_ss_disable,s_income_ss_retire,sp_income_ss_retire,s_sp_income_ss_retire,hh_income_ss_retire,s_income_rr_ben,sp_income_rr_ben,s_sp_income_rr_ben,hh_income_rr_ben,s_income_vet_ben,sp_income_vet_ben,s_sp_income_vet_ben,hh_income_vet_ben,s_income_unemploy,sp_income_unemploy,s_sp_income_unemploy,hh_income_unemploy,s_income_tanf,sp_income_tanf,s_sp_income_tanf,hh_income_tanf,s_income_cash_assist,sp_income_cash_assist,s_sp_income_cash_assist,hh_income_cash_assist,s_income_other_nw,sp_income_other_nw,s_sp_income_other_nw,hh_income_other_nw,s_income_earned,sp_income_earned,s_sp_income_earned,hh_income_earned">
		<cfset "session.#fieldname#" = 1000000>
	</cfloop>
<cfelse>
	<cfloop index="fieldname" list="s_income_pri_retire,sp_income_pri_retire,s_sp_income_pri_retire,hh_income_pri_retire,s_income_dividends,sp_income_dividends,s_sp_income_dividends,hh_income_dividends,s_income_ssi,sp_income_ssi,s_sp_income_ssi,hh_income_ssi,s_income_ss_disable,sp_income_ss_disable,s_sp_income_ss_disable,hh_income_ss_disable,s_income_ss_retire,sp_income_ss_retire,s_sp_income_ss_retire,hh_income_ss_retire,s_income_rr_ben,sp_income_rr_ben,s_sp_income_rr_ben,hh_income_rr_ben,s_income_vet_ben,sp_income_vet_ben,s_sp_income_vet_ben,hh_income_vet_ben,s_income_unemploy,sp_income_unemploy,s_sp_income_unemploy,hh_income_unemploy,s_income_tanf,sp_income_tanf,s_sp_income_tanf,hh_income_tanf,s_income_cash_assist,sp_income_cash_assist,s_sp_income_cash_assist,hh_income_cash_assist,s_income_other_nw,sp_income_other_nw,s_sp_income_other_nw,hh_income_other_nw,s_income_earned,sp_income_earned,s_sp_income_earned,hh_income_earned">
		<cfif not IsDefined("session.#fieldname#")>
			<cfset "session.#fieldname#" = 0>
		</cfif>
	</cfloop>
</cfif>


<!--- 7. Look up Zip and get County, City --->
<cfset tempzip = session.zip>
<CFIF tempzip IS NOT "0">
<!--- Need to put in code to check what zip code it is, and to strip off zeroes if need to be --->
<!--- This will strip off leading zeroes then reassign the variable back to zip MSK 3/37/00--->
	<CFSET strLeft = left(tempzip, 2)>
		<CFIF strLeft is "00">
			<CFSET tempzip = right(tempzip, 3)>
		</CFIF>
	<CFSET strLeft = left(tempzip, 1)>
		<CFIF strLeft is "0">
			<CFSET tempzip = right(tempzip, 4)>
		</CFIF>

<!--- look up zip by integer --->
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="cnty">
		SELECT County, cast( Zip as int), LastLineCity
		FROM tbl_zip
		WHERE cast( Zip as int) =<cfqueryparam value="#tempzip#" cfsqltype="cf_sql_integer" maxlength="5"> and State = '#session.st#'  
	</CFQUERY>
		<CFIF cnty.recordcount IS NOT 0>
			<CFSET county = #cnty.county#>
			<CFSET city = #cnty.LastLineCity#>
		<CFELSE>
			<CFSET county = "none">
			<cfset city = "none">
		</CFIF>
<CFELSE>
	<CFSET county = "none">
	<CFSET city = "none">
</CFIF>

<CFSET session.county = county>
<cfif not (session.st eq 'IL' and session.county eq 'COOK' and session.city neq "")>
	<CFSET session.city=city>
</cfif>

<CFIF not isDefined("session.othercity")>
	<cfset session.othercity="">
</cfif>


<!--- 8. do crazy income calculations --->
<CF_TagYeSetIncomeVar>
<CF_TagYeSetAssetVar>

<!--- 9. do d.o.b. calculations --->

	<cfif isdefined("session.dob_month") and isdefined("session.dob_year")>
		<cfset session.dob = "#session.dob_month#/01/#session.dob_year#">
		<cfset session.dob = Abs(DateDiff("yyyy", DateFormat(NOW()), session.dob))>
	</cfif>
	<cfif not isdefined("session.dob")>
		<cfset session.dob="0">
	</cfif>
	<cfif isdefined("session.sp_dob_month") and isdefined("session.sp_dob_year")>
		<cfset session.sp_dob = "#session.sp_dob_month#/01/#session.sp_dob_year#">
		<cfset session.sp_dob = Abs(DateDiff("yyyy", DateFormat(NOW()), session.sp_dob))>
	</cfif>
	<cfif not isdefined("session.sp_dob")>
		<cfset session.sp_dob="0">
	</cfif>

<!--- 10. optional questions --->
<CFIF not isDefined("session.learn")>
	<CFSET session.learn = "">	
</cfif>
<CFIF not isDefined("session.race")>
	<CFSET session.race = "">
</cfif>


<!--- START DRUG PROCESSING --->
<cfif isDefined("session.selecteddrugnm")>
	<cfset session.selectedDrugs = session.selecteddrugnm>
<cfelse>
	<cfset session.selectedDrugs = ''>
</cfif>
<cfloop index="drugvar" list="#StructKeyList(session)#">
	<cfset var=drugvar>
	<cfif FindNoCase("dn_", var) eq 1 or FindNoCase("dc_", var) eq 1>
		<cfset StructDelete(session, var)>
	</cfif>
</cfloop>
<cfif isDefined("session.selecteddrugnm")>
	<cfloop list="#session.selecteddrugnm#" index="field">
		<cfif field neq "null">
            <cfset afobj = application.ApplicationPool.getAnswerfield(field)>
			<cfif afobj.type eq 'generic'>
				<cfquery name="qryGeneric" datasource="#application.dbSrc#">
					SELECT a.answerfield fieldtext
					FROM answerfield_relationship ar, answerfield a
					WHERE ar.right_answerfield_id=#afobj.id#
						and ar.relationship_id=1
						AND ar.left_answerfield_id=a.answerfield_id
				</cfquery>
				<cfloop query="qryGeneric">
					<cfset "session.#fieldtext#" = "Y">
				</cfloop>
			<cfelse>
				<cfset "session.#field#" = "Y">
			</cfif>
		</cfif>
	</cfloop>
</cfif>
<!--- END DRUG PROCESSING --->


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


<cfset session.prg_list = "">
<cfset session.buff_list = "">

<!--- 07/09/2002 REM  The "normal" pass --->
<cf_screenRules ynDoBuffer="FALSE">

<!--- 07/09/2002 REM  Now we set up for Buffer --->
<!--- need to offset the total figures by 500 and 100 respectively --->
<CFSET SESSION.S_asset_TOTAL_COMPLETE = SESSION.s_asset_TOTAL_COMPLETE - 500>
<CFSET SESSION.S_SP_asset_TOTAL_COMPLETE = SESSION.S_SP_asset_TOTAL_COMPLETE - 500>
<CFSET SESSION.HH_asset_TOTAL_COMPLETE = SESSION.HH_asset_TOTAL_COMPLETE - 500>
<CFSET SESSION.S_INCOME_TOTAL_COMPLETE = SESSION.s_INCOME_TOTAL_COMPLETE - 100>
<CFSET SESSION.S_SP_INCOME_TOTAL_COMPLETE = SESSION.S_SP_INCOME_TOTAL_COMPLETE - 100>
<CFSET SESSION.HH_INCOME_TOTAL_COMPLETE = SESSION.HH_INCOME_TOTAL_COMPLETE - 100>

<cf_screenRules ynDoBuffer="TRUE">

<!--- now we put the total figures back again :)--->
<CFSET SESSION.S_asset_TOTAL_COMPLETE = SESSION.s_asset_TOTAL_COMPLETE + 500>
<CFSET SESSION.S_SP_asset_TOTAL_COMPLETE = SESSION.S_SP_asset_TOTAL_COMPLETE + 500>
<CFSET SESSION.HH_asset_TOTAL_COMPLETE = SESSION.HH_asset_TOTAL_COMPLETE + 500>
<CFSET SESSION.S_INCOME_TOTAL_COMPLETE = SESSION.s_INCOME_TOTAL_COMPLETE + 100>
<CFSET SESSION.S_SP_INCOME_TOTAL_COMPLETE = SESSION.S_SP_INCOME_TOTAL_COMPLETE + 100>
<CFSET SESSION.HH_INCOME_TOTAL_COMPLETE = SESSION.HH_INCOME_TOTAL_COMPLETE + 100>

<!--- 07/09/2002 REM  DONE WITH BUFFER --->



<!--- BS 05/19/03 --->
<!--- Check for clientnum data already in tbl_user_ans --->
<!--- If present, get new clientnum, to avoid dupe clientnums on browser back button --->
<cf_screenSessionClientnumCheck>



<cfif session.wantchips is "y">
	<cfset session.prg_list = ListAppend(session.prg_list, "'103-309-2191-FD-FD'")>
</cfif>
<!---
<cfif session.genericdrugs is "y">
	<cfset session.prg_list = ListAppend(session.prg_list, "'XXX-311-2387-FD-FD'")>
</cfif>
--->

<!--- Store client prg_id's 5-15-2001--->
<!--- 03/03/2002 REM  NOTE THAT THIS NEEDS TO BE REFINED TO FIGURE OUT HOW TO AVOID WRITING A 
DUPLICATE SET OF ENTRIES IF THE USER BACKS UP AND RESUBMITS HIS ANSWERS TO THIS PROCESS 
PAGE. --->
<cfif IsDefined('session.subset_id') And session.subset_id eq 1>
	<cfset unseenVal = 1>
<cfelse>
	<cfset unseenVal = 'NULL'>
</cfif>
<cfloop list="#session.prg_list#" index="prg_id">
	<cfset unseenAdjustedVal = unseenVal>
	<cfif unseenVal eq 'NULL'>
		<cfif Mid(prg_id, Find('-', prg_id) + 1, Find('-', prg_id, Find('-', prg_id) + 1) - Find('-', prg_id) - 1) eq '333'>
			<cfset unseenAdjustedVal = 1>
		</cfif>
	</cfif>
	<CFQUERY NAME="prgs" DATASOURCE="#application.dbSrc#">
		INSERT INTO tbl_user_prgid
			(prg_id, clientnum, unseen)
		VALUES
			(#PreserveSingleQuotes(prg_id)#, #session.clientnum#, #unseenAdjustedVal#)
	</CFQUERY>
</cfloop>

<!--- tag that will save the session variables that have been assigned during the questionaire into the answer table --->
<cfset session.end_time = CreateODBCDateTime(Now())>

<cf_tagvariabletracker>

<cf_screenPrintedReport randseed="#RandRange(1, 9999999)#">

<cfset "caller.#attributes.prglistvar#" = session.prg_list>
<cfset "caller.#attributes.bufflistvar#" = session.buff_list>
<cfset caller.pdfname = pdfname>
