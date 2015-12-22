
	
	<cfprocessingdirective suppresswhitespace="Yes"> 

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
		
		
		
	<div id="frmdetails" class="row survey">
	
		<style>
			#pageTip{ top:30px !important; display: none;}
		</style>
	
			<div class="question">
				<div class="questionHolder questionBar">
					<div id="pageTip" class="helpTip">
						<h2><cf_displayText group="site" code="site_questionnaire_instructions_title"></h2>
                       	<p><cf_displayText group="site" code="site_questionnaire_instructions_body"></p>
                      
					</div><!-- pageTip -->
				</div><!-- questionHolder -->
			</div><!-- question -->	
			
		
	
		<cfoutput>
			
				<div class="question">
					<div class="questionHolder questionBar">
						
							<a href="/quickcheck-report/?screeningID=#url.screeningID#"><img src="img/backToResults.gif" alt="Back to Results" border="0" /></a> 
						
							<img  src="img/print_this_page.gif" alt="Print this Page" onclick="self.print();" border="0" /> 
						
			 	 	</div><!-- questionHolder -->
				</div><!-- question -->	
	
		</cfoutput>
	
	
		<div class="question">
			<div class="questionHolder questionBar">

			<cfif IsDefined('url.county') and url.county neq '0'>
				<cfset passCounty = url.county>
			<cfelse>
				<cfset passCounty = ''>
			</cfif>
	
			<cfif IsDefined('url.st')>
				<cfset passState = url.st>
			<cfelseif IsDefined('url.state_id')>
				<cfset passState = url.state_id>
			<cfelse>
				<cfset passState = ''>
			</cfif>
			<cfif IsDefined('url.zip') and url.zip neq '0' and url.zip neq '00000'>
				<cfset passZip = url.zip>
			<cfelse>
				<cfset passZip = ''>
			</cfif>

			<cfoutput>displayprogramdetail language_id="#language_id#" prg_id="#prg_id#" mode="#passMode#" source="#src#" report_type="#url.reportType#" number="#passNumber#" county="#passCounty#" state_id="#passState#" zip="#passZip#" getWebResources="TRUE"</cfoutput>
				<cf_displayprogramdetail language_id="#language_id#" prg_id="#prg_id#" mode="#passMode#" source="#src#" report_type="#url.reportType#" number="#passNumber#" county="#passCounty#" state_id="#passState#" zip="#passZip#" getWebResources="TRUE">
			</div><!-- questionHolder -->
		</div><!-- question -->	
				
		<cfoutput>
				<div class="question">
					<div class="questionHolder questionBar" style="margin-left:-75px !important">
						
							<a href="/quickcheck-report/?screeningID=#url.screeningID#"><img src="img/backToResults.gif" alt="Back to Results" border="0" /></a> 
						
							<img  src="img/print_this_page.gif" alt="Print this Page" onclick="self.print();" border="0" /> 
						
			 	 	</div><!-- questionHolder -->
				</div><!-- question -->	
			
		</cfoutput>
	</div>  
	<cf_tagfooter>
	</cfprocessingdirective>
