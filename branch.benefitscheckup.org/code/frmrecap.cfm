<!----=======================================
DESCRIPTION: Displays the answers that the user supplied to various questions. Displays within own window
CALLED BY: Hyperlink on frmEligibility.cfm
GOES TO: ProcIncome.cfm
REQUIRED: N/A
NOTES:   Go through each of the identified session variables, make sure they exist, and make sure
			they are not set to zero (default parameter) and then from there customize each to 
			the user through the session.strClient variable.....on the asset figures, there is an additional
			step of adding in values from the grid that we dont actually add in for eligibility testing, 
			but if the user keeps track of what they entered and see our totals mismatch there's
			they may precieve it as an error.
============================================---->
<CFOUTPUT>
<cfset session.s_sp_ASSET_IRREVOCABLE = ReReplace(session.s_sp_ASSET_IRREVOCABLE,'\.(.*)','','ALL')> <!--- remove anything after a .--->
<cfset session.s_sp_ASSET_IRREVOCABLE = reReplaceNoCase(session.s_sp_ASSET_IRREVOCABLE, '[^[:digit:]]', '', 'ALL') > <!---Lynna Cekova: replace all nonnumeric characters such as $ --->
<cfset session.sp_ASSET_IRREVOCABLE = ReReplace(session.sp_ASSET_IRREVOCABLE,'\.(.*)','','ALL')> <!--- remove anything after a .--->
<cfset session.sp_ASSET_IRREVOCABLE = reReplaceNoCase(session.sp_ASSET_IRREVOCABLE, '[^[:digit:]]', '', 'ALL') > <!---Lynna Cekova: replace all nonnumeric characters such as $ --->
<cfset session.s_sp_ASSET_LIFE_FACE = ReReplace(session.s_sp_ASSET_LIFE_FACE,'\.(.*)','','ALL')> <!--- remove anything after a .--->
<cfset session.s_sp_ASSET_LIFE_FACE = reReplaceNoCase(session.s_sp_ASSET_LIFE_FACE, '[^[:digit:]]', '', 'ALL') > <!---Lynna Cekova: replace all nonnumeric characters such as $ --->
<cfset session.sp_ASSET_LIFE_FACE = ReReplace(session.s_sp_ASSET_LIFE_FACE,'\.(.*)','','ALL')> <!--- remove anything after a .--->
<cfset session.sp_ASSET_LIFE_FACE = reReplaceNoCase(session.s_sp_ASSET_LIFE_FACE, '[^[:digit:]]', '', 'ALL') > <!---Lynna Cekova: replace all nonnumeric characters such as $ --->




<cfif session.partner_id neq 14>
<TITLE> Answer Recap</TITLE>
<!--- Javascript for closing window--->
<BODY ONBLUR="window.close();" BGCOLOR="white">
<P></P>
<FONT face="Arial" size=4 class="mmmHide"><b>Answer Recap</b></font>
<hr>
</cfif>
<FONT face="Arial">
<CFIF IsDefined('session.st')>

<CFIF #session.StrClient# IS "self">You
<CFELSE>Your #session.StrClient# </CFIF>
 screened for benefits in: #session.st#<BR>
</CFIF>

<CFIF IsDefined('session.dob')>
	<CFIF session.dob NEQ 0>
		<CFIF #session.StrClient# IS "self">Your
		<CFELSE>Your #session.StrClient#'s</CFIF>
	 age is: #session.dob#<BR>
	</cfif>
</CFIF>

<CFIF IsDefined('session.marital_stat')>
	<CFIF session.marital_stat NEQ 0>
		<CFIF #session.StrClient# IS "self">Your
		<CFELSE>Your #session.StrClient#'s</CFIF>
	 marital status is: #session.marital_stat#<BR>
	</CFIF>
</CFIF>

<CFIF IsDefined('session.work_status')>
	<CFIF session.work_status NEQ 0>
		<CFIF #session.StrClient# IS "self">Your
		<CFELSE>Your #session.StrClient#'s</CFIF>
	 work status is: #session.work_status#<BR>
	</CFIF>
</CFIF>

<CFIF IsDefined('session.S_asset_TOTAL_COMPLETE')>
	 <cfif session.S_asset_TOTAL_COMPLETE gte '100000' OR session.skipassets EQ "N">
		<CFSET recapTotal = #Session.s_ASSET_IRREVOCABLE# + #Session.s_ASSET_LIFE_FACE# + #SESSION.s_asset_TOTAL_COMPLETE#>
			<CFIF #session.StrClient# IS "self">Your 
			<CFELSE>Your #session.StrClient#'s</CFIF>
		 total assets are greater than $100,000.<BR>
	 <CFelse>
		<CFSET recapTotal = #Session.s_ASSET_IRREVOCABLE# + #Session.s_ASSET_LIFE_FACE# + #SESSION.s_asset_TOTAL_COMPLETE#>
			<CFIF #session.StrClient# IS "self">Your 
			<CFELSE>Your #session.StrClient#'s</CFIF>
		 total assets are: $#NumberFormat('#recaptotal#')#<BR>
	 </cfif>
</CFIF>

<CFIF IsDefined('session.marital_stat')>
	<CFIF #session.marital_stat# IS 'married'>
		<CFIF IsDefined('session.SP_asset_TOTAL_COMPLETE')>
			<cfif session.sp_asset_total_complete gte '100000' OR session.skipassets EQ "N">
			<CFSET recapTotal = #Session.sp_ASSET_IRREVOCABLE# + #Session.sp_ASSET_LIFE_FACE# + #SESSION.sp_asset_TOTAL_COMPLETE#>
				<CFIF #session.StrClient# IS "self">Your
				<CFELSE>Your #session.StrClient#'s</CFIF>
		 	spouse's total assets are greater than $100,000.<BR>
			<CFSET recapTotal = #Session.s_ASSET_IRREVOCABLE# + #Session.s_ASSET_LIFE_FACE# + #SESSION.s_asset_TOTAL_COMPLETE#+ #Session.sp_ASSET_IRREVOCABLE# + #Session.sp_ASSET_LIFE_FACE# + #SESSION.sp_asset_TOTAL_COMPLETE#>
			
				<CFIF #session.StrClient# IS "self">Your and your
				<CFELSE>Your #session.StrClient# and his/her</CFIF>
	 		spouse's total assets are greater than $100,000.<BR>
			<cfelse>	
		
			<CFSET recapTotal = #Session.sp_ASSET_IRREVOCABLE# + #Session.sp_ASSET_LIFE_FACE# + #SESSION.sp_asset_TOTAL_COMPLETE#>
				<CFIF #session.StrClient# IS "self">Your
				<CFELSE>Your #session.StrClient#'s</CFIF>
		 	spouse's total assets are: $#NumberFormat('#recaptotal#')#<BR>

			<CFSET recapTotal =  #Session.S_sp_ASSET_IRREVOCABLE# + #Session.S_sp_ASSET_LIFE_FACE# + #SESSION.S_sp_asset_TOTAL_COMPLETE#>
			 
				<CFIF #session.StrClient# IS "self">Your and your
				<CFELSE>Your #session.StrClient# and his/her</CFIF>
	 		spouse's total assets are: $#NumberFormat('#recaptotal#')#<BR>
			</cfif>
		</cfif>
	</CFIF>
</CFIF>

<CFIF IsDefined('SESSION.hh_asset_TOTAL_COMPLETE')>
 <cfif session.hh_asset_total_complete gte '100000' OR session.skipassets EQ "N">
	<CFSET recapTotal = #Session.HH_ASSET_IRREVOCABLE# + #Session.HH_ASSET_LIFE_FACE# + #SESSION.hh_asset_TOTAL_COMPLETE#>
	
		<CFIF #session.StrClient# IS "self">Your
		<CFELSE>Your #session.StrClient#'s</CFIF>
	 household's total assets are greater than $100,000<BR>
 <cfelse> 
	 <CFSET recapTotal = #Session.HH_ASSET_IRREVOCABLE# + #Session.HH_ASSET_LIFE_FACE# + #SESSION.hh_asset_TOTAL_COMPLETE#>

		<CFIF #session.StrClient# IS "self">Your
		<CFELSE>Your #session.StrClient#'s</CFIF>
	 household's total assets are: $#NumberFormat('#recaptotal#')#<BR>
 </cfif>
</CFIF>

<CFIF IsDefined('session.S_income_TOTAL_COMPLETE')>
 <cfif session.S_income_TOTAL_COMPLETE gte '1000000' OR session.skipinc EQ "N">
	<CFIF #session.StrClient# IS "self">Your 
	<CFELSE>Your #session.StrClient#'s</CFIF>
     total monthly income is greater than $4,500. <BR>
 <cfelse>
	<CFIF #session.StrClient# IS "self">Your 
		<CFELSE>Your #session.StrClient#'s</CFIF>
	 total monthly income is: $#Numberformat('#session.S_income_TOTAL_COMPLETE#')#<BR>
 </cfif>
</CFIF>

<CFIF IsDefined('session.marital_stat')>
	<CFIF #session.marital_stat# IS 'married'>
		 <CFIF IsDefined('session.SP_INCOME_TOTAL_COMPLETE')>
			<cfif session.SP_INCOME_Total_COMPLETE gte '1000000' OR session.skipinc EQ "N">
				<CFIF #session.StrClient# IS "self">Your
				<CFELSE>Your #session.StrClient#'s</CFIF>
			 spouse's total monthly income is greater than $4,500. <BR>
		
				<CFIF #session.StrClient# IS "self">Your and your
				<CFELSE>Your #session.StrClient# and his/her</CFIF>
			 spouse's total monthly income is greater than $4,500.<BR>
		    
			<cfelse>
				<CFIF #session.StrClient# IS "self">Your
				<CFELSE>Your #session.StrClient#'s</CFIF>
			 spouse's total monthly income is: $#numberformat('#session.SP_INCOME_TOTAL_COMPLETE#')#<BR>
			
				<CFIF #session.StrClient# IS "self">Your and your
				<CFELSE>Your #session.StrClient# and his/her</CFIF>
			 spouse's total monthly income is: $#numberformat('#SESSION.S_SP_income_total_complete#')#<BR>
			
			
			</cfif>
	  </CFIF>
		
	</CFIF>
</CFIF>

<CFIF IsDefined('SESSION.hh_income_total_complete')>
   <cfif session.hh_income_total_complete gte '1000000' OR session.skipinc EQ "N">
	
		<CFIF #session.StrClient# IS "self">Your
		<CFELSE>Your #session.StrClient#'s</CFIF>
	 entire household's total monthly income is greater than $4,500.<BR>
   <cfelse>
  	
		<CFIF #session.StrClient# IS "self">Your
		<CFELSE>Your #session.StrClient#'s</CFIF>
	 entire household's total monthly income is: $#numberformat('#SESSION.hh_income_total_complete#')#<BR>
	    
  </cfif>
</CFIF>



<CFIF IsDefined('session.veteran')>
	<cfif session.veteran IS 'Y'>
		<CFIF #session.StrClient# IS "self">You are
		<CFELSE>Your #session.StrClient# is</CFIF>
	 a veteran.<BR>
	</CFIF>
</CFIF>


<CFIF IsDefined('session.INT_ALZHEIMER')>
	<cfif session.INT_ALZHEIMER IS 'Y'>
		<CFIF #session.StrClient# IS "self">You are
		<CFELSE>Your #session.StrClient# is</CFIF>
	 interested in information on Alzheimer's programs.<BR>
	</CFIF>
</CFIF>

<CFIF IsDefined('session.int_blind')>
	<cfif session.INT_BLIND IS 'Y'>
		<CFIF #session.StrClient# IS "self">You are
		<CFELSE>Your #session.StrClient# is</CFIF>
	 interested in information for the visually impaired.<BR>
	</CFIF>
</CFIF>

<CFIF IsDefined('session.int_deaf')>
	<cfif session.INT_DEAF IS 'Y'>
		<CFIF #session.StrClient# IS "self">You are
		<CFELSE>Your #session.StrClient# is</CFIF>
	 interested in information for the hearing impaired.<BR>
	</CFIF>
</CFIF>

<CFIF IsDefined('session.int_vol')>
	<cfif session.INT_VOL IS 'Y'>
		<CFIF #session.StrClient# IS "self">You are
		<CFELSE>Your #session.StrClient# is</CFIF>
	 interested in volunteer information.<BR>
	</CFIF>
</CFIF>

<CFIF IsDefined('session.no_hh_members')>
      Number of people living in your household: #session.no_hh_members#<BR>
</CFIF>
 
<CFIF IsDefined('session.over_60')>
      Number of people who are 60 years old or older: #session.over_60#<BR>
</CFIF>
<CFIF IsDefined('session.hh_disabled')>	
      Number of people who have a disability: #session.hh_disabled#<BR>
</CFIF>
</cfoutput>

<cfif IsDefined('session.selectedDrugs')>
	<cfset hasOutputted = false>
	<cfloop list="#session.selectedDrugs#" index="chosendrug">
		<cfif #hasOutputted# EQ false>
			<DL>
			<DT><cfoutput><cfif #session.StrClient# IS "self">You are<cfelse>Your #session.StrClient# is</cfif> taking the following medications:<BR></cfoutput>
			<cfset hasOutputted = true>
		</cfif>
        <cfset afobj = application.AnswerfieldPool.getAnswerfield('#chosendrug#')>
		<cfif afobj.type eq 'drug'>
			<DD><li><cf_displayText group="rx" code="rx_#LCase(chosendrug)#"></li>
		<cfelseif afobj.type eq 'generic'>
			<DD><li><cf_displayText group="generic" code="generic_#LCase(chosendrug)#"></li>
		</cfif>
	</cfloop>
</cfif>
</Dl>

<!--- 12/16/2002 BS  No need to check selected drug companies at the moment, unless we put that question back in

<cfset hasOutputed=false>
<CFLOOP collection=#session# item="Y">
<cfif #Y# CONTAINS 'DC_' AND #session[y]# NEQ 0>
<cfif #hasOutputed# EQ false>
<dL>
<DT><cfoutput>The following drug company(s) make your medications:<BR></cfoutput> 
<cfset hasOutputed=true>
</cfif>
<DD><li><cf_displayText code="rxco_#LCase(Y)#" group="rxco"></li>
</cfif>
</cfloop>
<cfoutput></dl></cfoutput>

--->

</FONT>

<cfif session.partner_id neq 14>
<div align="center" style="margin-top:50px;">
</cfif>
<cfif session.partner_id neq 14>
<cf_tagClose>
</cfif>
</div>

