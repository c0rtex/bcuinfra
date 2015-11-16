<cf_checkAccess level="3">
<cf_buildPage title="Crawling for New Images" section="image">

<cf_directoryTree>

<h2>Crawling for New Images</h2>

<cfoutput>
<cfset count = 0>
<cfset maxlen = 0>
<cfloop list="#imageList#" index="x">
	<cfif application.rootSlash eq '\'>
		<cfset x = Replace(x, '\', '/', 'ALL')>
	</cfif>
	<cfquery name="getimg" datasource="#application.dbSrc#">
		select image_id
		from image
		where filename='#x#'
	</cfquery>
	<cfif not getimg.RecordCount>
		#x#<br />
		<img src="http://#application.serverPathBCU#/#x#" /><br />
		<cfset count = count + 1>
		<cfif Len(x) gt maxlen>
			<cfset maxlen = Len(x)>
		</cfif>
		<cfset code = REReplace(lcase(x), '[^0-9A-Za-z_]', '_', 'ALL')>
		<cfset match = 1>
		<cfset pushcount = 0>
		<cfloop condition="match eq 1">
			<cfif pushcount eq 0>
				<cfset codepush = code>
			<cfelse>
				<cfset codepush = "#code##pushcount#">
			</cfif>
			<cfquery name="getimg" datasource="#application.dbSrc#">
				select image_id
				from image
				where code='#codepush#'
			</cfquery>
			<cfset match = getimg.RecordCount>
			<cfset pushcount = pushcount + 1>
		</cfloop>
		<cfquery name="getimg" datasource="#application.dbSrc#">
			insert into image
				(code, filename)
			values
				('#codepush#', '#x#')
		</cfquery>
		<br />
	</cfif>
</cfloop>
<b>found:</b> #count#<br />
</cfoutput>

</cf_buildPage>