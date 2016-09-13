<!-- recap responses at beginning of report -->
<cfquery name="qryRecap" datasource="#application.dbSrc#">
SELECT     rec, answerfield
FROM         programtext
WHERE     (template = 'PROFILE') 
order by sortorder ASC
</cfquery>
<ul>
<cfloop query="qryRecap" >
	<cfset tmpAnswerfield = "session.#answerfield#">
	<cfif evaluate('#tmpAnswerfield#') eq 'y'>
		<cfoutput><li>#rec#</li></cfoutput>
	</cfif>
</cfloop>

<cfif structKeyExists(session.screening.afval, 'rx_off_label') and  StructFind(session.screening.afval, 'rx_off_label') eq 1>
	<li>You indicated that you may be taking one or more medications for an "off label" use</li>
<cfelseif structKeyExists(session.screening.afval, 'rx_off_label') and StructFind(session.screening.afval, 'rx_off_label') eq 1474>
	<li>You indicated that you may be taking one or more medications for an "off label" use</li>
</cfif>

<cfif structKeyExists(session.screening.afval, 'rx_oop_costs') and  StructFind(session.screening.afval, 'rx_oop_costs') gt 0>
	<li>You indicated that you are currently spending <cfoutput>#Numberformat(session.rx_oop_costs,'$_,___,___')#</cfoutput>
out-of-pocket on medications each month.</li>
</cfif>

<cfif session.hh_income_earned eq 0>
	<li>You indicated that you have no monthly work income</li>
<cfelseif session.hh_income_earned gte 5000 >
	<li>
		You indicated that you have monthly work income above <cfoutput>#Numberformat(session.hh_income_earned,'$_,___,___')#</cfoutput>
	</li>
<cfelse>
	<cfset upperrange_income_earned = session.hh_income_earned + 99>
	<li>You indicated that you have monthly work income between 
		<cfoutput>#Numberformat(session.hh_income_earned,'$_,___,___')# and #Numberformat(upperrange_income_earned,"$_,___,___")#</cfoutput>
	</li>
</cfif>

<cfif session.hh_income_other_nw eq 0>
	<li>You indicated that you have no monthly income from sources other than employment</li>
<cfelseif session.hh_income_other_nw gte 5000>
	<li>You indicated that you have monthly income from sources other than employment above 
	<cfoutput>#Numberformat(session.hh_income_other_nw,'$_,___,___')#</cfoutput></li>
<cfelse>
	<cfset upperrange_income_other_nw = session.hh_income_other_nw + 99>
	<li>You indicated that you have monthly income from sources other than employment between <cfoutput>#Numberformat(session.hh_income_other_nw,'$_,___,___')# and #Numberformat(upperrange_income_other_nw,'$_,___,___')#</cfoutput></li>
</cfif>

<cfif session.hh_asset_total_complete eq 0>
	<li>You indicated that you have no assets</li>
</cfif>

<cfif session.marital_stat eq 'Married'>
	<cfif session.hh_asset_total_complete gt  23000 >
		<li>You indicated that your assets are above $23,000  </li>
	<cfelseif session.hh_asset_total_complete gt 18000 >
		<li>You indicated that your assets are between $18,001 and $23,000 </li>
	<cfelseif session.hh_asset_total_complete gt 15000 >
		<li>You indicated that your assets are between $15,001 and $18,000</li>
	<cfelseif session.hh_asset_total_complete gt  10000 >
		<li>You indicated that your assets are between $10,001 and $15,000 </li>
	<cfelseif session.hh_asset_total_complete gt 6000 >
		<li>You indicated that your assets are between $6,001 and $10,000 </li>
	<cfelseif session.hh_asset_total_complete gt 5000 >
		<li>You indicated that your assets are between $5,001 and $6,000</li>
	<cfelseif session.hh_asset_total_complete gt 4000 >
		<li>You indicated that your assets are between $4,001 and $5,000 </li>
	<cfelseif session.hh_asset_total_complete gt 3000>
		<li>You indicated that your assets are between $3,001 and $4,000 </li>
	<cfelseif session.hh_asset_total_complete gt 2000 >
		<li>You indicated that your assets are between $2,001 and $3,000</li>
	<cfelseif session.hh_asset_total_complete gt 0 >
		<li>You indicated that your assets are between $1 and $2,000 </li>
	</cfif>
<cfelse>
	<cfif session.hh_asset_total_complete gt  12000 >
		<li>You indicated that your assets are above $12,000</li>
	<cfelseif session.hh_asset_total_complete gt 11500 >
		<li>You indicated that your assets are between $11,501 and $12,000 </li>
	<cfelseif session.hh_asset_total_complete gt 10000 >
		<li>You indicated that your assets are between $10,001 and $11,500</li>
	<cfelseif session.hh_asset_total_complete gt  8000 >
		<li>You indicated that your assets are between $8,001 and $10,000 </li>
	<cfelseif session.hh_asset_total_complete gt 6000 >
		<li>You indicated that your assets are between $6,001 and $8,000 </li>
	<cfelseif session.hh_asset_total_complete gt 5000 >
		<li>You indicated that your assets are between $5,001 and $6,000</li>
	<cfelseif session.hh_asset_total_complete gt 4000 >
		<li>You indicated that your assets are between $4,001 and $5,000 </li>
	<cfelseif session.hh_asset_total_complete gt 3000>
		<li>You indicated that your assets are between $3,001 and $4,000 </li>
	<cfelseif session.hh_asset_total_complete gt 2000 >
		<li>You indicated that your assets are between $2,001 and $3,000</li>
	<cfelseif session.hh_asset_total_complete gt 0 >
		<li>You indicated that your assets are between $1 and $2,000 </li>
	</cfif>
</cfif> 
</ul>

<div class="noprint">
	<p>
		(Click <cf_sessionPassVars href="startover.cfm" partner_id="12" subset_id="14" prev_id="#session.screening_id#">here</cf_sessionPassVars> if you need to go back to 
		correct any of this information.  (Please note, if you click on this link, 
		you will go back to the first page of the questionnaire where you can review 
		your previous responses.  You will be able to make any changes you want and resubmit your questionnaire. ) 
	</p>
</div>