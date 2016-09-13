<!--- Get all fit screenings --->
<cfquery name="getFitScreenings" datasource="#application.dbSrc#">
	Select screening_id, language_id
    from screening
    where partner_id = 76 and subset_id = 61 and end_datetime IS NOT NULL
    order by screening_id ASC
</cfquery>
<!--- Debug --->
<cfoutput><b><font size="+2">Number of Completed FIT Screenings: #getFitScreenings.RecordCount#</font><BR>Start Time: #TimeFormat( Now(), "h:mm:ss TT" )#<b><BR><BR></cfoutput>

<!--- Get all screenings without fit score answerfield inserted into screening_answerfield --->
<cfloop query="getFitScreenings">

	<!--- Debug --->
    <cfoutput>-------------------------------------------------------------------------------------------<BR />Screening_id = #getFitScreenings.screening_id#<BR /></cfoutput>
    
	<cfset estLumpSum = 0>
    	
   <cfquery name="fit_home_debt" datasource="#application.dbSrc#">
            Select response
            from screening_answerfield
            where screening_id = #getFitScreenings.screening_id# and answerfield_id = 6333
        </cfquery>
        <cfif IsNumeric(fit_home_debt.response)>
            <cfset fhb = #fit_home_debt.response#>
        <cfelse>
            <cfset fhb = 0>    
        </cfif>
        <cfquery name="fit_non_house_debt_yes" datasource="#application.dbSrc#">
            Select response
            from screening_answerfield
            where screening_id = #getFitScreenings.screening_id# and answerfield_id = 6370
        </cfquery>
        <cfif IsNumeric(fit_non_house_debt_yes.response)>
            <cfset fnhdy = #fit_non_house_debt_yes.response#>    
        <cfelse>
            <cfset fnhdy = 0>
        </cfif>
        <cfquery name="fit_loan_uses_yes" datasource="#application.dbSrc#">
            Select response
            from screening_answerfield
            where screening_id = #getFitScreenings.screening_id# and answerfield_id = 6371
        </cfquery>
         <cfif IsNumeric(fit_loan_uses_yes.response)>
            <cfset fluy = #fit_loan_uses_yes.response#>    
        <cfelse>
            <cfset fluy = 0>
        </cfif>
        <cfquery name="fit_needs_mod_lt1yr_yes" datasource="#application.dbSrc#">
            Select response
            from screening_answerfield
            where screening_id = #getFitScreenings.screening_id# and answerfield_id = 6372
        </cfquery>
        <cfif IsNumeric(fit_needs_mod_lt1yr_yes.response)>
            <cfset fnmly = #fit_needs_mod_lt1yr_yes.response#>    
        <cfelse>
            <cfset fnmly = 0>
        </cfif>
        <cfset estLumpSum = #fhb# + #fnhdy# + #fluy# + #fnmly#>
        <!---cfquery name="insertFitEstLumpSum" datasource="#application.dbSrc#">
        	INSERT INTO screening_answerfield WITH (ROWLOCK)
            (screening_id, answerfield_id, responsetype, response, pagenum, derived_flag, submit_datetime)
        	VALUES
            (#getFitScreenings.screening_id#, 6646, 1, #estLumpSum#, 1, 1, #CreateODBCDateTime(Now())#)
    	</cfquery--->
        <!--- Debug --->
    	<cfoutput>AF ID: 6646 (Est Lump Sum) updated! Est Lump Sum = #estLumpSum# --> #fhb# + #fnhdy# + #fluy# + #fnmly#<BR></cfoutput>
    	<!--- END EST lump Sum --->
</cfloop>    