<cfif SESSION.partner_id EQ 0 OR SESSION.partner_id EQ 77>
	<h2>Comments</h2>
	<hr>
<cfelseif session.partner_id eq 14>
<br>
	<h2>Comments</h2>

<cfelseif session.partner_id neq 5 or session.subset_id eq 49>
<FONT SIZE=+2><b>Comments</b></FONT><br>
<hr>

</cfif>

<cfif session.partner_id neq 5>
	<p>
	How has this service been helpful to you? How can we make it better? 
	Please take a moment to send your comments and suggestions to 
	<cfoutput><a href="mailto:#request.comments_address#">#request.comments_address#</a></cfoutput>.
	</p>
</cfif>

<cfif session.subset_id eq 49>
	<p>
		<cf_displayText code="site_results_comments_aarpsurvey" group="site">
	</p>
</cfif>
