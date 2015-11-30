<cfparam name="attributes.selectedDrugs" type="string">
<cfparam name="attributes.strSummary" type="string">
<cfparam name="attributes.strClient" type="string">
<cfset selectedDrugs = #attributes.selectedDrugs# >
<cfset strClient = #attributes.strClient# >
<cfif isdefined('attributes.strSummary')>
	<cfset strSummary = #attributes.strSummary# >
<cfelse>
	<cfset strSummary = "Yes">
</cfif>

<cfif IsDefined('selectedDrugs')>
<cfset position = ListFindNoCase(selectedDrugs, "null", ",")>
<cfif position gt 0>
	<cfset selectedDrugs = ListDeleteAt(selectedDrugs, position ,  "," )>
</cfif>

<cfset TotalDrugs = #ListLen(selectedDrugs, ",")#  >
<cfset hasOutputted=false>
<cfset tempCount = 0 >
<cfloop list="#selectedDrugs#" index="chosendrug">
<cfset tempCount = tempCount + 1 >
<cfif #hasOutputted# EQ false>
<cfif strSummary eq "Yes"><cfoutput><li><cfif #StrClient# IS "self">You are<cfelse>Your #StrClient# is</cfif> taking the following medications<cfif IsDefined('session.drugnumber')> <i>(<a href="frmDrugList.cfm?shownumber=#session.drugnumber#&cfid=#session.cfid#&cftoken=#session.cftoken#">click here</a> to make any corrections)</i></cfif>:</li></cfoutput></cfif>
<cfset hasOutputted=true>
<ul>
</cfif>
<cfif Left(chosendrug, 1) eq 'g'>
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="getName">
		SELECT generic_name option_nm
		FROM tbl_generic
		WHERE generic_id=#Right(chosendrug, Len(chosendrug) - 1)#
	</CFQUERY>
<cfelse>
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="getName">
		SELECT option_nm
		FROM tbl_opt
		WHERE lower(fieldtext) = '#LCase(chosendrug)#'
		ORDER BY sort_id
	</CFQUERY>
</cfif>
<CFOUTPUT query="getName">
<font size="3"><li>#option_nm#</li></font>
</CFOUTPUT>
</cfloop>
</cfif>
</ul>