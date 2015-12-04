<cfif request.compare eq "Y"  >
<cfif mode eq "Summary">
	<li>Compare Medicare Prescription Drug Plans that are available in your area.</li>
<cfelse>
<cfif request.ShowCompareAfter eq "Y">
<li>
</cfif>
Compare Medicare Prescription Drug Plans that are available in your area. If
you would like one-on-one assistance to get help comparing and selecting a
plan, contact your <a href="http://www.medicare.gov/contacts/" title="State Health Insurance Program (SHIP)" target="_blank">State Health Insurance Program (SHIP)</a>:

<!---Compare Medicare Prescription Drug Plans that are available in your area. If you would like one-on-one assistance to get help comparing and selecting a plan, contact your local <a href="http://www.accesstobenefits.org/About%20Us/State%20and%20Local%20Coalitions/" title="Access to Benefits Coalition" target="_blank">Access to Benefits Coalition</a> or <a href="http://www.medicare.gov/Contacts/staticpages/ships.aspx" title="State Health Insurance Program (SHIP)" target="_blank">State Health Insurance Program (SHIP)</a>:--->

<cfif request.ShowCompareAfter eq "Y">
</li>
</cfif>
<br>
<!--- <br>
<table><tr><td width="140" valign=top>
<a href="planfactsheet.pdf" target="_blank" ><img alt="View Factsheet" src="images/button_fact_sheet.gif" border=0></a>
</td><td  valign=top>
<font size=+1>Click here to get a Fact Sheet from Center for Medicare and Medicaid Services (CMS) </font>
</td>
</tr>
</table>	 --->

	<cfif (benefit neq 3) and not listcontains(session.prg_list,'103-311-2593-FD-FD')>
		<cfset prg_id = "103-311-2588-FD-FD">
		<cfinclude template="../dspLinks.cfm">
	</cfif>
<table><tr><td width="140" valign=top>
<a href="planfinderworksheet.pdf" target="_blank" ><img id="view_worksheet" alt="View Worksheet" src="images/button_work_sheet.gif" border=0></a>
</td><td  valign=top>
<div class="li_description">Click here to get a Medicare Prescription Drug Coverage Personal Information Worksheet (Fill it out by hand and use it as a guide to help you choose a Medicare Prescription Drug Plan)<br>
<em>(Clicking the button to the left will open a new window.)</em></div>
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
<!---table><tr><td width="140" valign=top>
<a href="https://www.medicare.gov/find-a-plan/questions/home.aspx" target="_blank" ><img alt="Available Plans" src="../images/button_available_plans.gif" border=0></a>
</td><td  valign=top>
<font size=+1>Click here to get an overview of the plans available in your area</font><br>
<i>(Clicking the button to the left will open a new window.)</i>
</td>
</tr>
</table>	
<br--->
<table>
<tr><td width="140" valign=top >
<cf_buildRedirectURL code="planfind" text="<img class='available_plans' alt=""Select a Plan"" src=""images/button_select_plan.gif"" border=""0"">">
</td><td  valign=top>
<div class="li_description">Click here to find a Medicare Prescription Drug Plan<br>
<em>(Clicking the button to the left will open a new window.)</em>
</div>
</td>
</tr>
</table>
<br><br>
<cfif request.enrollnow eq "Y">
<table><tr><td width="140" valign=top>
<cf_buildRedirectURL code="planenroll" text="<img class='available_plans' alt=""Select a Plan"" src=""images/button_select_plan2.gif"" width=""130"" height=""28"" border=""0"">">
</td><td  valign=top>
<div class="li_description">Click here to enroll in a Medicare Prescription Drug Plan
<br>
<em>(Clicking the button to the left will open a new window.)</em>
</div>
</td>
</tr>
</table>
</cfif>
</cfif>
</cfif>