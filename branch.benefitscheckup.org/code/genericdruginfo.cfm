<cfprocessingdirective suppresswhitespace="Yes">
<cfparam name="src" type="string" default="">
<cfparam name="sr" type="numeric" default="1">
<cfset urlAARP = "http://www.aarppharmacy.com/aarpnet/mc/mcDefault.aspx">
<cfset urlFDA = "http://www.ftc.gov/bcp/edu/pubs/consumer/health/hea06.shtm">
<!---=======================================
DESCRIPTION: shows information about Generic Drugs - built on the frmDetails.cfm page
CALLED BY: frmEligibility.cfm
GOES TO: N/A
REQUIRED: prg_id  sent via the URL.
============================================--->
<cf_tagHeader show_title="yes" guts="genericdruginfo.cfm">
<table id="generic_drug_info" style="margin-left: 20px; margin-right:20px;" border="0" align="center"><TR><cfif session.partner_id neq 0 AND SESSION.partner_id NEQ 77><TD bgcolor="#ffffff"><cfelse><TD bgcolor="#ffffff" class="text1"></cfif>
<cfif session.partner_id neq 0 AND SESSION.partner_id NEQ 77>
    <cfoutput>
    <div id="print_button_fact_generic">
        <img  src="img/print_this_page.gif" alt="Print this Page" onclick="self.print();" border="0" />
    </div>
    <div id="results_button_fact_generic">
        <a href="frmeligibility.cfm?sr=#sr#&cfid=#session.cfid#&cftoken=#session.cftoken#">
            <img src="img/backToResults.gif" alt="Back to Results" border="0" />
        </a>
    </div>
    </cfoutput>
    <div id="genericdrug_info">
<cfelse>
	<cfoutput>
	<div id="print_button_fact_generic" style="clear:both;float:left;">
        <img border="0" onclick="self.print();" alt="Print this Page" src="img/print_this_page.gif">
    </div>
    <div id="results_button_fact_generic" style="float:right;">
        <a href="frmeligibility.cfm?sr=#sr#&cfid=#session.cfid#&cftoken=#session.cftoken#">
            <img src="img/backToResults.gif" alt="Back to Results" border="0" />
        </a>
    </div>
    </cfoutput>
   	<div id="genericdrug_info" style="clear:both;">
</cfif>
<cfif session.partner_id neq 0 AND SESSION.partner_id NEQ 77>
	<strong>Saving Money at the Pharmacy</strong>
<cfelse>
	<BR /><h1>Saving Money at the Pharmacy</h1>
</cfif>
<!---<cfif session.partner_id neq 0>
	<br><br>
	<cfif src eq 'eforms'>
		<cf_buttons goText="Back to Application Guide" goURL="frmAccess.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#">
	<cfelseif src eq 'elig'>
		<cf_buttons goText="Back to Results" goURL="frmeligibility.cfm?sr=#sr#&cfid=#session.cfid#&cftoken=#session.cftoken#">
	<cfelse>
		<cf_buttons goText="Back to Recommendations" goURL="frmRecommend.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#">
	</cfif>
<cfelse>
	<div id="back_buttons">
		<cfif src eq 'eforms'>
			<div id="backtoguide_buttons"><cf_buttons goText="Back to Application Guide" goURL="frmAccess.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#"></div>
		<cfelseif src eq 'elig'>
			<div id="backtoresults_buttons"><cf_buttons goText="Back to Results" goURL="frmeligibility.cfm?sr=#sr#&cfid=#session.cfid#&cftoken=#session.cftoken#"></div>
		<cfelse>
			<cf_buttons goText="Back to Recommendations" goURL="frmRecommend.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#">
		</cfif>
	</div>
</cfif>--->

	<h3 class="unbold">To save money at the pharmacy, generic drugs are an important option to consider.</h3>
	<h3>Brief Overview of Generic Drugs</h3>
	<p class="text1">
	A generic drug is a copy of a name-brand drug that has the same dosage,
	safety, strength, quality, performance and intended use. Since
	prescription drugs can be a costly medical expense, especially for older
	people and those who are chronically ill, each state has a law that lets
	pharmacists substitute less expensive generic drugs for many name-brand
	products. Depending on your prescription needs, your savings could be
	significant.
	</p><br>
	<p class="text1">
	Many companies may sell the same generic medications. These generic
	medications may not all look alike. They may come in different colors,
	shapes and sizes. The United States Food and Drug Administration tests
	these medications to make sure they are safe and have the same action.
	</p><br>
	<p class="text1">
	When you receive a new prescription ask your pharmacist or health care
	provider if a less expensive, but equally effective generic product, is
	available. The savings may surprise you.
	</p><br>
	<p class="text1">
	For additional information on generic medicines visit the following web
	site:<br>
	<cfoutput><A HREF="#urlFDA#">#urlFDA#</A></cfoutput><br>
	</p>
</div>
<cfif session.partner_id neq 0 AND SESSION.partner_id NEQ 77>
	<cfif src eq 'eforms'>
		<cf_buttons goText="Back to Application Guide" goURL="frmAccess.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#">
	<cfelseif src eq 'elig'>
		<cf_buttons goText="Back to Results" goURL="frmeligibility.cfm?sr=#sr#&cfid=#session.cfid#&cftoken=#session.cftoken#">
	<cfelse>
		<cf_buttons goText="Back to Recommendations" goURL="frmRecommend.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#">
	</cfif>
<cfelse>
<cfoutput>
<BR />
<div id="print_button_fact_generic" style="clear:both; float:left;">
	<img  src="img/print_this_page.gif" alt="Print this Page" onclick="self.print();" border="0" />
</div>
<div id="results_button_fact_generic" style="float:right;">
	<a href="frmeligibility.cfm?sr=#sr#&cfid=#session.cfid#&cftoken=#session.cftoken#">
		<img src="img/backToResults.gif" alt="Back to Results" border="0" />
	</a>
</div>
</cfoutput>
</cfif>
</td></tr></table>
</body></html>	   
</cfprocessingdirective>
<cf_tagFooter>