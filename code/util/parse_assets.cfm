<!--load assets.xml file , parse results and save to db -->
<cffile action="read" file="/var/www/html/BCU/util/assets.xml" variable="assetsxml" >
<!-- Convert file to XML document object -->
    <!-- Delete all assets data before inserting -->
    
	 delete from asset
	
<!--Remove dashes -->
<br/>
<cfset assetsxmldoc = XmlParse(assetsxml)>

<!--cfdump var="#assetsxmldoc#"-->
<cfset numItems = ArrayLen(assetsxmldoc.library.dir.asset)>
<cfoutput>Number of assets Records to Parse:#numItems#<br/></cfoutput>
<cfset numItems = ArrayLen(assetsxmldoc.library.dir)>
<cfoutput>Number of assets Records to Parse:#numItems#<br/></cfoutput>
<cfset numItems = ArrayLen(assetsxmldoc.library.dir.dir)>
<cfoutput>Number of assets Records to Parse:#numItems#<br/></cfoutput>
<cfset numItems = ArrayLen(assetsxmldoc.library.dir.dir.dir)>
<cfoutput>Number of assets Records to Parse:#numItems#<br/></cfoutput>
<cfabort>
<!-- Loop through xml records  -->
<cfloop index="i" from = "1" to = #numItems#>	
	<cftry>
	<cfset asset_id = assetsxmldoc.library.asset[i].XmlAttributes.id>
    <cfset name = assetsxmldoc.library.asset[i].name.xmltext>
    <cfset asset_type_id = assetsxmldoc.library.asset[i].asset_type_id.xmltext>
    <cfset tags = assetsxmldoc.library.asset[i].strapline.xmltext>

    <!-- Call Insert assets Stored Proc -->
    
	CALL insertasset(
    '#asset_id#',
	#name#, 
	'#asset_type_id#',
	'#tags#')
	
	RECORD <cfoutput>#i# #name#</cfoutput> COMPLETED.<br/>
	<cfflush >
    <cfcatch >
    <cfoutput>RECORD <cfoutput>#i# #code#</cfoutput> PARSING ERROR.<br/></cfoutput>
    </cfcatch>
    </cftry>
</cfloop>
<cfoutput><br><br>Loading Completed.</cfoutput>


  