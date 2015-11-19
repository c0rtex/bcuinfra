<cfquery name="checktally" datasource="#application.dbSrc#">
	SELECT DATEDIFF(updated, now()) - 30 diff
	FROM tbl_tally
</cfquery>
<cfif checktally.diff gt 0>
	<cfquery name="gettally" datasource="#application.dbSrc#">
		SELECT bcu, rx, brand, generic, drug
		FROM view_tally
	</cfquery>
	<cfquery name="updatetally" datasource="#application.dbSrc#">
		UPDATE tbl_tally
		SET bcu=#gettally.bcu#, rx=#gettally.rx#, brand=#gettally.brand#, generic=#gettally.generic#, drug=#gettally.drug#, updated=now()
	</cfquery>
</cfif>