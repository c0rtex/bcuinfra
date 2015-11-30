

<CFIF listcontains( #prg_list#, "XXX-309-2690-HI-ST") >



<cfif mode eq "Summary">

<li>You are eligible for Hawaii's KP Helps Charity Care Program. For a fact sheet on this program, click <a href="frmDetails.cfm?prg_id=XXX-309-2690-HI-ST">here</a>.</li>

<cfelse>

<cfset RxPrgList = #ListAppend(RxPrgList, "129-307-2680-FD-FD", ",")# >

<li>
<p>

<cfif #StrClient# IS "self">You<cfelse>Your <cfoutput>#StrClient#</cfoutput></cfif> may be able to get additional help by applying for Hawaii's KP Helps Charity Care Program. For a fact sheet on this program, click <cfoutput><a href="frmDetails.cfm?prg_id=XXX-309-2690-HI-ST">here</a>. </cfoutput>   

</p>

</li>

</cfif>

</CFIF>