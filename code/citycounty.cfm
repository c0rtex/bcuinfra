<cfdump var="#cgi.PATH_TRANSLATED#">

<cffile action="read" file="j:\bcu\bcu\us_city_map\usa_bak.xml" variable="xml">

<cfset xml = xmlparse(xml)>

<table border="1">

<cfloop array="#xmlsearch(xml,'/usa/map/state')#" index="i">
	<cftry>
	<cfset readFile = replace(i.xml.XmlText, "/", "\", "all")>
	<cfset st = listGetAt(readFile, listLen(readfile, "\"), "\")>
	<cfset st = listGetAt(st, 1, ".")>
			<cffile action="read" file="j:\bcu\bcu\us_city_map\maps\#st#_data.xml" variable="data">
			
			<cfset x = rematch("city=.{1,40}?&", data)>
			
			
			<cfloop array="#x#" index="i">
			<cfset city = replacenocase(i, "city=", "")>
			<cfset city = replacenocase(city, "&", "")>			
			
			
			<cfquery name="findCity" datasource="#application.dbSrc#">
				SELECT *
				FROM city c
				LEFT JOIN city_zip cz ON cz.city_id = c.city_id
				WHERE c.state_id = <cfqueryparam value="#st#">
				AND c.city_name = <cfqueryparam value="#city#">
				AND c.valid = 1
			</cfquery>			

			<cfquery name="cityCounties" datasource="#application.dbSrc#">
				SELECT *
				FROM view_city_county cc
				LEFT JOIN county c ON c.county_id = cc.county_id
				WHERE city_id = '#findCity.city_id#'
			</cfquery>				

			
			<cfoutput query="cityCounties" group="city_id">
			<tr>
			<td colspan="2"><strong>#city#, #ucase(st)#</strong></td>
			</tr>
			<cfoutput>
			<tr>
			<td>#COUNTY_NAME#</td>
			<td><input type="radio" name="#findCity.city_id#" value="#COUNTY_ID#" checked="checked"></td>
			</tr>
			</cfoutput>
			</cfoutput>
			</cfloop>
	<cfflush>
	
	<cfcatch>
	</cfcatch>
	</cftry>
	
</cfloop>






<!cfdump var="#xml#">
<!cfdump var="#state#">




<cfabort>
