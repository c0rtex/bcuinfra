<cfsilent>
<cfparam name="attributes.prg_id" type="string" >

<!--- Get the rules for the program --->
<CFQUERY datasource="#application.dbSrc#" name="qryGetRules">
	SELECT elig_rule
	FROM tbl_rules
	WHERE prg_id = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="25"  value="#attributes.prg_id#">
</CFQUERY>
</cfsilent>
<p><b>Common eligibility rules:</b><br>
<li>Must be a citizen, legal resident or other qualified alien</li>
<li>Must not be receiving Medicaid</li>
<li>Must not currently have prescription drug insurance</li></p>

<cfloop query="qryGetRules">
<cfset tmp_elig_rule=Trim(elig_rule)>
<cfif Find("isDefined", tmp_elig_rule)>
	<cfsilent>
	<cfset tmp_elig_rule=Replace(tmp_elig_rule, """) OR isDefined(""session.", ",","ALL")>
	<cfset tmp_elig_rule=Replace(tmp_elig_rule, "(isDefined(""session.", "","ALL")>
	<cfset tmp_elig_rule=Replace(tmp_elig_rule, """))", '',"ALL")>
	<cfset tmp_elig_rule=Replace(tmp_elig_rule, "') OR isDefined('session.", ",","ALL")>
	<cfset tmp_elig_rule=Replace(tmp_elig_rule, "(isDefined('session.", "","ALL")>
	<cfset tmp_elig_rule=Replace(tmp_elig_rule, "'))", '',"ALL")>
	<cfquery datasource="#application.dbSrc#" name="qryGetNames">
	SELECT option_nm, field_nm
	FROM tbl_opt
	WHERE fieldtext IN (#ListQualify(tmp_elig_rule,"'")#)
	ORDER BY field_nm
	</cfquery>
	</cfsilent>
	<p>
	<cfoutput query="qryGetNames" group="field_nm">
	<b><cfif field_nm EQ "drugco">Companies<cfelse><br>Drugs</cfif> associated with this program:</b><br>
	<cfoutput>
	<li>#option_nm#</li><br>
	</cfoutput>
	</cfoutput>
	</p>
<cfelseif Find("struct_memXX", tmp_elig_rule)>
	<cfsilent>
	<cfset tmp_elig_rule=Replace(tmp_elig_rule, "(##session.hh_income_total_complete##", "Household Income","ALL")>
	<cfset tmp_elig_rule=Replace(tmp_elig_rule, "lteq", "less than","ALL")>
	<cfset tmp_elig_rule=Replace(tmp_elig_rule, "##struct_memXX[484]##)", "100% of Poverty","ALL")>
	<cfset tmp_elig_rule=Replace(tmp_elig_rule, "##struct_memXX[485]##)", "125% of Poverty","ALL")>
	<cfset tmp_elig_rule=Replace(tmp_elig_rule, "##struct_memXX[486]##)", "150% of Poverty","ALL")>
	<cfset tmp_elig_rule=Replace(tmp_elig_rule, "##struct_memXX[487]##)", "175% of Poverty","ALL")>
	<cfset tmp_elig_rule=Replace(tmp_elig_rule, "##struct_memXX[488]##)", "200% of Poverty","ALL")>
	<cfset tmp_elig_rule=Replace(tmp_elig_rule, "##struct_memXX[489]##)", "300% of Poverty","ALL")>
	<cfset tmp_elig_rule=Replace(tmp_elig_rule, "##struct_memXX[491]##)", "250% of Poverty","ALL")>
	</cfsilent>
	<p><b>Income eligibility rules for this program:</b><br>
	<cfoutput><li>#tmp_elig_rule#</li></cfoutput><br>
	</p>
<cfelse>
	<cfsilent>
	<cfset tmp_elig_rule=Replace(tmp_elig_rule, "(##session.hh_income_total_complete##", "Household Income","ALL")>
	<cfset tmp_elig_rule=Replace(tmp_elig_rule, "lteq", "less than","ALL")>
	<cfset tmp_elig_rule=Replace(tmp_elig_rule, "(##session.medicare_receive## NEQ 'Y')", "Not Receiving Medicare","ALL")>
	<cfset tmp_elig_rule=Replace(tmp_elig_rule, "(##session.veteran## EQ 'N')", "Not a Veteran")>
	<cfset tmp_elig_rule=Replace(tmp_elig_rule, ")", "","ALL")>
	</cfsilent>
	<p><b>Other eligibility rules for this program:</b><br>
	<cfoutput><li>#tmp_elig_rule#</li></cfoutput><br>
	</p>
</cfif>
</cfloop>