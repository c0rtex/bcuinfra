<cf_sessionLoadVars>
<cfset oeURL = "http://#application.serverPathOE#/menu.do">
<cf_tagHeader refreshurl="#oeURL#" refreshsec="0">
<table width="100%" border="0" align="center" cellpadding="#session.cellpadding#" cellspacing="#session.cellspacing#">
        <TR>
          <TD bgColor="#ffffff" align="left"><font face="arial,helvetica"><cfoutput>

<h2>Returning to OE</h2>

If you are not redirected within 5 seconds, please <a href="#oeURL#">click here</a>.

		</cfoutput></font></TD>
	</TR>
</TABLE>
<cf_tagFooter>