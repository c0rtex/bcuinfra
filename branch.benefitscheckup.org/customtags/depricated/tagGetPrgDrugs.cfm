<!-- requires prg_id and output options -->
<cfif isdefined('attributes.prg_id')>
	<cfset prg_id = "#attributes.prg_id#">
<cfelse>
	<cfset prg_id="">
</cfif>
<cfif isdefined('attributes.type')>
	<cfset type = "#attributes.type#">
<cfelse>
	<cfset type="none">
</cfif>
<cfif Type EQ "CMSTA">
	<cfset session.drugCount = 0 >
</cfif>
<cfif Type EQ "CheckCount">
	<cfset Session.AvailableDrugCount = 0 >
</cfif>
<cfif isdefined('attributes.output')>
	<cfset output = "#attributes.output#">
<cfelse>
	<cfset output ="">
</cfif>

<cfset hasOutputted = false>
<cfif not isdefined('session.structDrugOptionName')>
	<cfset session.structDrugOptionName = structnew()>
</cfif>
<cfloop collection="#session.structDrugOptionName#" item="x">
	<cfset temp_prg_id = #StructFind(session.structDrugPrgID, x)# >
	<cfif temp_prg_id eq '#prg_id#'>
		<cfset option_nm = #StructFind(session.structDrugOptionName, x)# >
		<!-- Display output depending on type attribute -->
		<cfif type EQ "PAP">
			<!--- <cfif ListFindNoCase(Session.WrapAroundDrugList, option_nm) eq 0> --->
				<cfif hasOutputted eq false>
					<Cfoutput>#option_nm#</Cfoutput>
				<cfelse>
					<cfoutput>, #option_nm#</Cfoutput>
				</cfif>
				<cfset hasOutputted = true>
			<!---  </cfif>  --->

		<cfelseif type EQ "CheckCount">
				<!-- <cfif ListFindNoCase(Session.WrapAroundDrugList, option_nm) eq 0>	 -->
					<cfset Session.AvailableDrugCount = Session.AvailableDrugCount + 1 >
				<!-- </cfif> -->

		<cfelseif type EQ "CMSTA" >
				<cfset Session.drugCount = Session.drugCount + 1 >
				<cfif ListFindNoCase(session.OutputtedDrugList, Option_nm) eq 0>
				<cfset session.OutputtedDrugList = #listAppend(session.OutputtedDrugList,Option_nm, ",")# >
					<cfset OPT_ID = #StructFind(session.structDrugOptID, x)# >
					<cfif listcontains(session.OPTLIST,OPT_ID,",")>
					<cfset doQuery = "No">
					<cfelse>
					<cfset session.OPTList = #listAppend(session.OPTLIST,OPT_ID,",")#>
						<cfset doQuery = "Yes">
					</cfif>

					<cfif doQuery eq "Yes" and output neq "No">
					<cfquery datasource="#application.dbSrc#" name="RxDetails" >
						SELECT     tbl_RX_MFR.MFR_Name, tbl_RX_MFR.Discount_Amount
						FROM         tbl_RX_MFR INNER JOIN
                      	tbl_RX_Detail ON tbl_RX_MFR.MFR_ID = tbl_RX_Detail.MFR_ID
						where opt_id = <cfqueryparam cfsqltype="cf_sql_integer" maxlength="4" value="#opt_id#">	
					</cfquery>
					<cfloop query="RxDetails"  >				
					<cfoutput query="RxDetails" >
					<ul>
					<li>
					#option_nm# - After the additional assistance is used up, <cfif #session.StrClient# IS "self">you <cfelse>your #session.StrClient# </cfif> can get this #MFR_Name# medication for <cfif Discount_Amount eq 0>a modest dispensing fee<cfelse>$#Discount_Amount# per prescription</cfif>.
					</li>
					</ul>
					</cfoutput>
					</cfloop>
					</cfif>
			 	</cfif>

		<cfelseif type EQ "CMSNOTA" >
				<cfset Session.drugCount = Session.drugCount + 1 >
				<cfset session.OutputtedDrugList = #listAppend(session.OutputtedDrugList,Option_nm, ",")# >
					<cfset OPT_ID = #StructFind(session.structDrugOptID, x)# >
					<cfif listcontains(session.OPTLIST,OPT_ID,",")>
					<cfset doQuery = "No">
					<cfelse>
					<cfset session.OPTList = #listAppend(session.OPTLIST,OPT_ID,",")#>
					<cfset doQuery = "Yes">
					</cfif>
					<cfif doQuery eq "Yes"  and output neq "No">
					<cfquery datasource="#application.dbSrc#" name="RxDetails" >
						SELECT     tbl_RX_MFR.MFR_Name, tbl_RX_MFR.Discount_Amount
						FROM         tbl_RX_MFR INNER JOIN
                      	tbl_RX_Detail ON tbl_RX_MFR.MFR_ID = tbl_RX_Detail.MFR_ID
						where opt_id = <cfqueryparam cfsqltype="cf_sql_integer" maxlength="4" value="#opt_id#">	
					</cfquery>

					<cfloop query="RxDetails" >				
					<cfoutput >
					<ul>
					<li>
					#option_nm# - <cfif #session.StrClient# IS "self">You <cfelse>Your #session.StrClient# </cfif> can get this #MFR_Name# medication for <cfif Discount_Amount eq 0>a modest dispensing fee<cfelse>$#Discount_Amount# per prescription</cfif>
					</li>
					</ul>
					</cfoutput>
					</cfloop>
				</cfif>
		<cfelseif type EQ "SETDRUGLIST">	
			<cfset Session.drugCount = Session.drugCount + 1 >
			<cfoutput>
				<li>
				#option_nm#
				</li>
			</cfoutput>
		<cfelseif type EQ "OtherCards">	
				<cfoutput>
				<ul><li>
				#option_nm# 
				</li></ul> 
				</cfoutput>
		</cfif>	
	</cfif>
</cfloop>