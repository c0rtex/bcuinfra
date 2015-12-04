<cfparam name="page" type="numeric" default="0">
<cfparam name="edit" type="numeric" default="0">
<cfparam name="continue" type="numeric" default="0">
<cfparam name="badResponseList" type="string" default="">
<cfparam name="session.screening.recap" default="0">
<cfparam name="url.repop" default="false">
<cfset session.reloadpage = "false">
<cfset session.SCREENING.PGNO = 2>
<cfset session.subset_id = 72>
<cfset session.org_id = 0>
<cfset session.partner_id = 14>
<cfset session.source_id = 1>
<cfset session.client_id=''>
<cfset session.user_id =''>
<cfset session.prev_id  =''>
<cfset session.access_id  =''>
<cfset session.STATE_ID =''>
<cfset session.test_ID =''>
<cfset session.language_id = 'EN'>
<cfoutput>

<cfinclude template="mockupmqcheader3.cfm">
<!--- wait message  --->
<div class="span12">  
<center><img alt="MedicareQuickCheck" title="MedicareQuickCheck" src="/cf/img/MedicareQuickCheck_logo.gif"></center>
	
       
        <div class="whitewell span12" >
	  <div class="span4" align="center">
            <img src="img/gears_animated.gif"><br><br>
	  </div>
	  <div  class="span8" >
            <h4>Did you know?</h4>
		<h4>For more than 60 years, the National Council on Aging (NCOA) has been the
nation's leading nonprofit service and advocacy organization representing older
adults and the community organizations that serve them.  NCOA's  goal is to
improve the health, independence, and economic security of 10 million older
adults by 2020.</h4><br><br><br><br><br>
	  </div>
	 
	
        </div>
                      
</div> 
<cfinclude template="mockupmqcfooter.cfm">
</cfoutput>
<cfflush>
<!--- Process Report from wordpress page questionnaire --->



<!---cf_sessionLoadVarsPHP --->
<cfif isdefined('form.screeningID') >
	<cfif isdefined('url.debug')>	
		<cfoutput>rescreen #form.screeningID#</cfoutput>
   	</cfif>
<!--- handleScreeningPHP initvarname="accumAFList" debug="false" action="start" screening_id="#form.screeningID#" --->
<cfset session.screening_id = form.screeningID>
</cfif>
<cf_handleScreeningPHP initvarname="accumAFList" debug="false">
<!---cfdump var="#form#" --->
<!--- Log Screening Data , Validate and Set values to database --->
<cf_logScreeningInputPHP initvarname="accumAFList" useOptionCodes="true" debug="false">
<cfflush>
<!--- Check for Validation Errors if so return to form --->
<cfif badResponseList neq ''>
  <cfif isdefined('url.debug') >
	<cfoutput><p>ScreeningID: #session.screening_id# badResponseList: #badResponseList#</p></cfoutput>
	<cfabort>
  <cfelse>
	<cfoutput><meta http-equiv="refresh" content="0;url=/quickcheck?badresponselist=#badResponseList#&screeningID=#session.screening_id#"></cfoutput>
  </cfif>
<cfelse>
	<cfinclude template="getcontentrules.cfm">
	<cfset tmpScreeningID = session.screening_id>
	<cfinclude template="procMQCShadowPHP.cfm">
	<cfoutput><meta http-equiv="refresh" content="0;url=https://www.benefitscheckup.org/mqc-results/?screeningID=#tmpScreeningID#&shadowID=#session.screening_id#&request_id=#session.cfid#-#cftoken#"></cfoutput>
		<cfabort>
</cfif>
