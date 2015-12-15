<cffile action="read" file="j:\bcu\bcu\us_city_map\usa_bak.xml" variable="xml">

<cfset xml = xmlparse(xml)>

<cfloop array="#xmlsearch(xml,'/usa/map/state')#" index="i">
	<cfset readFile = replace(i.xml.XmlText, "/", "\", "all")>
	<cfset st = listGetAt(readFile, listLen(readfile, "\"), "\")>
	<cfset st = listGetAt(st, 1, ".")>
	<cfoutput>#readFile# - #st#<br></cfoutput>

	<!cftry>
		<cffile action="read" file="j:\bcu\bcu\us_city_map\#readFile#" variable="state">
		
		<cfoutput>
		<h1>Parsing #readFile#</h1>
		</cfoutput>
		
		<cfset state = xmlparse(state)>
		
		<cfloop array="#xmlsearch(state,'/map/county')#" index="i">
			<cfoutput>#i.name.XmlText# - #i.id.XmlText# --- </cfoutput>
			
			<cfquery name="findCounty" datasource="#application.dbSrc#">
				SELECT *
				FROM county
				WHERE state_id = '#st#'
				AND county_name = '#i.name.XmlText#'
			</cfquery>
			
		
			<cfif findCounty.recordcount IS 1>
			
				<cfoutput>
				#findCounty.county_name# found
				</cfoutput>
			
				<cfquery name="updateCounty" datasource="#application.dbSrc#">
					UPDATE county
					SET map_id =  #i.id.XmlText#
					WHERE county_id = #findCounty.county_id#
				</cfquery>
			<cfelse>
			<font color="##FF0000"><strong>NOT FOUND</strong></font>
			</cfif>
			<br>
			<cfflush>
		</cfloop>
<!--- 		<cfcatch>
		</cfcatch>
	</cftry> --->

</cfloop>

<!cfdump var="#xml#">
<!--- 
 --->
<!cfdump var="#state#">


