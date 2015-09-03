<cfset neededURL = "neededinfo.cfm">
<cfoutput>
<table cellpadding="20" cellspacing="0" width="100%" border="0">
<cf_sessionPassVars action="/frmwelcome2.cfm" subset_id="39" method="post" name="formwelcome">

<tr>
<td>
<p><cf_sessionPassVars href="frmwelcome2.cfm" class="h1link" prev_id="0" subset_id="39">Get Started Now!</cf_sessionPassVars></p>
<img src="img/partners/pfizer/cover.jpg" alt="" align="right" hspace="12" /><p class="text1">#session.subsetText#</p>

<h1 class="h1">Here's how it works:</h1>
<p class="text1">
<ol>
<li class="text1"><INPUT TYPE="submit" VALUE="Click Here" NAME="welcome" class="b1"></b> to start.</li>
<li class="text1">Print out your personalized report that lists programs you may qualify for, telephone numbers, and directions on how to sign up for these programs.</li>
</ol></p>
<p class="text1">
<a href="javascript:help2('<cfoutput>#application.transferType#://#application.serverPath#/whatithelps.cfm?id=#session.subset_id#</cfoutput>')">Click here</a> to learn which benefits are included in this screening and enrollment service.<br />
<a href="javascript:help2('<cfoutput>#neededURL#</cfoutput>')">Click here</a> to see if you need to gather any information before you begin.
</p>


</cf_sessionPassVars>


</div></td>
</tr>
</table>
</cfoutput>