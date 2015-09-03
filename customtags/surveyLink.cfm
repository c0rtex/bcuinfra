<cfparam name="attributes.src" type="string" default="e">
<cfparam name="attributes.aft" type="numeric" default="0">
<div style="background-color:#FFFF99; color: black; margin-bottom: 20px; padding: 10px; font-family: Georgia, Times New Roman, Times, serif; font-size: 11pt;">
<cfif attributes.aft>
Thank you! Your response has been received.
<cfelse>
<cfoutput>Two million people have found valuable benefits from BenefitsCheckUp, and you were one of them!  <a href="share.cfm?src=#attributes.src#&cfid=#session.cfid#&cftoken=#session.cftoken#">Click here</a> if you would like to share with us how BenefitsCheckUp helped you.</cfoutput>
</cfif>
</div>