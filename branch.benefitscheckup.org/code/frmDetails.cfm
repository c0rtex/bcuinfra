<cfif IsDefined('SESSION.partner_id') AND (SESSION.partner_id EQ 0 or session.partner_id eq 77  )>	
	
	<cfprocessingdirective suppresswhitespace="Yes"> 
	<cfif isdefined('url.state_id')>
		<cfparam name="session.state_id" default="#url.state_id#">
	</cfif>
	<!----
	DESCRIPTION: shows description of programs, entry points, and required materials
	CALLED BY: frmEligibility.cfm
	GOES TO: N/A
	REQUIRED: prg_id  sent via the URL.
	---->
	
	<cfparam name="src" type="string" default="">
	<cfparam name="sr" type="numeric" default="1">
	<cfparam name="url.reportType" type="string" default="">
	<cfparam name="content_title_override" type="string" default="">
	<cfparam name="url.lang" default="">
	<cfparam name="form.lang" default="">
	<cfif form.lang NEQ "">
	  <cfset language_id = form.lang>
	  <cfelse>
	  <cfset language_id = 'EN'>
	</cfif>
	<cfoutput> 
	  <!--- current language_id: #language_id#<br /> ---> 
	  <!--- <form id="testLang" action="#cgi.ALL_HTTP#" method="post">
	    	<input type="radio" id="lang" name="lang" value="EN" />EN<br />
	        <input type="radio" id="lang" name="lang" value="ES" />ES<br />
	        <input type="submit" value="submit" />
	    </form> ---> 
	</cfoutput>
	<cfif Not IsDefined('session.st')>
	  <cfset session.state_id = url.stat_id>
	  <cfset session.st = session.state_id>
	</cfif>
    <cfif session.partner_id eq 77>
    	<cfset session.st = session.state_id>
    </cfif>
	<cfif Not IsDefined('session.county') and IsDefined('url.county')>
	  <cfset session.county = url.county>
	</cfif>
	<cfif Not IsDefined('session.city') and IsDefined('url.city')>
	  <cfset session.city = url.city>
	</cfif>
	<cfif Not IsDefined('session.zip') and IsDefined('url.zip')>
	  <cfset session.zip = url.zip>
	  <cfif Not IsDefined('session.sessionHasDied')>
	    <!cfset session.sessionHasDied = true>
	  </cfif>
	</cfif>
	<cfif isDefined("attributes.report")>
	  <cfset boolReport="TRUE">
	  <cfset prg_id = attributes.prg_id>
	  <cfset major_cat = attributes.major_cat>
	  <cfset intCellPad="0">
	  <cfset intFontSize="3">
	  <cfelse>
	  <cfset boolReport="FALSE">
	  <cf_tagheader show_title="yes" content_title_override="#content_title_override#" guts="frmDetails.cfm" popupwarning="1">
	  <cfset intCellPad="12">
	  <cfset intFontSize="4">
	</cfif>
	<cfif src eq 'ec'>
	  <cfset intFontSize="3">
	</cfif>
	
	<cfif boolReport>
		  <cfset passMode = 'print'>
		 <cfelse>
		  <cfset passMode = 'screen'>
		</cfif>
	
		<cfif IsDefined('caller.intPrgNum')>
		  <cfset passNumber = caller.intPrgNum>
		 <cfelse>
		  <cfset passNumber = 0>
		</cfif>
		
		<cfif IsDefined('session.county') and session.county neq '0'>
		  <cfset passCounty = session.county>
		 <cfelse>
		  <cfset passCounty = ''>
		</cfif>
		
		<cfif IsDefined('url.st')>
		  <cfset passState = url.st>
		 <cfelseif IsDefined('url.state_id')>
		  <cfset passState = url.state_id>
		 <cfelseif IsDefined('session.st')>
		  <cfset passState = session.st>
		 <cfelse>
		  <cfset passState = ''>
		</cfif>
		
		<cfif IsDefined('session.zip') and session.zip neq '0' and session.zip neq '00000'>
		  <cfset passZip = session.zip>
		 <cfelse>
		  <cfset passZip = ''>
		</cfif>
		
	<div id="frmdetails" class="row survey">
	
		<style>
			#pageTip{ top:30px !important; display: none;}
		</style>
	
			<div class="question">
				<div class="questionHolder questionBar">
					<div id="pageTip" class="helpTip">
						<h2><cf_displayText group="site" code="site_questionnaire_instructions_title"></h2>
                       	<p><cf_displayText group="site" code="site_questionnaire_instructions_body"></p>
                        <cfif IsDefined('session.partner_id') And session.partner_id eq 6>
                            <br /><br />
                            <a href="javascript:help2('neededinfo-rx.cfm')">Click here</a> 
                            to see if you need to gather any information before you begin.<br />
                        </cfif>
					</div><!-- pageTip -->
				</div><!-- questionHolder -->
			</div><!-- question -->	
			
		<cfif IsDefined('session.sessionHasDied') and session.sessionHasDied>
		  	<div class="question">
				<div class="questionHolder questionBar">
		  			<p><cf_displaytext group="site" code="site_session_dead_disclaimer"></p>
		  		</div><!-- questionHolder -->
			</div><!-- question -->	
		</cfif>
	
		<cfoutput>
			<cfif SESSION.partner_id EQ 0 or session.partner_id eq 77 >
				<div class="question">
					<div class="questionHolder questionBar">
						<cfif src eq 'eforms'>
							<cf_buttons gotext="Back to Application Guide" gourl="frmAccess.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#">
						<cfelseif src eq 'elig' and sr eq 77>
								<a href="/cf/taxRelief2.cfm?partner_id=77&taxReliefZip=#passZip#"><img src="img/backToRelief.gif" alt="Back to Tax Relief Programs" border="0" /></a>
						<cfelseif src eq 'elig' and sr eq 2  >
							<a href="/quickcheck-report/?screeningID=#url.screeningID#"><img src="img/backToResults.gif" alt="Back to Results" border="0" /></a> 
						<cfelseif src eq 'elig' >
							<a href="frmeligibility.cfm?sr=#sr#&cfid=#session.cfid#&cftoken=#session.cftoken#"><img src="img/backToResults.gif" alt="Back to Results" border="0" /></a> 
						<cfelseif src eq 'ec'>
							<img src="img/backToAFC.gif" alt="Back to Application Forms Center" border="0"onclick="javascript:history.go(-1)" />
						<cfelseif url.ReportType neq "">
							<a href="frmRecommend.cfm?ReportType=#url.ReportType#&cfid=#session.cfid#&cftoken=#session.cftoken#"><img src="img/backtorecommendations.gif" alt="Back to Recommendations" border="0" /></a>
						<cfelseif src neq 'frame'>
							<a href="frmRecommend.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#"><img src="img/backtorecommendations.gif" alt="Back to Recommendations" border="0" /></a>
						</cfif>
						<cfif SESSION.partner_id EQ 0 or session.partner_id eq 77 >
							<img  src="img/print_this_page.gif" alt="Print this Page" onclick="self.print();" border="0" /> 
						</cfif>
			 	 	</div><!-- questionHolder -->
				</div><!-- question -->	
			 </cfif>
		</cfoutput>
	
	
		<div class="question">
			<div class="questionHolder questionBar">

			<cfif IsDefined('url.county') and url.county neq '0'>
				<cfset passCounty = url.county>
			<cfelseif IsDefined('session.county') and session.county neq '0'>
				<cfset passCounty = session.county>
			<cfelse>
				<cfset passCounty = ''>
			</cfif>
	
			<cfif IsDefined('url.st')>
				<cfset passState = url.st>
			<cfelseif IsDefined('url.state_id')>
				<cfset passState = url.state_id>
			<cfelseif IsDefined('session.st')>
				<cfset passState = session.st>
			<cfelse>
				<cfset passState = ''>
			</cfif>
			<cfif IsDefined('url.zip') and url.zip neq '0' and url.zip neq '00000'>
				<cfset passZip = url.zip>
			<cfelseif IsDefined('session.zip') and session.zip neq '0' and session.zip neq '00000'>
				<cfset passZip = session.zip>
			<cfelse>
				<cfset passZip = ''>
			</cfif>

		
				<cf_displayprogramdetail language_id="#language_id#" prg_id="#prg_id#" mode="#passMode#" source="#src#" report_type="#url.reportType#" number="#passNumber#" county="#passCounty#" state_id="#passState#" zip="#passZip#" getWebResources="TRUE">
			</div><!-- questionHolder -->
		</div><!-- question -->	
				
		<cfoutput>
			<cfif SESSION.partner_id EQ 0>
				<div class="question">
					<div class="questionHolder questionBar" style="margin-left:-75px !important">
						<cfif src eq 'eforms'>
							<cf_buttons gotext="Back to Application Guide" gourl="frmAccess.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#">
						<cfelseif src eq 'elig' and sr eq 2 >
							<a href="/quickcheck-report/?screeningID=#url.screeningID#"><img src="img/backToResults.gif" alt="Back to Results" border="0" /></a> 
						<cfelseif src eq 'elig'>
							<a href="frmeligibility.cfm?sr=#sr#&cfid=#session.cfid#&cftoken=#session.cftoken#"><img src="img/backToResults.gif" alt="Back to Results" border="0" /></a> 
						<cfelseif src eq 'ec'>
							<img src="img/backToAFC.gif" alt="Back to Application Forms Center" border="0"onclick="javascript:history.go(-1)" />
						<cfelseif url.ReportType neq "">
							<a href="frmRecommend.cfm?ReportType=#url.ReportType#&cfid=#session.cfid#&cftoken=#session.cftoken#"><img src="img/backtorecommendations.gif" alt="Back to Recommendations" border="0" /></a>
						<cfelseif src neq 'frame'>
							<a href="frmRecommend.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#"><img src="img/backtorecommendations.gif" alt="Back to Recommendations" border="0" /></a>
						</cfif>
						<cfif SESSION.partner_id EQ 0>
							<img  src="img/print_this_page.gif" alt="Print this Page" onclick="self.print();" border="0" /> 
						</cfif>
			 	 	</div><!-- questionHolder -->
				</div><!-- question -->	
			 </cfif>
		</cfoutput>
		
	  <cfif src neq 'frame'>
	    <cfif IsDefined('session.partner_id') And session.partner_id eq 5>
	      <cfif IsDefined('session.randomname') And session.randomname neq ''>
	        <cfset exitURL = "http://#session.ltccservername#/index.cfm?bcupath=" & URLEncodedFormat("http://#application.serverPath#/pdf/#session.cftoken#-#session.cfid##session.randomname#.cfm")>
	        <cfelse>
	        <cfset exitURL = "http://#session.ltccservername#/index.cfm">
	      </cfif>
	      <cfelse>
	      <cfset exitURL = "frmgoodbye.cfm">

	    </cfif>
	  </cfif>
	
	</div>  
	
	<cf_tagfooter>
	</cfprocessingdirective>
<cfelse>
	<!--- PL Begins HERE --->
	<cfprocessingdirective suppresswhitespace="Yes"> 
	
	<!----
	DESCRIPTION: shows description of programs, entry points, and required materials
	CALLED BY: frmEligibility.cfm
	GOES TO: N/A
	REQUIRED: prg_id  sent via the URL.
	---->
	<cfparam name="session.partner_id" default = "0">
	<cfparam name="src" type="string" default="">
	<cfparam name="sr" type="numeric" default="1">
	<cfparam name="url.reportType" type="string" default="">
	<cfparam name="content_title_override" type="string" default="">
	<cfparam name="url.lang" default="">
	<cfparam name="form.lang" default="">
	<cfif form.lang NEQ "">
		<cfset language_id = form.lang>
		<cfelse>
		<cfset language_id = 'EN'>
	</cfif>
	<cfoutput> 
		<!--- current language_id: #language_id#<br /> ---> 
		<!--- <form id="testLang" action="#cgi.ALL_HTTP#" method="post">
	    	<input type="radio" id="lang" name="lang" value="EN" />EN<br />
	        <input type="radio" id="lang" name="lang" value="ES" />ES<br />
	        <input type="submit" value="submit" />
	    </form> ---> 
	</cfoutput>
	<cfif Not IsDefined('session.st')>
		<cfset session.state_id = url.state_id>
		<cfset session.st = session.state_id>
	</cfif>
    <cfif session.partner_id eq 76>
    	<cfset session.st = session.state_id>
    </cfif>
	<cfif Not IsDefined('session.county') and IsDefined('url.county')>
		<cfset session.county = url.county>
	</cfif>
	<cfif Not IsDefined('session.city') and IsDefined('url.city')>
		<cfset session.city = url.city>
	</cfif>
	<cfif Not IsDefined('session.zip') and IsDefined('url.zip')>
		<cfset session.zip = url.zip>
		<cfif Not IsDefined('session.sessionHasDied')>
			<!cfset session.sessionHasDied = true>
		</cfif>
	</cfif>
	<cfif isDefined("attributes.report")>
		<cfset boolReport="TRUE">
		<cfset prg_id = attributes.prg_id>
		<cfset major_cat = attributes.major_cat>
		<cfset intCellPad="0">
		<cfset intFontSize="3">
		<cfelse>
		<cfset boolReport="FALSE">
		<cf_tagheader show_title="yes" content_title_override="#content_title_override#" guts="frmDetails.cfm" popupwarning="1">
		<cfset intCellPad="12">
		<cfset intFontSize="4">
	</cfif>
	<cfif src eq 'ec'>
		<cfset intFontSize="3">
	</cfif>
	
	<div id="content">
		<cfif src eq 'taxrelief'>
			<style>
				.screeninghr
				{display: none;}
			</style>	
		</cfif>
	
		<table <cfif SESSION.partner_id EQ 80>id="fact_sheet_buttons"</cfif> border="0" cellpadding="<cfoutput>#intCellPad#</cfoutput>" cellspacing=2>
		<cfif IsDefined('session.sessionHasDied') and session.sessionHasDied>
			<tr>
				<td bgcolor="pink" colspan="2"><b>
					<cf_displaytext group="site" code="site_session_dead_disclaimer">
					</b></td>
			</tr>
		</cfif>
		<tr>
		<td bgcolor="#FFFFFF" colspan="2" class="printtd">
			<cfoutput>
				<div class="noprint">
				<table <cfif SESSION.partner_id EQ 80>id="fact_sheet_footer"</cfif> cellpadding="0" cellspacing="0" style="float:right;">
					<tr>
						<td valign="top" style="padding-right: 8px;"><cfif src eq 'eforms'>
								<cf_buttons gotext="Back to Application Guide" gourl="frmAccess.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#">
								<cfelseif src eq 'elig' or src eq 'quickcheck'>
								<cfif SESSION.partner_id EQ 80>
									<div id="results_button">
								</cfif>
								<a href="frmeligibility.cfm?sr=#sr#&cfid=#session.cfid#&cftoken=#session.cftoken#&monkey=true"><img src="img/backToResults.gif" alt="Back to Results" border="0" /></a>
								<cfif SESSION.partner_id EQ 80>
									</div>
								</cfif>
								<cfelseif src eq 'taxrelief' and (1 eq 0)>
										<!---<a href="##" id="hideFactSheet"><img src="img/backToRelief.gif" alt="Back to Tax Relief Programs" border="0" /></a>--->
								<cfelseif src eq 'ec'>
								<img src="img/backToAFC.gif" alt="Back to Application Forms Center" border="0"onclick="javascript:history.go(-1)" />
								<cfelseif url.ReportType neq "">
								<a href="frmRecommend.cfm?ReportType=#url.ReportType#&cfid=#session.cfid#&cftoken=#session.cftoken#"><img src="img/backtorecommendations.gif" alt="Back to Recommendations" border="0" /></a>
								<cfelseif src neq 'frame' AND (SESSION.partner_id NEQ 76 AND SESSION.subset_id NEQ 0)>
								<a href="frmRecommend.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#"><img src="img/backtorecommendations.gif" alt="Back to Recommendations" border="0" /></a>
							</cfif></td>
						<td valign="top"align="right"><cfif SESSION.partner_id EQ 80>
								<div id="print_button">
							</cfif>
							<cfif (src neq 'taxrelief' or session.partner_id eq 77) and session.partner_id neq 22>
								<img  src="img/print_this_page.gif" alt="Print this Page" onclick="self.print();" border="0" />
							</cfif>
							<cfif SESSION.partner_id EQ 80>
								</div>
							</cfif></td>
					</tr>
				</table>
				</div>
			</cfoutput>
		<cfif SESSION.partner_id EQ 80>
			</div>
		</cfif>
		<cfif boolReport>
			<cfset passMode = 'print'>
			<cfelse>
			<cfset passMode = 'screen'>
		</cfif>
		<cfif IsDefined('caller.intPrgNum')>
			<cfset passNumber = caller.intPrgNum>
			<cfelse>
			<cfset passNumber = 0>
		</cfif>
		<cfif IsDefined('session.county') and session.county neq '0'>
			<cfset passCounty = session.county>
			<cfelse>
			<cfset passCounty = ''>
		</cfif>
		<cfif IsDefined('url.st')>
			<cfset passState = url.st>
			<cfelseif IsDefined('url.state_id')>
			<cfset passState = url.state_id>
			<cfelseif IsDefined('session.st')>
			<cfset passState = session.st>
			<cfelse>
			<cfset passState = ''>
		</cfif>
		<cfif IsDefined('url.zip') and url.zip neq '0' and url.zip neq '00000'>
			<cfset passZip = url.zip>
		<cfelseif IsDefined('session.zip') and session.zip neq '0' and session.zip neq '00000'>
			<cfset passZip = session.zip>
		<cfelse>
			<cfset passZip = ''>
		</cfif>
		<cf_displayprogramdetail language_id="#language_id#" prg_id="#prg_id#" mode="#passMode#" source="#src#" report_type="#url.reportType#" number="#passNumber#" county="#passCounty#" state_id="#passState#" zip="#passZip#">
		
		<!--- 02/24/2002 REM  A new attribute that will be passed if this page is called as a 
		tag from the report writer--if it is, we bypass the buttons and bottom text, and output the
		HTML comment we need for the PDF generator to force a page break.  --->
		<cfif boolReport>
			</td>
			</tr>
			</table>
			<!-- NEW PAGE --> 
			<cfelse>
			<div class="noprint" style="margin-top:30px;"> <cfoutput>
					<table cellpadding="0" cellspacing="0" width="100%">
						<tr>
							<td valign="top"><cfif src eq 'eforms'>
									<cf_buttons gotext="Back to Application Guide" gourl="frmAccess.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#">
									<cfelseif src eq 'taxrelief'>
										<!---<a href="##" id="hideFactSheet"><img src="img/backToRelief.gif" alt="Back to Tax Relief Programs" border="0" /></a>--->
									<cfelseif src eq 'elig' and sr eq 2  >
										<a href="/quickcheck-report/?screeningID=#url.screeningID#"><img src="img/backToResults.gif" alt="Back to Results" border="0" /></a> 
									<cfelseif src eq 'elig'>
										<a href="frmeligibility.cfm?sr=#sr#&cfid=#session.cfid#&cftoken=#session.cftoken#"><img src="img/backToResults.gif" alt="Back to Results" border="0" /></a>
									<cfelseif src eq 'ec'>
										<img src="img/backToAFC.gif" alt="Back to Application Forms Center" border="0"onclick="javascript:history.go(-1)" />
									<cfelseif url.ReportType neq "">
									<a href="frmRecommend.cfm?ReportType=#url.ReportType#&cfid=#session.cfid#&cftoken=#session.cftoken#"><img src="img/backtorecommendations.gif" alt="Back to Recommendations" border="0" /></a>
									<cfelseif src neq 'frame'>
										<a href="frmRecommend.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#"><img src="img/backtorecommendations.gif" alt="Back to Recommendations" border="0" /></a>
								</cfif></td>
							<td valign="top"align="right"><cfif (src neq 'taxrelief' or session.partner_id eq 77) and session.partner_id neq 22><img src="img/print_this_page.gif" alt="Print this Page" onclick="self.print();" border="0" /></cfif></td>
						</tr>
					</table>
				</cfoutput> </div>
			<cfif src neq 'frame'>
				<cfif IsDefined('session.partner_id') And session.partner_id eq 5>
					<cfif IsDefined('session.randomname') And session.randomname neq ''>
						<cfset exitURL = "http://#session.ltccservername#/index.cfm?bcupath=" & URLEncodedFormat("http://#application.serverPath#/pdf/#session.cftoken#-#session.cfid##session.randomname#.cfm")>
						<cfelse>
						<cfset exitURL = "http://#session.ltccservername#/index.cfm">
					</cfif>
					<cfelse>
					<cfset exitURL = "frmgoodbye.cfm">
				</cfif>
			</cfif>
			</td>
			</tr>
			</table>
		</div>
		<cf_tagfooter>
	</cfif>
	</cfprocessingdirective>
	
</cfif>