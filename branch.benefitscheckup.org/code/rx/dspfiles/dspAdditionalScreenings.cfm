<!-- If TA eligible - Temporarily dump in ta screening rules in if statement -->
<cfif (#session.med_receive# NEQ 'Y')>
<cfif (#session.rec_tricare# NEQ 'Y') >
<cfif (#session.medicare_receive# EQ 'Y')>
<cfif ((((#session.marital_stat# neq 'Married') AND (#session.s_income_total_complete# lte 1077)) OR ((#session.marital_stat# eq 'Married') AND (#session.s_sp_income_total_complete# lte 1444))) and (#session.st# neq 'AK' and #session.st# neq 'HI')) OR ((((#session.marital_stat# neq 'Married') AND (#session.s_income_total_complete# lte 1345)) OR ((#session.marital_stat# eq 'Married') AND (#session.s_sp_income_total_complete# lte 1804))) and (#session.st# eq 'AK')) OR ((((#session.marital_stat# neq 'Married') AND (#session.s_income_total_complete# lte 1239)) OR ((#session.marital_stat# eq 'Married') AND (#session.s_sp_income_total_complete# lte 1661))) and (#session.st# eq 'HI')) 
 and (#session.rec_employee_hi# NEQ 'Y') and (#session.rec_il_seniorcare# NEQ 'Y') and (#session.rec_fl_silversaverx# NEQ 'Y') and (#session.rec_md_pharmacyassistance# NEQ 'Y') and (#session.rec_sc_silverrx# NEQ 'Y') and (#session.rec_wi_seniorcare# NEQ 'Y')  >

<cfinclude template="../dspOtherOptions.cfm">
<p>
<li>
<strong>Apply for a Medicare-approved discount card with additional assistance.</strong> If you need help with paying for your prescription drugs between now and the end of 2005, you can get a Medicare-approved drug discount card with additional assistance.  This card could save you several hundred dollars this year. Click <a href="../../frmNewScreening.cfm?goto=card">here</a>
to select and enroll in the card that will best meet your needs.  
</li>
</p>
</cfif>
</cfif>
</cfif>
</cfif>
<cfif ((((#session.marital_stat# neq 'Married') AND (#session.s_income_total_complete# lte 2393)) OR ((#session.marital_stat# eq 'Married') AND (#session.s_sp_income_total_complete# lte 3208))) and (#session.st# neq 'AK' and #session.st# neq 'HI')) OR ((((#session.marital_stat# neq 'Married') AND (#session.s_income_total_complete# lte 2988)) OR ((#session.marital_stat# eq 'Married') AND (#session.s_sp_income_total_complete# lte 4008))) and (#session.st# eq 'AK')) OR ((((#session.marital_stat# neq 'Married') AND (#session.s_income_total_complete# lte 2753)) OR ((#session.marital_stat# eq 'Married') AND (#session.s_sp_income_total_complete# lte 3690))) and (#session.st# eq 'HI'))>
<cfinclude template="../dspOtherOptions.cfm">
<p>
<li>
<strong>Apply for a company patient assistance program.</strong>You may be eligible for assistance programs offered by pharmaceutical companies.  These programs provide certain medications at a very low cost based on a person's income and needs. Click <a href="../../frmNewScreening.cfm?goto=pap">here</a>
to learn about the medicines that these programs cover, to see if you qualify and to get the application forms.  In 2005, these programs could help make some of your medicines more affordable. In 2006, when the new Medicare benefit is in effect, these programs may help you pay for certain types of medicines that are not covered by the new Medicare benefit.  To learn more about what types of medicines are not covered by the new Medicare benefit, click <a href="../../frmExcludedMeds.cfm" >here</a>.  
</li>
</p>
</cfif>