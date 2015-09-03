<cfcomponent>
  <cffunction name="getTaxReliefValues" access="remote" output="true" returnType="string" returnformat="plain">
    <cfargument name="taxReliefZip" required="true" default="10001" />
	<cfif IsNumeric(arguments.taxReliefZip)>
		<cfquery name="getTaxProgramsNoRulesApplied" dataSource="#APPLICATION.dbSrc#">
	    		SELECT DISTINCT p.program_id, p.program_code, p.legacy_prg_id, 
	    		dl.display_text, z.state_id, c.county_name
				FROM program p
				INNER JOIN display_language dl ON dl.display_id = p.name_display_id
				INNER JOIN zip z ON z.state_id = p.state_id
		        INNER JOIN county c ON c.county_id = z.county_id
		        INNER JOIN city_zip cz ON cz.zipcode = z.zipcode
		        INNER JOIN city ci ON ci.city_id = cz.city_id
				WHERE p.programcategory_id = 5
				AND p.active_flag = 1
				AND z.zipcode = <cfqueryparam value="#taxReliefZip#" CFSQLType="CF_SQL_VARCHAR">
				AND dl.display_text != ''
				ORDER BY dl.display_text ASC
	    	</cfquery>
	    	
	    	<cfset SESSION.state_id = getTaxProgramsNoRulesApplied.state_id>
	    	<cfset SESSION.county = getTaxProgramsNoRulesApplied.county_name>
	    	<cfset SESSION.zip = taxReliefZip>
	    	
	    	<cfset prgList = ''>
		<cfset showMoreOutput = "false">

		<cfquery name="getTaxProgramsNoRulesApplied" datasource="#APPLICATION.dbSrc#">

			SELECT DISTINCT p.program_id, p.program_code, p.legacy_prg_id, 
	    		dl.display_text, z.state_id, c.county_name
				FROM program p
				INNER JOIN display_language dl ON dl.display_id = p.name_display_id
				INNER JOIN zip z ON z.state_id = p.state_id
		        INNER JOIN county c ON c.county_id = z.county_id
		        INNER JOIN city_zip cz ON cz.zipcode = z.zipcode
		        INNER JOIN city ci ON ci.city_id = cz.city_id
				WHERE p.programcategory_id = 5
				AND p.active_flag = 1
				AND z.zipcode = #session.zip#
				AND dl.display_text != ''
				ORDER BY dl.display_text ASC


		</cfquery>
		<cfset prgList = ValueList(getTaxProgramsNoRulesApplied.program_id)>
		<cfif showMoreOutput><cfoutput>prgList: #prgList#</cfoutput><cfdump var="#getTaxProgramsNoRulesApplied#"></cfif>

		<!--- Loop through and display results for each program --->
		<cfloop query="getTaxProgramsNoRulesApplied" >

		<cfquery dataSource="#APPLICATION.dbSrc#" name="applyRules">
		SELECT r.rule_text, p.program_id
		FROM program p
		INNER JOIN program_rule pr ON pr.program_id = p.program_id
		LEFT OUTER JOIN rule r ON r.rule_id = pr.rule_id
		WHERE p.program_id = #getTaxProgramsNoRulesApplied.program_id#
		AND r.legacy_pri_sec IS NULL
		</cfquery>
		<cfif showMoreOutput><cfoutput>zip: #session.zip#</cfoutput>

		<cfdump var="#applyRules#">
		</cfif>

		<cfloop query="applyRules">
		<cfset strRule = applyRules.rule_text >
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
				  <!--- 03/09/2002 REM  Need to strip the opening '(' --->
				  <!--- 10/25/2005 BShunn  Also strip apostrophes --->
				  <cfif Find("('", strItem) eq 1>
					  <cfset strItem = Mid(strItem, 3, Len(strItem) - 3)>
					<cfelse>
					 <cfset strItem = Mid(strItem, 2, Len(strItem) - 1)>
				</cfif>
				<cfif showMoreOutput><cfoutput> (#strItem#)</cfoutput></cfif>
				  <!--- 03/09/2002 REM  Need to do this to extract the compare list --->
				  <cfset strList = Trim(Right(strRule, Len(strRule) - (posFind + posLen - 1)))>
				  <cfif showMoreOutput><cfoutput> (#strList#)</cfoutput></cfif>
				  <!--- 03/09/2002 REM  Need to strip the closing ')' --->
				  <cfset strList = Mid(strList, 2, Len(strList) - 3)>
				  <cfif showMoreOutput><cfoutput> (#strList#)</cfoutput></cfif>
				  <cfloop index="element" from="1" to="#ListLen(strList)#">
					<cfset strList = ListSetAt(strList, element, Trim(ListGetAt(strList, element)))>
				  </cfloop>
				  <cfif showMoreOutput><cfoutput>The ITEM: #strItem# <br>The LIST: <br> (#strList#)</cfoutput></cfif>
				  <cfset temp = #ListFindNoCase(strList, #evaluate(strItem)#)#>
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
					<cfif showMoreOutput><cfoutput>#evaluate(strItem)# is in list: #answer# for program #getTaxProgramsNoRulesApplied.program_id#</cfoutput></cfif>
					<cfif answer eq 'no'>
						<cfset prgValue = #listFind(prgList, getTaxProgramsNoRulesApplied.program_id)#>

						<cfset prgList = #listdeleteat(prgList,prgValue)#>
					</cfif>
				</cfif>


			

			</cfloop>

			</cfloop>
		<cfif showMoreOutput><cfoutput><br>Final List: #prgList#</cfoutput></cfif>
		<cfif prgList eq ""><cfset prgList = 0><cfset html =""></cfif>
	    	
	    	<!--- Re-run query with rules applied --->
	    	<cfquery name="getTaxPrograms" dataSource="#APPLICATION.dbSrc#">
	    		SELECT DISTINCT p.program_code, p.legacy_prg_id, 
	    		dl.display_text, z.state_id, c.county_name
				FROM program p
				INNER JOIN display_language dl ON dl.display_id = p.name_display_id
				INNER JOIN zip z ON z.state_id = p.state_id
		        INNER JOIN county c ON c.county_id = z.county_id
		        INNER JOIN city_zip cz ON cz.zipcode = z.zipcode
		        INNER JOIN city ci ON ci.city_id = cz.city_id
				WHERE p.programcategory_id = 5
				AND p.active_flag = 1
				AND z.zipcode = <cfqueryparam value="#taxReliefZip#" CFSQLType="CF_SQL_VARCHAR">
				AND dl.display_text != ''
				AND p.program_id IN (#prgList#) and p.program_id not in (1750,1761,1428,1350,1777,63,1019)
				ORDER BY dl.display_text ASC
	    	</cfquery>
	    	
	    	<cfswitch expression="#getTaxPrograms.state_id#">
	    		<cfcase value="AL">
	    			<cfset stateName = 'Alabama'>
	    		</cfcase>
				<cfcase value="AK">
					<cfset stateName = 'Alaska'>
	    		</cfcase>
				<cfcase value="AZ">
					<cfset stateName = 'Arizona'>
	    		</cfcase>
				<cfcase value="AR">
					<cfset stateName = 'Arkansas'>
	    		</cfcase>
				<cfcase value="CA">
					<cfset stateName = 'California'>
	    		</cfcase>
				<cfcase value="CO">
					<cfset stateName = 'Colorado'>
	    		</cfcase>
				<cfcase value="CT">
					<cfset stateName = 'Connecticut'>
	    		</cfcase>
				<cfcase value="DE">
					<cfset stateName = 'Delaware'>
	    		</cfcase>
				<cfcase value="DC">
					<cfset stateName = 'District of Columbia'>
	    		</cfcase>
				<cfcase value="FL">
					<cfset stateName = 'Florida'>
	    		</cfcase>
				<cfcase value="GA">
					<cfset stateName = 'Georgia'>
	    		</cfcase>
				<cfcase value="HI">
					<cfset stateName = 'Hawaii'>
	    		</cfcase>
				<cfcase value="ID">
					<cfset stateName = 'Idaho'>
	    		</cfcase>
				<cfcase value="IL">
					<cfset stateName = 'Illinois'>
	    		</cfcase>
				<cfcase value="IN">
					<cfset stateName = 'Indiana'>
	    		</cfcase>
				<cfcase value="IA">
					<cfset stateName = 'Iowa'>
	    		</cfcase>
				<cfcase value="KS">
					<cfset stateName = 'Kansas'>
	    		</cfcase>
				<cfcase value="KY">
					<cfset stateName = 'Kentucky'>
	    		</cfcase>
				<cfcase value="LA">
					<cfset stateName = 'Louisiana'>
	    		</cfcase>
				<cfcase value="ME">
					<cfset stateName = 'Maine'>
	    		</cfcase>
				<cfcase value="MD">
					<cfset stateName = 'Maryland'>
	    		</cfcase>
				<cfcase value="MA">
					<cfset stateName = 'Massachusetts'>
	    		</cfcase>
				<cfcase value="MI">
					<cfset stateName = 'Michigan'>
	    		</cfcase>
				<cfcase value="MN">
					<cfset stateName = 'Minnesota'>
	    		</cfcase>
				<cfcase value="MS">
					<cfset stateName = 'Mississippi'>
	    		</cfcase>
				<cfcase value="MO">
					<cfset stateName = 'Missouri'>
	    		</cfcase>
				<cfcase value="MT">
					<cfset stateName = 'Montana'>
	    		</cfcase>
				<cfcase value="NE">
					<cfset stateName = 'Nebraska'>
	    		</cfcase>
				<cfcase value="NV">
					<cfset stateName = 'Nevada'>
	    		</cfcase>
				<cfcase value="NH">
					<cfset stateName = 'New Hampshire'>
	    		</cfcase>
				<cfcase value="NJ">
					<cfset stateName = 'New Jersey'>
	    		</cfcase>
				<cfcase value="NM">
					<cfset stateName = 'New Mexico'>
	    		</cfcase>
				<cfcase value="NY">
					<cfset stateName = 'New York'>
	    		</cfcase>
				<cfcase value="NC">
					<cfset stateName = 'North Carolina'>
	    		</cfcase>
				<cfcase value="ND">
					<cfset stateName = 'North Dakota'>
	    		</cfcase>
				<cfcase value="OH">
					<cfset stateName = 'Ohio'>
	    		</cfcase>
				<cfcase value="OK">
					<cfset stateName = 'Oklahoma'>
	    		</cfcase>
				<cfcase value="OR">
					<cfset stateName = 'Oregon'>
	    		</cfcase>
				<cfcase value="PA">
					<cfset stateName = 'Pennsylvania'>
	    		</cfcase>
				<cfcase value="RI">
					<cfset stateName = 'Rhode Island'>
	    		</cfcase>
				<cfcase value="SC">
					<cfset stateName = 'South Carolina'>
	    		</cfcase>
				<cfcase value="SD">
					<cfset stateName = 'South Dakota'>
	    		</cfcase>
				<cfcase value="TN">
					<cfset stateName = 'Tennessee'>
	    		</cfcase>
				<cfcase value="TX">
					<cfset stateName = 'Texas'>
	    		</cfcase>
				<cfcase value="UT">
					<cfset stateName = 'Utah'>
	    		</cfcase>
				<cfcase value="VT">
					<cfset stateName = 'Vermont'>
	    		</cfcase>
				<cfcase value="VA">
					<cfset stateName = 'Virginia'>
	    		</cfcase>
				<cfcase value="WA">
					<cfset stateName = 'Washington'>
	    		</cfcase>
				<cfcase value="WV">
					<cfset stateName = 'West Virginia'>
	    		</cfcase>
				<cfcase value="WI">
					<cfset stateName = 'Wisconsin'>
	    		</cfcase>
				<cfcase value="WY">
					<cfset stateName = 'Wyoming'>
	    		</cfcase>
	    	</cfswitch>
	    
	    	<cfif getTaxPrograms.recordcount>
			    <cfsavecontent variable="html">
			    	<script type="text/javascript">
						jQuery(document).ready(function(){

							$('a.getFactSheet').click(function() {
								$('##taxReliefMap').hide();
								$('##taxReliefState').hide();
			    				$('##wantToFind').hide();
			    				$('##taxRelief_h1').hide();
			    				$('##taxRelief_p').hide();
			    				$('##taxReliefContainer').hide();
			    				$('##taxRelief_p_state').hide();
			    				$('##showOfficeButtons').hide();
			    				$('##showButtons').fadeIn('slow');
						  		$('##loadFactSheet').fadeIn('fast');
						  		$('##loadFactSheet').html('<h1 style="margin-top:50px;">Loading Fact Sheet...</h1>');
						  		$('##showFactSheet').attr('href',$(this).attr('href'));
						  		$('##loadFactSheet').load($(this).attr('href'), function() {
						  			//after loading fact sheet is complete, run the following code:
									$('.offices_link').removeAttr('onclick');
									var office_url = $('.offices_link').attr('href');
									office_url = office_url + ' ##content';
									$('.offices_link').attr('href', office_url);
									
									$('a.offices_link').click(function() {
										$('##taxReliefMap').hide();
										$('##taxReliefState').hide();
										$('##wantToFind').hide();
										$('##taxRelief_h1').hide();
										$('##taxRelief_p').hide();
										$('##taxReliefContainer').hide();
										$('##taxRelief_p_state').hide();
										$('##showButtons').hide();
										$('##showOfficeButtons').fadeIn('slow');
								  		$('##loadFactSheet').fadeIn('fast');
								  		$('##loadFactSheet').html('<h1 style="margin-top:50px;">Loading Offices...</h1>');
								  		//load offices
								  		$("##loadFactSheet").load($(this).attr('href'), function() {
								  			$('##content').css({'margin':'50px 25px','font-family':'Arial,Helvetica,sans-serif'});
								  			$('.screeningh2').show();
								  		});	
								  		return false;
									});	
									
								});//end ##loadFactSheet
						  			
						  		return false;
							});		
							
							$('a##hideFactSheet').click(function() {
								$('##showButtons').hide();
								$('##showOfficeButtons').hide();
								$('##taxReliefMap').hide();
								$('##taxReliefState').show();
			    				$('##wantToFind').show();
			    				$('##taxRelief_h1').show();
			    				$('##taxRelief_p').hide();
			    				$('##taxRelief_p_state').show();
			    				$('##taxReliefContainer').show();
						  		$('##loadFactSheet').hide();	
						  		return false;
							});
						});
					</script>
			    
			    	<div id="stateMap">
						<h3 align="center" style="font-size:18px;">#stateName#</h3>
						<!--- Remove spaces from stateName --->
						<cfset stateImage = ReReplace(stateName, "[[:space:]]","","ALL")>
						<img id="stateImage" src="images/usstates/#lcase(stateImage)#.png" alt="#stateName#" title="#stateName#">
					</div>
					
					<div id="statePrograms">
						<h3>Tax Relief Programs for Zip: #taxReliefZip#</h3>
						<ul id="taxRelief_ul">
							
							<cfloop query="getTaxPrograms">
								<cfif session.partner_id neq 77>
								<li><a class="getFactSheet" href="frmDetails.cfm?partner_id=#SESSION.partner_id#&taxreliefprogram=true&state_id=#getTaxPrograms.state_id#&prg_id=#getTaxPrograms.legacy_prg_id#&src=taxrelief&sr=0&zip=#taxReliefZip# ##content">#getTaxPrograms.display_text#</a></li>
								<cfelse>
								<li><a  href="frmDetails.cfm?partner_id=#SESSION.partner_id#&state_id=#getTaxPrograms.state_id#&prg_id=#getTaxPrograms.legacy_prg_id#&src=elig&sr=77&zip=#taxReliefZip#">#getTaxPrograms.display_text#</a></li>
								</cfif>
							</cfloop>		
						</ul>
					</div>
			    </cfsavecontent> 
			<cfelse>
				<div id="stateMap">
					<!---h3>Invalid Zip Code: #arguments.taxReliefZip#</h3--->
					<p style="color:red">You have entered an invalid zip code: <strong>#taxReliefZip#</strong>.
					Please enter a five digit, numeric zip code.
					</p>
				</div>
				
				<div id="statePrograms">
					<h3>No Programs Found</h3>
				</div>
			</cfif>   	
    	<cfelse>
    		<cfsavecontent variable="html">
    			<div id="stateMap">
					<!---h3>Invalid Zip Code: #taxReliefZip#</h3--->
					<p style="color:red">You have entered an invalid zip code: <strong>#taxReliefZip#</strong>.
					Please enter a five digit, numeric zip code.
					</p>
				</div>
				
				<div id="statePrograms">
					<h3>No Programs Found</h3>
				</div>
    		</cfsavecontent>
    	</cfif>

	<cfreturn html />
  </cffunction>
</cfcomponent>