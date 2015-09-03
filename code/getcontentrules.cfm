<cfparam name="showOutput" default="false">
<cfparam name="attributes.debugOutput" default="false">
<cfset tmp_screening_id = session.screening_id >
<!-- get content rules and wp post codes -->
			<cfquery name="rule_content" datasource="#application.dbSrc#">
				SELECT
				rule.rule_id,
				rule_content.post_id,
				rule_content.post_code,
				rule.code,
				rule.rule_text
				FROM
				rule
				INNER JOIN rule_content ON rule.code = rule_content.post_code
				WHERE rule.code like '%mqc_report%'
				<cfif session.subset_id eq 75>
				and rule.code not like 'mqc_report_searchplans' and rule.code not like 'mqc_report_refer_bcu' and rule.code not like 'mqc_report_benefitsadvisor_summary'
				and rule.code not like 'mqc_report_vetben' and rule.code not like 'mqc_report_esrd' and rule.code not like 'mqc_report_tricare' and rule.code not like 'mqc_report_railroad'
				and rule.code not like 'mqc_report_nursing_home' and rule.code not like 'mqc_report_cobra' and rule.code not like 'mqc_report_als'
				and rule.code not like 'mqc_report_gov_retiree'
				</cfif>
			</cfquery>
<cfloop query="rule_content">       
<cfif attributes.debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Starting cacheRulePool code="#rule_content.code#" <br /><br /></cfoutput></cfif>

			<cf_cacheRulePool action="get" code="#rule_content.code#" var="testRule">
			<cfset strRule = Replace(testRule.text, "gteq", "gte", "ALL")>
			<cfset strRule = Replace(strRule, "lteq", "lte", "ALL")>
			<!-- any rule that calls upon an income table will replace the end bracket
			with the reference to the associated column of the income array for the 
			number of people in the household --->
			
				<cfif showOutput><cfoutput><h2>#strRule#</h2></cfoutput></cfif>
				<cfset findPos = 1>
				<cfloop condition="Find('##', strRule, findPos)">
					<cfset firstPound = Find('##', strRule, findPos)>
					<cfset secondPound = Find('##', strRule, firstPound + 1)>
					<cfif secondPound gt firstPound>
						<cfset variableName = Mid(strRule, firstPound + 1, secondPound - firstPound - 1)>
						<cfif showOutput><cfoutput><li>#variableName#: </cfoutput></cfif>
						<cfif FindNoCase('struct_mem[', variableName) eq 1 Or FindNoCase('listable[', variableName) eq 1 Or FindNoCase('childtable[', variableName) eq 1 Or IsDefined(variableName)>
							<cfset eVal = Evaluate(variableName)>
						<cfelseif FindNoCase('session.', variableName) eq 1>
							<cfset newVariableName = RemoveChars(variableName, 1, 8)>
							<cf_handleScreeningAnswerfield action="get" code="#newVariableName#" element="val" var="eVal">
						<cfelse>
							<cfset eVal = 0>
						</cfif>
						<cfif eVal eq ''>
							<cfset eVal = 0>
						</cfif>
						<cfif Not IsNumeric(eVal) Or (IsNumeric(eVal) And Len(eVal) gt 1 And Left(eVal, 1) eq '0')>
							<cfset eVal = "'#eVal#'">
						</cfif>
						<cfif showOutput><cfoutput>#eVal#</cfoutput></cfif>
						<cfset strRule = Replace(strRule, "###variableName###", eVal, 'ONE')>
					<cfelse>
						<cfset findPos = firstPound + 1>
					</cfif>
				</cfloop>
				<cfif showOutput><cfoutput><br><br>#strRule#</cfoutput></cfif>
			   <!--- Need an additional proc for the 'NOT IN' rules --->
				<cfset posIn = FindNoCase(' in ', strRule, 1)>
				<cfset posNotIn = FindNoCase(' not in ', strRule, 1)>
				<cfif posNotIn>
					<cfset posFind = posNotIn>
					<cfset posLen = 8>
				<cfelseif posIn>
					<cfset posFind = posIn>
					<cfset posLen = 4>
				<cfelse>
					<cfset posFind = 0>
				</cfif>
			   <cfif posFind>
				  <cfset strItem = Trim(Left(strRule, posFind - 1))>
				  <cfif showMoreOutput><cfoutput> (#strItem#)</cfoutput></cfif>
				  <!-- Need to strip the opening '(' -->
				  <!-- Also strip apostrophes -->
				  <cfif Find("('", strItem) eq 1>
					  <cfset strItem = Mid(strItem, 3, Len(strItem) - 3)>
					<cfelse>
					 <cfset strItem = Mid(strItem, 2, Len(strItem) - 1)>
				</cfif>
				<cfif showMoreOutput><cfoutput> (#strItem#)</cfoutput></cfif>
				  <!--Need to do this to extract the compare list -->
				  <cfset strList = Trim(Right(strRule, Len(strRule) - (posFind + posLen - 1)))>
				  <cfif showMoreOutput><cfoutput> (#strList#)</cfoutput></cfif>
				  <!-- Need to strip the closing ')' -->
				  <cfset strList = Mid(strList, 2, Len(strList) - 3)>
				  <cfif showMoreOutput><cfoutput> (#strList#)</cfoutput></cfif>
				  <cfloop index="element" from="1" to="#ListLen(strList)#">
					<cfset strList = ListSetAt(strList, element, Trim(ListGetAt(strList, element)))>
				  </cfloop>
				  <cfif showMoreOutput><cfoutput> (#strList#)</cfoutput></cfif>
				  <cfset temp = ListFindNoCase(strList, strItem)>
				  <cfif temp eq 0>
					<cfif posNotIn>
						<cfset answer="YES">
					 <cfelse>
						<cfset answer="NO">
					 </cfif>
				  <cfelse>
					<cfif posNotIn>
						<cfset answer="NO">
					 <cfelse>
						<cfset answer="YES">
					 </cfif>
				  </cfif>
			   <cfelse>
				  
				  <cftry>
				  	<cfset answer=Evaluate("#strRule#")>
				  <cfcatch type="any">
				  	<cfset answer="YES">
				  </cfcatch>
				  </cftry>
				  
			   </cfif>
			   <cfif showOutput><cfoutput> = #answer#<br></cfoutput></cfif>	
            <cfquery name="wp_posts" datasource="wp_benefitscheckup">           
            	select id from wp_posts where id = #rule_content.post_id#
            </cfquery>
	    <cfif answer eq 'yes'>	
	    <cfquery name="content_insert" datasource="#application.dbSrc#">           
            	insert into screening_content
		(screening_id, post_id,content_code)
		values
		(#tmp_screening_id#,#rule_content.post_id#,'#rule_content.post_code#')
            </cfquery>
	   </cfif>
</cfloop>


