<!--- Get all fit screenings --->
<cfquery name="getFitScreenings" datasource="#application.dbSrc#">
    Select screening_id, language_id
    from screening
    where partner_id = 76 and subset_id = 61 and screening_id = 5003740
    order by screening_id ASC
</cfquery>
<!--- Debug --->
<cfoutput><b><font size="+2">Number of Completed FIT Screenings: #getFitScreenings.RecordCount#</font><BR>Start Time: #TimeFormat( Now(), "h:mm:ss TT" )#<b><BR><BR></cfoutput>

<!--- Get all screenings without fit score answerfield inserted into screening_answerfield --->
<cfloop query="getFitScreenings">

	<!--- Debug --->
    <cfoutput>-------------------------------------------------------------------------------------------<BR />Screening_id = #getFitScreenings.screening_id#<BR /></cfoutput>
    
	<cfset estLumpSum = 0>
    <cfset mthlyCashNeeds = 0>
    <cfset FitNum = 0>
	
	<!--- Est lump sum : Q0(fit_home_debt) + Q19(fit_non_house_debt_yes ) + Q20(fit_loan_uses_yes) + Q23(fit_needs_mod_lt1yr_yes) --->
	<!--- Check if fit est lump sum answerfield exists--->
    <cfquery name="chkFitEstLumpSumExists" datasource="#application.dbSrc#">
    	Select count(screening_id) as ctFitEstLumpSumAF
        from screening_answerfield
        where screening_id = #getFitScreenings.screening_id# and answerfield_id = 6645
    </cfquery>
    <cfif chkFitEstLumpSumExists.ctFitEstLumpSumAF eq 0>
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
        <cfquery name="insertFitEstLumpSum" datasource="#application.dbSrc#">
        	INSERT INTO screening_answerfield
            (screening_id, answerfield_id, responsetype, response, pagenum, derived_flag, submit_datetime)
        	VALUES
            (#getFitScreenings.screening_id#, 6646, 1, #estLumpSum#, 1, 1, #CreateODBCDateTime(Now())#)
    	</cfquery>
        <!--- Debug --->
        <cfoutput>AF ID 6646 (fitEstLumpSum) inserted! Est Lump Sum = #estLumpSum#<BR></cfoutput>
    <cfelse>
    	<!--- Debug --->
        <cfoutput>AF ID 6646 (fitEstLumpSum) NOT inserted cause this AFID already exists for this screening!<BR /></cfoutput>
    </cfif>
    <!--- END Est lump sum --->
    
    <!--- Monthly cash needs : (fit_mthly_exp_yes) + (fit_med_help_exp_yes) + (fit_proptax_homeins_yes) + (other_mthly_needs_val) + (fit_fin_others_yes) --->
    <!--- Check if fit est mthly cash needs answerfield exists--->
    <cfquery name="chkFitEstMthlyCashNeedsExists" datasource="#application.dbSrc#">
    	Select count(screening_id) as ctFitEstMthlyCashNeedsAF
        from screening_answerfield
        where screening_id = #getFitScreenings.screening_id# and answerfield_id = 6645
    </cfquery>
    <cfif chkFitEstMthlyCashNeedsExists.ctFitEstMthlyCashNeedsAF eq 0>
    	<cfquery name="fit_mthly_exp_yes" datasource="#application.dbSrc#">
            Select response
            from screening_answerfield
            where screening_id = #getFitScreenings.screening_id# and answerfield_id = 6363
        </cfquery>
        <cfif IsNumeric(fit_mthly_exp_yes.response)>
            <cfset fmey = #fit_mthly_exp_yes.response#>    
        <cfelse>
            <cfset fmey = 0>
        </cfif>
        <cfquery name="fit_med_help_exp_yes" datasource="#application.dbSrc#">
            Select response
            from screening_answerfield
            where screening_id = #getFitScreenings.screening_id# and answerfield_id = 6364
        </cfquery>
        <cfif IsNumeric(fit_med_help_exp_yes.response)>
            <cfset fmhey = #fit_med_help_exp_yes.response#>    
        <cfelse>
            <cfset fmhey = 0>
        </cfif>
        <cfquery name="fit_proptax_homeins_yes" datasource="#application.dbSrc#">
            Select response
            from screening_answerfield
            where screening_id = #getFitScreenings.screening_id# and answerfield_id = 6365
        </cfquery>
        <cfif IsNumeric(fit_proptax_homeins_yes.response)>
            <cfset fphy = #fit_proptax_homeins_yes.response#>    
        <cfelse>
            <cfset fphy = 0>
        </cfif>
        <cfquery name="other_mthly_needs_val" datasource="#application.dbSrc#">
            Select response
            from screening_answerfield
            where screening_id = #getFitScreenings.screening_id# and answerfield_id = 6313
        </cfquery>
        <cfif IsNumeric(other_mthly_needs_val.response)>
            <cfset omnv = #other_mthly_needs_val.response#>    
        <cfelse>
            <cfset omnv = 0>
        </cfif>
        <cfquery name="fit_fin_others_yes" datasource="#application.dbSrc#">
            Select response
            from screening_answerfield
            where screening_id = #getFitScreenings.screening_id# and answerfield_id = 6369
        </cfquery>
        <cfif IsNumeric(fit_fin_others_yes.response)>
            <cfset ffoy = #fit_fin_others_yes.response#>    
        <cfelse>
            <cfset ffoy = 0>
        </cfif>
        <cfset mthlyCashNeeds = #fmey# + #fmhey# + #fphy# + #omnv# + #ffoy#>
        <cfquery name="insertFitEstMthlyCashNeeds" datasource="#application.dbSrc#">
        	INSERT INTO screening_answerfield
            (screening_id, answerfield_id, responsetype, response, pagenum, derived_flag, submit_datetime)
        VALUES
            (#getFitScreenings.screening_id#, 6645, 1, #mthlyCashNeeds#, 1, 1, #CreateODBCDateTime(Now())#)
    	</cfquery>
        <!--- Debug --->
        <cfoutput>AF ID: 6645 (Est Mthly Cash Needs) inserted! response = #mthlyCashNeeds#<BR></cfoutput>
    <cfelse>
    	<!--- Debug --->
        <cfoutput>AF ID 6645 (Est Mthly Cash Needs) NOT inserted cause this AFID already exists for this screening!<BR /></cfoutput>
    </cfif>
    <!--- END Mthly Cash Needs --->
    
        
    <!--- FIT NUM Recalculation from db --->
    <!--- Check if fit Score answerfield exists--->
    <cfquery name="chkFitScoreExists" datasource="#application.dbSrc#">
    	Select count(screening_id) as ctFitScoreAF
        from screening_answerfield
        where screening_id = #getFitScreenings.screening_id# and answerfield_id = 6644
    </cfquery>
    <cfif chkFitScoreExists.ctFitScoreAF eq 0>
		<!--- yellow flags --->
        <cfset rtnTotal = 0>
        <!--- Q2 --->
        <cfquery name="getQ2" datasource="#application.dbSrc#">
            Select option_id
            from screening_answerfield
            where screening_id = #getFitScreenings.screening_id# and answerfield_id = 6346
        </cfquery>
        <cfif getQ2.option_id EQ 1>
            <cfset rtnTotal++>
            <cfoutput>Q2 Yellow Flag<BR /></cfoutput>
        </cfif>
        <!--- Q6 --->
        <cfquery name="getQ6" datasource="#application.dbSrc#">
            Select option_id
            from screening_answerfield
            where screening_id = #getFitScreenings.screening_id# and answerfield_id = 6355
        </cfquery>
        <cfif getQ6.option_id EQ 0>
            <cfset rtnTotal++>
            <cfoutput>Q6 Yellow Flag<BR /></cfoutput>
        </cfif>
        <!--- Q7 --->
        <cfquery name="getQ7_H1" datasource="#application.dbSrc#">
            Select option_id
            from screening_answerfield
            where screening_id = #getFitScreenings.screening_id# and answerfield_id = 6356
        </cfquery>
        <cfquery name="getQ7_H2" datasource="#application.dbSrc#">
            Select option_id
            from screening_answerfield
            where screening_id = #getFitScreenings.screening_id# and answerfield_id = 6357
        </cfquery>
        <cfquery name="getQ7_H3" datasource="#application.dbSrc#">
            Select option_id
            from screening_answerfield
            where screening_id = #getFitScreenings.screening_id# and answerfield_id = 6358
        </cfquery>
        <cfif getQ7_H1.option_id EQ 3 OR getQ7_H2.option_id EQ 3 OR getQ7_H3.option_id EQ 3>
            <cfset rtnTotal++>
            <cfoutput>Q7 Yellow Flag<BR /></cfoutput>
        </cfif>
        <!--- Q8 --->
        <cfquery name="getQ8" datasource="#application.dbSrc#">
            Select option_id
            from screening_answerfield
            where screening_id = #getFitScreenings.screening_id# and answerfield_id = 6296
        </cfquery>
        <cfif getQ8.option_id EQ 1>
            <cfset rtnTotal++>
            <cfoutput>Q8 Yellow Flag<BR /></cfoutput>
        </cfif>
        <!--- Q9 --->
        <cfquery name="getQ9_dress" datasource="#application.dbSrc#">
            Select option_id
            from screening_answerfield
            where screening_id = #getFitScreenings.screening_id# and answerfield_id = 6297
        </cfquery>
        <cfquery name="getQ9_hear" datasource="#application.dbSrc#">
            Select option_id
            from screening_answerfield
            where screening_id = #getFitScreenings.screening_id# and answerfield_id = 6298
        </cfquery>
        <cfquery name="getQ9_chores" datasource="#application.dbSrc#">
            Select option_id
            from screening_answerfield
            where screening_id = #getFitScreenings.screening_id# and answerfield_id = 6300
        </cfquery>
        <cfif getQ9_dress.option_id EQ 1 OR getQ9_hear.option_id EQ 1 OR getQ9_chores.option_id EQ 1>
            <cfset rtnTotal++>
            <cfoutput>Q9 Yellow Flag<BR /></cfoutput>
        </cfif>
        <!--- Q10 --->
        <cfquery name="getQ10" datasource="#application.dbSrc#">
            Select option_id
            from screening_answerfield
            where screening_id = #getFitScreenings.screening_id# and answerfield_id = 6360
        </cfquery>
        <cfif getQ10.option_id EQ 1>
            <cfset rtnTotal++>
            <cfoutput>Q10 Yellow Flag<BR /></cfoutput>
        </cfif>
        <!--- Q11 --->
        <cfquery name="getQ11_friend" datasource="#application.dbSrc#">
            Select option_id
            from screening_answerfield
            where screening_id = #getFitScreenings.screening_id# and answerfield_id = 6374
        </cfquery>
        <cfquery name="getQ11_caregiver" datasource="#application.dbSrc#">
            Select option_id
            from screening_answerfield
            where screening_id = #getFitScreenings.screening_id# and answerfield_id = 6375
        </cfquery>
        <cfif (getQ11_friend.option_id EQ 1 OR getQ11_caregiver.option_id EQ 1)>
            <cfset rtnTotal++>
            <cfoutput>Q11 Yellow Flag<BR /></cfoutput>
        </cfif>
        <!--- Q14 --->
        <cfquery name="getQ14_mthly" datasource="#application.dbSrc#">
            Select option_id
            from screening_answerfield
            where screening_id = #getFitScreenings.screening_id# and answerfield_id = 6304
        </cfquery>
        <cfquery name="getQ14_med" datasource="#application.dbSrc#">
            Select option_id
            from screening_answerfield
            where screening_id = #getFitScreenings.screening_id# and answerfield_id = 6305
        </cfquery>
        <cfquery name="getQ14_proptax" datasource="#application.dbSrc#">
            Select option_id
            from screening_answerfield
            where screening_id = #getFitScreenings.screening_id# and answerfield_id = 6306
        </cfquery>
        <cfquery name="getQ14_other" datasource="#application.dbSrc#">
            Select option_id
            from screening_answerfield
            where screening_id = #getFitScreenings.screening_id# and answerfield_id = 6312
        </cfquery>
        <cfif getQ14_mthly.option_id EQ 1 OR getQ14_med.option_id EQ 1 OR getQ14_proptax.option_id EQ 1 OR getQ14_other.option_id EQ 1>
            <cfset rtnTotal++>
            <cfoutput>Q14 Yellow Flag<BR /></cfoutput>
        </cfif>
        <!--- Q15 --->
        <cfquery name="getQ15" datasource="#application.dbSrc#">
            Select option_id
            from screening_answerfield
            where screening_id = #getFitScreenings.screening_id# and answerfield_id = 6373
        </cfquery>
        <cfif getQ15.option_id EQ 0>
            <cfset rtnTotal++>
            <cfoutput>Q15 Yellow Flag<BR /></cfoutput>
        </cfif>
        <!--- Q16 --->
        <cfquery name="getQ16_late" datasource="#application.dbSrc#">
            Select option_id
            from screening_answerfield
            where screening_id = #getFitScreenings.screening_id# and answerfield_id = 6367
        </cfquery>
        <cfquery name="getQ16_late_yes" datasource="#application.dbSrc#">
            Select option_id
            from screening_answerfield
            where screening_id = #getFitScreenings.screening_id# and answerfield_id = 6368
        </cfquery>
        <cfif getQ16_late.option_id EQ 1 AND getQ16_late_yes.option_id EQ 1>
            <cfset rtnTotal++>
            <cfoutput>Q16 Yellow Flag<BR /></cfoutput>
        </cfif>
        <!--- Q18 --->
        <cfquery name="getQ18" datasource="#application.dbSrc#">
            Select option_id
            from screening_answerfield
            where screening_id = #getFitScreenings.screening_id# and answerfield_id = 6315
        </cfquery>
        <cfif getQ18.option_id EQ 1>
            <cfset rtnTotal++>
            <cfoutput>Q18 Yellow Flag<BR /></cfoutput>
        </cfif>
        <!--- Q21 --->
        <cfquery name="getQ21" datasource="#application.dbSrc#">
            Select option_id
            from screening_answerfield
            where screening_id = #getFitScreenings.screening_id# and answerfield_id = 6327
        </cfquery>
        <cfif getQ21.option_id EQ 3>
            <cfset rtnTotal++>
            <cfoutput>Q21 Yellow Flag<BR /></cfoutput>
        </cfif>
        <!--- Q22 --->
        <cfquery name="getQ22" datasource="#application.dbSrc#">
            Select option_id
            from screening_answerfield
            where screening_id = #getFitScreenings.screening_id# and answerfield_id = 6323
        </cfquery>
        <cfif getQ22.option_id EQ 1>
            <cfset rtnTotal++>
            <cfoutput>Q22 Yellow Flag<BR /></cfoutput>
        </cfif>
        <!--- Q24 --->
        <cfquery name="getQ24" datasource="#application.dbSrc#">
            Select option_id
            from screening_answerfield
            where screening_id = #getFitScreenings.screening_id# and answerfield_id = 6326
        </cfquery>
        <cfif getQ24.option_id EQ 1>
            <cfset rtnTotal++>
            <cfoutput>Q24 Yellow Flag<BR /></cfoutput>
        </cfif>
        
        <!--- Q5 --->
        
        <cfquery name="myList" datasource="#application.dbSrc#">
            SELECT *
            from screening_answerfield
            WHERE   screening_id = #getFitScreenings.screening_id# and answerfield_id = 6347
        </cfquery>
        <cfloop query="myList">
            <cfswitch expression="#option_id#">
                <cfcase value="2455">
                    <cfquery name="getSubAnswerfield6348" datasource="#application.dbSrc#">
                        Select option_id
                        from screening_answerfield
                        where answerfield_id = 6348
                    </cfquery>
                    <cfif getSubAnswerfield6348.option_id EQ 2457 or getSubAnswerfield6348.option_id EQ 2458>
                    	<cfoutput>Q5 married pension spouse not covered or no pension Yellow Flag<BR /></cfoutput>
                        <cfset rtnTotal++>
                    </cfif>
                    <cfquery name="getSubAnswerfield6349" datasource="#application.dbSrc#">
                        Select option_id
                        from screening_answerfield
                        where answerfield_id = 6349
                    </cfquery>
                    <cfif getSubAnswerfield6349.option_id EQ 0>
                        <cfset rtnTotal++>
                        <cfoutput>Q5 married no life insurance Yellow Flag<BR /></cfoutput>
                    </cfif>
                </cfcase>
                <cfcase value="7">
                    <cfquery name="getSubAnswerfield6384" datasource="#application.dbSrc#">
                        Select option_id
                        from screening_answerfield
                        where answerfield_id = 6384
                    </cfquery>
                    <cfif getSubAnswerfield6384.option_id EQ 1>
                        <cfset rtnTotal++>
                        <cfoutput>Q5 widowed past 12 mths Yellow Flag<BR /></cfoutput>
                    </cfif>
                    <cfquery name="getSubAnswerfield6385" datasource="#application.dbSrc#">
                        Select option_id
                        from screening_answerfield
                        where answerfield_id = 6385
                    </cfquery>
                    <cfif getSubAnswerfield6385.option_id EQ 1>
                        <cfset rtnTotal++>
                        <cfoutput>Q5 widowed live alone Yellow Flag<BR /></cfoutput>
                    </cfif>
                </cfcase>
                <cfcase value="2456">
                    <cfquery name="getSubAnswerfield6387" datasource="#application.dbSrc#">
                        Select option_id
                        from screening_answerfield
                        where answerfield_id = 6387
                    </cfquery>
                    <cfif getSubAnswerfield6387.option_id EQ 1>
                        <cfset rtnTotal++>
                        <cfoutput>Q5 Divorce/Sep past 12 mths Yellow Flag<BR /></cfoutput>
                    </cfif>
                    <cfquery name="getSubAnswerfield6388" datasource="#application.dbSrc#">
                        Select option_id
                        from screening_answerfield
                        where answerfield_id = 6388
                    </cfquery>
                    <cfif getSubAnswerfield6388.option_id EQ 1>
                        <cfset rtnTotal++>
                        <cfoutput>Q5 Div/Sep live alone Yellow Flag<BR /></cfoutput>
                    </cfif>
                </cfcase>
                <cfcase value="6">
                    <cfquery name="getSubAnswerfield6382" datasource="#application.dbSrc#">
                        Select option_id
                        from screening_answerfield
                        where answerfield_id = 6382
                    </cfquery>
                    <cfif getSubAnswerfield6382.option_id EQ 1>
                        <cfset rtnTotal++>
                        <cfoutput>Q5 Single live alone Yellow Flag<BR /></cfoutput>
                    </cfif>
                </cfcase>
            </cfswitch>
        </cfloop>
        
        <!--- process fit number 5=0 flags, 4=1-3 flags, 3=4-6 flags, 2=7-9 flags, 1=10+ flags]--->
        <cfif rtnTotal GTE 10>
            <cfset FitNum = 1>
        <cfelseif rtnTotal EQ 0>
            <cfset FitNum = 5>
        <cfelseif rtnTotal EQ 7 OR rtnTotal EQ 8 OR rtnTotal EQ 9>
            <cfset FitNum = 2>
        <cfelseif rtnTotal EQ 4 OR rtnTotal EQ 5 OR rtnTotal EQ 6>
            <cfset FitNum = 3>
        <cfelseif rtnTotal EQ 1 OR rtnTotal EQ 2 OR rtnTotal EQ 3>
            <cfset FitNum = 4>
        </cfif>
    
        <!--- END FIT NUM Recalculation from db --->
        
        <!--- Debug --->
        <cfoutput>Yellow Flags = #rtnTotal#<BR /></cfoutput>
        
        <cfquery name="insertFitScore" datasource="#application.dbSrc#">
            INSERT INTO screening_answerfield
                (screening_id, answerfield_id, responsetype, response, pagenum, derived_flag, submit_datetime)
            VALUES
                (#getFitScreenings.screening_id#, 6644, 1, #FitNum#, 1, 1, #CreateODBCDateTime(Now())#)
        </cfquery>
        <!--- Debug --->
        <cfoutput>AF ID 6644 (fitScore) inserted! FitNum = #FitNum#<BR></cfoutput>
    <cfelse>
    	<!--- Debug --->
        <cfoutput>AF ID 6644 (fitScore) NOT inserted cause this AFID already exists for this screening!<BR /></cfoutput>
    </cfif>
    
    <!--- Debug --->
    <cfoutput>-------------------------------------------------------------------------------------------<BR /><BR /></cfoutput>
</cfloop>
<cfoutput><b><font size="+2">The script is complete.</font><BR>End Time: #TimeFormat( Now(), "h:mm:ss TT" )#<b><BR><BR></cfoutput>