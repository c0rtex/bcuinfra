<cfparam name="display_level" type="numeric">
<cfparam name="Scenario" type="string">
<cfset arrayActions = arrayNew(1)>
<cfset arrayLinks = arrayNew(1)>
<cfif url.reportType eq 'simple'>
	<cfset listtype='none'>
<cfelseif url.reportType eq 'card'>
	<cfset listtype='unordered'>
<cfelse>
	<cfset listtype='ordered'>
</cfif>
	<cfset ST = "XX">
<cfset temp_display_level = display_level >
<cfif display_level eq 1 and mode eq "Summary">
	<cfinclude template="qryStateScenarios.cfm">
	<cfset catlist = "">
	<!-- set cat list to be used to filter drugs in tagDrugInfo -->
	<cfloop query="qryStateScenarios">
		<cfif len(qryStateScenarios.Template_name) gt 1 >
			<cfif Template_name eq 'PAP'>
					<cfset CatList = #ListAppend(CatList, '331', ",")# >
			<cfelseif  Template_name eq 'CMSCard'>
					<cfset CatList = #ListAppend(CatList, '334', ",")# >
			<cfelseif  Template_name eq 'WrapAround'>
					<cfset CatList = #ListAppend(CatList, '333', ",")# >
			<cfelseif  Template_name eq 'OtherCards'>
					<cfset CatList = #ListAppend(CatList, '332', ",")# >
			</cfif>
		</cfif>
	</cfloop>
	<!--- create structure of drugs --->
	<cfif catlist neq "">
		<cf_tagDrugInfo CATLIST="#CATLIST#"> 
	</cfif>
</cfif>
<cfif display_level eq 1>
	<cfif listtype eq 'ordered'>
		<ol class="striping">
	<cfelseif listtype eq 'unordered'  >
		<ul class="striping">
	</cfif>
</cfif>
<!-- set cat list to be used to filter drugs in tagDrugInfo -->
<cfif (session.subset_id eq 19  ) or ( (isdefined('url.ReportType')) and (url.ReportType eq 'PAP'))>
  <cfif display_level eq 1>
    <cfset CatList = #ListAppend(CatList, '331', ",")# >
    <cfset CatList = #ListAppend(CatList, '332', ",")# >
    <cf_tagDrugInfo CATLIST="#CATLIST#"> 
      <cfinclude template="dspfiles/dspPAP.cfm">
  <cfelse>
      <cfinclude template="dspfiles/dspOtherCards.cfm">  
  </cfif>
<cfelseif (session.subset_id eq 12) or ( (isdefined('url.ReportType')) and (url.ReportType eq 'Card'))>
  <cfif display_level eq 1>
  <cfset CatList = #ListAppend(CatList, '333', ",")# >
  <cfset CatList = #ListAppend(CatList, '334', ",")# >
  <cf_tagDrugInfo CATLIST="#CATLIST#"> 
      <cfinclude template="dspfiles/dspWrapAround.cfm">
  </cfif>
<cfelse>
  <cfset PartDOutput = "No"> 
    <cfif isdefined('url.debug')>
        <cfdump var="#qryStateScenarios#">
        <cfoutput>#scenario#</cfoutput>
    </cfif>
  <cfloop query="qryStateScenarios">
      <cfoutput>
      <cfif len(qryStateScenarios.Template_name) gt 1  AND #qryStateScenarios.display_level# eq '#temp_display_level#' >				
          <cfinclude template="dspfiles/dsp#qryStateScenarios.template_name#.cfm"> 
      </cfif>
      </cfoutput>
  </cfloop>
   
  <cfif display_level eq 1 and (session.subset_id eq 39 or session.subset_id eq 27)  and request.ShowCompareAfter eq "Y">
      <cfinclude template="dspfiles/dspComparePlans.cfm"> 
  </cfif>
</cfif>
<cfif listtype eq 'ordered'>
</ol>
<cfelseif listtype eq 'unordered'  >
</ul>
</cfif>