<cfprocessingdirective suppresswhitespace="Yes">
<cfparam name="src" type="string" default="">
<cfparam name="sr" type="numeric" default="1">
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

<FONT FACE="arial" Size=5><B>Saving Money at the Pharmacy</b></FONT>
<Br><BR>

	<cfif src eq 'eforms'>
		<cf_buttons goText="Back to Application Guide" goURL="frmAccess.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#">
	<cfelseif src eq 'elig'>
		<cf_buttons goText="Back to Results" goURL="frmeligibility.cfm?sr=#sr#&cfid=#session.cfid#&cftoken=#session.cftoken#">
	<cfelse>
		<cf_buttons goText="Back to Recommendations" goURL="frmRecommend.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#">
	</cfif>

<FONT FACE="arial" Size=3>
To save money at the pharmacy, generic drugs are an important option to consider.<br><br>

<FONT FACE="arial" Size=4><B>Brief Overview of Generic Drugs</b></FONT>
<Br><BR>

A generic drug is a copy of a name-brand drug that has the same dosage,
safety, strength, quality, performance and intended use. Since
prescription drugs can be a costly medical expense, especially for older
people and those who are chronically ill, each state has a law that lets
pharmacists substitute less expensive generic drugs for many name-brand
products. Depending on your prescription needs, your savings could be
significant.
<BR><BR>
Many companies may sell the same generic medications. These generic
medications may not all look alike. They may come in different colors,
shapes and sizes. The United States Food and Drug Administration tests
these medications to make sure they are safe and have the same action.
<BR><BR>
When you receive a new prescription ask your pharmacist or health care
provider if a less expensive, but equally effective generic product, is
available. The savings may surprise you.
<BR><BR>
For additional information on generic medicines visit the following web
site:
<cfoutput><DD><LI><A HREF="#urlFDA#">#urlFDA#</A></cfoutput>
<BR>
</FONT>

	<cfif src eq 'eforms'>
		<cf_buttons goText="Back to Application Guide" goURL="frmAccess.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#">
	<cfelseif src eq 'elig'>
		<cf_buttons goText="Back to Results" goURL="frmeligibility.cfm?sr=#sr#&cfid=#session.cfid#&cftoken=#session.cftoken#">
	<cfelse>
		<cf_buttons goText="Back to Recommendations" goURL="frmRecommend.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#">
	</cfif>
</td></tr></table></center>
</body></html>
	   
</cfprocessingdirective>

<cf_tagFooter hidehf="true">
