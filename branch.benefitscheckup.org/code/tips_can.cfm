<cf_sessionLoadVars>
<!--- Call header tag --->
<cf_tagHeader>
<cfoutput>
<span class="Black-b1-bold">TIPS ON USE for <cf_tagBCU subset_id="#subset_id#"></span><br><br>

<b><i>Having Information Readily Available</i></b> - We've found that having the necessary information at your fingertips makes completing the questions easier. Here's a quick <cf_tagBCU subset_id="#subset_id#"> List that you may want to refer to when gathering materials.<ul>
<li>ZIP code</li> 
<li>Date of birth for self and spouse</li> 
<cfif subset_id neq 1>
<li>Type of residence (house, apartment, or mobile home)</li> 
<li>Length of time in current residence</li> 
<li>Employment history (specifically, whether or not the person ever worked for the state, local, county, or federal government or the railroads) for self and spouse</li> 
</CFIF>
<li>Veteran status for self and spouse</li>
<li>Names of prescription medications you are taking (we recommend that you have available the prescription bottles or information about your medications from your health professional)</li>
<li>Current income and assets from all sources for self, spouse and others in the household</li> 
<cfif subset_id neq 1>
<li>Estimates of current expenses (such as mortgage/rent, utilities, out-of-pocket medical bills, expenses for caring for someone at home while you work or go to school, etc.)</li>
<CFELSE>
<LI>Out-of-pocket medical expenses</LI>
</CFIF>
</ul>

<b><i>When to estimate, when to wait</i></b> - It's important to be as precise as possible with the information entered, especially the income and asset questions.  However, it's better to estimate than not enter anything at all.  Remember that the service is free and you can enter information as many times as you would like, so if you don't have the information now, take the time to get it all (using the <cf_tagBCU subset_id="#subset_id#"> List) and then complete the service with the most accurate information possible. 
<p>
<b><i>Keyboard Techniques</i></b> - Did you know that you can use the "Tab" button (located on the left side of your keyboard) to maneuver from field to field on the screen?  Try it, it might be faster than using the mouse to access each of the boxes.  In addition, you can use the "Tab" button to access the "Next" buttons.  When you've highlighted them (you know they are highlighted when there's a dotted line just inside the perimeter of the button), you can hit your keyboard's "space" button to activate the "Next" button and move to the next page. However, the enter key can't be used to move from one question to the next. This may send you to the next page before you have completed the page you are currently working on.
<p>
<cfif subset_id neq 1>
<b><i>Try Again</i></b> - The service is free, so try it as many times as you would like. Try it for yourself, using different income and asset levels. Estimate what your situation might be in six months or a year from now and see if there is any difference. Try it for your friends and relatives. And of course tell them that they should try it as well.
<p>
</CFIF>
<b><i>Try Again in Six Months</i></b> - <cf_tagBCU subset_id="#subset_id#"> is updated and improved regularly.  New programs are added, eligibility rules and criteria are updated regularly, and your life situation will probably change. Therefore, we recommend that you come back and complete another <cf_tagBCU subset_id="#subset_id#"> screening.  Doing so may identify programs for you that could significantly impact the quality of your life or the life of a loved one.
<BR><BR>

If your medical condition or the medications you are currently taking change, we recommend that you complete another <cf_tagBCU subset_id="#subset_id#"> screening.  Programs that provide prescription discounts are related to specific medications.  If your medications change, you may find that you are eligible for additional benefits programs.
<p>

<b><i>Next Steps</i></b> - Once you've printed out the report, we recommend that you immediately collect the required material and apply for the listed programs.  Timing can vary on how quickly program eligibility can be determined, so depending upon your situation and the program, allow for approximately two to three weeks before following up with each agency.  
<p>
<cfif Not IsDefined('session.partner_id') or session.partner_id neq 7>

We would sincerely appreciate it if you would contact us if you receive benefits from a program that you discovered through our service. Please share your success with us by emailing <a href="mailto:comments@benefitscheckup.org">comments@benefitscheckup.org</a>.
</cfif>
</cfoutput>
<cf_tagFooter>