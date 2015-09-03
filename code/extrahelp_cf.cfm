<cfparam name="URL.partner_id" default="0">

<cfif IsDefined('URL.sc_partner_id') AND URL.sc_partner_id NEQ ''>
	<cfset SESSION.sc_partner_id = URL.sc_partner_id>
<cfelse>

	<cfset SESSION.sc_partner_id = 0>
</cfif>


<!---<cf_displayText group="site" code="site_extrahelp_intro">--->
<cfquery name="getText3" datasource="#application.dbSrc#">
SELECT *
FROM display_language
where display_id = 3463 and language_id = 'EN'
</cfquery>
<cfoutput>#getText3.display_text#</cfoutput>
<p>Not sure if you should apply? Answer a few questions to find out. <a href="frmwelcome2.cfm?subset_id=27&amp;partner_id=<cfoutput>#URL.partner_id#</cfoutput>&sc_partner_id=<cfoutput>#SESSION.sc_partner_id#</cfoutput>">Get Started</a>
</p>
<p>
 <a href="start.cfm" onclick="this.href='dispatch.cfm?source_id=1&amp;prev_id=0&amp;org_id=0&amp;partner_id=<cfoutput>#URL.partner_id#</cfoutput>&amp;sc_partner_id=<cfoutput>#SESSION.sc_partner_id#</cfoutput>&amp;subset_id=41&amp;language_id=EN&amp;access_id=0&amp;client_id=NULL&amp;user_id=NULL&amp;test_id=0&amp;bcu_url=start%2Ecfm';" class="linkbutton">Apply Now</a> 
</p>
