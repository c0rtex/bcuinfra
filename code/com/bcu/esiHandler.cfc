<cfcomponent displayname="fitHandler" hint="Handles the answerfileds for the FIT app.">
<!--- 

--->
	<cfset variables.instance = structNew()>
	<cffunction name="init" access="public" returntype="any">
        <cfargument name="screening_id" type="numeric" required="yes" default="0">
        <cfargument name="noprocessing" type="boolean" required="no" default="false">
        <cfscript>
			variables.instance.screening_id = arguments.screening_id;
			variables.instance.fitNum = 0;
			variables.instance.lumpSum = 0;
			variables.instance.flagNum = 0;
			variables.instance.monthlyCashNeeds = 0;
			variables.instance.reponsetype_3 = 0;
			variables.instance.responsetype_2 = 0;
			variables.instance.responsetype_1 = 0;
			variables.instance.testScreenId = arguments.screening_id;
			variables.instance.qAnswerfields = getAnswerfieldsAsQuery();
			
			if(!arguments.noprocessing){
			processMonthlyCashNeeds(getQAnswerfields());
			processLumpSum(getQAnswerfields());
			processYellowFlags(getQAnswerfields());
			processFitNum(getFlagNum());
			};
		</cfscript>

		<cfreturn this />
	</cffunction>
    
    <cffunction name="getScreening_id" access="public" returntype="any">
		<cfreturn variables.instance.screening_id>
	</cffunction>
    <cffunction name="setScreening_id" access="public" returntype="void">
		<cfargument name="screening_id" type="numeric" required="yes">
        <cfset variables.instance.screening_id = arguments.screening_id />
	</cffunction>
    <cffunction name="getFitNum" access="public" returntype="any">
		<cfreturn variables.instance.fitNum>
	</cffunction>
    <cffunction name="setFitNum" access="public" returntype="void">
		<cfargument name="fitNum" type="numeric" required="yes">
        <cfset variables.instance.fitNum = arguments.fitNum />
	</cffunction>
    <cffunction name="getFlagNum" access="public" returntype="any">
		<cfreturn variables.instance.flagNum>
	</cffunction>
    <cffunction name="setFlagNum" access="public" returntype="void">
		<cfargument name="flagNum" type="numeric" required="yes">
        <cfset variables.instance.flagNum = arguments.flagNum />
	</cffunction>
    <cffunction name="setMonthlyCashNeeds" access="public" returntype="void">
		<cfargument name="monthlyCashNeeds" type="numeric" required="yes">
        <cfset variables.instance.monthlyCashNeeds = arguments.monthlyCashNeeds />
	</cffunction>
    <cffunction name="getMonthlyCashNeeds" access="public" returntype="numeric">
        <cfreturn variables.instance.monthlyCashNeeds />
	</cffunction>
    
    <cffunction name="makingEndsMeetExist" access="public" returntype="boolean">
    	<cfset var rtnBool = false>
        <cfset var qAnswerfields = getQAnswerfields()>
        <cfset var rtnCount = 0>
        <cfloop query="qAnswerfields">
        	<cfswitch expression="#answerfield#">
            	<cfcase value="mthly_exp,med_health_exp,proptax_homeins,other_mthly_needs_spec,fin_others">
                	<cfif option_code is "y">
                    	<cfreturn true>
                    </cfif>
                </cfcase>
            </cfswitch>
        </cfloop>
        <cfif rtnCount IS 4>
        	<cfset rtnBool = true>
        </cfif>
        <cfreturn rtnBool />
    </cffunction>
    
    <!---Challenges with the home environment [Print if Q21=More than 25 yrs, or Q22=Y]
	
	--->
    <cffunction name="homeChallengeExist" access="public" returntype="boolean">
    	<cfset var rtnBool = false>
        	<cfif session.house_age is 3>
            	<cfreturn true />
            </cfif>
            <cfif session.stairs_barriers is "y">
            	<cfreturn true />
            </cfif>
        <cfreturn rtnBool />
   	</cffunction>
    
    <!--- other resources are limited
		Q5(fit_no_pension,fit_pension_uncovered_spouse,fit_married_partner_in=n), or Q5c=Y, or Q6=N, or Q24=Y
	--->
    <cffunction name="otherResourcesExist" access="public" returntype="boolean">
    	<cfset var rtnBool = false>
        <cfset var qAnswerfields = getQAnswerfields()>
        <cfloop query="qAnswerfields">
        	<cfswitch expression="#answerfield#">
            	<cfcase value="fit_marital_stus">
               		<cfswitch expression="#option_code#">
                    	<cfcase value="fit_married_partner">
                        	<cfif session.fit_married_partner is "fit_no_pension" or session.fit_married_partner is "fit_pension_uncovered_spouse" or session.fit_married_partner_ins is "n">
                        		<cfreturn true />
                        	</cfif>
                        </cfcase>
                        <cfcase value="widowed,single,fit_div_sep">
                        	<cfif evaluate("session.live_alone_#option_code#") is "y">
                            	<cfreturn true />
                            </cfif>
                        </cfcase>
                    </cfswitch>
                </cfcase>
            </cfswitch>
        </cfloop>
        <cfif session.fit_emergency_help is "n" OR session.loan_fut_exp is "y">
        	<cfreturn true />
        </cfif>
        <cfreturn rtnBool />
    </cffunction>
    
    <!--- homeowner responsibilities
		(fit_have_homeowners_ins)=N or (fit_proptax_homeins_late)=Y
	--->
	<cffunction name="homeRespExist" access="public" returntype="boolean">
    	<cfset var rtnBool = false>
        <cfif session.fit_have_homeowners_ins IS "n" or session.fit_proptax_homeins_late IS "y">
        	<cfreturn true />
        </cfif>
        <cfreturn rtnBool />
    </cffunction>
    
    <!---Continue to get help from public programs [Print if Q18=Y]--->
    <cffunction name="publicProgramsExist" access="public" returntype="boolean">
    	<cfset var rtnBool = false>
        <cfif session.get_other_inc IS "y">
        	<cfreturn true />
        </cfif>
        <cfreturn rtnBool />
    </cffunction>
    
    <!--- Purchasing an annuity or other financial product [Print if Q2=Y]--->
    <cffunction name="annuityExist" access="public" returntype="boolean">
    	<cfset var rtnBool = false>
        <cfif session.fit_mortgage_use IS "y">
        	<cfreturn true />
        </cfif>
        <cfreturn rtnBool />
    </cffunction>
    
    <!--- Uncertainty about staying at home 
		(fit_past12)=Y, or (fit_health_homeowner1)=poor health/3, or (stay_hosp_nurse)=Y] 
	--->
    <cffunction name="stayingHomeExist" access="public" returntype="boolean">
    	<cfset var rtnBool = false>
        <cfset var qAnswerfields = getQAnswerfields()>
        <cfloop query="qAnswerfields">
        	<cfswitch expression="#answerfield#">
            	<cfcase value="fit_marital_stus">
               		<cfswitch expression="#option_code#">
                        <cfcase value="widowed,fit_div_sep">
                        	<cfif evaluate("session.fit_past12_#option_code#") is "y">
                            	<cfreturn true />
                            </cfif>
                        </cfcase>
                    </cfswitch>
                </cfcase>
                <cfcase value="fit_health_homeowner1">
                	<cfif session.fit_health_homeowner1 IS 3 OR session.fit_health_homeowner2 IS 3 OR session.fit_health_homeowner3 IS 3>
                    	<cfreturn true />
                    </cfif>
                </cfcase>
                <cfcase value="stay_hosp_nurse">
                	<cfif session.stay_hosp_nurse is "y">
                    	<cfreturn true />
                    </cfif>
                </cfcase>
            </cfswitch>
        </cfloop>
        <cfreturn rtnBool />
    </cffunction>
    
    <!--- Health and activity limitations [Print if Q9=Y to any limitation, or Q10=Y, or Q11=Y to helpers] 
		SELECT mem1 AS povLevel
		FROM tbl_inc_new
		WHERE proc_id = 484
		[Print if Q12<200% FPL, or Q9a=Yes, or Q11=Yes on receiving help]
		
		- Q12 >= 200% FPL AND Q9a=No AND Q11=None of the above
		
		Q12 < 200% FPL OR Q9a=Yes OR Q11=Yes on receiving help and shows:
		fit_summary_assessment_needed (sitetext_id=147)
		
		If - Q12 >= 200% FPL AND Q9a=No AND Q11=None of the above and "Yes" to question
		#25, then show:
		sitetext_id=192, fit_summary_assessment_requested
		
		If - Q12 >= 200% FPL AND Q9a=No AND Q11=None of the above and "NO" to question
		#25, then show:
		nothing
	--->
    <cffunction name="benefitsExist" access="public" returntype="numeric">
    	<cfset var rtnBool = 0>
        <cfset var qAnswerfields = getQAnswerfields()>
        <cfset var hhMembers = "mem1">
        <cfset var qPoverty = "">
        <cfset var maxPovertyAmt = 0>
        <cfloop query="qAnswerfields">
        	<cfswitch expression="#answerfield#">
            	<cfcase value="fit_marital_stus">
               		<cfswitch expression="#option_code#">
                    	<cfcase value="fit_married_partner">
							<cfset hhMembers = "mem2">
                        </cfcase>
                    </cfswitch>
                </cfcase>
            </cfswitch>
        </cfloop>
        <cfquery name="qPoverty" datasource="#application.dbSrc#" cachedwithin="#CreateTimeSpan(0,1,0,0)#">
        	SELECT <cfoutput>#hhMembers#</cfoutput> AS povLevel
			FROM tbl_inc_new
			WHERE proc_id = 484
        </cfquery>
        <cfif qPoverty.recordCount NEQ 0>
        	<cfset maxPovertyAmt = qPoverty.povLevel * 2>
            <cfif session.fit_annual_income LTE maxPovertyAmt>
            	<cfreturn 1 />
            </cfif>
        </cfif>
        <cfif session.bath_dress IS "y" OR session.fit_friend is "y" OR session.fit_paid_helper_caregiver is "y">
        	<cfreturn 1 />
        <cfelseif session.bath_dress NEQ "y" AND (session.fit_friend NEQ "y" OR session.fit_paid_helper_caregiver NEQ "y") AND session.fit_bcu_assessment is 'y'>
        	<cfreturn 2 />
        </cfif>
        <cfreturn rtnBool />
    </cffunction>
    
    <cffunction name="activityLimitsExist" access="public" returntype="boolean">
    	<cfset var rtnBool = false>
        <cfif session.fit_homeowner_fall IS "y">
        	<cfreturn true />
        </cfif>
        <cfif session.bath_dress IS "y" OR session.see_hear is "y" OR session.chores is "y">
        	<cfreturn true />
        </cfif>
        <cfif session.fit_paid_helper_caregiver is "y" or session.fit_friend is "y">
        	<cfreturn true />
        </cfif>
        <cfreturn rtnBool />
    </cffunction>
    
    <!--- Monthly cash needs : 
		(fit_mthly_exp_yes) + (fit_med_help_exp_yes) + (fit_proptax_homeins_yes) + (other_mthly_needs_val) + (fit_fin_others_yes)] 
	--->
    <cffunction name="processMonthlyCashNeeds" access="private" returntype="void">
    	<cfargument name="qAnswerfields" type="query" required="yes">
    	<cfset var rtnTotal = 0>
    	<cfloop query="arguments.qAnswerfields">
        	<cfswitch expression="#answerfield#">
            	<cfcase value="fit_mthly_exp_yes,fit_med_help_exp_yes,fit_proptax_homeins_yes,other_mthly_needs_val,fit_fin_others_yes">
                	<cfif response NEQ "">
                	<cfset rtnTotal = rtnTotal + response>
                    </cfif>
                </cfcase>
            </cfswitch>
        </cfloop>
        <cfset setMonthlyCashNeeds(rtnTotal)>
	</cffunction>
    <!--- / monthly cash needs --->
    
    
    <!--- yellow flags
	
	--->
    <cffunction name="processYellowFlags" access="private" returntype="void">
    	<cfargument name="qAnswerfields" type="query" required="yes">
        <cfset var rtnTotal = 0>
        <!--- Q2 --->
        <cfif session.fit_mortgage_use is "y">
        	<cfset rtnTotal++>
        </cfif>
        <!--- Q6 --->
        <cfif session.fit_emergency_help is "n">
        	<cfset rtnTotal++>
        </cfif>
        <!--- Q7 --->
        <cfif session.fit_health_homeowner1 IS 3 OR session.fit_health_homeowner2 IS 3 OR session.fit_health_homeowner3 IS 3>
			<cfset rtnTotal++>
        </cfif>
        <!--- Q8 --->
        <cfif session.stay_hosp_nurse is "y">
			<cfset rtnTotal++>
        </cfif>
        <!--- Q9 --->
        <cfif session.bath_dress IS "y" OR session.see_hear is "y" OR session.chores is "y">
        	<cfset rtnTotal++>
        </cfif>
        <!--- Q10 --->
        <cfif session.fit_homeowner_fall IS "y">
        	<cfset rtnTotal++>
        </cfif>
        <!--- Q11 --->
		<cfif (session.fit_friend IS "y" OR session.fit_paid_helper_caregiver is "y")>
        	<cfset rtnTotal++>
        </cfif>
        <!--- Q14 --->
        <cfif session.mthly_exp is "y" OR session.med_health_exp is "y" OR session.proptax_homeins is "y" OR session.other_mthly_needs_spec is "y">
        	<cfset rtnTotal++>
        </cfif>
        <!--- Q15 --->
        <cfif session.fit_have_homeowners_ins is "n">
        	<cfset rtnTotal++>
        </cfif>
        <!--- Q16 --->
        <cfif session.fit_proptax_homeins_late is "y" AND session.fit_proptax_homeins_late_yes is "y">
        	<cfset rtnTotal++>
        </cfif>
        <!--- Q18 --->
        <cfif session.get_other_inc is "y">
        	<cfset rtnTotal++>
        </cfif>
        <!--- Q21 --->
        <cfif session.house_age is 3>
        	<cfset rtnTotal++>
        </cfif>
        <!--- Q22 --->
        <cfif session.stairs_barriers is "y">
        	<cfset rtnTotal++>
        </cfif>
        <!--- Q24 --->
        <cfif session.loan_fut_exp is "y">
        	<cfset rtnTotal++>
        </cfif>
        
        <cfloop query="arguments.qAnswerfields">
        	<cfswitch expression="#answerfield#">
            	<cfcase value="fit_marital_stus">
               		<cfswitch expression="#option_code#">
                    	<!--- Q5 --->
                    	<cfcase value="fit_married_partner">
                        	<cfif session.fit_married_partner is "fit_no_pension" or session.fit_married_partner is "fit_pension_uncovered_spouse">
                        		<cfset rtnTotal++>
                        	</cfif>
                            <cfif session.fit_married_partner_ins is "n">
                            	<cfset rtnTotal++>
                            </cfif>
                        </cfcase>
                        <cfcase value="widowed,fit_div_sep">
                        	<cfif evaluate("session.fit_past12_#option_code#") is "y">
                            	<cfset rtnTotal++>
                            </cfif>
                            <cfif evaluate("session.live_alone_#option_code#") is "y">
                            	<cfset rtnTotal++>
                            </cfif>
                        </cfcase>
                        <cfcase value="single">
                        	<cfif evaluate("session.live_alone_#option_code#") is "y">
                            	<cfset rtnTotal++>
                            </cfif>
                        </cfcase>
                    </cfswitch>
                </cfcase>
            </cfswitch>
        </cfloop>
        <cfset setFlagNum(rtnTotal)>
    </cffunction>
    <!--- process fit number 5=0 flags, 4=1-3 flags, 3=4-6 flags, 2=7-9 flags, 1=10+ flags]--->
    <cffunction name="processFitNum" access="private" returntype="void">
    	<cfargument name="flagNum" type="numeric" required="yes">
        <cfif arguments.flagNum GTE 10>
        	<cfset setFitNum(1)>
        <cfelseif arguments.flagNum IS 0>
        	<cfset setFitNum(5)>
        <cfelseif arguments.flagNum EQ 7 OR arguments.flagNum EQ 8 OR arguments.flagNum EQ 9>
        	<cfset setFitNum(2)>
        <cfelseif arguments.flagNum EQ 4 OR arguments.flagNum EQ 5 OR arguments.flagNum EQ 6>
        	<cfset setFitNum(3)>
        <cfelseif arguments.flagNum EQ 1 OR arguments.flagNum EQ 2 OR arguments.flagNum EQ 3>
        	<cfset setFitNum(4)>
        </cfif>
        
    </cffunction>
    <!--- lump sum : 
		Q0(fit_home_debt) + Q19(fit_non_house_debt_yes ) + Q20(fit_loan_uses_yes) + Q23(fit_needs_mod_lt1yr_yes)
	--->
    <cffunction name="processLumpSum" access="private" returntype="void">
    	<cfargument name="qAnswerfields" type="query" required="yes">
    	<cfset var rtnTotal = 0>
    	<cfloop query="arguments.qAnswerfields">
        	<cfswitch expression="#answerfield#">
            	<cfcase value="fit_home_debt,fit_non_house_debt_yes,fit_loan_uses_yes,fit_needs_mod_lt1yr_yes">
                <cfif response NEQ "">
                	<cfset rtnTotal = rtnTotal + response>
                </cfif>
                </cfcase>
            </cfswitch>
        </cfloop>
        <cfset setLumpSum(rtnTotal)>
	</cffunction>
    <cffunction name="getLumpSum" access="public" returntype="any">
		<cfreturn variables.instance.lumpSum>
	</cffunction>
    <cffunction name="setLumpSum" access="public" returntype="void">
		<cfargument name="lumpSum" type="numeric" required="yes">
        <cfset variables.instance.lumpSum = arguments.lumpSum />
	</cffunction>
   
    <cffunction name="getAnswerfieldsAsQuery" access="public" returntype="query">
        <cfset var myList = "">
        <cfquery name="myList" datasource="#application.dbSrc#" cachedwithin="#CreateTimeSpan(0,1,0,0)#">
            SELECT a.answerfield, a.display_id, sa.responsetype, sa.response, sa.option_id, o.option_code, dl.display_text
            FROM answerfield a
            INNER JOIN screening_answerfield sa ON a.answerfield_id = sa.answerfield_id 
            LEFT OUTER JOIN `option` o ON sa.option_id = o.option_id
            LEFT OUTER JOIN display_language dl ON a.display_id = dl.display_id AND language_id = <cfoutput>'#session.language_id#'</cfoutput>
            WHERE   sa.screening_id = <cfoutput>#getScreening_id()#</cfoutput>
        </cfquery>
        <cfreturn myList />
    </cffunction>
    
    <cffunction name="getAnswerfield" access="public" returntype="query">
    	<cfargument name="answerfield" required="yes" type="string">
        <cfset var myList = "">
        <cfquery name="myList" datasource="#application.dbSrc#" cachedwithin="#CreateTimeSpan(0,1,0,0)#">
            SELECT a.answerfield, sa.responsetype, sa.response, sa.option_id, o.option_code
            FROM answerfield a
            INNER JOIN screening_answerfield sa ON a.answerfield_id = sa.answerfield_id 
            LEFT OUTER JOIN `option` o ON sa.option_id = o.option_id
            LEFT OUTER JOIN display_language dl ON a.display_id = dl.display_id AND language_id = <cfoutput>'#session.language_id#'</cfoutput>
            WHERE   sa.screening_id = <cfqueryparam cfsqltype="cf_sql_numeric" value="#getScreening_id()#" />
            AND answerfield = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.answerfield#" />
        </cfquery>
        <cfreturn myList />
    </cffunction>
    <cffunction name="getQAnswerfields" access="public" returntype="query">
		<cfreturn variables.instance.qAnswerfields>
	</cffunction>
    <cffunction name="setQAnswerfields" access="public" returntype="void">
		<cfargument name="qAnswerfields" type="query" required="yes">
        <cfset variables.instance.qAnswerfields = arguments.qAnswerfields />
	</cffunction>
</cfcomponent>