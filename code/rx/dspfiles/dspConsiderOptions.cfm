<!--- Display What to do Next Section--->
<h3>3. What to do Next</h3>
<cfset listActions = #arraytolist(arrayActions)#>
<cfset count = 1>
	<ul>
	<cfloop list="#listActions#" index="action" >
	<!-- Output action items other than state programs  -->
	<cfquery name="qryActions" datasource="#session.datasrc#">
		SELECT      pt.actions
		FROM        programtext pt
		WHERE     programtext_id = (#arrayActions[count]#)
	</cfquery>
		<cfset Actions = qryActions.actions>
		<cfoutput query="qryActions"><cfif #len(actions)# gt 5><li>#actions#</li></cfif></cfoutput>
		<cfset count =  count + 1>
	</cfloop>
<cfif isdefined('request.ApplyNow') and request.ApplyNow eq "Y">
<li>To apply for Extra Help available through Medicare's Prescription Drug Coverage:
<br><br>
<table><tr><td width="140" valign=top>
<cf_displayLISPopup>
</td><td  valign=top>
<font size=+1>Apply for extra help available through Medicare's Prescription Drug Coverage</font><br>
<em>(Clicking the button to the left will open a new window.)</em>
</td>
</tr>
</table>

<table><tr><td width="140" valign=top>
<a href="ssalisworksheet.pdf" target="new"><img alt="View Worksheet" src="images/button_work_sheet.gif" border=0></a>
</td><td  valign=top><font size=+1>Click here to get a Worksheet (Fill it out by hand and use it as a 
guide to help you apply for the Extra Help)</font><br>
<em>(Clicking the button to the left will open a new window.)</em>
</td>
</tr>
</table>
	<cfset prg_id = "103-311-2593-FD-FD">
	<cfinclude template="../dspLinks.cfm">
</li><br/>
</cfif>
<cfif isdefined('request.MSPApply') and request.MSPApply eq "Y">
<li>To apply for the Medicare Savings Program, which can help you pay for Medicare Part B premiums:<br><br>
	<cfset prg_id = request.MedicareSavingsPrg_ID>
	<cfset applyNow = Request.ApplyNow >
	<cfinclude template="../dspLinks.cfm">
</li><br/>
</cfif>
	<cfif isdefined('request.stprg')>
		<cfset prg_id = request.stprg >
	</cfif>
	<cfif isdefined('request.sttype')>
		<cfset type = request.sttype >
		<cfset benefit = request.stbenefit >
	<!-- Output action items other than state programs  -->
	<cfquery name="qryActions2" datasource="#session.datasrc#">
		SELECT      pt.actions
		FROM          tbl_prg_all p, programtext pt
		WHERE     p.recid = pt.program_id 
						and p.prg_id = <cfqueryparam 
                        value="#prg_id#" 
                        cfsqltype="CF_SQL_VARCHAR" 
                        maxlength="25"> 
						and pt.type=<cfqueryparam 
                        value="#type#" 
                        cfsqltype="CF_SQL_VARCHAR" 
                        maxlength="25"> 
						and pt.benefit=<cfqueryparam 
                        value="#benefit#" 
                        cfsqltype="cf_sql_integer"
                        maxlength="2">
	</cfquery>
	<cfloop query="qryActions2">
		<cfset Actions = qryActions2.actions>
		<cfoutput query="qryActions2"><cfif #len(actions)# gt 5><li>#actions#</li></cfif></cfoutput>
		<br><br>
		<cfif type eq 'eligible'><cfinclude template="../dspLinks.cfm"></cfif>
	</cfloop>
	</cfif>
<cfif request.compare eq "Y">
<li>Compare Medicare Prescription Drug Plans that are available in your area. We recommend that you read Things to Think About When You Compare Plans and complete the Medicare Prescription Drug Coverage Personal Information Worksheet before you start comparing plans. If you would like one-on-one assistance to get help comparing and selecting a plan, contact your local <a href="http://www.accesstobenefits.org/About%20Us/State%20and%20Local%20Coalitions/" title="Access to Benefits Coalition" target="_blank">Access to Benefits Coalition</a> or <a href="http://www.medicare.gov/Contacts/staticpages/ships.aspx" title="State Health Insurance Program (SHIP)" target="_blank">State Health Insurance Program (SHIP)</a>:
<cfif session.st eq 'AL' or session.st eq 'LA' or session.st eq 'MS' ><br><br>If you were affected by the hurricanes of 2005 and are living in certain zip codes, you have a Special Enrollment Period (SEP) and can enroll in a Medicare Prescription Drug Plan now. Click <a href="forms/Evacuee_SEP_ZipList.pdf" target=_blank>here</a> to see the list of zip codes the hurricane recovery SEP applies to.</cfif>
</li>
<br>
<!--- <br>
<table><tr><td width="140" valign=top>
<a href="planfactsheet.pdf" target="_blank" ><img alt="View Factsheet" src="images/button_fact_sheet.gif" border=0></a>
</td><td  valign=top>
<font size=+1>Click here to get a Fact Sheet from Center for Medicare and Medicaid Services (CMS) </font>
</td>
</tr>
</table>	 --->
<br>
<table><tr><td width="140" valign=top>
<a href="Things_to_Think_about_when_You_Compare_Plans.pdf" target="_blank" ><img alt="View Fact Sheet" src="images/button_fact-sheet.gif" border=0></a>
</td><td  valign=top>
<font size=+1>Click here to get a Fact Sheet of Things to Think About When You Compare Plans</font><br>
<em>(Clicking the button to the left will open a new window.)</em>
</td>
</tr>
</table>	
<br>
<table><tr><td width="140" valign=top>
<a href="planfinderworksheet.pdf" target="_blank" ><img alt="View Worksheet" src="images/button_work_sheet.gif" border=0></a>
</td><td  valign=top>
<font size=+1>Click here to get a Medicare Prescription Drug Coverage Personal 
Information Worksheet (Fill it out by hand and use it as a guide to help you choose a Medicare Prescription Drug Plan)</font><br>
<em>(Clicking the button to the left will open a new window.)</em>
</td>
</tr>
</table>	
<!--- <br>
<table><tr><td width="140" valign=top>
<a href="http://www.medicare.gov/medicarereform/MPDP_Cost_Estimator.asp" target="_blank" ><img alt="Go to Cost Estimator" src="images/button_estimator.gif" border=0></a>
</td><td  valign=top>
<font size=+1>Click here to go Medicare Prescription Drug Plan Cost Estimator</font>
</td>
</tr>
</table>	 --->		
<br>
<table><tr><td width="140" valign=top>
<a href="http://www.medicare.gov/medicarereform/map.asp" target="_blank" ><img alt="Available Plans" src="images/button_available_plans.gif" border=0></a>
</td><td  valign=top>
<font size=+1>Click here to get an overview of the plans available in your area</font><br>
<em>(Clicking the button to the left will open a new window.)</em>
</td>
</tr>
</table>	
<br>
<table>
<tr><td width="180" valign=top >
<cf_buildRedirectURL code="planfind" text="<img alt=""Select a Plan"" src=""images/button_select_plan.gif"" border=""0"">">
</td><td  valign=top>
<font size=+1>Click here to go directly to the Medicare Prescription Drug Plan Finder</font><br>
<em>(Clicking the button to the left will open a new window.)</em>
</td>
</tr>
</table>
</cfif>
<cfif request.doScreening neq "N">
	<p><li>Click <cfoutput><cf_sessionPassVars href="startover.cfm"  subset_id="28" prev_id="#session.screening_id#">here</cf_sessionPassVars></cfoutput> to learn whether you should apply for <cfif request.doScreening eq "Both">Medicaid or Supplemental Security Income<cfelseif request.doScreening eq "m">Medicaid<cfelse>Supplemental Security Income</cfif>. (<em>By clicking on this link, you will start a new BenefitsCheckUp screening.  Therefore, please make sure to print this page for your records before you start a new screening as you will not be able to immediately access this page again.)</em></li></p>
</cfif>
<cfif request.FoodStampsScreening eq "Y">
	<p><li>Click <cfoutput><cf_sessionPassVars href="startover.cfm"  subset_id="35" prev_id="#session.screening_id#">here</cf_sessionPassVars></cfoutput> to learn whether you should apply for Food Stamps, Housing and Energy Assistance Programs. (<em>By clicking on this link, you will start a new BenefitsCheckUp screening. Therefore, please make sure to print this page for your records before you start a new screening as you will not be able to immediately access this page again.)</em></li></p>
</cfif>
</ul>
<!-- <p>How to go about selecting a plan:</p>
<p>Medicare has an on-line tool called Medicare Prescription Drug Plan Finder that can help you compare plans. You can access it directly at <a href="www.medicare.gov">www.medicare.gov</a> or by calling 1-800-Medicare.   Before you use the tool, please fill out the work sheet listed below.    Your local State Health Insurance Program (SHIP) and other organizations are available to provide one-on-one assistance. </p>
 -->