<!----=======================================
DESCRIPTION: these are the two questions that are used for drugs and drug companies.
CALLED BY: procAsset.cfm
GOES TO: procDrugQuestions.cfm
REQUIRED:N/A
============================================---->
<cfif IsDefined('SESSION.partner_id') AND (SESSION.partner_id EQ 0 OR SESSION.partner_id EQ 77 )>
	<cfparam name="session.selectedDrugs" default="">
	<cfif session.access_id eq 1> 
		<!--- START ACCESSIBILITY IF: If user has indicated using a screen reader, redirect to text version --->
		<cflocation url="frmDrugQuestions.cfm" AddToken="Yes">
	<cfelse> 
		<!--- ELSE ACCESSIBILITY IF: Do rest of page --->
		<cfsilent>
		<cfset session.drugnumber = session.screening.qnum>
		
		<cfif IsDefined('session.partner_id') And session.partner_id eq 7>
			<cfset boxColor = "##cccc99">
			<cfset boxColorDark = "##999966">
	<cfelseif IsDefined('session.partner_id') And session.partner_id eq 86>
			<cfset boxColor = "##D0D9D6">
			<cfset boxColorDark = "##D0D9D6">
	<cfelseif IsDefined('session.partner_id') And session.partner_id eq 89>
		<cfset boxColor = "##b2d8e5">
		<cfset boxColorDark = "##b2d8e5">
	<cfelseif IsDefined('session.partner_id') And session.partner_id eq 90>
		<cfset boxColor = "##b2d8e5">
		<cfset boxColorDark = "##b2d8e5">	
		<cfelse>
			<cfset boxColor = "##d4dfdb">
			<cfset boxColorDark = "##bdcfc8">
		</cfif>
		
		<cfif session.screening.prepopulate and not session.screening.dview>
			<cfset session.screening.dview = 1>
			<!---<cfset session.selectedDrugs = ''>--->
			<cfset drugload = true>
		<cfelse>
			<cfset drugload = false>
		</cfif>
		
		</cfsilent>
	
		<cf_buildHTML expires="true" jsInclude="true" show_title="yes" guts="frmDrugList.cfm"> 
		<style>
			#pageTip{ top:0px !important;}
		</style>
			
		<div class="row survey">
		
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
		
			
				<form action="procDrugQuestions.cfm" method="post" name="formDrug" id="formDrug">
					<cfoutput>
						<input type="hidden" name="cfid" value="#session.cfid#" />
						<input type="hidden" name="cftoken" value="#session.cftoken#" />
					</cfoutput>
					
					<div class="question">
						<div class="questionHolder questionBar">
								<h2>Your Medications</h2>
						</div><!-- questionHolder -->
					</div><!-- question -->
			
					<div class="question">
						<div class="questionHolder questionBar">
							<span class="question_number"><cf_showQuestionNumber>.</span> 			
							<cfif isdefined('session.subset_id') and session.subset_id eq '22'>
								<p>If you are interested in learning about company programs that 
								can save you money on prescription drugs, you should answer this 
								question.  If you are only interested in government programs 
								or if you don&rsquo;t choose to select medications at this time, 
								just scroll down the page and click on the &quot;next&quot; button.</p>
							</cfif>
					
							<script type="text/javascript">
							jQuery(document).ready(function(){
							   
							   	$('#popupLink240').click(function() {
							   		//submit serialized form data to procDrugList
									$.post("procDrugList.cfm", $("#formDrug").serialize());
									
										setTimeout(function() {
										  		window.location.href = "frmDrugQuestions.cfm";
										}, 1000);
									// then allow procDrugList to handle redirect after post (this is how it was before)
									//window.location="procDrugList.cfm";  
								}); 
							   
							});
							</script>
					
							<p>
								For each medication you take, search through the list below left, click the name of the medication, and click the button &quot;I take this.&quot; When all your medications appear in the list below right, scroll to the very bottom of the page and click &quot;Next&quot;.<em> (If you would like to choose your medications one at a time from alphabetical lists, <a id="popupLink240" href="#">click here</a>.)</em>
							</p>	
						</div><!-- questionHolder -->
					</div><!-- question -->	
			
			
			<table id="medication_table" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td class="box_color" align="center">
						<h3>Available Medications</h3>
					</td>
					<td class="box_color_dark" align="center">
						<h3>My Medications</h3></td>
				</tr>
				<tr>
					<td class="box_color padding_bottom" valign="top">
						To find your medications, scroll through the list below.  
						<script language="JavaScript">
							<!--
							if (ie)
								document.writeln("Locate a specific medication in the list by typing its name into the box below.");
							else
								document.writeln("Click in the list box and press a letter key to jump to medications beginning with that letter.");
							// -->
						</script>
						<script language="JavaScript">
							<!--
							if (ie) {
	                            var initText = "Click here and type medication name";
								document.writeln('<div style="padding-top:5px;"><input id="typeDrugNm" type="text" name="typeDrugNm" value="' + initText + '" size="34" onFocus="if (this.value == initText) {this.value = \'\'; this.form.avlDrugNm.selectedIndex = 0}" onKeyUp="matchElement(document.formDrug.avlDrugNm, this.value); this.focus()"></div>');
							}
							// -->
						</script>
						<script type="text/javascript">
							jQuery(document).ready(function(){
							   
							   	$('#popupLink240').click(function() {
							   		//submit serialized form data to procDrugList
									$.post("procDrugList.cfm", $("#formDrug").serialize());
									
										setTimeout(function() {
										  		window.location.href = "frmDrugQuestions.cfm";
										}, 1000);
									// then allow procDrugList to handle redirect after post (this is how it was before)
									//window.location="procDrugList.cfm";  
								}); 
							   
							});
							</script>
						
					</td>
					<td class="box_color_dark" valign="top">
						If you accidentally select an incorrect medication, you can click on it 
						below and then click on the &quot;I don't take this&quot; button to remove it.  
						When all your medications appear in this list, click &quot;Next&quot; below to continue.
					</td>
				</tr>
				<tr>
					<cfoutput>
						<td class="box_color" valign="top">
							<select id="avlDrugNm" multiple name="avlDrugNm" size="10" width="250">					
							<cf_loopRxStruct grouplist="rx,generic" chop="50" object="rxobj">
								<cfif session.screening.prepopulate And StructKeyExists(session.screening.a, rxobj.code)>
									<cf_handleScreeningAnswerfield action="get" code="#rxobj.code#" element="pre" var="matchVal">
									<cfif drugload and matchVal neq ''>
										<cfset session.selectedDrugs = ListAppend(session.selectedDrugs, rxobj.code)>
									</cfif>
								</cfif>
								<option value="#rxobj.code#">#rxobj.text#</option>
							</cf_loopRxStruct>
							</select>
							<div id="drug_buttons">
								<div id="i_take_this">
									<input class="drug_button" type="button" name="avlDrugNmBtn" value="I take this" onClick="copyElements(this.form.avlDrugNm, this.form.selDrugNm, this.form.selDrugNm, this.form.selectedDrugNm); if (ie) {this.form.typeDrugNm.value = ''; this.form.typeDrugNm.focus()}">
								</div>
								<div id="not_in_list">
									<input class="drug_button" type="button" name="popup" value="Medication not in list" onClick="javascript:help2('RxNotListed.cfm')">
								</div>
							</div>
						</td>
						<td class="box_color_dark" valign="top">
							<select id="selDrugNm" multiple name="selDrugNm" size="10" width="250">
							<cf_loopRxStruct grouplist="rx,generic" chop="50" object="rxobj">
								<cfif ListFind(session.selectedDrugs, rxobj.code)>
									<option value="#rxobj.code#">#rxobj.text#</option>
								</cfif>
							</cf_loopRxStruct>
							</select>
							<div id="drug_buttons">
								<div id="i_dont_take_this">
									<input type="hidden" name="selectedDrugNm" value="">
									<input class="drug_button" type="button" name="selDrugNmBtn" value="I don't take this" onClick="removeElements(this.form.selDrugNm, this.form.selDrugNm, this.form.selectedDrugNm)">
								</div>
							</div>
						</td>
					</cfoutput>
				</tr>
			</table>
			
			<div id="surveyNav">
				<p>
					<div class="left">
                    <cfif SESSION.subset_id EQ 0 and SESSION.partner_id EQ 77>
                    	<input type="submit" value="  View Results " onClick="submitDrugs(this.form.selDrugNm, this.form.selectedDrugNm, this.form)" name="answeradditional" class="view_results" />
                    <cfelse>
						<input type="submit" value="  Next > " onClick="submitDrugs(this.form.selDrugNm, this.form.selectedDrugNm, this.form)" name="answeradditional" />
                  	</cfif>
					</div>
				</p> 
			</div>
		
			<cf_passScreeningInput aflist="d-selecteddrugnm" pagecode="drugs" setnum="#Evaluate('session.screening.qnum + 1')#">
				</form>
			</div>
	<cfif session.partner_id eq 89 OR session.partner_id eq 90>
	 <h3 style="width:840px; margin: 0 auto; padding:20px;"><strong>Your results will now be assembled. It should just take another moment or two
	before they are displayed. Thank you for using BenefitsCheckUp.</strong></h3>
	</cfif>
		</cf_buildHTML>
	</cfif> <!--- END ACCESSIBILITY IF --->
<cfelse>
	<!--- PL Begins HERE --->
	<cfif session.access_id eq 1> <!--- START ACCESSIBILITY IF: If user has indicated using a screen reader, redirect to text version --->
		<cflocation url="frmDrugQuestions.cfm" AddToken="Yes">
	<cfelse> <!--- ELSE ACCESSIBILITY IF: Do rest of page --->
	
	<cfsilent>
	<cfparam name="session.selectedDrugs" default="">
	<cfset session.drugnumber = session.screening.qnum>
	
	<cfif IsDefined('session.partner_id') And session.partner_id eq 7>
		<cfset boxColor = "##cccc99">
		<cfset boxColorDark = "##999966">
	<cfelseif IsDefined('session.partner_id') And session.partner_id eq 86>
		<cfset boxColor = "##D0D9D6">
		<cfset boxColorDark = "##D0D9D6">
	<cfelseif IsDefined('session.partner_id') And session.partner_id eq 89>
		<cfset boxColor = "##b2d8e5">
		<cfset boxColorDark = "##b2d8e5">
	<cfelseif IsDefined('session.partner_id') And session.partner_id eq 90>
		<cfset boxColor = "##b2d8e5">
		<cfset boxColorDark = "##b2d8e5">	
	<cfelse>
		<cfset boxColor = "##d4dfdb">
		<cfset boxColorDark = "##bdcfc8">
	</cfif>
	
	<cfif session.screening.prepopulate and not session.screening.dview>
		<cfset session.screening.dview = 1>
		<!---<cfset session.selectedDrugs = ''>--->
		<cfset drugload = true>
	<cfelse>
		<cfset drugload = false>
	</cfif>
	
	</cfsilent>
	
	<cf_buildHTML expires="true" jsInclude="true" show_title="yes" guts="frmDrugList.cfm"> 
	<table width="100%" border="0" align="center" cellpadding=6 cellspacing=2>
		<tr>
		<td bgcolor=#FFFFFF>
	<!--- Dynamic Area --->
	
	<cfoutput>
	<form action="procDrugQuestions.cfm" method="post" name="formDrug">
		<input type="hidden" name="cfid" value="#session.cfid#" />
		<input type="hidden" name="cftoken" value="#session.cftoken#" />
	<br>
	<table border="0" align="center" width="95%"><!--- outer --->
	<tr>
	<td>
	<font face="Arial" size="3"><b>Your Medications</b></font><br><br>
	
	<table align="center" width="100%" border="0">
	<tr>
			<TD WIDTH="35" valign="top">
				<cfif SESSION.partner_id NEQ 80>
					<FONT FACE="arial"><B>
					<cf_showQuestionNumber increment="false">.</b>
				<cfelse>
					<div class="question_number">
						<cf_showQuestionNumber increment="false">.
					</div>
				</cfif></td><TD VALIGN="top"><FONT FACE="arial"><cfif isdefined('session.subset_id') and session.subset_id eq '22'><B>If you are interested in learning about company programs that can save you money on prescription drugs, you should answer this question.  If you are only 
	interested in government programs or if you don't choose to select medications at this time, just scroll down the page and click on the "next" button.</font></B><br><br></cfif>
	<cfquery dataSource="#application.dbSrc#" name="getDrugText">
	select dl.display_text
			from display_language dl, language l
			where dl.display_id=2283
				and dl.language_id=l.language_id
				and l.default_flag=1
				and l.active=1
	</cfquery>
	<FONT face="Arial" size="3"><cfoutput>#getDrugText.display_text#</cfoutput>
	&nbsp;
	
	<i>(If you would like to choose your medications one at a time from alphabetical lists, <a id="popupLink240" href="##">click here</a>.)</i><br><br>
	</font>
	
	</cfoutput>
				<script type="text/javascript">
							jQuery(document).ready(function(){
							   
							   	$('#popupLink240').click(function() {
							   		//submit serialized form data to procDrugList
									$.post("procDrugList.cfm", $("#formDrug").serialize());
									
										setTimeout(function() {
										  		window.location.href = "frmDrugQuestions.cfm";
										}, 1000);
									// then allow procDrugList to handle redirect after post (this is how it was before)
									//window.location="procDrugList.cfm";  
								}); 
							   
							});
							</script>
	
	
		<cfif session.partner_id neq 86><table width="100%" align="left" cellpadding="0" cellspacing="0" border="0"><!--- inner --->
	    <cfelse><table width="100%" align="left" cellpadding="5px" cellspacing="0" border="0"><!--- inner ---></cfif>
		<tr><td align="center">
	
			<table id="medication_table" align="center" border="0" cellspacing="0" cellpadding="5" <cfif SESSION.partner_id EQ 89 OR SESSION.partner_id EQ 90>width="815"<cfelse>width="515"</cfif> >
				<tr>
					<td class="box_color" align="center" width="250" bgcolor="<cfoutput>#boxColor#</cfoutput>"><font face="Arial" size="3"><b>Available Medications</b></font></td>
					<td width="15" rowspan="5"><img src="images/pixel.gif" width="15" height="1" border="0" name="rxPixel" alt="" onLoad="rxInit()"></td>
					<td class="box_color_dark" align="center" width="250" bgcolor="<cfoutput>#boxColorDark#</cfoutput>"><font face="Arial" size="3"><img src="images/pixel.gif" width="1" height="7" border="0" name="rxPixel" alt="" onLoad="rxInit()"><b>My Medications</b></td>
					<cfif session.partner_id neq 86><td width="15" rowspan="5"><img src="images/pixel.gif" width="15" height="1" border="0" alt=""></td></cfif>
				</tr>
	
				<tr>
					<td class="box_color" align="center" valign="top" bgcolor="<cfoutput>#boxColor#</cfoutput>"><font face="Arial" size="2">To find your medications, scroll through the list below.  <script language="JavaScript">
	<!--
	if (navigator.userAgent.indexOf("Firefox")==-1)
		document.writeln("Locate a specific medication in the list by typing its name into the box below.");
	else
		document.writeln("Click in the list box and press a letter key to jump to medications beginning with that letter.");
	// -->
					</script></font></td>
					<td class="box_color_dark" align="center" valign="top" rowspan="2" bgcolor="<cfoutput>#boxColorDark#</cfoutput>"><font face="Arial" size="2">If you accidentally select an incorrect medication, you can click on it below and then click on the "I don't take this" button to remove it.</center></font></td>
				</tr>
				<cfif SESSION.partner_id NEQ 86>
				<tr>
					<td class="box_color" align="center" valign="bottom" bgcolor="<cfoutput>#boxColor#</cfoutput>"><script language="JavaScript">
	<!--
	if (navigator.userAgent.indexOf("Firefox")==-1) {
		var initText = "-- Click here and type medication name --";
		document.writeln('<input <cfif SESSION.partner_id EQ 80>id="typeDrugNm"</cfif> type="text" name="typeDrugNm" value="' + initText + '" size="30" style="width: 250px; font-family: Arial, Helvetica; font-size: 8pt;" onFocus="if (this.value == initText) {this.value = \'\'; this.form.avlDrugNm.selectedIndex = 0}" onKeyUp="matchElement(document.formDrug.avlDrugNm, this.value); this.focus()"><br>');
	}
	// -->
					</script></td>
				</tr>
	            <cfelse>
	            	<tr>
					<td class="box_color" align="center" valign="bottom" bgcolor="<cfoutput>#boxColor#</cfoutput>"><script language="JavaScript">
	<!--
	if (navigator.userAgent.indexOf("Firefox")==-1) {
		var initText = "-- Click here and type medication name --";
		document.writeln('<input <cfif SESSION.partner_id EQ 80>id="typeDrugNm"</cfif> type="text" name="typeDrugNm" value="' + initText + '" size="34" style="width: 250px; font-family: Arial, Helvetica; font-size: 8pt;" onFocus="if (this.value == initText) {this.value = \'\'; this.form.avlDrugNm.selectedIndex = 0}" onKeyUp="matchElement(document.formDrug.avlDrugNm, this.value); this.focus()"><br>');
	}
	// -->
					</script></td>
				</tr>
	            </cfif>
				
				<tr><cfoutput>
					<td class="box_color" align="center" bgcolor="<cfoutput>#boxColor#</cfoutput>"><script type="text/javascript">
							if (navigator.userAgent.indexOf("Firefox")!=-1){
								document.write('<select id="avlDrugNm" multiple name="avlDrugNm" size="10" width="250" style="font-family: Arial, Helvetica; font-size: 8pt; height:145px;">');
							}
							else {
								document.write('<select id="avlDrugNm" multiple name="avlDrugNm" size="10" width="250" style="font-family: Arial, Helvetica; font-size: 8pt;">');
							}
						</script>
                    <cf_loopRxStruct grouplist="rx,generic" chop="50" object="rxobj">
						<cfif session.screening.prepopulate And StructKeyExists(session.screening.a, rxobj.code)>
							<cf_handleScreeningAnswerfield action="get" code="#rxobj.code#" element="pre" var="matchVal">
							<cfif drugload and matchVal neq ''>
								<cfset session.selectedDrugs = ListAppend(session.selectedDrugs, rxobj.code)>
							</cfif>
						</cfif>
						<option value="#rxobj.code#">#rxobj.text#</option>
					</cf_loopRxStruct>
					</select><BR /><BR /></td>
					<td class="box_color_dark" align="center" valign="top" bgcolor="<cfoutput>#boxColorDark#</cfoutput>">
                    <script type="text/javascript">
							if (navigator.userAgent.indexOf("Firefox")!=-1){
								document.write('<select id="selDrugNm" multiple name="selDrugNm" size="10" width="250" style="width: 300px; font-family: Arial, Helvetica; font-size: 8pt;height:145px;">');
							}
							else {
								document.write('<select id="selDrugNm" multiple name="selDrugNm" size="10" width="250" style="width: 300px; font-family: Arial, Helvetica; font-size: 8pt;">');
							}
						</script>
                    <cf_loopRxStruct grouplist="rx,generic" chop="50" object="rxobj">
						<cfif ListFind(session.selectedDrugs, rxobj.code)>
							<option value="#rxobj.code#">#rxobj.text#</option>
						</cfif>
					</cf_loopRxStruct>
					</select></td>
				</cfoutput></tr>
				<cfif SESSION.partner_id NEQ 86>
				<tr>
					<td  class="box_color" align="center" valign="top" bgcolor="<cfoutput>#boxColor#</cfoutput>"><input type="button" name="avlDrugNmBtn" value="I take this" onClick="copyElements(this.form.avlDrugNm, this.form.selDrugNm, this.form.selDrugNm, this.form.selectedDrugNm); if (ie) {this.form.typeDrugNm.value = ''; this.form.typeDrugNm.focus()}"><br>
					<img src="images/pixel.gif" width="1" height="10" border="0" alt=""><br>
					<input type="button" name="popup" value="Medication not in list" onClick="javascript:help2('RxNotListed.cfm')"><br><br></td>
					<td  class="box_color_dark" align="center" valign="top" bgcolor="<cfoutput>#boxColorDark#</cfoutput>"><input type="hidden" name="selectedDrugNm" value="">
					<input type="button" name="selDrugNmBtn" value="I don't take this" onClick="removeElements(this.form.selDrugNm, this.form.selDrugNm, this.form.selectedDrugNm)"><BR /><BR /></td>
				</tr>
				<cfelse>
				<tr>
					<td colspan="3">
							
						<div id="drug_buttons">
							<div id="i_take_this">
								<input type="button" name="avlDrugNmBtn" value="I take this" onClick="copyElements(this.form.avlDrugNm, this.form.selDrugNm, this.form.selDrugNm, this.form.selectedDrugNm); if (ie) {this.form.typeDrugNm.value = ''; this.form.typeDrugNm.focus()}">
							</div>
							<div id="i_dont_take_this">
								<input type="hidden" name="selectedDrugNm" value="">
								<input type="button" name="selDrugNmBtn" value="I don't take this" onClick="removeElements(this.form.selDrugNm, this.form.selDrugNm, this.form.selectedDrugNm)">
							</div>
							<div id="not_in_list">
								<input type="button" name="popup" value="Medication not in list" onClick="javascript:help2('RxNotListed.cfm')">
							</div>
						</div>	
			
					</td>
				</tr>
				</cfif>
			</table>
	
	
	</td></tr></table>
	<br><br>
	
			<!--- depending on income and assets responses from previous page, set output --->
			</td></TR>
			<TR><TD colspan="2" align="right">
			<br><font size="4" face="Arial">
	
			<b><input type="button" name="answeradditional" value="Next" onClick="submitDrugs(this.form.selDrugNm, this.form.selectedDrugNm, this.form)"></b>
	
	      </font>
		  </td></tr>
	<a name="blah"></a>
		</table>	
	</td></tr>	
	</table>
	<cf_passScreeningInput aflist="d-selecteddrugnm" pagecode="drugs" setnum="#Evaluate('session.screening.qnum + 1')#">
	</form>
	
	</TD></TR>
	</TABLE>
	
	<cfif session.partner_id eq 89 OR session.partner_id eq 90>
	 <h3 style="width:840px; margin: 0 auto; padding:20px;"><strong>Your results will now be assembled. It should just take another moment or two
	before they are displayed. Thank you for using BenefitsCheckUp.</strong></h3>
	</cfif>
	
	</cf_buildHTML>
	</cfif> <!--- END ACCESSIBILITY IF --->		
</cfif>