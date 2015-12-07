<cfcomponent>
	<cffunction name="setvalues" returntype="struct"  >
		<!-- this function loops through the batch fields, maps, validates and cleans some fields and prepares the data to be passed to the screening tag-->
		<cfargument required="yes" name="BatchQuery" type="query">
		<cfset fieldlist = batchquery.columnList >
		<cfset mappeddata = structnew()>
		<!--- Commenting out this line. Not sure of the purpose but is causing invalid processing by overwriting app values from CSV with a blank.
		cfset BatchQuery.BE_CLNT_SUB_SW = ""--->
       <cfloop list="#fieldlist#" index="field" >
        	<cfset queryfield = "BatchQuery." & "#field#">
			<cfset thisvalue = "">
			<cfset thisvalue = #evaluate(queryfield)# >
			<cfset thisvalue = trim(thisvalue)>
			<!--- cfoutput>Field #field# value: #thisvalue# </br></cfoutput ---->
			<!--- Removed 12/07/09 
			<cfif field eq 'be_ins_pol_amt'>
				<cfif BatchQuery.be_ins_pol_amt lt 1 and BatchQuery.be_clnt_ins_pol_xnd eq 'y' >
					<cfset thisvalue = '1'>			
				</cfif>
			</cfif>--->
			<cfif field eq 'be_clnt_earn_loss_xnd' or field eq 'be_noncl_earn_loss_xnd'>
				<cfif thisvalue eq  'yes_net_earnings'>
					<cfset thisvalue = "2366-yes_net_earnings">
				<cfelseif thisvalue eq  'yes_net_loss'>
					<cfset thisvalue = "2367-yes_net_loss">
				<cfelseif thisvalue eq  'n'>
					<cfset thisvalue = "0-n">
				</cfif>
			</cfif>								
				
			<cfif field eq 'be_clnt_sfx' or  field eq 'be_noncl_sfx'>
				<cfif thisvalue eq  'jr' or thisvalue eq 'sfx_junior'>
					<cfset thisvalue = "2349-sfx_junior">
				<cfelseif thisvalue eq  'sr' or thisvalue eq 'sfx_senior'>
					<cfset thisvalue = "2350-sfx_senior">
				<cfelseif thisvalue eq  'I' or thisvalue eq 'sfx_1'>
					<cfset thisvalue = "2351-sfx_1">
				<cfelseif thisvalue eq  'II' or thisvalue eq 'sfx_2'>
					<cfset thisvalue = "2352-sfx_2">
				<cfelseif thisvalue eq  'III' or thisvalue eq 'sfx_3'>
					<cfset thisvalue = "2353-sfx_3">
				<cfelseif thisvalue eq  'IV' or thisvalue eq 'sfx_4'>
					<cfset thisvalue = "2354-sfx_4">
				</cfif>
			</cfif>		
		
					
			<cfif field eq 'BE_THRD_REL'>
				<cfif thisvalue eq  'rel_agency'>
					<cfset thisvalue = "2360-rel_agency" >
				<cfelse>
					<cfif thisvalue eq  'rel_advocate'>
						<cfset thisvalue = "2361-rel_advocate" >
					<cfelse>
						<cfset thisvalue = "2365-rel_other" >
					</cfif>
				</cfif>
			</cfif>
			
			<cfif field eq 'CT_MRTL_STUS'>
				<cfif thisvalue eq  'married_living_together'>
					<cfset thisvalue = "2347-married_living_together">
				<cfelseif thisvalue eq "single">
					<cfset thisvalue = "6-single">
				<cfelseif thisvalue eq "married_not_living_together">
					<cfset thisvalue = "2348-married_not_living_together">
				<cfelseif thisvalue eq "divorced">
					<cfset thisvalue = "5-divorced">
				<cfelseif thisvalue eq "widowed">
					<cfset thisvalue = "7-widowed">
				<cfelseif thisvalue eq "separated">
					<cfset thisvalue = "2346-separated">	
				</cfif>
				<!--- cfoutput>CT_MRTL_STUS:#thisvalue#</cfoutput --->
			</cfif>
			<cfif (field eq 'BE_CLNT_BUEXP_SW') or (field eq 'BE_NONCL_BUEXP_SW') or (field eq 'BE_SEND_MSPINFO_CD')>
				<cfif thisvalue eq  '1'>
					<cfset thisvalue = "y">
				<cfelse>
					<cfset thisvalue = "n">	
				</cfif>
				
			</cfif>
            
            <!-- Removed ,be_expense_xnd,,BE_CLNT_INS_POL_XND,BE_NONCL_INS_POL_XND 12/7/09 -->
			<cfif #listcontainsnocase('BE_RES_BANK_ACC_XND,BE_RES_INVST_XND,BE_RES_CSH_XND,be_clnt_earn_xnd,be_clnt_earn_wgs_xnd,be_clnt_loss_xnd,be_clnt_oth_incm_xnd,be_clnt_pens_annuit_xnd,be_clnt_va_benefits_xnd,be_ins_pol_xnd',field,",")#  >
				<cfif thisvalue neq 'y' and thisvalue neq 'n' >
					<cfset thisvalue = 'n'>
					<!--- cfoutput><br/>XND Field: #field# Value: #thisvalue#<br/></cfoutput ---->				
				</cfif>
			</cfif>
			
            <!--- Removed 12/07/09 
			<cfif (#findnocase('_amt',field)# gt 0 )  and ((thisvalue lt 0) or (thisvalue eq '') or (thisvalue eq 'NULL')) and field neq 'be_ins_pol_amt' >
				<!---cfoutput><br/>Field Not Mapped: #field# : #thisvalue#<br/></cfoutput--->
			<cfelseif (#findnocase('_CNTCT',field)# gt 0 )  and ( (thisvalue eq '') or (thisvalue eq 'NULL')) >
				<!--- cfoutput><br/>Field Not Mapped: #field# : #thisvalue#<br/></cfoutput --->
			<cfelseif (field eq 'be_clnt_mnm') and ((#len(thisvalue)# lt 1) or (thisvalue eq 'NULL')) >
				<!--- cfoutput><br/>Field Not Mapped: #field# : #thisvalue#<br/></cfoutput --->
			<cfelseif (field eq 'be_noncl_mnm') and ((#len(thisvalue)# lt 1) or (thisvalue eq 'NULL')) >
				<!--- cfoutput><br/>Field Not Mapped: #field# : #thisvalue#<br/></cfoutput --->
			<cfelseif ((#findnocase('_NONCL',field)# gt 0) and (BatchQuery.be_wh_apply neq 'y' and BatchQuery.be_wh_apply neq 'n'))>
			    <!---cfoutput><br/>SPOUSE Field Not Mapped: #field# : #thisvalue#<br/></cfoutput --->
			<cfelseif #findnocase('ient_id',field)# gt 0 >
			    <!--- cfoutput><br/> Not Mapped: #field# : #thisvalue#<br/></cfoutput --->
			<cfelseif #findnocase('ssabatch_id',field)# gt 0 >
			    <!--- cfoutput><br/> Not Mapped: #field# : #thisvalue#<br/></cfoutput --->
			<cfelse>
				<cfset results = #structinsert(mappeddata,field,thisvalue)#>
			</cfif>--->
            
			<!-- Added 12/07/09 -->
	     
            		<cfset mappedField = field>
			<cfif mappedField eq 'ct_live' >
  				<cfset mappedField = 'CT_LIVE_GRT'>
			<cfelseif mappedField eq 'be_thrd_addr_st' >
  				<cfset mappedField = 'CT_THRD_ADDR_ST_GRT'>
			<cfelseif mappedField eq 'be_clnt_cossn' >
  				<cfset mappedField = 'CT_CLNT_COSSN'>
			<cfelseif mappedField eq 'be_noncl_cossn' >
  				<cfset mappedField = 'CT_NONCL_COSSN'>
			<cfelseif mappedField eq 'be_clnt_mail_addr_ST' >
  				<cfset mappedField = 'CT_CLNT_MAIL_ADDR_ST_GRT'>
			</cfif>

			<cfset results = #structinsert(mappeddata,mappedField,thisvalue)#>
                        			
        </cfloop>
		<cfreturn mappeddata>
	</cffunction>

	<cffunction name="getfieldlist" returntype="string"  >
			<cfargument name="mappedresults" required="yes" type="struct">
			<!-- Set AFLIST to be passed into logscreening -->
			<cfset afList = "">
			<cfset firstList = "">
			<cfquery name="fieldtypes" dbtype="query" DATASOURCE="#session.datasrc#" >
					SELECT at.answerfieldtype_id, a.answerfield
         			FROM answerfield a 
         			INNER JOIN subset_answerfield sa ON a.answerfield_id = sa.answerfield_id 
					INNER JOIN answerfieldtype at ON a.answerfieldtype_id = at.answerfieldtype_id 
					where subset_id = 41
          			ORDER BY a.answerfield 
			</cfquery>

			<cfset secondList = "">
			<cfloop query="fieldtypes">
				<cfset field = fieldtypes.answerfield >
				<cfif #structkeyexists(mappedresults,field)#>
					<cfif #structfind(mappedresults,field)# neq '' >
						<cfif field eq 'ct_live_grt'>
							<cfset addval = 's-' & #field#>	
						<cfelseif field eq 'ct_clnt_mail_addr_st_grt'>
							<cfset addval = 's-' & #field#>
						<cfelseif field eq 'be_clnt_mail_addr_zip5'>
							<cfset addval = 's-' & #field#>
						<cfelseif field eq 'ct_thrd_addr_st_grt'>
							<cfset addval = 's-' & #field#>
						<cfelseif field eq 'BE_THRD_ADDR_zip5'>
							<cfset addval = 's-' & #field#>
						<cfelseif fieldtypes.answerfieldtype_id eq "1">
							<cfset addval = 's-' & #field#>
						<cfelseif fieldtypes.answerfieldtype_id eq "2">
							<cfset addval = 'n-' & #field#>
						<cfelseif fieldtypes.answerfieldtype_id eq "3">
							<cfset addval = 'n-' & #field#>
						<cfelseif fieldtypes.answerfieldtype_id eq "4">
							<cfset addval = 's-' & #field#>
						<cfelseif fieldtypes.answerfieldtype_id eq "5">
							<cfset addval = 'y-' & #field#>
						<cfelseif fieldtypes.answerfieldtype_id eq "6">
							<cfset addval = 'y-' & #field#>
						<cfelseif fieldtypes.answerfieldtype_id eq "7">
							<cfset addval = 'y-' & #field#>
						<cfelseif fieldtypes.answerfieldtype_id eq "8">
							<cfset addval = 'o-' & #field#>
						<cfelseif fieldtypes.answerfieldtype_id eq "9">
							<cfset addval = 'o-' & #field#>
						<cfelseif fieldtypes.answerfieldtype_id eq "10">
							<cfset addval = 's-' & #field#>
						<cfelseif fieldtypes.answerfieldtype_id eq "12">
							<cfset addval = 's-' & #field#>
						<cfelseif fieldtypes.answerfieldtype_id eq "13">
							<cfset addval = 'c-' & #field#>
						<cfelseif fieldtypes.answerfieldtype_id eq "14">
							<cfset addval = 'c-' & #field#>
						<cfelseif fieldtypes.answerfieldtype_id eq "15">
							<cfset addval = 'c-' & #field#>
						<cfelseif fieldtypes.answerfieldtype_id eq "16">
							<cfset addval = 'i-' & #field#>
						<cfelseif fieldtypes.answerfieldtype_id eq "17">
							<cfset addval = 'a-' & #field#>
						<cfelseif fieldtypes.answerfieldtype_id eq "18">
							<cfset addval = 'c-' & #field#>
						<cfelseif fieldtypes.answerfieldtype_id eq "19">
							<cfset addval = 's-' & #field#>
						<cfelseif fieldtypes.answerfieldtype_id eq "20">
							<cfset addval = 's-' & #field#>
						<cfelseif fieldtypes.answerfieldtype_id eq "21">
							<cfset addval = 's-' & #field#>
						<cfelseif fieldtypes.answerfieldtype_id eq "22">
							<cfset addval = 's-' & #field#>
						<cfelseif fieldtypes.answerfieldtype_id eq "23">
							<cfset addval = 'c-' & #field#>
						<cfelse>
							<cfset addval = 's-' & #field#>
						</cfif>
						<!-- Removed ,be_expense_xnd,BE_CLNT_INS_POL_XND,BE_NONCL_INS_POL_XND 12/07/09 -->
						<cfif #listcontainsnocase('BE_RES_BANK_ACC_XND,BE_RES_INVST_XND,BE_RES_CSH_XND,be_clnt_earn_xnd,be_clnt_earn_wgs_xnd,be_clnt_loss_xnd,be_clnt_oth_incm_xnd,be_clnt_pens_annuit_xnd,be_clnt_va_benefits_xnd,be_ins_pol_xnd',field,",")#  >
							<cfset firstList = #listappend(firstList,addval,",")#>
						<cfelseif #listcontainsnocase('BE_CLNT_BUEXP_SW,BE_NONCL_BUEXP_SW',field,",")#>
							<cfset secondList = #listappend(secondList,addval,",")#>
						<cfelse>
							<cfset afList = #listappend(afList,addval,",")#>
						</cfif>
					</cfif>
				</cfif>
			</cfloop>
			<cfset afList = #listappend(afList,secondList,",")#>
			<cfset afList = #listprepend(afList,firstlist,",")#>
		<cfreturn aflist>
	</cffunction>
</cfcomponent>
