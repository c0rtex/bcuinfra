<cfprocessingdirective suppresswhitespace="Yes">
<cfparam name="src" type="string" default="">
<cfset urlAARP = "http://www.aarppharmacy.com/aarpnet/mc/mcDefault.aspx">
<cfset urlFDA = "http://www.fda.gov/cder/consumerinfo/generics_q&a.htm">
<!----=======================================
DESCRIPTION: shows information about Generic Drugs - built on the frmDetails.cfm page
CALLED BY: frmEligibility.cfm
GOES TO: N/A
REQUIRED: prg_id  sent via the URL.
============================================---->
<cf_tagHeader>
<CENTER><table width=100% border="0" align="center" cellpadding=12 cellspacing=2><TR><TD bgcolor="#ffffff">

<FONT FACE="arial" Size=5><B>General Instructions for Completing Application Forms</b></FONT>
<Br><BR>

	<cfif src eq 'guide'>
		<cf_buttons goText="Back to Application Guide" goURL="frmEForms.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#">
	<cfelseif src eq 'elig'>
		<cf_buttons goText="Back to Results" goURL="frmeligibility.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#">
	<cfelse>
		<cf_buttons goText="Back to ABC Recommendations" goURL="frmRecommend.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#">
	</cfif>

<FONT FACE="arial" Size=3>
<ol>

<li>Separate each packet of instructions and application into a group for less confusion in applying.<br><br>

<li>Read each packet of information carefully.  (Each packet of information often contains fact sheets, application(s), and instructions.)<br><br>

<li>Answer every question in the application form.  (Your application will be returned if it is incomplete.)  If you used the electronic form function, watch for blank fields of information that remain to be filled out.<br><br>

<li>Be as accurate as possible in answering income information.<br><br>

<li>Make sure your Social Security Number (SS#) is accurate and legible.<br><br>

<li>Be sure to place your signature in each appropriate location.<br><br>

<li>Be sure to date each application.<br><br>

<li>Note additional requirements such as your doctor's signature and/or a current prescription for your medications.<br><br>

<li>Mail each application individually to the location given on the application or in the instructions.<br><br>

<li>When possible, keep a copy of your completed forms for your records.<br><br>

<li>If you have questions call the phone number provided with each application form.<br><br>

<li><cfif false>
<cfoutput>Please direct any further questions or comments to <a href="mailto:#request.comments_address#">#request.comments_address#</A>.</cfoutput>
<cfelse>
<cfoutput>Please direct any further questions or comments to <a href="mailto:support@benefitscheckup.org">support@benefitscheckup.org</A>.</cfoutput>
</cfif>

</ol>

</FONT>

	<cfif src eq 'guide'>
		<cf_buttons goText="Back to Application Guide" goURL="frmEForms.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#">
	<cfelseif src eq 'elig'>
		<cf_buttons goText="Back to Results" goURL="frmeligibility.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#">
	<cfelse>
		<cf_buttons goText="Back to ABC Recommendations" goURL="frmRecommend.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#">
	</cfif>
</td></tr></table></center>
</body></html>
	   
</cfprocessingdirective>

<cf_tagFooter>
