<!--- Grab data for WordPress header callout and save to WP table --->
<!--- Call data mine query to count screenings --->
	<!---cfquery name="whscr" datasource="#application.dbSrcWarehouse#">
		select count(s.id) AS c
		from screening s join oe_org o
		on s.oe_org_id=o.id
		where s.subset_id not in (41, 53)
	</cfquery>
	<!--- Call data mine query to sum dollar value --->
	<cfquery name="whdlr" datasource="#application.dbSrcWarehouse#">
		select sum(dollarvalue) as s
        from screening s join oe_org o on s.oe_org_id = o.id 
        where (s.subset_id != 41 or              
        (s.source_id = 7 or s.partner_id in (47,51)) 
        and s.submission_status in (1,222,999))) 
        and s.subset_id != 53;
	</cfquery>
	
<cfif whdlr.s gt 1000000000000>
	<cfset whdlr.s = int(whdlr.s / 100000000000) / 10>
	<cfset whdlr.s = whdlr.s & " trillion">
<cfelseif whdlr.s gt 1000000000>
	<cfset whdlr.s = int(whdlr.s / 100000000) / 10>
	<cfset whdlr.s = whdlr.s & " billion">
<cfelseif whdlr.s gt 1000000>
	<cfset whdlr.s = int(whdlr.s / 100000) / 10>
	<cfset whdlr.s = whdlr.s & " million">
<cfelseif whdlr.s gt 1000>
	<cfset whdlr.s = int(whdlr.s / 100) / 10>
	<cfset whdlr.s = whdlr.s & " thousand">
<cfelseif whdlr.s gt 100>
	<cfset whdlr.s = int(whdlr.s / 10) / 10>
	<cfset whdlr.s = whdlr.s & " hundred">
</cfif--->
	
	<cfsavecontent variable="wp_callout">
		<cfoutput>
			We have helped <strong><cf_cachetoteboard></span></strong> 
			people find over <strong><cf_cachetoteboard field="dollars" writerounded="true"></span></strong> worth of benefits.
		</cfoutput>
	</cfsavecontent>
	
	<cfquery dataSource="wp_benefitscheckup">
		UPDATE wp_posts
		SET post_content = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#wp_callout#">
		WHERE ID = 2185
	</cfquery>
	
<cfoutput>
	#wp_callout#
</cfoutput>